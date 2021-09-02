import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penger/bloc/booking-categories/booking_category_bloc.dart';
import 'package:penger/config/color.dart';
import 'package:penger/helpers/theme/custom_font.dart';
import 'package:penger/helpers/theme/theme_helper.dart';
import 'package:penger/models/booking_category_model.dart';
import 'package:penger/models/providers/booking_item_model.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class FormStepCategory extends StatefulWidget {
  const FormStepCategory({Key? key}) : super(key: key);

  @override
  _FormStepCategoryState createState() => _FormStepCategoryState();
}

class _FormStepCategoryState extends State<FormStepCategory> {
  @override
  void initState() {
    // TODO: implement initState
    _loadCategories();
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
          return SizedBox(
            height: 70,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: state.categories.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    width: 10,
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  final BookingCategory cat = state.categories[index];
                  final bool isSelected =
                      cat.id == context.watch<BookingItemModel>().categoryId;
                  return ChoiceChip(
                    label: Text(
                      cat.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isSelected ? whiteColor : primaryColor),
                    ),
                    selectedColor: primaryColor,
                    backgroundColor: primaryLightColor,
                    selected: isSelected,
                    onSelected: (bool v) {
                      context.read<BookingItemModel>().setCategoryId(cat.id);
                    },
                  );
                }),
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
    debugPrint("Dispose");
    super.dispose();
  }
}