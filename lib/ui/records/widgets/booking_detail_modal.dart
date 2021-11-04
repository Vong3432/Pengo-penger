import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penger/bloc/booking-records/booking_records_bloc.dart';
import 'package:penger/config/color.dart';
import 'package:penger/const/space_const.dart';
import 'package:penger/helpers/theme/custom_font.dart';
import 'package:penger/helpers/theme/theme_helper.dart';
import 'package:penger/models/user_model.dart';
import 'package:penger/ui/widgets/api/loading.dart';

class BookingDetail extends StatefulWidget {
  const BookingDetail({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  _BookingDetailState createState() => _BookingDetailState();
}

class _BookingDetailState extends State<BookingDetail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _load();
  }

  final BookingRecordsBloc _bloc = BookingRecordsBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookingRecordsBloc>(
      create: (BuildContext context) => _bloc,
      child: Material(
        child: Container(
          height: mediaQuery(context).size.height * 0.45,
          padding: const EdgeInsets.all(18),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text(
                    "Detail",
                    style: PengoStyle.title2(context)
                        .copyWith(color: secondaryTextColor),
                  ),
                ),
                BlocBuilder<BookingRecordsBloc, BookingRecordsState>(
                  builder: (BuildContext context, BookingRecordsState state) {
                    if (state is BookingRecordLoading) {
                      return const LoadingWidget();
                    }
                    if (state is BookingRecordLoaded) {
                      final User user = state.record.goocard.user;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: SECTION_GAP_HEIGHT),
                          Text(
                            "User info",
                            style: PengoStyle.caption(context).copyWith(
                              color: secondaryTextColor,
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              foregroundImage: NetworkImage(user.avatar),
                            ),
                            title: Text(
                              user.username,
                              style: PengoStyle.title(context),
                            ),
                          ),
                          Text(
                            "Contact",
                            style: PengoStyle.caption(context).copyWith(
                              color: secondaryTextColor,
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.phone),
                            title: Text(
                              user.phone,
                              style: PengoStyle.body(context),
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.email),
                            title: Text(
                              user.email,
                              style: PengoStyle.body(context),
                            ),
                          ),
                        ],
                      );
                    }
                    return Container();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _load() {
    _bloc.add(FetchBookingRecord(id: widget.id));
  }
}
