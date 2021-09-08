import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:penger/bloc/booking-items/view/view_booking_item_bloc.dart';
import 'package:penger/bloc/coupons/create/add_coupon_bloc.dart';
import 'package:penger/config/color.dart';
import 'package:penger/const/space_const.dart';
import 'package:penger/helpers/theme/custom_font.dart';
import 'package:penger/models/booking_item_model.dart';
import 'package:penger/models/coupon_model.dart';
import 'package:penger/ui/widgets/button/custom_button.dart';
import 'package:penger/ui/widgets/input/custom_textfield.dart';
import 'package:penger/ui/widgets/layout/sliver_appbar.dart';
import 'package:penger/ui/widgets/layout/sliver_body.dart';

class AddCouponPage extends StatefulWidget {
  const AddCouponPage({Key? key}) : super(key: key);

  @override
  _AddCouponPageState createState() => _AddCouponPageState();
}

class _AddCouponPageState extends State<AddCouponPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameValidator = MultiValidator([
    RequiredValidator(errorText: 'Name cannot be empty'),
  ]);
  final _quantityValidator = MultiValidator([
    RequiredValidator(errorText: 'Quantiy cannot be empty'),
  ]);
  final _startFromValidator = MultiValidator([
    RequiredValidator(errorText: 'Start from cannot be empty'),
  ]);
  final _endAtValidator = MultiValidator([
    RequiredValidator(errorText: 'End at cannot be empty'),
  ]);
  final _minCreditPointsValidator = MultiValidator([
    RequiredValidator(errorText: 'Minimum credit points cannot be empty'),
  ]);

  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _quantityController;
  late TextEditingController _startFromController;
  late TextEditingController _endAtController;
  late TextEditingController _minimumCreditPointsController;
  late TextEditingController _requiredCreditPointsController;

  late DateTime _startFrom;
  late DateTime _endAt;
  bool _isActive = false;
  late List<BookingItem> _selectedItems = [];
  String _errRequiredMsg = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _quantityController = TextEditingController();
    _startFromController = TextEditingController();
    _endAtController = TextEditingController();
    _minimumCreditPointsController = TextEditingController(text: 0.toString());
    _requiredCreditPointsController = TextEditingController(text: 0.toString())
      ..addListener(() {
        _minimumCreditPointsController.text =
            _requiredCreditPointsController.text;
      });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddCouponBloc>(
      create: (context) => AddCouponBloc(),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Form(
          key: _formKey,
          child: Scaffold(
            body: CustomScrollView(
              slivers: <Widget>[
                CustomSliverAppBar(
                  title: Text(
                    "Create coupon",
                    style: PengoStyle.navigationTitle(context),
                  ),
                ),
                CustomSliverBody(
                  content: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        children: [
                          CustomTextField(
                            label: "Name",
                            validator: _nameValidator,
                            controller: _nameController,
                            hintText: "Shop sales",
                          ),
                          CustomTextField(
                            label: "Description",
                            controller: _descriptionController,
                            hintText: "Shop sales",
                            isOptional: true,
                          ),
                          CustomTextField(
                            label: "Quantity",
                            validator: _quantityValidator,
                            controller: _quantityController,
                            inputType: TextInputType.number,
                            hintText: "",
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "Start from",
                                style: PengoStyle.caption(context),
                              ),
                              const Spacer(),
                              Expanded(
                                flex: 8,
                                child: TextFormField(
                                  validator: _startFromValidator,
                                  controller: _startFromController,
                                  onTap: () {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    DatePicker.showDateTimePicker(context,
                                        minTime: DateTime.now(),
                                        onConfirm: (DateTime dt) {
                                      setState(() {
                                        _startFrom = dt;
                                      });
                                      _startFromController.text =
                                          DateFormat.yMEd()
                                              .add_jms()
                                              .format(dt);
                                    });
                                  },
                                  keyboardType: TextInputType.datetime,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: SECTION_GAP_HEIGHT,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "End at",
                                style: PengoStyle.caption(context),
                              ),
                              const Spacer(),
                              Expanded(
                                flex: 8,
                                child: TextFormField(
                                  validator: _endAtValidator,
                                  controller: _endAtController,
                                  onTap: () {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    DatePicker.showDateTimePicker(context,
                                        minTime: DateTime.now(),
                                        onConfirm: (DateTime dt) {
                                      setState(() {
                                        _endAt = dt;
                                      });
                                      _endAtController.text = DateFormat.yMEd()
                                          .add_jms()
                                          .format(dt);
                                    });
                                  },
                                  keyboardType: TextInputType.datetime,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: SECTION_GAP_HEIGHT,
                          ),
                          CustomTextField(
                            validator: _minCreditPointsValidator,
                            label: "Minimum credit points",
                            inputType: TextInputType.number,
                            controller: _minimumCreditPointsController,
                            hintText: "",
                            sideNote: Text(
                              "Max: 5000",
                              style: PengoStyle.smallerText(context).copyWith(
                                color: grayTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          CustomTextField(
                            controller: _requiredCreditPointsController,
                            label: "Required credit points",
                            isOptional: true,
                            inputType: TextInputType.number,
                            hintText: "",
                            onChanged: (_) {
                              setState(() {
                                _errRequiredMsg = "";
                              });
                            },
                            sideNote: Text(
                              _errRequiredMsg.isEmpty
                                  ? "Only required when you want to specific the credit points amount. Max: 5000"
                                  : _errRequiredMsg,
                              style: PengoStyle.smallerText(context).copyWith(
                                color: _errRequiredMsg.isEmpty
                                    ? grayTextColor
                                    : dangerColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          CheckboxListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: Text(
                              "Active now",
                              style: PengoStyle.caption(context),
                            ),
                            subtitle: Text(
                              "Allow users to redeem right after published.",
                              style: PengoStyle.text(context),
                            ),
                            value: _isActive,
                            onChanged: (bool? val) {
                              if (val == null) return;
                              setState(() {
                                _isActive = val;
                              });
                            },
                          ),
                          const SizedBox(
                            height: SECTION_GAP_HEIGHT,
                          ),
                          CustomTextField(
                            readOnly: true,
                            label: "Applicable to",
                            hintText: _selectedItems.isEmpty
                                ? ''
                                : _displaySelectedItemName(),
                            onTap: _showBookingItemsDialog,
                          ),
                          const SizedBox(
                            height: SECTION_GAP_HEIGHT,
                          ),
                          BlocConsumer<AddCouponBloc, AddCouponState>(
                            listener:
                                (BuildContext context, AddCouponState state) {
                              // TODO: implement listener
                              if (state is AddCouponSuccess) {
                                Fluttertoast.showToast(
                                  msg: "Added successfully",
                                  backgroundColor: successColor,
                                  textColor: whiteColor,
                                  toastLength: Toast.LENGTH_LONG,
                                );
                              } else if (state is AddCouponFailed) {
                                Fluttertoast.showToast(
                                  msg: state.e.toString(),
                                  backgroundColor: dangerColor,
                                  textColor: whiteColor,
                                  toastLength: Toast.LENGTH_LONG,
                                );
                              }
                            },
                            builder:
                                (BuildContext context, AddCouponState state) {
                              if (state is AddCouponLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return CustomButton(
                                text: const Text("Save"),
                                onPressed: () => _onSaved(context),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _checkRequiredValid() {
    if (_requiredCreditPointsController.text.isEmpty) {
      return true;
    }
    final double _required =
        double.tryParse(_requiredCreditPointsController.text) ?? 0;
    final double _min =
        double.tryParse(_minimumCreditPointsController.text) ?? 0;

    final bool result = _required >= _min;

    if (result) {
      setState(() {
        _errRequiredMsg = "";
      });
    }

    return result;
  }

  String _displaySelectedItemName() {
    return _selectedItems
        .map((BookingItem item) => item.title)
        .join(',')
        .toString();
  }

  void _showBookingItemsDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return BlocBuilder<ViewItemBloc, ViewBookingItemState>(
          builder: (BuildContext context, ViewBookingItemState state) {
            if (state is BookingItemsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is BookingItemsLoaded) {
              final List<MultiSelectItem<BookingItem>> _items = state.items
                  .map((item) => MultiSelectItem<BookingItem>(item, item.title))
                  .toList();

              return MultiSelectDialog(
                items: _items,
                initialValue: _selectedItems,
                onConfirm: (List<BookingItem> values) {
                  setState(() {
                    _selectedItems = values;
                  });
                },
              );
            }
            return Container();
          },
        );
      },
    );
  }

  void _fetchItems() {
    BlocProvider.of<ViewItemBloc>(context).add(FetchBookingItemsEvent());
  }

  void _onSaved(BuildContext context) {
    if (_checkRequiredValid() == false) {
      setState(() {
        _errRequiredMsg =
            "Required credit points must bigger than min. credit points.";
      });
      return;
    }

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final List<int> ids =
          _selectedItems.map((BookingItem item) => item.id).toList();
      BlocProvider.of<AddCouponBloc>(context).add(
        CreateCouponEvent(
          Coupon(
            itemIds: ids,
            title: _nameController.text,
            description: _descriptionController.text,
            validFrom: DateFormat('yyyy-MM-dd hh:mm:ss').format(_startFrom),
            validTo: DateFormat('yyyy-MM-dd hh:mm:ss').format(_endAt),
            quantity: int.parse(_quantityController.text),
            minCreditPoints: double.parse(_minimumCreditPointsController.text),
            requiredCreditPoints:
                _requiredCreditPointsController.text.isNotEmpty
                    ? double.parse(_requiredCreditPointsController.text)
                    : null,
            isRedeemable: _isActive,
          ),
        ),
      );
    } else {
      Fluttertoast.showToast(
        msg: "Please make sure you fill in all fields correctly.",
        backgroundColor: dangerColor,
        toastLength: Toast.LENGTH_LONG,
        textColor: whiteColor,
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _quantityController.dispose();
    _startFromController.dispose();
    _endAtController.dispose();
    _minimumCreditPointsController.dispose();
    _requiredCreditPointsController.dispose();
  }
}
