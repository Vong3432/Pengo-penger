import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:penger/bloc/booking-close-dates/booking_close_date_bloc.dart';
import 'package:penger/bloc/staff/staff_bloc.dart';
import 'package:penger/bloc/staff/staff_repo.dart';
import 'package:penger/config/color.dart';
import 'package:penger/extensions/string_extension.dart';
import 'package:penger/helpers/theme/custom_font.dart';
import 'package:penger/helpers/toast/toast_helper.dart';
import 'package:penger/models/booking_close_date_model.dart';
import 'package:penger/models/user_model.dart';
import 'package:penger/ui/close-date/close_date_form.dart';
import 'package:penger/ui/staff/staff_form.dart';
import 'package:penger/ui/widgets/api/loading.dart';
import 'package:penger/ui/widgets/layout/sliver_appbar.dart';
import 'package:penger/ui/widgets/layout/sliver_body.dart';

class CloseDateListPage extends StatefulWidget {
  const CloseDateListPage({Key? key}) : super(key: key);

  @override
  _CloseDateListPageState createState() => _CloseDateListPageState();
}

class _CloseDateListPageState extends State<CloseDateListPage> {
  final BookingCloseDateBloc _bloc = BookingCloseDateBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadCloseDates();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookingCloseDateBloc>(
      create: (context) => _bloc,
      child: Scaffold(
        backgroundColor: greyBgColor,
        body: CustomScrollView(
          slivers: <Widget>[
            CustomSliverAppBar(
              centerTitle: true,
              title: Text(
                "Schedule",
                style: PengoStyle.title2(context),
              ),
              actions: <Widget>[
                IconButton(
                  onPressed: _showCloseDateForm,
                  icon: Icon(
                    Icons.add,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            CustomSliverBody(
              content: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child:
                      BlocBuilder<BookingCloseDateBloc, BookingCloseDateState>(
                    builder:
                        (BuildContext context, BookingCloseDateState state) {
                      if (state is BookingCloseDateListLoading) {
                        return const LoadingWidget();
                      }
                      if (state is BookingCloseDateListLoaded) {
                        return ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.list.length,
                            itemBuilder: (BuildContext context, int index) {
                              final BookingCloseDate date = state.list[index];
                              return Dismissible(
                                confirmDismiss:
                                    (DismissDirection direction) async {
                                  if (direction ==
                                      DismissDirection.startToEnd) {
                                    return await _confirmDelete();
                                  }
                                },
                                onDismissed: (_) => _delete(date),
                                background: Container(
                                    color: dangerColor,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.delete,
                                          color: whiteColor,
                                        ),
                                      ],
                                    )),
                                key: Key(date.id.toString()),
                                child: ListTile(
                                  onTap: () => _showCloseDateForm(
                                    date: date,
                                  ),
                                  tileColor: whiteColor,
                                  title: Text(
                                    date.name,
                                    style: PengoStyle.title2(context),
                                  ),
                                  // FIXME: Maybe changes db column type?
                                  subtitle: Text(
                                    "${DateFormat("yyyy-MM-dd").format(date.from!.add(const Duration(days: 1)).toLocal())} to ${DateFormat("yyyy-MM-dd").format(date.to!.add(const Duration(days: 1)).toLocal())}",
                                    style: PengoStyle.captionNormal(context)
                                        .copyWith(
                                      color: secondaryTextColor,
                                    ),
                                  ),
                                ),
                              );
                            });
                      }
                      return Container();
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _confirmDelete() async {
    bool del = false;
    await showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Alert'),
        content: const Text('Proceed to remove this schedule?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            child: const Text('No'),
            onPressed: () {
              del = false;
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            child: const Text('Yes'),
            isDestructiveAction: true,
            onPressed: () {
              // Do something destructive.
              del = true;
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
    return del;
  }

  void _showCloseDateForm({BookingCloseDate? date}) {
    showCupertinoModalBottomSheet(
      context: context,
      expand: false,
      builder: (BuildContext context) {
        return CloseDateForm(
          date: date,
        );
      },
    ).then((_) => _loadCloseDates());
  }

  Future<void> _delete(BookingCloseDate date) async {
    try {
      _bloc.add(DeleteCloseDate(date.id!));
      showToast(msg: "Deleted successfully", backgroundColor: successColor);
    } catch (e) {
      showToast(msg: e.toString());
    }
  }

  void _loadCloseDates() {
    _bloc.add(FetchCloseDates());
  }
}
