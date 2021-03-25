// Flutter imports.
import 'package:http/http.dart' as http;

// App imports.
import 'package:mikestore/models/product.dart';
import 'package:mikestore/models/user.dart';
import 'package:mikestore/providers/auth.dart';
import 'package:mikestore/providers/provider.dart';

class UserProvider extends Provider {
  String resourceName = '/users';

  User _user;

  @override
  Provider auth(AuthProvider authProvider) {
    this._user = authProvider.user;
    return super.auth(authProvider);
  }

  Future<void> addOrRemoveFavorite(Product product) async {
    String url = getApiUrl('/${_user.id}');

    // Remove product if exists, adds if not.
    if (isFavorite(product)) {
      _user.favorites.remove(product.id);
    } else {
      _user.favorites.add(product.id);
    }

    await http.patch(url, body: _user.toJson());
  }

  bool isFavorite(Product product) => _user.favorites.contains(product.id);
}
