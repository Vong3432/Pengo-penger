import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_geocoding/google_geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:penger/bloc/pengers/penger_bloc.dart';
import 'package:penger/config/color.dart';
import 'package:penger/const/space_const.dart';
import 'package:penger/helpers/google/geocoding.dart';
import 'package:penger/helpers/storage/shared_preference_helper.dart';
import 'package:penger/helpers/theme/custom_font.dart';
import 'package:penger/helpers/theme/theme_helper.dart';
import 'package:penger/helpers/toast/toast_helper.dart';
import 'package:penger/models/auth_model.dart';
import 'package:penger/models/penger_model.dart';
import 'package:penger/models/providers/auth_model.dart';
import 'package:penger/ui/widgets/button/custom_button.dart';
import 'package:penger/ui/widgets/input/custom_textfield.dart';
import 'package:penger/ui/widgets/input/image_upload_field.dart';

class PengerForm extends StatefulWidget {
  const PengerForm({Key? key, this.penger}) : super(key: key);

  final Penger? penger;

  @override
  _PengerFormState createState() => _PengerFormState();
}

class _PengerFormState extends State<PengerForm> {
  XFile? _poster;
  late double _lat;
  late double _lng;

  // controllers
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _locationController;
  late TextEditingController _locationNameController;
  final ImagePicker _picker =
      ImagePicker(); // TODO: Replace with another image picker plugin.

  // validators
  final _nameValidator = MultiValidator([
    RequiredValidator(errorText: 'Name cannot be empty'),
  ]);
  final _locationNameValidator = MultiValidator([
    RequiredValidator(errorText: 'Location name cannot be empty'),
  ]);

  List<GeocodingResult> geocodingResults = [];

  final _key = GlobalKey<FormState>();
  bool _isEditing = false;

  final PengerBloc _bloc = PengerBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isEditing = widget.penger != null;
    if (_isEditing) {
      _lat = widget.penger!.location.geolocation.latitude;
      _lng = widget.penger!.location.geolocation.longitude;
    }
    _nameController = TextEditingController(text: widget.penger?.name ?? "");
    _descriptionController =
        TextEditingController(text: widget.penger?.description ?? "");
    _locationController =
        TextEditingController(text: widget.penger?.location.street ?? "");
    _locationNameController =
        TextEditingController(text: widget.penger?.location.name ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PengerBloc>(
      create: (context) => _bloc,
      child: Material(
        child: Form(
          key: _key,
          child: Container(
            height: mediaQuery(context).size.height * 0.75,
            padding: const EdgeInsets.all(18),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _isEditing ? "Edit" : "Create",
                    style: PengoStyle.header(context),
                  ),
                  const SizedBox(
                    height: SECTION_GAP_HEIGHT,
                  ),
                  CustomTextField(
                    controller: _nameController,
                    validator: _nameValidator,
                    hintText: "Name",
                    label: "Name",
                  ),
                  CustomTextField(
                    controller: _descriptionController,
                    hintText: "The store...",
                    label: "Description",
                    isOptional: true,
                  ),
                  CustomTextField(
                    controller: _locationNameController,
                    validator: _locationNameValidator,
                    hintText: "eg: HQ",
                    label: "Branch name",
                  ),
                  Text(
                    "Logo",
                    style: PengoStyle.caption(context),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ImageUploadField(
                    filePath: _poster?.path,
                    url: _isEditing ? widget.penger?.logo : null,
                    onTap: () async {
                      final XFile? poster = await _picker.pickImage(
                          source: ImageSource.gallery,
                          // imageQuality: 60,
                          maxHeight: 480,
                          maxWidth: 640);
                      if (poster != null && mounted) {
                        setState(() {
                          _poster = poster;
                        });
                      } else {
                        return;
                      }
                    },
                  ),
                  CustomTextField(
                    label: "Location",
                    hintText: _locationController.text,
                    sideNote: Text(
                      "Selected location: ${_locationController.text}",
                    ),
                    onChanged: (String v) {
                      _geocodingSearch(v);
                    },
                    onEditingComplete: () {
                      _clearGeocodingSearch();
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    lblStyle: PengoStyle.caption(context),
                  ),
                  const SizedBox(height: SECTION_GAP_HEIGHT),
                  _buildGeolocationResult(),
                  BlocConsumer<PengerBloc, PengerState>(
                    listener: (BuildContext context, PengerState state) async {
                      // TODO: implement listener
                      if (state is PengerAdded) {
                        // final Auth? auth =
                        //     context.select<AuthModel, Auth?>((am) => am.user);
                        // if (auth != null) {
                        //   final Penger p = Penger.fromJson(
                        //     state.response.data as Map<String, dynamic>,
                        //   );
                        //   auth.pengers?.add(p);
                        //   AuthModel().setUser(auth);
                        // }
                        return showToast(
                          msg: state.response.msg ?? "Saved",
                          backgroundColor: successColor,
                        );
                      } else if (state is PengerNotAdded) {
                        return showToast(
                          msg: state.e.toString(),
                        );
                      } else if (state is PengerUpdated) {
                        return showToast(
                          msg: state.response.msg ?? "Saved",
                          backgroundColor: successColor,
                        );
                      } else if (state is PengerNotUpdated) {
                        return showToast(
                          msg: state.e.toString(),
                        );
                      }
                    },
                    builder: (BuildContext context, PengerState state) {
                      return CustomButton(
                        isLoading:
                            state is PengerAdding || state is PengerUpdating,
                        text: const Text("Save"),
                        onPressed: _save,
                      );
                    },
                  ),
                  const SizedBox(
                    height: SECTION_GAP_HEIGHT * 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ListView _buildGeolocationResult() {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: geocodingResults.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const CircleAvatar(
            child: Icon(
              Icons.pin_drop,
              color: Colors.white,
            ),
          ),
          title: Text(geocodingResults[index].formattedAddress ?? ''),
          onTap: () {
            final GeocodingResult res = geocodingResults[index];
            final Geometry geo = res.geometry!;

            debugPrint("Tapped");
            setState(() {
              _locationController.text = res.formattedAddress!;
              _lat = geo.location!.lat!;
              _lng = geo.location!.lng!;
            });
          },
        );
      },
    );
  }

  Future<void> _geocodingSearch(String value) async {
    final GeocodingResponse? response =
        await getGeoCodingIns().geocoding.get(value, [], region: 'MY');
    if (response != null && response.results != null) {
      if (mounted) {
        setState(() {
          geocodingResults = response.results!;
        });
      }
    } else {
      _clearGeocodingSearch();
    }
  }

  void _clearGeocodingSearch() {
    if (mounted) {
      setState(() {
        geocodingResults = [];
      });
    }
  }

  void _save() {
    if (_key.currentState!.validate()) {
      // save
      if (_isEditing) {
        // edit
        _bloc.add(
          UpdatePenger(
            id: widget.penger!.id,
            name: _nameController.text,
            locationName: _locationNameController.text,
            lng: _lng,
            lat: _lat,
            poster: _poster,
            description: _descriptionController.text,
          ),
        );
      } else {
        if (_poster == null) {
          return showToast(msg: "Logo cannot be empty");
        }
        // create
        _bloc.add(
          CreatePenger(
            name: _nameController.text,
            locationName: _locationNameController.text,
            lng: _lng,
            lat: _lat,
            poster: _poster!,
            description: _descriptionController.text,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _locationNameController.dispose();
  }
}
