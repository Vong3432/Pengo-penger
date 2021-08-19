import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:penger/helpers/theme/custom_font.dart';
import 'package:penger/ui/widgets/layout/sliver_appbar.dart';
import 'package:penger/ui/widgets/layout/sliver_body.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return CustomScrollView(
      slivers: <Widget>[
        CustomSliverAppBar(
          title: Text(
            "Home",
            style: PengoStyle.navigationTitle(context),
          ),
        ),
        CustomSliverBody(
          content: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                // ignore: prefer_const_literals_to_create_immutables
                children: <Widget>[
                  CupertinoSearchTextField(
                    onChanged: (String value) {
                      debugPrint('The text has changed to: $value');
                    },
                    onSubmitted: (String value) {
                      debugPrint('Submitted text: $value');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
