import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:penger/bloc/auth/auth_repo.dart';
import 'package:penger/config/color.dart';
import 'package:penger/helpers/storage/shared_preference_helper.dart';
import 'package:penger/helpers/theme/custom_font.dart';
import 'package:penger/helpers/toast/toast_helper.dart';
import 'package:penger/helpers/validation/validation_helper.dart';
import 'package:penger/models/auth_model.dart';
import 'package:penger/models/providers/auth_model.dart';
import 'package:penger/ui/widgets/button/custom_button.dart';
import 'package:penger/ui/widgets/input/custom_textfield.dart';
import 'package:penger/ui/widgets/input/image_upload_field.dart';
import 'package:penger/ui/widgets/layout/sliver_appbar.dart';
import 'package:penger/ui/widgets/layout/sliver_body.dart';
import 'package:provider/src/provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _phoneValidator = MultiValidator([
    RequiredValidator(errorText: 'Phone cannot be empty'),
    MinLengthValidator(10, errorText: 'Your phone is incorrect format'),
    // MaxLengthValidator(10, errorText: 'Your phone is incorrect format')
  ]);
  final _passwordValidator = MultiValidator(
      [MinLengthValidator(8, errorText: 'Minimum password length is 8')]);

  final _emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email cannot be empty'),
    PatternValidator(ValidationHelper.emailPattern(),
        errorText: 'Email format is invalid')
  ]);

  final _usernameValidator = MultiValidator([
    RequiredValidator(errorText: 'Username cannot be empty'),
  ]);

  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  late TextEditingController _emailController;
  late TextEditingController _usernameController;

  final ImagePicker _picker = ImagePicker();
  XFile? _profile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
    _usernameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final Auth? auth = context.select((AuthModel am) => am.user);

    if (auth != null) {
      _phoneController.text = auth.phone!;
      _emailController.text = auth.email!;
      _usernameController.text = auth.username!;
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSliverAppBar(
            title: Text(
              "Edit profile",
              style: PengoStyle.navigationTitle(context),
            ),
          ),
          CustomSliverBody(
            content: auth == null
                ? <Widget>[
                    Container(),
                  ]
                : <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CustomTextField(
                            controller: _usernameController,
                            validator: _usernameValidator,
                            label: "Username",
                            hintText: auth.username!,
                          ),
                          CustomTextField(
                            controller: _emailController,
                            validator: _emailValidator,
                            label: "Email",
                            hintText: auth.email!,
                          ),
                          CustomTextField(
                            controller: _phoneController,
                            validator: _phoneValidator,
                            label: "Phone",
                            hintText: auth.phone!,
                          ),
                          CustomTextField(
                            controller: _passwordController,
                            validator: _passwordValidator,
                            label: "Password",
                            hintText:
                                "Leave this blank if dont want to change password",
                            obsecureText: true,
                          ),
                          Text(
                            "Avatar",
                            style: PengoStyle.title2(context).copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ImageUploadField(
                              filePath: _profile?.path,
                              url: auth.avatar,
                              onTap: () async {
                                final XFile? poster = await _picker.pickImage(
                                    source: ImageSource.gallery,
                                    // imageQuality: 60,
                                    maxHeight: 480,
                                    maxWidth: 640);
                                if (poster != null && mounted) {
                                  setState(() {
                                    _profile = poster;
                                  });
                                } else {
                                  return;
                                }
                              }),
                          CustomButton(
                            onPressed: () {
                              save(auth);
                            },
                            text: const Text("Save"),
                          ),
                        ],
                      ),
                    ),
                  ],
          ),
        ],
      ),
    );
  }

  void save(Auth auth) {
    try {
      AuthRepo()
          .updateProfile(
        userId: auth.user.id,
        avatar: _profile,
        password:
            _passwordController.text.isEmpty ? null : _passwordController.text,
        username: _usernameController.text == auth.username
            ? null
            : _usernameController.text,
        email:
            _emailController.text == auth.email ? null : _emailController.text,
        phone:
            _phoneController.text == auth.phone ? null : _phoneController.text,
      )
          .then((Auth updatedAuth) {
        context.read<AuthModel>().setUser(updatedAuth);
        showToast(
          msg: "Updated successfully",
          backgroundColor: successColor,
        );
        String encoded = jsonEncode(updatedAuth.toJson());
        debugPrint("encoded $encoded");
        SharedPreferencesHelper().setStr("user", encoded);
      });
    } catch (e) {
      showToast(
        msg: e.toString(),
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
  }
}
