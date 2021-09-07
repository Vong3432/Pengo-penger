import 'package:flutter/material.dart';
import 'package:penger/config/color.dart';
import 'package:penger/const/space_const.dart';
import 'package:penger/helpers/theme/custom_font.dart';
import 'package:penger/helpers/theme/theme_helper.dart';
import 'package:penger/ui/widgets/layout/sliver_appbar.dart';
import 'package:penger/ui/widgets/layout/sliver_body.dart';

class CouponPage extends StatefulWidget {
  const CouponPage({Key? key}) : super(key: key);

  @override
  _CouponPageState createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSliverAppBar(
            toolbarHeight: mediaQuery(context).size.height * 0.15,
            title: Text(
              "Coupons",
              style: PengoStyle.navigationTitle(context),
            ),
            bottom: PreferredSize(
              preferredSize: const Size(double.infinity, 15),
              child: Container(
                decoration: const BoxDecoration(
                  //This is for bottom border that is needed
                  border: Border(bottom: BorderSide(color: Colors.grey)),
                ),
                width: double.infinity,
                child: TabBar(
                  controller: _tabController,
                  unselectedLabelColor: secondaryTextColor,
                  labelColor: Colors.black,
                  indicatorColor: Colors.black,
                  tabs: _generateTabBar,
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                _activeTabBarView(),
                _expiredTabBarView(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container _expiredTabBarView() {
    return Container(
      padding: const EdgeInsets.all(18),
      child: Text("Expired view"),
    );
  }

  Container _activeTabBarView() {
    return Container(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [],
      ),
    );
  }

  List<Widget> get _generateTabBar {
    return const <Widget>[
      Tab(
        text: "Active",
      ),
      Tab(
        text: "Expired",
      ),
    ];
  }
}
