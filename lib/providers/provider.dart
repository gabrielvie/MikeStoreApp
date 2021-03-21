import 'package:flutter/foundation.dart';
import 'package:mikestore/providers/auth.dart';

abstract class Provider with ChangeNotifier {
  String apiServerURL =
      'https://shopapp-gabrielvie-default-rtdb.firebaseio.com';
  String resourceName;

  AuthProvider authProvider;

  Provider auth(AuthProvider authProvider) {
    this.authProvider = authProvider;
    return this;
  }

  String getApiUrl([String complement = '', withJson = true]) {
    String apiUrl = apiServerURL + resourceName;

    if (complement.isNotEmpty) {
      apiUrl += complement;
    }

    if (withJson) {
      apiUrl += '.json';
    }

    if (authProvider != null && authProvider.token != null) {
      apiUrl += '?auth=${authProvider.token}';
    }

    return apiUrl;
  }
}
