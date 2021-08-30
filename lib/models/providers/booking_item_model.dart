import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class BookingItemModel with ChangeNotifier {
  int? _categoryId;
  bool _isPreserveable = false;
  bool _isTransferable = false;
  bool _isCountable = false;
  bool _isDiscountable = false;
  String _name = "";
  String _description = "";
  double? _price;
  XFile? _poster;
  String _location = "";
  DateTime? _startFrom;
  DateTime? _endAt;
  double _creditPoints = 0;

  bool _isStepFourDone = false;

  void setIsStepFourDone(bool v) {
    _isStepFourDone = v;
    notifyListeners();
  }

  bool get isStepFourDone => _isStepFourDone;

  void setCategoryId(int v) {
    _categoryId = v;
    notifyListeners();
  }

  int? get categoryId => _categoryId;

  void setPreservable(bool v) {
    _isPreserveable = v;
    notifyListeners();
  }

  bool get preservable => _isPreserveable;

  void setTransferable(bool v) {
    _isTransferable = v;
    notifyListeners();
  }

  bool get transferable => _isTransferable;

  void setCountable(bool v) {
    _isCountable = v;
    notifyListeners();
  }

  bool get countable => _isCountable;

  void setDiscountable(bool v) {
    _isDiscountable = v;
    notifyListeners();
  }

  bool get discountable => _isDiscountable;

  void setName(String v) {
    _name = v;
    debugPrint(v);
    notifyListeners();
  }

  String get name => _name;

  void setDescription(String v) {
    _description = v;
    notifyListeners();
  }

  String get description => _description;

  void setLocation(String v) {
    _location = v;
    notifyListeners();
  }

  String get location => _location;

  void setPrice(double v) {
    _price = v;
    notifyListeners();
  }

  double? get price => _price;

  void setCreditPoints(double v) {
    _creditPoints = v;
    notifyListeners();
  }

  double get creditPoints => _creditPoints;

  void setPoster(XFile v) {
    _poster = v;
    notifyListeners();
  }

  XFile? get poster => _poster;

  void setStartFrom(DateTime v) {
    debugPrint(v.toString());
    _startFrom = v;
    notifyListeners();
  }

  DateTime? get startFrom => _startFrom;

  void setEndAt(DateTime v) {
    _endAt = v;
    notifyListeners();
  }

  DateTime? get endAt => _endAt;

  void disposeBookingItemModel() {
    debugPrint("dispose");
    _categoryId = null;
    _isPreserveable = false;
    _isTransferable = false;
    _isCountable = false;
    _isDiscountable = false;
    _name = "";
    _description = "";
    _price = null;
    _poster = null;
    _location = "";
    _startFrom = null;
    _endAt = null;
    _creditPoints = 0;
    _isStepFourDone = false;
  }
}
