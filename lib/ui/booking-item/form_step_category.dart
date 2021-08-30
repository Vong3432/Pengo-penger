import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penger/bloc/booking-categories/booking_category_bloc.dart';
import 'package:penger/config/color.dart';
import 'package:penger/helpers/theme/custom_font.dart';
import 'package:penger/helpers/theme/theme_helper.dart';
import 'package:penger/models/booking_category_model.dart';
import 'package:penger/models/providers/booking_item_model.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class FormStepCategory extends StatefulWidget {
  const FormStepCategory({Key? key}) : super(key: key);

  @override
  _FormStepCategoryState createState() => _FormStepCategoryState();
}

class _FormStepCategoryState extends State<FormStepCategory> {
  final GroupController controller = GroupController();

  @override
  void initState() {
    // TODO: implement initState
    _loadCategories();
    controller.listen((c) {
      BookingCategory? parsedC = c as BookingCategory;
      context.read<BookingItemModel>().setCategoryId(parsedC.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
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

  void _loadCategories() {
    BlocProvider.of<BookingCategoryBloc>(context)
        .add(FetchBookingCategoriesEvent());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
