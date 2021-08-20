import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:penger/bloc/auth/auth_bloc.dart';
import 'package:penger/config/color.dart';
import 'package:penger/config/shadow.dart';
import 'package:penger/const/space_const.dart';
import 'package:penger/helpers/theme/custom_font.dart';
import 'package:penger/splash.dart';
import 'package:penger/ui/widgets/button/custom_button.dart';
import 'package:penger/ui/widgets/input/custom_textfield.dart';
import 'package:penger/ui/widgets/layout/sliver_body.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _phoneValidator = MultiValidator([
    RequiredValidator(errorText: 'Phone cannot be empty'),
    MaxLengthValidator(10, errorText: 'Your phone is incorrect format')
  ]);
  final _passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password cannot be empty'),
    MinLengthValidator(8, errorText: 'Minimum password length is 8')
  ]);

  final TextEditingController _phoneController =
      TextEditingController(text: '0149250542');
  final TextEditingController _passwordController =
      TextEditingController(text: '12345678');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        // physics: const NeverScrollableScrollPhysics(),
        slivers: <Widget>[
          CustomSliverBody(content: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: primaryLightColor,
                // gradient: primaryLinear,
              ),
              child: Column(
                children: <Widget>[
                  _buildHeader(),
                  _buildContent(context),
                ],
              ),
            ),
          ])
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Form(
      key: _formKey,
      child: Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: whiteColor,
            boxShadow: bottomBarShadow(Theme.of(context)),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: SECTION_GAP_HEIGHT,
              ),
              CustomTextField(
                controller: _phoneController,
                label: "Phone",
                hintText: "0123456789",
                validator: _phoneValidator,
              ),
              CustomTextField(
                controller: _passwordController,
                obsecureText: true,
                label: "Password",
                hintText: "Password",
                validator: _passwordValidator,
              ),
              const SizedBox(
                height: SECTION_GAP_HEIGHT * 2,
              ),
              BlocConsumer(
                bloc: BlocProvider.of<AuthBloc>(context),
                listener: (context, state) {
                  debugPrint(state.toString());
                  // TODO: implement listener        }
                  if (state is AuthenticatedState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("You're logged in! Redirecting..."),
                        backgroundColor: primaryColor,
                      ),
                    );
                    Future.delayed(const Duration(seconds: 2)).then((_) => {
                          Navigator.of(context).pushReplacement(
                              CupertinoPageRoute(
                                  builder: (BuildContext context) =>
                                      const Splash()))
                        });
                  }
                  if (state is NotAuthenticatedState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Authentication fail.'),
                        backgroundColor: dangerColor,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AuthenticatingState) {
                    return const CircularProgressIndicator();
                  }
                  return CustomButton(
                    onPressed: () {
                      debugPrint("Login");
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        debugPrint("logging");
                        BlocProvider.of<AuthBloc>(context).add(LoginEvent(
                            _phoneController.text, _passwordController.text));
                      }
                    },
                    text: Text(
                      "Sign In",
                      style: PengoStyle.subtitle(context).copyWith(
                        color: whiteColor,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: SECTION_GAP_HEIGHT,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Don't have an account? ",
                    style: PengoStyle.subtitle(context),
                  ),
                  GestureDetector(
                    child: Text(
                      "Register here",
                      style: PengoStyle.subtitle(context).copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _buildHeader extends StatelessWidget {
  const _buildHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Stack(children: [
          Container(
            padding: const EdgeInsets.all(18),
            width: double.infinity,
            height: 250,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Sign-in", style: PengoStyle.navigationTitle(context)),
                  const SizedBox(
                    height: SECTION_GAP_HEIGHT - 10,
                  ),
                  Text(
                    "Start managing booking slot of your biz in the app right now.",
                    style: PengoStyle.title2(context).copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ],
    );
  }
}
