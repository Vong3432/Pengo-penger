import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:penger/bloc/staff/staff_bloc.dart';
import 'package:penger/bloc/staff/staff_repo.dart';
import 'package:penger/config/color.dart';
import 'package:penger/extensions/string_extension.dart';
import 'package:penger/helpers/theme/custom_font.dart';
import 'package:penger/helpers/toast/toast_helper.dart';
import 'package:penger/models/user_model.dart';
import 'package:penger/ui/staff/staff_form.dart';
import 'package:penger/ui/widgets/api/loading.dart';
import 'package:penger/ui/widgets/layout/sliver_appbar.dart';
import 'package:penger/ui/widgets/layout/sliver_body.dart';

class StaffListPage extends StatefulWidget {
  const StaffListPage({Key? key}) : super(key: key);

  @override
  _StaffListPageState createState() => _StaffListPageState();
}

class _StaffListPageState extends State<StaffListPage> {
  final StaffBloc _bloc = StaffBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadStaff();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StaffBloc>(
      create: (context) => _bloc,
      child: Scaffold(
        backgroundColor: greyBgColor,
        body: CustomScrollView(
          slivers: <Widget>[
            CustomSliverAppBar(
              centerTitle: true,
              title: Text(
                "All staff",
                style: PengoStyle.title2(context),
              ),
              actions: <Widget>[
                IconButton(
                  onPressed: _showStaffForm,
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
                  child: BlocBuilder<StaffBloc, StaffState>(
                    builder: (BuildContext context, StaffState state) {
                      if (state is StaffListLoading) {
                        return const LoadingWidget();
                      }
                      if (state is StaffListLoaded) {
                        return ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.staffList.length,
                            itemBuilder: (BuildContext context, int index) {
                              final User staff = state.staffList[index];
                              return Dismissible(
                                confirmDismiss:
                                    (DismissDirection direction) async {
                                  if (direction ==
                                      DismissDirection.startToEnd) {
                                    return await _confirmDelete();
                                  }
                                },
                                onDismissed: (_) => _delete(staff),
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
                                key: Key(staff.id.toString()),
                                child: ListTile(
                                  onTap: () => _showStaffForm(
                                    staff: staff,
                                  ),
                                  tileColor: whiteColor,
                                  leading: CircleAvatar(
                                    foregroundImage: NetworkImage(staff.avatar),
                                  ),
                                  title: Text(
                                    staff.username,
                                    style: PengoStyle.title2(context),
                                  ),
                                  subtitle: Text(
                                    staff.role?.name
                                            .snakeCasetoSentenceCase() ??
                                        "",
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
        content: const Text('Proceed to remove this staff?'),
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

  void _showStaffForm({User? staff}) {
    showCupertinoModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StaffForm(
          staff: staff,
        );
      },
    ).then((_) => _loadStaff());
  }

  Future<void> _delete(User staff) async {
    try {
      await StaffRepo().delStaff(staff.id);
      showToast(msg: "Deleted successfully", backgroundColor: successColor);
    } catch (e) {
      showToast(msg: e.toString());
    }
  }

  void _loadStaff() {
    _bloc.add(FetchStaffList());
  }
}
