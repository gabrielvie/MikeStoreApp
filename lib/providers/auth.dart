import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mikestore/models/user.dart';

// App imports.
import 'package:mikestore/providers/provider.dart';
import 'package:mikestore/utils/exeptions.dart';

class AuthProvider extends Provider {
  @override
  String apiServerURL = 'https://www.googleapis.com/identitytoolkit/v3';
  String resourceName = '/relyingparty';
  Map<String, String> actions = {
    'signin': '/verifyPassword?key=<key>',
    'signup': '/signupNewUser?key=<key>',
  };

  String apiKey = 'AIzaSyAPzs1YKhN38lC4qfHJvw1DVwEcNLJ_EzQ';

  User _user;

  Map<String, dynamic> _auth = {
    'idToken': null,
    'user': null,
    'refreshToken': null,
    'expiresIn': null
  };

  bool get isAuthenticated {
    return _auth['idToken'] != null;
  }

  String get token {
    if (_auth['expiresIn'] != null &&
        _auth['expiresIn'].isAfter(DateTime.now())) {
      return token;
    }

    return null;
  }

  Map<String, dynamic> _encodeData() {
    // Preparing data to send to the API Server.
    var mappedUser = _user.toMap();
    mappedUser.addAll({'returnSecureToken': true});

    return mappedUser;
  }

  void _storeData(Map<String, dynamic> responseData) {
    _user.id = responseData['localId'];

    int expiresIn = int.parse(responseData['expiresIn']);

    _auth.addAll({
      'idToken': responseData['idToken'],
      'user': _user,
      'refreshToken': responseData['refreshToken'],
      'expiresIn': DateTime.now().add(Duration(seconds: expiresIn)),
    });
  }

  Future<void> request(User user, String actionKey) async {
    _user = user;

    final String apiAction = actions[actionKey].replaceAll('<key>', apiKey);
    final String apiUrl = getApiUrl(apiAction, false);

    final response = await http.post(apiUrl, body: json.encode(_encodeData()));
    final responseData = json.decode(response.body) as Map<String, dynamic>;

    if (responseData['error'] != null) {
      throw new HttpException(
        code: responseData['error']['code'],
        error: responseData['error']['message'],
      );
    }

    _storeData(responseData);
    notifyListeners();
  }
}
