import 'package:flutter/material.dart';
import 'package:mikestore/utils/exeptions.dart';
import 'package:provider/provider.dart';

// App imports.
import 'package:mikestore/models/user.dart';
import 'package:mikestore/providers/auth.dart';
import 'package:mikestore/utils/constants.dart';
import 'package:mikestore/utils/enums.dart';

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  AuthMode _authMode = AuthMode.Login;
  Map<String, String> userData = {
    'email': null,
    'password': null,
  };

  bool _isLoading = false;
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 8,
      child: Container(
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 320 : 260),
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }

                    return null;
                  },
                  onSaved: (value) {
                    userData['email'] = value.toLowerCase();
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'password'),
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  controller: _passwordController,
                  validator: (value) {
                    if (value.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }

                    return null;
                  },
                  onSaved: (value) {
                    userData['password'] = value;
                  },
                ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'Password do not match!';
                            }

                            return null;
                          }
                        : null,
                  ),
                SizedBox(height: 20),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  ElevatedButton(
                    child:
                        Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                      primary: Constants.lightAccent,
                      textStyle: TextStyle(color: Constants.darkAccent),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                TextButton(
                  onPressed: _switchAuthMode,
                  child: Text(
                      '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 4),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    textStyle: TextStyle(color: Constants.lightAccent),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('An error occurred!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Ok'),
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    setState(() {
      _isLoading = true;
    });

    User user = User.fromMap(userData);
    AuthProvider authProvider = Provider.of(context, listen: false);

    try {
      if (_authMode == AuthMode.Login) {
        await authProvider.request(user, 'signin');
      } else {
        await authProvider.request(user, 'signup');
      }
    } on HttpException catch (e) {
      _showErrorDialog(e.toString());
    } catch (e) {
      _showErrorDialog(e.toString());
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    setState(() {
      _authMode =
          _authMode == AuthMode.Login ? AuthMode.Signup : AuthMode.Login;
    });
  }
}
