import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:penger/bloc/booking-categories/create/create_booking_category_bloc.dart';
import 'package:penger/bloc/booking-categories/edit/edit_booking_category_bloc.dart';
import 'package:penger/config/color.dart';
import 'package:penger/const/space_const.dart';
import 'package:penger/const/text_const.dart';
import 'package:penger/helpers/theme/custom_font.dart';
import 'package:penger/helpers/theme/theme_helper.dart';
import 'package:penger/helpers/toast/toast_helper.dart';
import 'package:penger/models/booking_category_model.dart';
import 'package:penger/ui/widgets/button/custom_button.dart';
import 'package:penger/ui/widgets/input/custom_textfield.dart';
import 'package:provider/src/provider.dart';

class CategoryForm extends StatefulWidget {
  const CategoryForm({Key? key, this.category, this.isEditing})
      : super(key: key);
  final BookingCategory? category;
  final bool? isEditing;

  @override
  _CategoryFormState createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  late TextEditingController _nameController;
  final _nameValidator = MultiValidator([
    RequiredValidator(errorText: 'Category name cannot be empty'),
  ]);
  final _formKey = GlobalKey<FormState>();
  bool _shouldEnable = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = TextEditingController();

    if (widget.isEditing == true && widget.category != null) {
      _nameController.text = widget.category!.name;
      _shouldEnable = widget.category!.isEnabled;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CreateBookingCategoryBloc, CreateBookingCategoryState>(
          listener: (BuildContext context, CreateBookingCategoryState state) {
            if (state is BookingCategoryAdded) {
              showToast(
                msg: state.response.msg ?? "Saved successfully",
                backgroundColor: successColor,
                textColor: whiteColor,
              );
            }
            if (state is BookingCategoryNotAdded) {
              showToast(
                msg: state.e.toString(),
                backgroundColor: dangerColor,
                textColor: whiteColor,
              );
            }
            // TODO: implement listener
          },
        ),
        BlocListener<EditBookingCategoryBloc, EditBookingCategoryState>(
          listener: (BuildContext context, EditBookingCategoryState state) {
            // TODO: implement listener
            if (state is BookingCategoryUpdated) {
              showToast(
                msg: state.response.msg ?? "Saved successfully",
                backgroundColor: successColor,
                textColor: whiteColor,
              );
            }
            if (state is BookingCategoryNotUpdated) {
              showToast(
                msg: state.e.toString(),
                backgroundColor: dangerColor,
                textColor: whiteColor,
              );
            }
          },
        ),
      ],
      child: Padding(
        padding: EdgeInsets.only(bottom: mediaQuery(context).viewInsets.bottom),
        child: Material(
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Container(
              padding: const EdgeInsets.all(18),
              height: mediaQuery(context).size.height * 0.4,
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Center(
                      child: Text(
                        "${widget.isEditing == true ? "Edit" : "Create"} category",
                        style: PengoStyle.title(context)
                            .copyWith(color: secondaryTextColor),
                      ),
                    ),
                    const SizedBox(
                      height: SECTION_GAP_HEIGHT,
                    ),
                    CustomTextField(
                      controller: _nameController,
                      validator: _nameValidator,
                      hintText: "",
                      label: "Name",
                      contentPadding: const EdgeInsets.all(10),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        "Enable",
                        style: PengoStyle.title2(context),
                      ),
                      trailing: CupertinoSwitch(
                        value: _shouldEnable,
                        onChanged: (bool value) {
                          setState(() {
                            _shouldEnable = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: SECTION_GAP_HEIGHT / 2,
                    ),
                    CustomButton(
                      onPressed: () => _save(context),
                      isLoading: _isSaving(),
                      text: const Text(
                        "Save",
                      ),
                    ),
                    const SizedBox(
                      height: SECTION_GAP_HEIGHT,
                    ),
                    if (widget.isEditing == null || widget.isEditing == false)
                      Text(
                        "* $CONFIGURE_FEATURES_FOR_NEW_CATEGORY_TEXT",
                        style: PengoStyle.captionNormal(context)
                            .copyWith(color: secondaryTextColor),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _isSaving() {
    return context.watch<CreateBookingCategoryBloc>().state
            is BookingCategoryAdding ||
        context.watch<EditBookingCategoryBloc>().state
            is BookingCategoryUpdating;
  }

  Future<void> _save(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (widget.isEditing == true) {
        // update API
        BlocProvider.of<EditBookingCategoryBloc>(context).add(
          UpdateBookingCategoryEvent(
            BookingCategory(
              id: widget.category!.id,
              isEnabled: _shouldEnable,
              name: _nameController.text,
            ),
          ),
        );
      } else {
        // create category API
        BlocProvider.of<CreateBookingCategoryBloc>(context).add(
          AddBookingCategoryEvent(
            BookingCategory(
              isEnabled: _shouldEnable,
              name: _nameController.text,
            ),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
  }
}
