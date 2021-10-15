import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:penger/bloc/booking-items/edit/edit_booking_item_bloc.dart';
import 'package:penger/bloc/booking-items/view/view_booking_item_bloc.dart';
import 'package:penger/config/color.dart';
import 'package:penger/const/space_const.dart';
import 'package:penger/helpers/theme/custom_font.dart';
import 'package:penger/helpers/theme/theme_helper.dart';
import 'package:penger/models/booking_item_model.dart';
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

class EditItemView extends StatefulWidget {
  const EditItemView({
    Key? key,
    required this.itemId,
  }) : super(key: key);

  final int itemId;

  @override
  _EditItemViewState createState() => _EditItemViewState();
}

class _EditItemViewState extends State<EditItemView> {
  late BookingItemModel _itemProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // fetch and set the items
    _getItemInfo();
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
              "Edit",
              style: PengoStyle.navigationTitle(context),
            ),
          ),
          CustomSliverBody(content: <Widget>[
            BlocConsumer<ViewItemBloc, ViewBookingItemState>(
              listener: (BuildContext context, ViewBookingItemState state) {
                if (state is BookingItemLoaded) {
                  setDefaultValue(state.item);
                }
              },
              builder: (BuildContext context, ViewBookingItemState state) {
                if (state is BookingItemLoading) {
                  return const LoadingWidget();
                }
                if (state is BookingItemLoaded) {
                  return _buildItemInfo(_tiles);
                }
                return Container();
              },
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildItemInfo(List<ItemStepTile> _tiles) {
    return Container(
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
          BlocConsumer<EditBookingItemBloc, EditBookingItemState>(
            listener: (BuildContext context, EditBookingItemState state) {
              // TODO: implement listener
              if (state is EditBookingItemSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.response.msg ?? 'Edit successfully'),
                  backgroundColor: primaryColor,
                ));
              }
              if (state is EditBookingItemFailed) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.e.toString()),
                  backgroundColor: dangerColor,
                ));
              }
            },
            builder: (BuildContext context, EditBookingItemState state) {
              if (state is EditBookingItemLoading) {
                return const CircularProgressIndicator();
              } else {
                return _isStepFiveCompleted()
                    ? CustomButton(
                        text: const Text("Edit"),
                        onPressed: _submit,
                      )
                    : Container();
              }
            },
          ),
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
        (context.watch<BookingItemModel>().poster != null ||
            context.watch<BookingItemModel>().posterUrl != null) &&
        context.watch<BookingItemModel>().location.isNotEmpty;
  }

  bool _isStepThreeCompleted() {
    return _isStepTwoCompleted() &&
        context.watch<BookingItemModel>().isStepThreeDone;
    // context.watch<BookingItemModel>().startFrom != null &&
    // context.watch<BookingItemModel>().endAt != null;
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

    BlocProvider.of<EditBookingItemBloc>(context)
        .add(EditBookingItemEvent(itemModel));
  }

  void setDefaultValue(BookingItem item) {
    context.read<BookingItemModel>().setBookingItem(item);
  }

  Future<void> _getItemInfo() async {
    BlocProvider.of<ViewItemBloc>(context)
        .add(FetchBookingItemEvent(widget.itemId));
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
