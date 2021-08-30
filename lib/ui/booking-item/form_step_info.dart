import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:penger/const/space_const.dart';
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

  static const _locale = 'ms';
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;

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
                  hintText: "Limited sales for August",
                  lblStyle: PengoStyle.caption(context),
                ),
                CustomTextField(
                  label: "Price",
                  hintText: "",
                  decoration: InputDecoration(prefixText: _currency),
                  controller: _priceController,
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
                      }
                    }),
                CustomTextField(
                  label: "Location",
                  hintText: "",
                  controller: _locationController,
                  onChanged: (String v) =>
                      context.read<BookingItemModel>().setLocation(v),
                  lblStyle: PengoStyle.caption(context),
                ),
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
