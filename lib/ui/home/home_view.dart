import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:penger/bloc/booking-categories/view/view_booking_category_bloc.dart';
import 'package:penger/bloc/booking-items/view/view_booking_item_bloc.dart';
import 'package:penger/config/color.dart';
import 'package:penger/const/icon_const.dart';
import 'package:penger/const/space_const.dart';
import 'package:penger/helpers/theme/custom_font.dart';
import 'package:penger/helpers/theme/theme_helper.dart';
import 'package:penger/models/booking_category_model.dart';
import 'package:penger/models/booking_item_model.dart';
import 'package:penger/models/providers/auth_model.dart';
import 'package:penger/ui/booking-item/add_item_view.dart';
import 'package:penger/ui/booking-item/edit_item_view.dart';
import 'package:penger/ui/home/widgets/current_penger_highlight.dart';
import 'package:penger/ui/home/widgets/stats/member_stat.dart';
import 'package:penger/ui/home/widgets/stats/schedule_stat.dart';
import 'package:penger/ui/home/widgets/stats/today_stat.dart';
import 'package:penger/ui/widgets/layout/sliver_appbar.dart';
import 'package:penger/ui/widgets/layout/sliver_body.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // state
  BookingCategory? _selectedCategory;
  GroupController controller = GroupController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadCategories();
  }

  void _loadCategories() {
    BlocProvider.of<ViewBookingCategoryBloc>(context)
        .add(FetchBookingCategoriesEvent());
    BlocProvider.of<ViewItemBloc>(context).add(FetchBookingItemsEvent());
  }

  @override
  Widget build(BuildContext context) {
    /*24 is for notification bar on Android*/
    final double itemHeight = mediaQuery(context).size.height * 0.25;
    final double itemWidth = mediaQuery(context).size.width / 2;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const CustomSliverAppBar(
            title: CurrentPengerHighlight(),
          ),
          CustomSliverBody(
            content: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: <Widget>[
                    GridView.count(
                      clipBehavior: Clip.none,
                      mainAxisSpacing: SECTION_GAP_HEIGHT,
                      crossAxisSpacing: SECTION_GAP_HEIGHT,
                      padding: const EdgeInsets.only(bottom: 18),
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: itemWidth / itemHeight,
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      children: <Widget>[
                        TodayStat(),
                        MemberStat(),
                        ScheduleStat(),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
