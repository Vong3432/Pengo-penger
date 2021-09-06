import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:penger/bloc/booking-categories/booking_category_bloc.dart';
import 'package:penger/bloc/booking-items/view/view_booking_item_bloc.dart';
import 'package:penger/config/color.dart';
import 'package:penger/const/space_const.dart';
import 'package:penger/helpers/theme/custom_font.dart';
import 'package:penger/helpers/theme/theme_helper.dart';
import 'package:penger/models/booking_category_model.dart';
import 'package:penger/models/booking_item_model.dart';
import 'package:penger/ui/booking-item/add_item_view.dart';
import 'package:penger/ui/booking-item/edit_item_view.dart';
import 'package:penger/ui/widgets/layout/sliver_appbar.dart';
import 'package:penger/ui/widgets/layout/sliver_body.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // state
  BookingCategory? _selectedCategory;
  GroupController controller = GroupController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadCategories();
  }

  void _loadCategories() {
    BlocProvider.of<BookingCategoryBloc>(context)
        .add(FetchBookingCategoriesEvent());
    BlocProvider.of<ViewItemBloc>(context).add(FetchBookingItemsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            heroTag: "add item",
            backgroundColor: primaryColor,
            onPressed: () {
              Navigator.of(context, rootNavigator: true)
                  .push(
                    CupertinoPageRoute(builder: (context) => AddItemView()),
                  )
                  .then((_) => _loadCategories());
            },
            child: const Icon(Icons.add_outlined),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSliverAppBar(
            title: Text(
              "Home",
              style: PengoStyle.navigationTitle(context),
            ),
          ),
          CustomSliverBody(
            content: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: <Widget>[
                    CupertinoSearchTextField(
                      onChanged: (String value) {
                        debugPrint('The text has changed to: $value');
                      },
                      onSubmitted: (String value) {
                        debugPrint('Submitted text: $value');
                      },
                    ),
                    const SizedBox(
                      height: SECTION_GAP_HEIGHT,
                    ),
                    _buildCategories(context),
                    _buildItems(context)
                    // CustomButton(
                    //   text: Text("Scan"),
                    //   onPressed: () {
                    //     Navigator.of(context).push(CupertinoPageRoute(
                    //       builder: (context) => QRScannerPage(),
                    //     ));
                    //   },
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  BlocBuilder<ViewItemBloc, ViewBookingItemState> _buildItems(
      BuildContext context) {
    return BlocBuilder(
        bloc: BlocProvider.of<ViewItemBloc>(context),
        builder: (BuildContext context, ViewBookingItemState state) {
          if (state is BookingItemsLoading) {
            return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 4),
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return SkeletonText(
                      height: mediaQuery(context).size.height / 2);
                });
          }
          if (state is BookingItemsLoaded) {
            return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 4,
                  childAspectRatio: MediaQuery.of(context).size.height / 1000,
                ),
                itemCount: state.items.length,
                itemBuilder: (BuildContext context, int index) {
                  final BookingItem item = state.items[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true)
                          .push(
                            CupertinoPageRoute(
                                builder: (context) =>
                                    EditItemView(itemId: item.id)),
                          )
                          .then((value) => _loadCategories());
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.network(
                          item.poster,
                          height: 160,
                        ),
                        Text(
                          item.title,
                          style: PengoStyle.caption(context),
                        ),
                        _buildDateAndTime(item, context)
                      ],
                    ),
                  );
                });
          }
          return Container();
        });
  }

  Widget _buildDateAndTime(BookingItem item, BuildContext context) {
    if (item.startFrom != null && item.endAt != null) {
      return Row(
        children: <Widget>[
          Text(
            "${DateFormat.yMd().format(item.startFrom!)}-${DateFormat.yMd().format(item.endAt!)}",
            style: PengoStyle.captionNormal(context),
          ),
        ],
      );
    }

    if (item.availableFrom != null && item.availableTo != null) {
      return Row(
        children: [
          Text(
            "${item.availableFrom}-${item.availableTo}",
            style: PengoStyle.smallerText(context),
          ),
        ],
      );
    }

    return Container();
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
          // return SizedBox(
          //   height: 50,
          //   child: ListView.separated(
          //       separatorBuilder:
          //           (BuildContext context, int index) {
          //         return const SizedBox(
          //           width: SECTION_GAP_HEIGHT,
          //         );
          //       },
          //       scrollDirection: Axis.horizontal,
          //       itemCount: state.categories.length,
          //       itemBuilder: (BuildContext context, int index) {
          //         final BookingCategory cat =
          //             state.categories[index];
          //         return ChoiceChip(
          //             label: Text(cat.name),
          //             onSelected: (bool v) {
          //               setState(() {
          //                 _selectedCategory = cat;
          //               });
          //             },
          //             selected: _selectedCategory == cat);
          //       }),
          // );
        }
        return Container();
      },
      bloc: BlocProvider.of<BookingCategoryBloc>(context),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
