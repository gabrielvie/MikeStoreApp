import 'package:flutter/foundation.dart';

abstract class Provider with ChangeNotifier {
  String apiServerURL =
      'https://shopapp-gabrielvie-default-rtdb.firebaseio.com';
  String resourceName;

  String getApiUrl([String complement = '']) {
    String apiUrl = apiServerURL + resourceName;

    if (complement.isNotEmpty) {
      apiUrl += complement;
    }

    return apiUrl + '.json';
  }

  Future<void> fetchData();

  Future<void> create();

  Future<void> update();

  Future<void> delete();
}
