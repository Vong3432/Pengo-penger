import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penger/bloc/booking-records/booking_records_bloc.dart';
import 'package:penger/config/color.dart';
import 'package:penger/helpers/theme/custom_font.dart';
import 'package:penger/helpers/theme/theme_helper.dart';
import 'package:penger/models/booking_record_model.dart';
import 'package:penger/ui/records/widgets/booking_card.dart';
import 'package:penger/ui/widgets/api/loading.dart';
import 'package:penger/ui/widgets/layout/sliver_appbar.dart';

class BookingRecordsPage extends StatefulWidget {
  const BookingRecordsPage({Key? key}) : super(key: key);

  @override
  _BookingRecordsPageState createState() => _BookingRecordsPageState();
}

class _BookingRecordsPageState extends State<BookingRecordsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final BookingRecordsBloc _bloc = BookingRecordsBloc();

  int _tabIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _tabChanged(_tabIndex); // fetch at first load
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookingRecordsBloc>(
      create: (BuildContext context) => _bloc,
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            CustomSliverAppBar(
              toolbarHeight: mediaQuery(context).size.height * 0.15,
              title: Text(
                "Booking stats",
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
                    indicatorColor: primaryColor,
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
                  SingleChildScrollView(child: _todayView()),
                  SingleChildScrollView(child: _upcomingView()),
                  SingleChildScrollView(child: _pastView()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _todayView() {
    return Container(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: <Widget>[
          BlocBuilder<BookingRecordsBloc, BookingRecordsState>(
            builder: (BuildContext context, BookingRecordsState state) {
              if (state is BookingRecordsLoading) {
                return const LoadingWidget();
              }
              if (state is BookingRecordsLoaded) {
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.records.length,
                  itemBuilder: (BuildContext context, int index) {
                    final BookingRecord record = state.records[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: BookingCard(
                        record: record,
                        refreshCallback: () => _tabChanged(_tabIndex),
                      ),
                    );
                  },
                );
              }
              return Container();
            },
          )
        ],
      ),
    );
  }

  Container _upcomingView() {
    return Container(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: <Widget>[
          BlocBuilder<BookingRecordsBloc, BookingRecordsState>(
            builder: (BuildContext context, BookingRecordsState state) {
              if (state is BookingRecordsLoading) {
                return const LoadingWidget();
              }
              if (state is BookingRecordsLoaded) {
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.records.length,
                  itemBuilder: (BuildContext context, int index) {
                    final BookingRecord record = state.records[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: BookingCard(
                        record: record,
                        refreshCallback: () => _tabChanged(_tabIndex),
                      ),
                    );
                  },
                );
              }
              return Container();
            },
          )
        ],
      ),
    );
  }

  Widget _pastView() {
    return Container(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: <Widget>[
          BlocBuilder<BookingRecordsBloc, BookingRecordsState>(
            builder: (BuildContext context, BookingRecordsState state) {
              if (state is BookingRecordsLoading) {
                return const LoadingWidget();
              }
              if (state is BookingRecordsLoaded) {
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.records.length,
                  itemBuilder: (BuildContext context, int index) {
                    final BookingRecord record = state.records[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: BookingCard(
                        record: record,
                        refreshCallback: () => _tabChanged(_tabIndex),
                      ),
                    );
                  },
                );
              }
              return Container();
            },
          )
        ],
      ),
    );
  }

  void _tabChanged(int index) {
    // selectedCouponList.clear();
    switch (index) {
      case 0:
        // show today
        _bloc.add(
          const FetchBookingRecords(
            showExpired: true,
            showToday: true,
          ),
        );
        break;
      case 1:
        // show upcoming + today
        _bloc.add(
          const FetchBookingRecords(
            showExpired: false,
            showToday: false,
          ),
        );
        break;
      case 2:
        // show upcoming + today
        _bloc.add(
          const FetchBookingRecords(
            showExpired: true,
            showToday: false,
          ),
        );
        break;
      default:
    }
    _tabIndex = index;
  }

  List<Widget> get _generateTabBar {
    return const <Widget>[
      Tab(
        text: "Today",
      ),
      Tab(
        text: "Upcoming",
      ),
      Tab(
        text: "Past",
      ),
    ];
  }
}
