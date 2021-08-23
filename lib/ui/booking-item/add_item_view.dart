import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:penger/bloc/booking-categories/booking_category_bloc.dart';
import 'package:penger/config/color.dart';
import 'package:penger/helpers/theme/custom_font.dart';
import 'package:penger/helpers/theme/theme_helper.dart';
import 'package:penger/models/booking_category_model.dart';
import 'package:penger/ui/booking-item/widgets/item_step_tile.dart';
import 'package:penger/ui/widgets/layout/sliver_appbar.dart';
import 'package:penger/ui/widgets/layout/sliver_body.dart';
import 'package:penger/ui/widgets/list/custom_list_item.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class AddItemView extends StatefulWidget {
  const AddItemView({Key? key}) : super(key: key);

  @override
  _AddItemViewState createState() => _AddItemViewState();
}

class _AddItemViewState extends State<AddItemView> {
  GroupController controller = GroupController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _loadCategories() {
    BlocProvider.of<BookingCategoryBloc>(context)
        .add(FetchBookingCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final List<ItemStepTile> _tiles = <ItemStepTile>[
      ItemStepTile(
        stepNum: 1,
        title: "Select category",
        subtitle: "Pick one for your booking item",
        isCompleted: false,
        onTap: () {
          _loadCategories();
          showCupertinoModalBottomSheet(
            context: context,
            builder: (BuildContext context) => Material(
              child: Container(
                padding: const EdgeInsets.all(18),
                height: mediaQuery(context).size.height * 0.4,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Select category",
                      style: PengoStyle.header(context),
                    ),
                    _buildCategories(context),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      ItemStepTile(
        stepNum: 2,
        title: "Complete info",
        subtitle: "Let people knows more about this item",
        isCompleted: false,
        onTap: () {},
      ),
      ItemStepTile(
        stepNum: 3,
        title: "Configure",
        subtitle: "Configure booking slot",
        isCompleted: false,
        onTap: () {},
      ),
      ItemStepTile(
        stepNum: 4,
        title: "Reward",
        subtitle: "Stay connect with your customer",
        isCompleted: false,
        onTap: () {},
      ),
      ItemStepTile(
        stepNum: 5,
        title: "Completed",
        subtitle: "Ready to publish",
        isCompleted: false,
        onTap: () {},
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
                children: [
                  ListView.builder(
                      itemCount: _tiles.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return _tiles[index];
                      })
                ],
              ),
            ),
          ]),
        ],
      ),
    );
  }

  BlocBuilder<BookingCategoryBloc, BookingCategoryState> _buildCategories(
      BuildContext context) {
    return BlocBuilder(
      builder: (BuildContext context, BookingCategoryState state) {
        if (state is BookingCategoriesLoading) {
          return const SkeletonText(
            height: 25,
          );
        }
        if (state is BookingCategoriesLoaded) {
          return SimpleGroupedChips<BookingCategory>(
            controller: controller,
            values: state.categories,
            itemTitle: state.categories.map((e) => e.name).toList(),
            chipGroupStyle: ChipGroupStyle.minimize(
              backgroundColorItem: greyBgColor,
              selectedColorItem: primaryColor,
              itemTitleStyle: PengoStyle.caption(context),
            ),
          );
        }
        return Container();
      },
      bloc: BlocProvider.of<BookingCategoryBloc>(context),
    );
  }
}
