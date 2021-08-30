import 'package:flutter/material.dart';
import 'package:penger/const/space_const.dart';
import 'package:penger/helpers/theme/custom_font.dart';
import 'package:penger/helpers/theme/theme_helper.dart';
import 'package:penger/models/providers/booking_item_model.dart';
import 'package:penger/ui/widgets/button/custom_button.dart';
import 'package:provider/provider.dart';

class FormStepReward extends StatelessWidget {
  const FormStepReward({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          padding: const EdgeInsets.all(18),
          height: mediaQuery(context).size.height * 0.4,
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Reward",
                  style: PengoStyle.header(context),
                ),
                const SizedBox(
                  height: SECTION_GAP_HEIGHT,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "${context.watch<BookingItemModel>().creditPoints.toInt()} credit points",
                      style: PengoStyle.caption(context),
                    ),
                    Slider(
                      max: 1000,
                      divisions: 10,
                      value: context.watch<BookingItemModel>().creditPoints,
                      onChanged: (double v) {
                        context.read<BookingItemModel>().setCreditPoints(v);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "0",
                            style: PengoStyle.caption(context),
                          ),
                          const Spacer(),
                          Text(
                            "1000",
                            style: PengoStyle.caption(context),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: SECTION_GAP_HEIGHT * 2,
                    ),
                    CustomButton(
                      text: const Text("Next"),
                      onPressed: () {
                        context
                            .read<BookingItemModel>()
                            .setIsStepFourDone(true);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
