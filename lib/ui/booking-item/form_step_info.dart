import 'package:flutter/material.dart';
import 'package:google_geocoding/google_geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:penger/const/space_const.dart';
import 'package:penger/helpers/google/geocoding.dart';
import 'package:penger/helpers/intl/currency_converter.dart';
import 'package:penger/helpers/theme/custom_font.dart';
import 'package:penger/helpers/theme/theme_helper.dart';
import 'package:penger/models/providers/booking_item_model.dart';
import 'package:penger/ui/widgets/button/custom_button.dart';
import 'package:penger/ui/widgets/input/custom_textfield.dart';
import 'package:penger/ui/widgets/input/image_upload_field.dart';
import 'package:provider/provider.dart';

class FormStepInfo extends StatefulWidget {
  const FormStepInfo({
    Key? key,
  }) : super(key: key);

  @override
  _FormStepInfoState createState() => _FormStepInfoState();
}

class _FormStepInfoState extends State<FormStepInfo> {
  late TextEditingController _itemNameController;
  late TextEditingController _locationController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  final ImagePicker _picker = ImagePicker();

  List<GeocodingResult> geocodingResults = [];

  @override
  void initState() {
    // TODO: implement initState
    final BookingItemModel myProvider =
        Provider.of<BookingItemModel>(context, listen: false);

    super.initState();
    _itemNameController = TextEditingController(text: myProvider.name);
    _descriptionController =
        TextEditingController(text: myProvider.description);
    _locationController = TextEditingController(text: myProvider.location);
    _priceController = TextEditingController(
        text: myProvider.price != null ? myProvider.price.toString() : "");
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          padding: const EdgeInsets.all(18),
          height: mediaQuery(context).size.height * 0.8,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Complete Info",
                  style: PengoStyle.header(context),
                ),
                const SizedBox(
                  height: SECTION_GAP_HEIGHT,
                ),
                CustomTextField(
                  label: "Name",
                  hintText: "Shop sales",
                  controller: _itemNameController,
                  onChanged: (String v) =>
                      context.read<BookingItemModel>().setName(v),
                  lblStyle: PengoStyle.caption(context),
                ),
                CustomTextField(
                  label: "Description",
                  controller: _descriptionController,
                  isOptional: true,
                  hintText: "Limited sales for August",
                  onChanged: (String v) =>
                      context.read<BookingItemModel>().setDescription(v),
                  lblStyle: PengoStyle.caption(context),
                ),
                CustomTextField(
                  label: "Price",
                  hintText: "",
                  decoration: InputDecoration(prefixText: currency),
                  isOptional: true,
                  controller: _priceController,
                  onChanged: (String v) => context
                      .read<BookingItemModel>()
                      .setPrice(double.tryParse(v)!),
                  inputType:
                      const TextInputType.numberWithOptions(decimal: true),
                  lblStyle: PengoStyle.caption(context),
                ),
                Text(
                  "Poster",
                  style: PengoStyle.caption(context),
                ),
                const SizedBox(
                  height: 10,
                ),
                ImageUploadField(
                    filePath: context.watch<BookingItemModel>().poster?.path,
                    onTap: () async {
                      final XFile? poster =
                          await _picker.pickImage(source: ImageSource.gallery);
                      if (poster != null) {
                        context.read<BookingItemModel>().setPoster(poster);
                      } else {
                        return;
                      }
                    }),
                CustomTextField(
                  label: "Location",
                  hintText: "",
                  sideNote: Text(
                      "Selected location: ${context.watch<BookingItemModel>().location}"),
                  controller: _locationController,
                  onChanged: (String v) {
                    // clear prev if have
                    context.read<BookingItemModel>().setLocation("");
                    geocodingSearch(v);
                  },
                  onEditingComplete: () {
                    clearGeocodingSearch();
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  lblStyle: PengoStyle.caption(context),
                ),
                const SizedBox(height: SECTION_GAP_HEIGHT),
                _buildGeolocationResult(),
                const SizedBox(height: SECTION_GAP_HEIGHT),
                CustomButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  text: Text("Next"),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListView _buildGeolocationResult() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: geocodingResults.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
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

            context.read<BookingItemModel>().setLocation(res.formattedAddress!);
            context.read<BookingItemModel>().setLat(geo.location!.lat!);
            context.read<BookingItemModel>().setLng(geo.location!.lng!);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => DetailsPage(
            //       placeId: geocodingResults[index].placeId,
            //     ),
            //   ),
            // );
          },
        );
      },
    );
  }

  Future<void> geocodingSearch(String value) async {
    final GeocodingResponse? response =
        await getGeoCodingIns().geocoding.get(value, [], region: 'MY');
    if (response != null && response.results != null) {
      debugPrint(response.results.toString());
      if (mounted) {
        setState(() {
          geocodingResults = response.results!;
        });
      }
    } else {
      clearGeocodingSearch();
    }
  }

  void clearGeocodingSearch() {
    if (mounted) {
      setState(() {
        geocodingResults = [];
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _itemNameController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _priceController.dispose();
  }
}
