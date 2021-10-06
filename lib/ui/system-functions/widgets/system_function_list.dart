import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penger/bloc/booking-options/edit/edit_booking_option_bloc.dart';
import 'package:penger/bloc/system-functions/view/view_system_functions_bloc.dart';
import 'package:penger/config/color.dart';
import 'package:penger/const/space_const.dart';
import 'package:penger/helpers/theme/custom_font.dart';
import 'package:penger/helpers/toast/toast_helper.dart';
import 'package:penger/models/booking_category_model.dart';
import 'package:penger/models/system_function_model.dart';
import 'package:penger/ui/booking-category/widgets/category_function_tile.dart';
import 'package:penger/ui/widgets/api/loading.dart';
import 'package:penger/ui/widgets/button/custom_button.dart';
import 'package:collection/collection.dart';

class SystemFunctionList extends StatefulWidget {
  const SystemFunctionList({Key? key, this.category}) : super(key: key);
  final BookingCategory? category;

  @override
  _SystemFunctionListState createState() => _SystemFunctionListState();
}

class _SystemFunctionListState extends State<SystemFunctionList> {
  List<SystemFunction> _selectedFunctions = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _load();
    _setDefaultSelectedFunctions();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Features",
            style:
                PengoStyle.title2(context).copyWith(color: secondaryTextColor),
          ),
          BlocBuilder<ViewSystemFunctionsBloc, ViewSystemFunctionsState>(
            builder: (BuildContext context, ViewSystemFunctionsState state) {
              if (state is ViewSystemFunctionsLoading) {
                return const LoadingWidget();
              }
              if (state is ViewSystemFunctionsLoaded) {
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: state.systemFunctions.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 18.0),
                      child: Divider(height: 2.5),
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    final SystemFunction systemFunction =
                        state.systemFunctions[index];
                    final SystemFunction? matchedOption;
                    if (widget.category == null ||
                        widget.category!.bookingOptions!.isEmpty) {
                      matchedOption = null;
                    } else {
                      matchedOption =
                          widget.category!.bookingOptions!.firstWhereOrNull(
                        (SystemFunction element) =>
                            element.id == systemFunction.id,
                      );
                    }
                    return CategoryFunctionTile(
                      systemFunction: systemFunction,
                      matchedOption: matchedOption,
                      onSwitchChanged: (bool val) {
                        setState(() {
                          if (val) {
                            // activated
                            _selectedFunctions.add(systemFunction);
                          } else {
                            // deactivated
                            _selectedFunctions.remove(systemFunction);
                          }
                        });
                      },
                    );
                  },
                );
              }
              return Container();
            },
          ),
          const Spacer(),
          BlocListener<EditBookingOptionBloc, EditBookingOptionState>(
            listener: (BuildContext context, EditBookingOptionState state) {
              // TODO: implement listener
              // TODO: implement listener
              if (state is BookingOptionNotUpdated) {
                showToast(
                  msg: state.e.toString(),
                  textColor: whiteColor,
                  backgroundColor: dangerColor,
                );
              }
              if (state is BookingOptionUpdated) {
                showToast(
                  msg: state.response.msg ?? "Saved successfully",
                  textColor: whiteColor,
                  backgroundColor: successColor,
                );
              }
            },
            child: CustomButton(
              isLoading: _isSaving(),
              text: const Text("Save"),
              onPressed: _saveSystemFunctionSetting,
            ),
          ),
        ],
      ),
    );
  }

  bool _isSaving() {
    return context.watch<EditBookingOptionBloc>().state
        is BookingOptionUpdating;
  }

  void _setDefaultSelectedFunctions() {
    if (widget.category != null) {
      if (widget.category?.bookingOptions != null) {
        _selectedFunctions.addAll(widget.category!.bookingOptions!);
      }
    }
  }

  Future<void> _saveSystemFunctionSetting() async {
    if (widget.category != null) {
      BlocProvider.of<EditBookingOptionBloc>(context).add(
          UpdateBookingOptionEvent(widget.category!.id!, _selectedFunctions));
    }
  }

  Future<void> _load() async {
    BlocProvider.of<ViewSystemFunctionsBloc>(context)
        .add(FetchSystemFunctionsEvent());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
