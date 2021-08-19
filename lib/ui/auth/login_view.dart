import 'package:flutter/material.dart';
import 'package:penger/config/color.dart';
import 'package:penger/config/shadow.dart';
import 'package:penger/const/space_const.dart';
import 'package:penger/helpers/theme/custom_font.dart';
import 'package:penger/ui/widgets/button/custom_button.dart';
import 'package:penger/ui/widgets/input/custom_textfield.dart';
import 'package:penger/ui/widgets/layout/sliver_body.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
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
    return Expanded(
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
            const CustomTextField(
              label: "Phone",
              hintText: "012-3456789",
            ),
            const CustomTextField(
              obsecureText: true,
              label: "Password",
              hintText: "Password",
            ),
            const SizedBox(
              height: SECTION_GAP_HEIGHT * 2,
            ),
            CustomButton(
              onPressed: () {
                debugPrint("Login");
              },
              text: Text(
                "Sign In",
                style: PengoStyle.subtitle(context).copyWith(
                  color: whiteColor,
                ),
              ),
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
