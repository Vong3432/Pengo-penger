import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:penger/bloc/pengers/penger_bloc.dart';
import 'package:penger/config/color.dart';
import 'package:penger/const/space_const.dart';
import 'package:penger/helpers/theme/custom_font.dart';
import 'package:penger/helpers/theme/theme_helper.dart';
import 'package:penger/models/auth_model.dart';
import 'package:penger/models/penger_model.dart';
import 'package:penger/models/providers/auth_model.dart';
import 'package:penger/ui/home/widgets/penger_form.dart';
import 'package:penger/ui/widgets/layout/sliver_appbar.dart';
import 'package:penger/ui/widgets/layout/sliver_body.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class PengerListingView extends StatefulWidget {
  const PengerListingView({Key? key}) : super(key: key);

  @override
  _PengerListingViewState createState() => _PengerListingViewState();
}

class _PengerListingViewState extends State<PengerListingView> {
  final PengerBloc _bloc = PengerBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSliverAppBar(
            centerTitle: true,
            title: Text(
              "My pengers",
              style: PengoStyle.title2(context),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.add,
                  color: primaryColor,
                ),
                onPressed: () {
                  showCupertinoModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: mediaQuery(context).viewInsets.bottom,
                        ),
                        child: const PengerForm(),
                      );
                    },
                  ).then((_) => _load());
                },
              )
            ],
          ),
          CustomSliverBody(
            content: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Consumer<AuthModel>(
                      builder: (BuildContext context, AuthModel model, _) {
                        if (model.user?.selectedPenger == null) {
                          return const Text("No result");
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Current",
                              style: PengoStyle.title2(context).copyWith(
                                color: secondaryTextColor,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            PengerInfo(
                              key: UniqueKey(),
                              id: model.user!.selectedPenger!.id,
                            ),
                            const SizedBox(
                              height: SECTION_GAP_HEIGHT * 1.5,
                            ),
                            Text(
                              "List",
                              style: PengoStyle.title2(context).copyWith(
                                color: secondaryTextColor,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    BlocProvider<PengerBloc>(
                      create: (BuildContext context) => _bloc,
                      child: BlocBuilder<PengerBloc, PengerState>(
                        builder: (BuildContext context, PengerState state) {
                          if (state is PengersLoading) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const <Widget>[
                                SizedBox(
                                    width: double.infinity,
                                    child: SkeletonText(height: 25)),
                                SizedBox(
                                  height: 8,
                                ),
                                SizedBox(
                                    width: double.infinity,
                                    child: SkeletonText(height: 25)),
                              ],
                            );
                          }
                          if (state is PengersLoaded) {
                            return _buildPengerList(
                              state,
                              context.watch<AuthModel>(),
                            );
                          }

                          return Container();
                        },
                      ),
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

  ListView _buildPengerList(PengersLoaded state, AuthModel? model) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: state.pengers.length,
      itemBuilder: (BuildContext context, int index) {
        final Penger _penger = state.pengers[index];
        return ListTile(
          dense: true,
          minLeadingWidth: 0,
          minVerticalPadding: 0,
          contentPadding: EdgeInsets.zero,
          title: Text(
            _penger.name,
            style: PengoStyle.title(context).copyWith(
              color: textColor,
            ),
          ),
          leading: _penger.id == model?.user?.selectedPenger?.id
              ? IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.check_circle,
                    color: primaryColor,
                  ),
                )
              : IconButton(
                  onPressed: () {
                    final Auth? auth = model?.user;
                    if (auth != null) {
                      final Auth newAuth =
                          auth.copyWith(selectedPenger: _penger);
                      context.read<AuthModel>().setUser(newAuth);
                    }
                  },
                  icon: Icon(
                    Icons.check_circle,
                    color: secondaryTextColor.withOpacity(0.5),
                  ),
                ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  showCupertinoModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: mediaQuery(
                            context,
                          ).viewInsets.bottom,
                        ),
                        child: PengerForm(
                          penger: _penger,
                        ),
                      );
                    },
                  ).then((_) {
                    _load();

                    if (_penger.id == model?.user?.selectedPenger?.id) {
                      setState(() {});
                    }
                  });
                },
                icon: Icon(
                  Icons.edit,
                  color: secondaryTextColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _load() {
    _bloc.add(const FetchPengers());
  }
}

class PengerInfo extends StatefulWidget {
  const PengerInfo({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;

  @override
  State<PengerInfo> createState() => _PengerInfoState();
}

class _PengerInfoState extends State<PengerInfo> {
  final PengerBloc _bloc = PengerBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadInfo();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PengerBloc>(
      create: (BuildContext context) => _bloc,
      child: BlocBuilder<PengerBloc, PengerState>(
        builder: (BuildContext context, PengerState state) {
          if (state is PengerLoading) {
            return const SkeletonText(height: 32);
          }

          if (state is PengerLoaded) {
            return ListTile(
              dense: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              tileColor: greyBgColor,
              contentPadding: const EdgeInsets.symmetric(horizontal: 18),
              leading: state is PengerLoading
                  ? Container()
                  : Container(
                      decoration: const BoxDecoration(
                        // border: Border.all(width: 2.5, color: greyBgColor),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: state.penger.logo.contains("dicebear")
                          ? SvgPicture.network(
                              state.penger.logo,
                              width: 32,
                              height: 32,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              state.penger.logo,
                              width: 32,
                              height: 32,
                              fit: BoxFit.cover,
                            ),
                    ),
              title: Text(
                state.penger.name,
                style: PengoStyle.title(context).copyWith(
                  color: textColor,
                ),
              ),
              subtitle: Text(
                state.penger.location.name ?? "",
                style: PengoStyle.captionNormal(context).copyWith(
                  color: secondaryTextColor,
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  void _loadInfo() {
    _bloc.add(FetchPenger(widget.id));
  }
}
