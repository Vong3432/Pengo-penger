import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:penger/bloc/booking-close-dates/booking_close_date_bloc.dart';
import 'package:penger/bloc/staff/staff_bloc.dart';
import 'package:penger/config/color.dart';
import 'package:penger/const/space_const.dart';
import 'package:penger/extensions/string_extension.dart';
import 'package:penger/helpers/storage/shared_preference_helper.dart';
import 'package:penger/helpers/theme/custom_font.dart';
import 'package:penger/helpers/theme/theme_helper.dart';
import 'package:penger/helpers/toast/toast_helper.dart';
import 'package:penger/models/auth_model.dart';
import 'package:penger/models/booking_close_date_model.dart';
import 'package:penger/models/providers/auth_model.dart';
import 'package:penger/models/user_model.dart';
import 'package:penger/ui/widgets/button/custom_button.dart';
import 'package:penger/ui/widgets/input/custom_textfield.dart';

class CloseDateForm extends StatefulWidget {
  const CloseDateForm({
    Key? key,
    this.date,
  }) : super(key: key);

  final BookingCloseDate? date;

  @override
  _CloseDateFormState createState() => _CloseDateFormState();
}

class _CloseDateFormState extends State<CloseDateForm> {
  bool _isEditing = false;

  final BookingCloseDateBloc _bloc = BookingCloseDateBloc();

  // controllers
  late TextEditingController _nameController;
  late TextEditingController _fromController;
  late TextEditingController _toController;

  final _key = GlobalKey<FormState>();

  // validators
  final _nameValidator = MultiValidator([
    RequiredValidator(errorText: 'Name cannot be empty'),
  ]);
  final _fromValidator = MultiValidator([
    RequiredValidator(errorText: 'Date cannot be empty'),
  ]);
  final _toValidator = MultiValidator([
    RequiredValidator(errorText: 'Date cannot be empty'),
  ]);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.date != null) {
      _isEditing = true;
    }

    _nameController = TextEditingController(text: widget.date?.name ?? "");
    _fromController = TextEditingController(text: widget.date != null ? DateFormat("yyyy-MM-dd").format(widget.date!.from!.add(const Duration(days: 1)).toLocal()) : "");
    _toController = TextEditingController(text: widget.date != null ? DateFormat("yyyy-MM-dd").format(widget.date!.to!.add(const Duration(days: 1)).toLocal()) : "");
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookingCloseDateBloc>(
      create: (context) => _bloc,
      child: Material(
        child: Form(
          key: _key,
          child: Container(
            height: mediaQuery(context).size.height * 0.7,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 28),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${_isEditing ? "Edit" : "Create"} close date",
                    style: PengoStyle.header(context),
                  ),
                  const SizedBox(
                    height: SECTION_GAP_HEIGHT,
                  ),
                  CustomTextField(
                    label: "Name",
                    controller: _nameController,
                    hintText: "Name",
                    validator: _nameValidator,
                    contentPadding: const EdgeInsets.all(8),
                  ),
                  const SizedBox(
                    height: SECTION_GAP_HEIGHT,
                  ),
                  Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Start from",
                            style: PengoStyle.title2(context),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Expanded(
                        flex: 8,
                        child: TextFormField(
                          controller: _fromController,
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            DatePicker.showDatePicker(context,
                                minTime: DateTime.now(),
                                onConfirm: (DateTime dt) {
                              _fromController.text =
                                  DateFormat('yyyy-MM-dd').format(dt);
                            });
                          },
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: SECTION_GAP_HEIGHT * 2,
                  ),
                  Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "End date",
                            style: PengoStyle.title2(context),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Expanded(
                        flex: 8,
                        child: TextFormField(
                          controller: _toController,
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            DatePicker.showDatePicker(context,
                                minTime: DateTime.now(),
                                onConfirm: (DateTime dt) {
                              _toController.text =
                                  DateFormat('yyyy-MM-dd').format(dt);
                            });
                          },
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: SECTION_GAP_HEIGHT * 2,
                  ),
                  BlocConsumer<BookingCloseDateBloc, BookingCloseDateState>(
                    listener:
                        (BuildContext context, BookingCloseDateState state) {
                      // TODO: implement listener
                      if (state is BookingCloseDateNotAdded) {
                        showToast(msg: state.e.toString());
                      }
                      if (state is BookingCloseDateAdded) {
                        showToast(
                          msg: state.response.msg ?? "Added",
                          backgroundColor: successColor,
                        );
                      }
                      if (state is BookingCloseDateUpdated) {
                        showToast(
                          msg: state.response.msg ?? "Updated",
                          backgroundColor: successColor,
                        );
                      }
                      if (state is BookingCloseDateNotUpdated) {
                        showToast(msg: state.e.toString());
                      }
                    },
                    builder:
                        (BuildContext context, BookingCloseDateState state) {
                      return CustomButton(
                        isLoading: state is BookingCloseDateAdding ||
                            state is BookingCloseDateUpdating,
                        onPressed: _save,
                        text: const Text("Save"),
                      );
                    },
                  ),
                  const SizedBox(
                    height: SECTION_GAP_HEIGHT,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (_key.currentState!.validate()) {
      if (_isEditing) {
        // edit
        _bloc.add(
          UpdateCloseDate(
            id: widget.date!.id!,
            type: widget.date!.type,
            to: _toController.text,
            from: _fromController.text,
            keyId: widget.date!.keyId!,
            name: _nameController.text,
          ),
        );
      } else {
        // create
        final prefs = await SharedPreferencesHelper().getKey("user");

        if (prefs == null) return;
        final Auth auth =
            Auth.fromJson(jsonDecode(prefs) as Map<String, dynamic>);

        if (auth.selectedPenger?.id == null) return;

        _bloc.add(
          AddCloseDate(
            keyId: auth.selectedPenger!.id,
            name: _nameController.text,
            from: _fromController.text,
            to: _toController.text,
            // currently only can close for organization
            type: CloseDateType.ORGANIZATION,
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
    _fromController.dispose();
    _toController.dispose();
  }
}
