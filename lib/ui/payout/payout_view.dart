import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:penger/bloc/payout/payout_bloc.dart';
import 'package:penger/bloc/pengers/penger_repo.dart';
import 'package:penger/config/color.dart';
import 'package:penger/const/icon_const.dart';
import 'package:penger/const/space_const.dart';
import 'package:penger/helpers/theme/custom_font.dart';
import 'package:penger/helpers/theme/theme_helper.dart';
import 'package:penger/helpers/toast/toast_helper.dart';
import 'package:penger/models/payout_model.dart';
import 'package:penger/ui/widgets/api/loading.dart';
import 'package:penger/ui/widgets/button/custom_button.dart';
import 'package:penger/ui/widgets/input/custom_textfield.dart';
import 'package:penger/ui/widgets/layout/sliver_appbar.dart';
import 'package:penger/ui/widgets/layout/sliver_body.dart';

class PayoutView extends StatefulWidget {
  const PayoutView({Key? key}) : super(key: key);

  @override
  _PayoutViewState createState() => _PayoutViewState();
}

class _PayoutViewState extends State<PayoutView> {
  bool _hasAccount = false;
  String? _bankId;

  final PayoutBloc _payoutBloc = PayoutBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkHasAcc();

    _loadPayoutInfo();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PayoutBloc>(
      create: (context) => _payoutBloc,
      child: Scaffold(
        backgroundColor: greyBgColor,
        body: CustomScrollView(
          slivers: <Widget>[
            CustomSliverAppBar(
              bgColor: Colors.transparent,
              title: Container(),
              actions: [
                Row(
                  children: [
                    if (_hasAccount)
                      CupertinoButton(
                        onPressed: () => _confirmWithdraw()
                            .then((value) => _loadPayoutInfo()),
                        child: SvgPicture.asset(
                          WITHDRAW_ICON_PATH,
                          color: secondaryTextColor,
                          width: 24,
                          height: 24,
                        ),
                      ),
                    CupertinoButton(
                      child: SvgPicture.asset(
                        BANK_ICON_PATH,
                        color: secondaryTextColor,
                        width: 24,
                        height: 24,
                      ),
                      onPressed: () {
                        showCupertinoModalBottomSheet(
                            expand: false,
                            context: context,
                            builder: (BuildContext context) {
                              return SaveBankForm(id: _bankId);
                            }).then((_) {
                          _loadPayoutInfo();
                          _checkHasAcc();
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            CustomSliverBody(
              content: <Widget>[
                BlocBuilder<PayoutBloc, PayoutState>(
                  builder: (BuildContext context, PayoutState state) {
                    if (state is PayoutLoading) {
                      return const LoadingWidget();
                    }

                    if (state is PayoutLoaded) {
                      final String currency = state.payout.currency;
                      final String currBal = state.payout.currentAmount;
                      final String totalGross = state.payout.totalGross;
                      final String totalCharge = state.payout.totalCharge;
                      final String totalEarn = state.payout.totalEarn;
                      final double chargeRate = state.payout.chargeRate;
                      final List<Transaction> transactions =
                          state.payout.transactions;
                      return Container(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Payout",
                              style: PengoStyle.navigationTitle(context),
                            ),
                            const SizedBox(
                              height: SECTION_GAP_HEIGHT,
                            ),
                            CurrentBalanceCard(
                              currency: currency,
                              balance: currBal,
                            ),
                            const SizedBox(
                              height: SECTION_GAP_HEIGHT,
                            ),
                            PayoutCard(
                              totalGross: totalGross,
                              totalCharge: totalCharge,
                              totalEarn: totalEarn,
                              currency: currency,
                            ),
                            const SizedBox(
                              height: SECTION_GAP_HEIGHT,
                            ),
                            ChargeCard(rate: chargeRate),
                            const SizedBox(
                              height: SECTION_GAP_HEIGHT,
                            ),
                            Text(
                              "History",
                              style: PengoStyle.title2(context).copyWith(
                                color: secondaryTextColor,
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            PayoutHistoryCard(list: transactions),
                          ],
                        ),
                      );
                    }
                    return Container();
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _checkHasAcc() async {
    try {
      final String res = await PengerRepo().getBankAcc();
      setState(() {
        _hasAccount = true;
        _bankId = res;
      });
    } catch (e) {
      setState(() {
        _hasAccount = false;
        _bankId = null;
      });
    }
  }

  Future<void> _loadPayoutInfo() async {
    _payoutBloc.add(FetchPayoutInfo());
  }

  Future<void> _confirmWithdraw() async {
    await showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Alert'),
        content: const Text('Proceed to withdraw?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            child: const Text('No'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              // Do something destructive.
              _withdraw();
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          )
        ],
      ),
    );
  }

  Future<void> _withdraw() async {
    try {
      final String msg = await PengerRepo().withdrawBalance();
      showToast(msg: "Withdraw successfully", backgroundColor: successColor);
      _loadPayoutInfo();
    } catch (e) {
      debugPrint("withdraw failed msg $e");
      showToast(msg: e.toString());
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}

class SaveBankForm extends StatefulWidget {
  const SaveBankForm({
    Key? key,
    this.id,
  }) : super(key: key);

  final String? id;

  @override
  _SaveBankFormState createState() => _SaveBankFormState();
}

class _SaveBankFormState extends State<SaveBankForm> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _controller;

  final _validator = MultiValidator([
    RequiredValidator(errorText: 'Stripe acc id cannot be empty'),
  ]);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //for test
    // _controller = TextEditingController(text: 'acct_1JsnkvIIGcSgr96M');
    _controller =
        TextEditingController(text: widget.id ?? 'acct_1JsnkvIIGcSgr96M');
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Form(
        key: _formKey,
        child: Padding(
          padding:
              EdgeInsets.only(bottom: mediaQuery(context).viewInsets.bottom),
          child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 28,
                horizontal: 18,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomTextField(
                    label: "Stripe account id",
                    validator: _validator,
                    controller: _controller,
                    hintText: "Your stripe connect account id",
                  ),
                  CustomButton(
                    text: const Text("Save"),
                    onPressed: _save,
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (_formKey.currentState!.validate()) {
      try {
        await PengerRepo().saveBankAcc(_controller.text);
        showToast(
          msg: "Saved",
          backgroundColor: successColor,
        );
        Navigator.of(context).pop();
      } catch (e) {
        showToast(msg: e.toString());
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
}

class CurrentBalanceCard extends StatelessWidget {
  const CurrentBalanceCard({
    Key? key,
    required this.currency,
    required this.balance,
  }) : super(key: key);

  final String currency;
  final String balance;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              SvgPicture.asset(
                BALANCE_ICON_PATH,
                color: successColor,
                width: 24,
                height: 24,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                "Balance",
                style: PengoStyle.header(context),
              )
            ],
          ),
          const SizedBox(
            height: SECTION_GAP_HEIGHT * 1.5,
          ),
          Text(
            "Current balance",
            style: PengoStyle.caption(context).copyWith(
              color: secondaryTextColor,
            ),
          ),
          Text(
            "$currency $balance",
            style: PengoStyle.header(context).copyWith(
              color: successColor,
            ),
          ),
          const SizedBox(
            height: SECTION_GAP_HEIGHT * 1.5,
          ),
        ],
      ),
    );
  }
}

class PayoutCard extends StatelessWidget {
  const PayoutCard({
    Key? key,
    required this.currency,
    required this.totalGross,
    required this.totalCharge,
    required this.totalEarn,
  }) : super(key: key);

  final String currency;
  final String totalGross;
  final String totalCharge;
  final String totalEarn;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              SvgPicture.asset(
                PAYOUT_ICON_PATH,
                color: successColor,
                width: 24,
                height: 24,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                "Payout",
                style: PengoStyle.title2(context),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: <Widget>[
                Text(
                  "Gross",
                  style: PengoStyle.captionNormal(context).copyWith(
                    color: secondaryTextColor,
                  ),
                ),
                const Spacer(),
                Text(
                  "$currency $totalGross",
                  style: PengoStyle.text(context),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: <Widget>[
                Text(
                  "Total charge",
                  style: PengoStyle.captionNormal(context).copyWith(
                    color: secondaryTextColor,
                  ),
                ),
                const Spacer(),
                Text(
                  "$currency $totalCharge",
                  style: PengoStyle.text(context),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: <Widget>[
                Text(
                  "Total earn",
                  style: PengoStyle.captionNormal(context).copyWith(
                    color: secondaryTextColor,
                  ),
                ),
                const Spacer(),
                Text(
                  "$currency $totalEarn",
                  style: PengoStyle.text(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChargeCard extends StatelessWidget {
  const ChargeCard({
    Key? key,
    required this.rate,
  }) : super(key: key);

  final double rate;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "Charge rate",
                style: PengoStyle.title2(context).copyWith(
                  color: textColor,
                ),
              ),
              const Spacer(),
              Text(
                "${rate * 100}%",
                style: PengoStyle.text(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PayoutHistoryCard extends StatelessWidget {
  const PayoutHistoryCard({
    Key? key,
    required this.list,
  }) : super(key: key);

  final List<Transaction> list;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.all(18),
      child: ListView.builder(
        itemCount: list.length,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          final Transaction transaction = list[index];
          return ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            minLeadingWidth: 10,
            leading: Container(
              margin: EdgeInsets.only(
                top: mediaQuery(context).size.height * 0.01,
              ),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: secondaryTextColor.withOpacity(0.5),
              ),
            ),
            title: Text(
              "Requested payout RM ${transaction.grossAmount}",
              style: PengoStyle.caption(context).copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            subtitle: Text(
              DateFormat('yyyy-MM-dd HH:mm:ss').format(transaction.createdAt),
              style: PengoStyle.captionNormal(context).copyWith(
                fontSize: 12,
              ),
            ),
          );
        },
      ),
    );
  }
}
