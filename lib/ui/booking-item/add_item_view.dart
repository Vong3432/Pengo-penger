import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:penger/bloc/booking-items/create/create_booking_item_bloc.dart';
import 'package:penger/config/color.dart';
import 'package:penger/const/space_const.dart';
import 'package:penger/helpers/theme/custom_font.dart';
import 'package:penger/helpers/theme/theme_helper.dart';
import 'package:penger/models/providers/booking_item_model.dart';
import 'package:penger/ui/booking-item/form_step_category.dart';
import 'package:penger/ui/booking-item/form_step_configure.dart';
import 'package:penger/ui/booking-item/form_step_info.dart';
import 'package:penger/ui/booking-item/form_step_reward.dart';
import 'package:penger/ui/booking-item/widgets/item_step_tile.dart';
import 'package:penger/ui/widgets/api/loading.dart';
import 'package:penger/ui/widgets/button/custom_button.dart';
import 'package:penger/ui/widgets/layout/sliver_appbar.dart';
import 'package:penger/ui/widgets/layout/sliver_body.dart';
import 'package:provider/provider.dart';

class AddItemView extends StatefulWidget {
  const AddItemView({Key? key}) : super(key: key);

  @override
  _AddItemViewState createState() => _AddItemViewState();
}

class _AddItemViewState extends State<AddItemView> {
  late BookingItemModel _itemProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<ItemStepTile> _tiles = <ItemStepTile>[
      ItemStepTile(
        stepNum: 1,
        title: "Select category",
        subtitle: "Pick one for your booking item",
        isCompleted: _isStepOneCompleted(),
        onTap: () {
          showCupertinoModalBottomSheet(
              context: context,
              builder: (BuildContext context) => const FormStepCategory());
        },
      ),
      ItemStepTile(
        stepNum: 2,
        title: "Complete info",
        subtitle: "Let people knows more about this item",
        isCompleted: _isStepTwoCompleted(),
        onTap: !_isStepOneCompleted()
            ? null
            : () {
                showCupertinoModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: mediaQuery(context).viewInsets.bottom),
                        child: const FormStepInfo(),
                      );
                    });
              },
      ),
      ItemStepTile(
        stepNum: 3,
        title: "Configure",
        subtitle: "Configure booking slot",
        isCompleted: _isStepThreeCompleted(),
        onTap: !_isStepTwoCompleted()
            ? null
            : () {
                showCupertinoModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: mediaQuery(context).viewInsets.bottom),
                        child: const FormStepConfigure(),
                      );
                    });
              },
      ),
      ItemStepTile(
        stepNum: 4,
        title: "Reward",
        subtitle: "Stay connect with your customer",
        isCompleted: _isStepThreeCompleted() && _itemProvider.isStepFourDone,
        onTap: !_isStepThreeCompleted()
            ? null
            : () {
                showCupertinoModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return const FormStepReward();
                    });
              },
      ),
      ItemStepTile(
        stepNum: 5,
        title: "Completed",
        subtitle: "Ready to publish",
        isCompleted: _isStepFiveCompleted(),
        onTap: !_isStepFourCompleted() ? null : () {},
      ),
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSliverAppBar(
            title: Text(
              "Create",
              style: PengoStyle.navigationTitle(context),
            ),
          ),
          CustomSliverBody(content: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListView.builder(
                    itemCount: _tiles.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return _tiles[index];
                    },
                  ),
                  const SizedBox(
                    height: SECTION_GAP_HEIGHT * 2,
                  ),
                  BlocConsumer<CreateBookingBloc, CreateBookingItemState>(
                    listener: (context, state) {
                      // TODO: implement listener
                      if (state is AddBookingItemSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text(state.response.msg ?? 'Add successfully'),
                          backgroundColor: primaryColor,
                        ));
                      }
                      if (state is AddBookingItemFailed) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(state.e.toString()),
                          backgroundColor: dangerColor,
                        ));
                      }
                    },
                    builder: (context, state) {
                      if (state is AddBookingItemLoading) {
                        return const LoadingWidget();
                      } else {
                        return _isStepFiveCompleted()
                            ? CustomButton(
                                text: const Text("Create"),
                                onPressed: _submit,
                              )
                            : Container();
                      }
                    },
                  ),
                ],
              ),
            ),
          ]),
        ],
      ),
    );
  }

  bool _isStepOneCompleted() {
    return context.watch<BookingItemModel>().categoryId != null;
  }

  bool _isStepTwoCompleted() {
    return _isStepOneCompleted() &&
        context.watch<BookingItemModel>().name.isNotEmpty &&
        context.watch<BookingItemModel>().poster != null &&
        context.watch<BookingItemModel>().location.isNotEmpty;
  }

  bool _isStepThreeCompleted() {
    return _isStepTwoCompleted() &&
        context.watch<BookingItemModel>().startFrom != null &&
        context.watch<BookingItemModel>().endAt != null;
  }

  bool _isStepFourCompleted() {
    return _isStepThreeCompleted() &&
        context.watch<BookingItemModel>().isStepFourDone == true;
  }

  bool _isStepFiveCompleted() {
    return _isStepFourCompleted();
  }

  void _submit() {
    final BookingItemModel itemModel =
        Provider.of<BookingItemModel>(context, listen: false);

    BlocProvider.of<CreateBookingBloc>(context)
        .add(AddBookingItemEvent(itemModel));
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    _itemProvider = Provider.of<BookingItemModel>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _itemProvider.disposeBookingItemModel();
    super.dispose();
  }
}
