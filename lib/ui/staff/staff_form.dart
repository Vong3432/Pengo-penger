import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:penger/bloc/staff/staff_bloc.dart';
import 'package:penger/config/color.dart';
import 'package:penger/const/space_const.dart';
import 'package:penger/extensions/string_extension.dart';
import 'package:penger/helpers/theme/custom_font.dart';
import 'package:penger/helpers/theme/theme_helper.dart';
import 'package:penger/helpers/toast/toast_helper.dart';
import 'package:penger/models/user_model.dart';
import 'package:penger/ui/widgets/button/custom_button.dart';
import 'package:penger/ui/widgets/input/custom_textfield.dart';

class StaffForm extends StatefulWidget {
  const StaffForm({
    Key? key,
    this.staff,
  }) : super(key: key);

  final User? staff;

  @override
  _StaffFormState createState() => _StaffFormState();
}

class _StaffFormState extends State<StaffForm> {
  bool _isEditing = false;

  final StaffBloc _bloc = StaffBloc();

  // controllers
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _ageController;

  final _key = GlobalKey<FormState>();

  // validators
  final _nameValidator = MultiValidator([
    RequiredValidator(errorText: 'Name cannot be empty'),
  ]);
  final _phoneValidator = MultiValidator([
    RequiredValidator(errorText: 'Phone cannot be empty'),
    MaxLengthValidator(10, errorText: 'Your phone is incorrect format')
  ]);
  final _emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email cannot be empty'),
  ]);
  final _ageValidator = MultiValidator([
    RequiredValidator(errorText: 'Age cannot be empty'),
  ]);
  final _passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password cannot be empty'),
    MinLengthValidator(8, errorText: 'Minimum password length is 8')
  ]);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.staff != null) {
      _isEditing = true;
    }

    _nameController = TextEditingController(text: widget.staff?.username ?? "");
    _phoneController =
        TextEditingController(text: widget.staff?.phone.withoutPhone() ?? "");
    _emailController = TextEditingController(text: widget.staff?.email ?? "");
    _passwordController =
        TextEditingController(text: widget.staff?.password ?? "");
    _ageController =
        TextEditingController(text: widget.staff?.age.toString() ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StaffBloc>(
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
                    "${_isEditing ? "Edit" : "Create"} staff",
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
                  CustomTextField(
                    label: "Password",
                    controller: _passwordController,
                    obsecureText: true,
                    hintText: "",
                    validator: _passwordValidator,
                    contentPadding: const EdgeInsets.all(8),
                  ),
                  CustomTextField(
                    label: "Phone",
                    controller: _phoneController,
                    hintText: "0123456789",
                    validator: _phoneValidator,
                    contentPadding: const EdgeInsets.all(8),
                  ),
                  CustomTextField(
                    label: "Email",
                    controller: _emailController,
                    hintText: "johndoe@gmail.com",
                    validator: _emailValidator,
                    contentPadding: const EdgeInsets.all(8),
                  ),
                  CustomTextField(
                    label: "Age",
                    controller: _ageController,
                    hintText: "",
                    validator: _ageValidator,
                    contentPadding: const EdgeInsets.all(8),
                  ),
                  const SizedBox(
                    height: SECTION_GAP_HEIGHT,
                  ),
                  BlocConsumer<StaffBloc, StaffState>(
                    listener: (BuildContext context, StaffState state) {
                      // TODO: implement listener
                      if (state is StaffNotAdded) {
                        showToast(msg: state.e.toString());
                      }
                      if (state is StaffAdded) {
                        showToast(
                          msg: state.response.msg ?? "Added",
                          backgroundColor: successColor,
                        );
                      }
                      if (state is StaffUpdated) {
                        showToast(
                          msg: state.response.msg ?? "Updated",
                          backgroundColor: successColor,
                        );
                      }
                      if (state is StaffNotUpdated) {
                        showToast(msg: state.e.toString());
                      }
                    },
                    builder: (BuildContext context, StaffState state) {
                      return CustomButton(
                        isLoading:
                            state is StaffAdding || state is StaffUpdating,
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

  void _save() {
    if (_key.currentState!.validate()) {
      if (_isEditing) {
        // edit
        _bloc.add(
          EditStaff(
            id: widget.staff!.id,
            password: _passwordController.text,
            age: int.parse(_ageController.text),
            email: _emailController.text,
            phone: _phoneController.text,
            name: _nameController.text,
          ),
        );
      } else {
        // create
        _bloc.add(
          AddStaff(
            password: _passwordController.text,
            age: int.parse(_ageController.text),
            email: _emailController.text,
            phone: _phoneController.text,
            name: _nameController.text,
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
    _ageController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
  }
}
