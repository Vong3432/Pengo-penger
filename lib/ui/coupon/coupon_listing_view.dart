import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:penger/bloc/coupons/view/view_active_coupons_bloc.dart';
import 'package:penger/bloc/coupons/view/view_expired_coupons_bloc.dart';
import 'package:penger/config/color.dart';
import 'package:penger/const/space_const.dart';
import 'package:penger/helpers/theme/custom_font.dart';
import 'package:penger/helpers/theme/theme_helper.dart';
import 'package:penger/models/coupon_model.dart';
import 'package:penger/ui/coupon/add_coupon_view.dart';
import 'package:penger/ui/widgets/layout/sliver_appbar.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class CouponPage extends StatefulWidget {
  const CouponPage({Key? key}) : super(key: key);

  @override
  _CouponPageState createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Coupon> selectedCouponList = [];

  int _tabIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _tabChanged(_tabIndex); // fetch at first load
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            heroTag: "add coupon",
            backgroundColor: primaryColor,
            onPressed: () {
              Navigator.of(context, rootNavigator: true)
                  .push(
                    CupertinoPageRoute(builder: (context) => AddCouponPage()),
                  )
                  .then((_) => _tabChanged(_tabIndex));
            },
            child: const Icon(Icons.add_outlined),
          ),
        ),
      ),
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
                  onTap: _tabChanged,
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
              physics: const NeverScrollableScrollPhysics(),
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

  void _tabChanged(int index) {
    selectedCouponList.clear();
    switch (index) {
      case 0:
        BlocProvider.of<ViewActiveCouponsBloc>(context)
            .add(FetchActiveCouponsEvent());
        break;
      case 1:
        //...
        BlocProvider.of<ViewExpiredCouponsBloc>(context)
            .add(FetchExpiredCouponsEvent());
        break;
      default:
    }
    _tabIndex = index;
  }

  Container _expiredTabBarView() {
    return Container(
      padding: const EdgeInsets.all(18),
      child: Column(children: <Widget>[
        BlocConsumer<ViewExpiredCouponsBloc, ViewExpiredCouponsState>(
            builder: (BuildContext context, ViewExpiredCouponsState state) {
          if (state is ViewExpiredCouponsLoading) {
            return Container(
              width: double.infinity,
              child: const SkeletonText(height: 20),
            );
          }
          if (state is ViewExpiredCouponsLoaded) {
            return _buildCouponsList(state.coupons);
          }
          return Container();
        }, listener: (BuildContext context, ViewExpiredCouponsState state) {
          if (state is ViewExpiredCouponsLoadedFailed) {
            Fluttertoast.showToast(
                msg: state.e.toString(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                backgroundColor: dangerColor,
                textColor: whiteColor,
                fontSize: 16.0);
          }
        })
      ]),
    );
  }

  Container _activeTabBarView() {
    return Container(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          BlocConsumer<ViewActiveCouponsBloc, ViewActiveCouponsState>(
              builder: (BuildContext context, ViewActiveCouponsState state) {
            if (state is ViewActiveCouponsLoading) {
              return Container(
                width: double.infinity,
                child: const SkeletonText(height: 20),
              );
            }
            if (state is ViewActiveCouponsLoaded) {
              return _buildCouponsList(state.coupons);
            }
            return Container();
          }, listener: (BuildContext context, ViewActiveCouponsState state) {
            if (state is ViewActiveCouponsLoadedFailed) {
              Fluttertoast.showToast(
                  msg: state.e.toString(),
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  backgroundColor: dangerColor,
                  textColor: whiteColor,
                  fontSize: 16.0);
            }
          })
        ],
      ),
    );
  }

  ListView _buildCouponsList(List<Coupon> coupons) {
    return ListView.separated(
        shrinkWrap: true,
        itemCount: coupons.length,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: SECTION_GAP_HEIGHT,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          final Coupon coupon = coupons[index];
          return _buildCouponItem(coupon);
        });
  }

  Widget _buildCouponItem(Coupon coupon) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      value: selectedCouponList.contains(coupon),
      onChanged: (bool? val) {
        setState(() {
          if (val == true) {
            selectedCouponList.add(coupon);
          } else {
            selectedCouponList.remove(coupon);
          }
        });
      },
      title: Text(
        coupon.title,
        style: PengoStyle.title2(context),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Align(
        alignment: Alignment.centerLeft,
        child: Chip(
            label: Text(
          "MIN ${coupon.minCreditPoints} CP",
          style: PengoStyle.caption(context).copyWith(
            fontSize: 12,
          ),
        )),
      ),
      secondary: Text(
        '${DateFormat("MMM d").format(DateTime.parse(coupon.validFrom))} - ${DateFormat("MMM d").format(DateTime.parse(coupon.validTo))}',
        style: PengoStyle.caption(context).copyWith(
          color: secondaryTextColor,
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
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
