import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:penger/config/color.dart';
import 'package:penger/const/locale_const.dart';
import 'package:penger/const/space_const.dart';
import 'package:penger/helpers/theme/custom_font.dart';
import 'package:penger/helpers/theme/theme_helper.dart';
import 'package:penger/models/condition_model.dart';
import 'package:penger/models/dpo_column_model.dart';
import 'package:penger/models/dpo_table_model.dart';
import 'package:penger/models/providers/booking_item_model.dart';
import 'package:penger/models/system_function_model.dart';
import 'package:penger/ui/priority-option/widgets/priority_field.dart';
import 'package:penger/ui/widgets/button/custom_button.dart';
import 'package:penger/ui/widgets/input/custom_textfield.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class FormStepConfigure extends StatefulWidget {
  const FormStepConfigure({
    Key? key,
  }) : super(key: key);

  @override
  _FormStepConfigureState createState() => _FormStepConfigureState();
}

class _FormStepConfigureState extends State<FormStepConfigure> {
  late TextEditingController _startFromController;
  late TextEditingController _endAtController;
  late TextEditingController _transferController;
  late TextEditingController _bookController;
  late TextEditingController _discountController;
  late TextEditingController _quantityController;
  late TextEditingController _timeGapValueController;
  late TextEditingController _preservableAmountController;

  @override
  void initState() {
    final BookingItemModel myProvider =
        Provider.of<BookingItemModel>(context, listen: false);
    // TODO: implement initState
    _startFromController = TextEditingController(
        text: myProvider.startFrom == null
            ? ""
            : DateFormat.yMEd().add_jms().format(myProvider.startFrom!));
    _endAtController = TextEditingController(
        text: myProvider.endAt == null
            ? ""
            : DateFormat.yMEd().add_jms().format(myProvider.endAt!));
    _transferController = TextEditingController(
      text: myProvider.maxTransfer == null
          ? ""
          : myProvider.maxTransfer.toString(),
    );
    _bookController = TextEditingController(
      text: myProvider.maxBook == null ? "" : myProvider.maxBook.toString(),
    );
    _discountController = TextEditingController(
      text: myProvider.discountAmount == null
          ? ""
          : myProvider.discountAmount.toString(),
    );
    _quantityController = TextEditingController(
      text: myProvider.quantity == null ? "" : myProvider.quantity.toString(),
    );
    _timeGapValueController = TextEditingController(
      text: myProvider.timeGapValue.toString(),
    );
    _preservableAmountController = TextEditingController(
      text: myProvider.preservedBookAmount == null
          ? ""
          : myProvider.preservedBookAmount.toString(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> options = [
      {
        "title": "Preservable",
        "subtitle": "Preserve for specific user group.",
        "value": context.watch<BookingItemModel>().preservable,
        "widget": Column(
          children: <Widget>[
            PriorityField(
              defaultColumn: context.watch<BookingItemModel>().dpoCol,
              defaultTable: context.watch<BookingItemModel>().dpoTable,
              defaultCondition: context.watch<BookingItemModel>().condition,
              defaultValue: context.watch<BookingItemModel>().priorityValue,
              onTableFieldChanged: (DpoTable table) {
                context.read<BookingItemModel>().setDpoTable(table);
              },
              onDpoColumnChanged: (DpoColumn column) {
                if (column.id != null) {
                  context.read<BookingItemModel>().setDpoCol(column);
                }
              },
              onConditionChanged: (Condition condition) {
                context.read<BookingItemModel>().setCondition(condition);
              },
              onValueChanged: (String value) {
                context.read<BookingItemModel>().setPriorityValue(value);
              },
            ),
            CustomTextField(
              label: 'Preserve for how many people',
              lblStyle: PengoStyle.caption(context),
              inputType: TextInputType.number,
              hintText: '0',
              controller: _preservableAmountController,
              contentPadding: const EdgeInsets.symmetric(horizontal: 18),
              onChanged: (String v) => context
                  .read<BookingItemModel>()
                  .setPreservedBookAmount(int.tryParse(v)!),
            ),
          ],
        ),
        "func": (bool v) => context.read<BookingItemModel>().setPreservable(v)
      },
      // {
      //   "title": "Early book",
      //   "subtitle": "Allow people book before start.",
      //   "value": ,
      //   "widget": Container(),
      // },
      // {
      //   "title": "Transferable",
      //   "subtitle": "Allow people transfer their slot.",
      //   "value": context.watch<BookingItemModel>().transferable,
      //   "widget": CustomTextField(
      //     label: 'Maximum transfer',
      //     lblStyle: PengoStyle.caption(context),
      //     inputType: TextInputType.number,
      //     hintText: '0',
      //     controller: _transferController,
      //     contentPadding: const EdgeInsets.symmetric(horizontal: 18),
      //     onChanged: (String v) =>
      //         context.read<BookingItemModel>().setMaxTransfer(int.tryParse(v)!),
      //   ),
      //   "func": (bool v) => context.read<BookingItemModel>().setTransferable(v)
      // },
      {
        "title": "Countable",
        "subtitle": "Maximum book for each time slot.",
        "value": context.watch<BookingItemModel>().countable,
        "widget": Column(
          children: [
            CustomTextField(
              label: 'Maximum book',
              lblStyle: PengoStyle.caption(context),
              inputType: TextInputType.number,
              hintText: '0',
              isOptional: true,
              controller: _bookController,
              contentPadding: const EdgeInsets.symmetric(horizontal: 18),
              onChanged: (String v) =>
                  context.read<BookingItemModel>().setMaxBook(int.tryParse(v)!),
            ),
            CustomTextField(
              label: 'Quantity',
              lblStyle: PengoStyle.caption(context),
              inputType: TextInputType.number,
              hintText: '0',
              controller: _quantityController,
              contentPadding: const EdgeInsets.symmetric(horizontal: 18),
              onChanged: (String v) => context
                  .read<BookingItemModel>()
                  .setQuantity(int.tryParse(v)!),
            ),
          ],
        ),
        "func": (bool v) => context.read<BookingItemModel>().setCountable(v)
      },
      // {
      //   "title": "Has discount",
      //   "value": context.watch<BookingItemModel>().discountable,
      //   "widget": CustomTextField(
      //     label: 'Discount amount (MYR)',
      //     lblStyle: PengoStyle.caption(context),
      //     inputType: const TextInputType.numberWithOptions(
      //       signed: true,
      //       decimal: true,
      //     ),
      //     hintText: '10',
      //     controller: _discountController,
      //     decoration: InputDecoration(prefixText: currency),
      //     contentPadding: const EdgeInsets.symmetric(horizontal: 18),
      //     onChanged: (String v) {
      //       if (double.tryParse(v) == null) return;

      //       context
      //           .read<BookingItemModel>()
      //           .setDiscountAmount(double.tryParse(v)!);
      //     },
      //   ),
      //   "func": (bool v) => context.read<BookingItemModel>().setDiscountable(v)
      // },
    ];

    final SystemFunction? noTimeFunc = context
        .watch<BookingItemModel>()
        .category
        ?.bookingOptions
        ?.firstWhereOrNull(
          (SystemFunction element) =>
              element.name == "Fixed timeslot" && element.isActive == true,
        );

    return Material(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          padding: const EdgeInsets.all(18),
          height: mediaQuery(context).size.height * 0.8,
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Configure",
                  style: PengoStyle.header(context),
                ),
                const SizedBox(
                  height: SECTION_GAP_HEIGHT - 10,
                ),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    final option = options[index];
                    return Column(
                      children: [
                        CheckboxListTile(
                          contentPadding: const EdgeInsets.all(0),
                          title: Text(
                            "${option['title']}",
                            style: PengoStyle.title2(context),
                          ),
                          subtitle: option['subtitle'] == null
                              ? Container()
                              : Text(
                                  "${option['subtitle']}",
                                  style: PengoStyle.text(context),
                                ),
                          value: option['value'] == true,
                          onChanged: (bool? val) {
                            option['func'](val);
                          },
                        ),
                        if (option['value'] == true)
                          Container(
                            padding: const EdgeInsets.only(left: 18),
                            child: option['widget'] as Widget,
                          )
                      ],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 0,
                    );
                  },
                  itemCount: options.length,
                ),
                const SizedBox(
                  height: SECTION_GAP_HEIGHT,
                ),
                Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Start from",
                          style: PengoStyle.title2(context),
                        ),
                        // Text(
                        //   "(optional)",
                        //   style: PengoStyle.caption(context).copyWith(
                        //     color: secondaryTextColor,
                        //   ),
                        // ),
                      ],
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 8,
                      child: TextFormField(
                        controller: _startFromController,
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          DatePicker.showDateTimePicker(context,
                              minTime: DateTime.now(),
                              onConfirm: (DateTime dt) {
                            context.read<BookingItemModel>().setStartFrom(dt);
                            _startFromController.text =
                                DateFormat.yMEd().add_jms().format(dt);
                          });
                        },
                        keyboardType: TextInputType.datetime,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: SECTION_GAP_HEIGHT * 2,
                ),
                Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "End at",
                          style: PengoStyle.title2(context),
                        ),
                        // Text(
                        //   "(optional)",
                        //   style: PengoStyle.caption(context).copyWith(
                        //     color: secondaryTextColor,
                        //   ),
                        // ),
                      ],
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 8,
                      child: TextFormField(
                        controller: _endAtController,
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          DatePicker.showDateTimePicker(context,
                              minTime: DateTime.now(),
                              onConfirm: (DateTime dt) {
                            context.read<BookingItemModel>().setEndAt(dt);
                            _endAtController.text =
                                DateFormat.yMEd().add_jms().format(dt);
                          });
                        },
                        keyboardType: TextInputType.datetime,
                      ),
                    ),
                  ],
                ),
                if (noTimeFunc == null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: SECTION_GAP_HEIGHT * 2,
                      ),
                      Text(
                        "Time gap (Units)",
                        style: PengoStyle.title2(context),
                      ),
                      SizedBox(
                        height: 70,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: TIME_GAP_UNIT_LIST.length,
                            itemBuilder: (BuildContext context, int index) {
                              TIME_GAP_UNITS unit = TIME_GAP_UNIT_LIST[index];
                              final bool isSelected = unit ==
                                  context
                                      .watch<BookingItemModel>()
                                      .timeGapUnits;
                              return ChoiceChip(
                                label: Text(
                                  unit.toString().split('.').last,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isSelected
                                          ? whiteColor
                                          : primaryColor),
                                ),
                                selectedColor: primaryColor,
                                backgroundColor: primaryLightColor,
                                selected: isSelected,
                                onSelected: (bool v) {
                                  context
                                      .read<BookingItemModel>()
                                      .setTimeGapUnit(unit);
                                },
                              );
                            }),
                      ),
                      const SizedBox(
                        height: SECTION_GAP_HEIGHT,
                      ),
                      CustomTextField(
                          controller: _timeGapValueController,
                          hintText: "1, 5, 10",
                          label: "Time gap (Value)",
                          inputType: TextInputType.number,
                          onChanged: (String v) {
                            // clear prev if have
                            context
                                .read<BookingItemModel>()
                                .setTimeGapValue(int.tryParse(v)!);
                          }),
                    ],
                  ),
                const SizedBox(
                  height: SECTION_GAP_HEIGHT * 2,
                ),
                CustomButton(
                  onPressed: () {
                    context.read<BookingItemModel>().setIsStepThreeDone(true);
                    Navigator.of(context).pop();
                  },
                  text: const Text("Next"),
                ),
                const SizedBox(
                  height: SECTION_GAP_HEIGHT,
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
    _startFromController.dispose();
    _endAtController.dispose();
    _discountController.dispose();
    _bookController.dispose();
    _transferController.dispose();
    _quantityController.dispose();
    _timeGapValueController.dispose();
    super.dispose();
  }
}
