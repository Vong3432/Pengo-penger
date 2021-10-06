import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:penger/bloc/booking-categories/create/create_booking_category_bloc.dart';
import 'package:penger/bloc/booking-categories/edit/edit_booking_category_bloc.dart';
import 'package:penger/bloc/booking-categories/view/view_booking_category_bloc.dart';
import 'package:penger/helpers/theme/custom_font.dart';
import 'package:penger/models/booking_category_model.dart';
import 'package:penger/ui/booking-category/category_view.dart';
import 'package:penger/ui/booking-category/widgets/category_form.dart';
import 'package:penger/ui/booking-category/widgets/category_tile.dart';
import 'package:penger/ui/widgets/api/error.dart';
import 'package:penger/ui/widgets/api/loading.dart';
import 'package:penger/ui/widgets/api/no_result.dart';
import 'package:penger/ui/widgets/layout/sliver_appbar.dart';
import 'package:penger/ui/widgets/layout/sliver_body.dart';

class CategoryListPage extends StatefulWidget {
  const CategoryListPage({Key? key}) : super(key: key);

  @override
  State<CategoryListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSliverAppBar(
              title: Text(
                "Categories",
                style: PengoStyle.navigationTitle(context),
              ),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    _showAddCategoryModal(context);
                  },
                  icon: Icon(Icons.add),
                ),
              ]),
          CustomSliverBody(
            content: <Widget>[
              Container(
                padding: const EdgeInsets.all(18),
                child: BlocBuilder<ViewBookingCategoryBloc,
                    ViewBookingCategoryState>(
                  builder:
                      (BuildContext context, ViewBookingCategoryState state) {
                    if (state is BookingCategoriesLoading) {
                      return const LoadingWidget();
                    }
                    if (state is BookingCategoriesNotLoaded) {
                      return const ErrorResultWidget();
                    }
                    if (state is BookingCategoriesLoaded) {
                      if (state.categories.isEmpty) {
                        return const NoResultWidget();
                      }
                      return ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          final BookingCategory category =
                              state.categories[index];
                          return CategoryListTile(
                            category: category,
                            onTap: () =>
                                _showEditCategoryModal(context, category),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            height: 2.5,
                          );
                        },
                        itemCount: state.categories.length,
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _loadCategories() async {
    BlocProvider.of<ViewBookingCategoryBloc>(context)
        .add(FetchBookingCategoriesEvent());
  }

  void _showAddCategoryModal(BuildContext context) {
    showCupertinoModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<CreateBookingCategoryBloc>(
              create: (context) => CreateBookingCategoryBloc(),
            ),
            BlocProvider<EditBookingCategoryBloc>(
              create: (context) => EditBookingCategoryBloc(),
            ),
          ],
          child: const CategoryForm(),
        );
      },
    ).then((_) => _reload());
  }

  void _showEditCategoryModal(BuildContext context, BookingCategory category) {
    showCupertinoModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return CategoryView(
          category: category,
        );
      },
    ).then((_) => _reload());
  }

  Future<void> _reload() async {
    _loadCategories();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    debugPrint("Leaving category list");
  }
}
