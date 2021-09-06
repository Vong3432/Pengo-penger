import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:penger/helpers/formatter/bool_to_int.dart';
import 'package:penger/models/booking_item_model.dart';

class BookingItemModel with ChangeNotifier {
  int? _id;
  int? _categoryId;
  bool _isPreserveable = false;
  bool _isTransferable = false;
  bool _isCountable = false;
  bool _isDiscountable = false;
  String _name = "";
  String _description = "";
  double? _price;
  XFile? _poster;
  String? _posterUrl;
  String _location = "";
  DateTime? _startFrom;
  DateTime? _endAt;
  double _creditPoints = 0;
  int? _maxTransfer;
  int? _maxBook;
  int? _quantity;
  int? _preservedBook;
  double? _discountAmount = 0;
  double? _lng;
  double? _lat;
  bool _isStepFourDone = false;

  int? get id => _id;

  void setPosterUrl(String url) {
    _posterUrl = url;
    notifyListeners();
  }

  String? get posterUrl => _posterUrl;

  void setLng(double v) {
    _lng = v;
    notifyListeners();
  }

  double? get lng => _lng;

  void setLat(double v) {
    _lat = v;
    notifyListeners();
  }

  double? get lat => _lat;

  void setDiscountAmount(double v) {
    _discountAmount = v;
    notifyListeners();
  }

  double? get discountAmount => _discountAmount;

  void setMaxBook(int v) {
    _maxBook = v;
    notifyListeners();
  }

  int? get maxBook => _maxBook;

  void setQuantity(int v) {
    _quantity = v;
    notifyListeners();
  }

  int? get quantity => _quantity;

  void setMaxTransfer(int v) {
    _maxTransfer = v;
    notifyListeners();
  }

  int? get maxTransfer => _maxTransfer;

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

  Future<Map<String, dynamic>> toMap() async {
    var map = new Map<String, dynamic>();
    map["booking_category_id"] = _categoryId;
    map["name"] = _name;
    if (_poster != null) {
      map["poster"] = await MultipartFile.fromFile(_poster!.path,
          filename: _poster!.name, contentType: MediaType("image", "png"));
    }
    map["geolocation"] = {
      "latitude": _lat,
      "longitude": _lng,
      "name": _location,
    };
    map["is_preservable"] = boolToInt(_isPreserveable);
    map["is_transferable"] = boolToInt(_isTransferable);
    map["is_countable"] = boolToInt(_isCountable);
    map["is_discountable"] = boolToInt(_isDiscountable);
    map["quantity"] = _quantity;
    map["discount_amount"] = _discountAmount;
    map["credit_points"] = _creditPoints;
    map["maximum_transfer"] = _maxTransfer;
    map["maximum_book"] = _maxBook;
    map["preserved_book"] = boolToInt(_isPreserveable);
    map["price"] = _price;
    map["start_from"] = DateFormat("yyyy-MM-dd hh:mm:ss").format(_startFrom!);
    map["end_at"] = DateFormat("yyyy-MM-dd hh:mm:ss").format(_endAt!);
    map["quantity"] = _quantity;

    // Add all other fields
    return map;
  }

  void setBookingItem(BookingItem item) {
    _id = item.id;
    _categoryId = item.categoryId;
    _isCountable = item.isCountable ?? false;
    _isTransferable = item.isTransferable ?? false;
    _isDiscountable = item.isDiscountable ?? false;
    _creditPoints =
        item.creditPoints != null ? item.creditPoints! as double : 0.0;
    _description = item.description ?? "";
    _name = item.title;
    _price = item.price;
    _location = item.location ?? "";
    _discountAmount = item.discountAmount;
    _posterUrl = item.poster;
    _quantity = item.quantity;
    _maxTransfer = item.maxTransfer;
    _maxBook = item.maxBook;

    if (item.location != null) {
      final d = jsonDecode(item.location!);
      _location = d['name'].toString();
      _lat = d['latitude'] as double;
      _lng = d['longitude'] as double;
    }

    if (item.startFrom != null) {
      _startFrom = item.startFrom;
    }
    if (item.endAt != null) {
      _endAt = item.endAt;
    }
    notifyListeners();
  }

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
    _posterUrl = null;
    _location = "";
    _startFrom = null;
    _endAt = null;
    _creditPoints = 0;
    _isStepFourDone = false;
    _lat = null;
    _lng = null;
    _maxBook = null;
    _maxTransfer = null;
    _quantity = null;
    _discountAmount = null;
  }
}
