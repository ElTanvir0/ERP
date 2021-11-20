import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:new_ways_app/features/auth/controller/authentication_provider.dart';
import 'package:new_ways_app/utils/constants.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  final _authctrl = Get.find<AuthenticationController>();
  LoginPage({Key? key}) : super(key: key);

  final double fontSize = 42;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _userIdController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  late String _userId;
  late String _password;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 140,
                child: Image.asset(
                  'assets/images/splash_logo.png',
                  fit: BoxFit.fitWidth,
                ),
              ),

              Container(
                height: 140,
                width: 140,
                child: Lottie.asset('assets/login.json'),
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        width: deviceSize.width * 0.9,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: TextFormField(
                          controller: _userIdController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8),

                            filled: true,

                            hintText: 'Please enter your id',

                            focusColor: Colors.grey,

                            fillColor: Color(0xFFECE7E7),

                            //  enabledBorder: InputBorder.none,

                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          onSaved: (value) {
                            _userId = value!;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your id';
                            }

                            if (value.length < 5 || value.length > 5) {
                              return 'Please enter a valid id';
                            }

                            return null;
                          },
                        ),
                      ),
                      Container(
                        width: deviceSize.width * 0.9,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8),

                            filled: true,

                            hintText: 'Please enter your password',

                            focusColor: Colors.grey,

                            fillColor: Color(0xFFECE7E7),

                            //  enabledBorder: InputBorder.none,

                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          onSaved: (value) {
                            _password = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a password';
                            }

                            return null;
                          },
                        ),
                      ),
                    ],
                  )),

              SizedBox(
                height: 20,
              ),

              //  Spacer(),

              Container(
                width: deviceSize.width * 0.9,
                height: 45,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => Dialog(
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  height: 80,
                                  child: Row(
                                    children: [
                                      CircularProgressIndicator(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Text('Wait you are logginn in...')
                                    ],
                                  ),
                                ),
                              ));

                      await _authctrl.logingUser(_userId, _password, context);
                    }
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
              ),

              SizedBox(
                height: deviceSize.height * 0.01,
              )
            ],
          ),
        ),
      ),
    );
  }
}
