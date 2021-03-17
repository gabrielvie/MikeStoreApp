import 'package:flutter/foundation.dart';

abstract class Provider with ChangeNotifier {
  String apiServerURL =
      'https://shopapp-gabrielvie-default-rtdb.firebaseio.com';
  String resourceName;

  String getApiUrl([String complement = '', withJson = true]) {
    String apiUrl = apiServerURL + resourceName;

    if (complement.isNotEmpty) {
      apiUrl += complement;
    }

    if (withJson) {
      return apiUrl + '.json';
    }

    return apiUrl;
  }
}
