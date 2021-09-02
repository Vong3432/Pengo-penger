import 'package:intl/intl.dart';
import 'package:penger/const/locale_const.dart';

String formatNumber(String s) =>
    NumberFormat.decimalPattern(LOCALE_LNG).format(int.parse(s));
String get currency =>
    NumberFormat.compactSimpleCurrency(locale: LOCALE_LNG).currencySymbol;
