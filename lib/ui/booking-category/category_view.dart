import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:penger/bloc/booking-categories/create/create_booking_category_bloc.dart';
import 'package:penger/bloc/booking-categories/edit/edit_booking_category_bloc.dart';
import 'package:penger/bloc/booking-categories/view/view_booking_category_bloc.dart';
import 'package:penger/bloc/system-functions/view/view_system_functions_bloc.dart';
import 'package:penger/config/color.dart';
import 'package:penger/const/space_const.dart';
import 'package:penger/helpers/theme/custom_font.dart';
import 'package:penger/helpers/theme/theme_helper.dart';
import 'package:penger/helpers/toast/toast_helper.dart';
import 'package:penger/models/booking_category_model.dart';
import 'package:penger/ui/booking-category/widgets/category_form.dart';
import 'package:penger/ui/system-functions/widgets/system_function_list.dart';
import 'package:penger/ui/widgets/api/loading.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({Key? key, required this.category}) : super(key: key);

  final BookingCategory category;

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.all(18),
        height: mediaQuery(context).size.height * 1,
        child: _buildViewCategoryContent(context),
      ),
    );
  }

  Widget _buildViewCategoryContent(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            "View category",
            style: PengoStyle.title(context).copyWith(
              color: secondaryTextColor,
            ),
          ),
        ),
        const SizedBox(
          height: SECTION_GAP_HEIGHT,
        ),
        BlocConsumer<ViewBookingCategoryBloc, ViewBookingCategoryState>(
          listener: (BuildContext context, ViewBookingCategoryState state) {
            // TODO: implement listener
            if (state is BookingCategoryNotLoaded) {
              showToast(
                msg: "Not able to load category",
                backgroundColor: dangerColor,
                textColor: whiteColor,
              );
            }
          },
          builder: (BuildContext context, ViewBookingCategoryState state) {
            if (state is BookingCategoryLoading) {
              return const LoadingWidget();
            }
            if (state is BookingCategoryLoaded) {
              final BookingCategory fetchedCategory = state.category;
              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: mediaQuery(context).size.width * 0.7,
                          child: Text(
                            fetchedCategory.name,
                            style: PengoStyle.navigationTitle(context),
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            showCupertinoModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) =>
                                  MultiBlocProvider(
                                providers: [
                                  BlocProvider<CreateBookingCategoryBloc>(
                                    create: (context) =>
                                        CreateBookingCategoryBloc(),
                                  ),
                                  BlocProvider<EditBookingCategoryBloc>(
                                    create: (context) =>
                                        EditBookingCategoryBloc(),
                                  ),
                                ],
                                child: CategoryForm(
                                  isEditing: true,
                                  category: fetchedCategory,
                                ),
                              ),
                            ).then((_) => _load());
                          },
                          icon: Icon(
                            Icons.edit,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: SECTION_GAP_HEIGHT,
                    ),
                    SystemFunctionList(
                      category: fetchedCategory,
                    ),
                    const SizedBox(
                      height: SECTION_GAP_HEIGHT,
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
        )
      ],
    );
  }

  Future<void> _load() async {
    BlocProvider.of<ViewBookingCategoryBloc>(context)
        .add(FetchBookingCategoryEvent(widget.category.id!));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
