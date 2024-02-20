import 'dart:convert';
import 'package:attedance/models/login_response.dart';
import 'package:attedance/pages/home_page.dart';
import 'package:attedance/profile/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final formkey = GlobalKey<FormState>();
  bool passwordvisible = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  // simpan token user
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> _token, _firstName, _lastName, _email, _phone;

 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _token = _prefs.then((SharedPreferences prefs) {
      return prefs.getString("token") ?? "";
    });

    _firstName = _prefs.then((SharedPreferences prefs) {
      return prefs.getString("firstName") ?? "";
    });
    _lastName = _prefs.then((SharedPreferences prefs) {
      return prefs.getString("lastName") ?? "";
    });
    _email = _prefs.then((SharedPreferences prefs) {
      return prefs.getString("email") ?? "";
    });
    _phone = _prefs.then((SharedPreferences prefs) {
      return prefs.getString("phone") ?? "";
    });
    checkToken(_token, _firstName, _lastName, _email, _phone);
  }

  checkToken(token, firstName, lastName, email, phone) async {
    String tokenStr = await token;
    String firstNameStr = await firstName;
    String lastNameStr = await lastName;
    String emailStr = await email;
    String phoneStr = await phone;
    if (tokenStr != "" && emailStr != "" && firstNameStr != "" && lastNameStr != "" && emailStr != "" && phoneStr != "") {
      Future.delayed(Duration(seconds: 1), () async {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomePage()))
            .then((value) {
          setState(() {});
        });
      });
    }
  }

  Future login(email, password) async {
    LoginResponseModel? loginResponseModel;
    Map<String, String> body = {"email": email, "password": password};
    var response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/login'),
        body: body);
    if (response.statusCode == 200) {
       loginResponseModel =
          LoginResponseModel.fromJson(json.decode(response.body));
      print('HASIL ' + response.body);
      // tampilkan alert dialog success
       
      saveUser(
        loginResponseModel.token, 
        loginResponseModel.user.firstName, 
        loginResponseModel.user.lastName, 
        loginResponseModel.user.email, 
        loginResponseModel.user.phone);
       // Redirect ke halaman beranda (HomePage) setelah beberapa detik
      Future.delayed(const Duration(seconds: 2), () {
        _showSuccessMessage('Welcome to attendance app!');
        Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => const HomePage()),
        (Route<dynamic> route) => false);
      });
      return true;
    } else if (response.statusCode == 401) {
      // Login gagal
      _showErrorMessage('Login gagal. Silakan coba lagi.');
    } else {
      // Error lainnya
      _showErrorMessage('Terjadi kesalahan. Silakan coba lagi nanti.');
    }
  }

  Future saveUser(token, firstName, lastName, email, phone) async {
    try {
      final SharedPreferences pref = await _prefs;
      pref.setString("token", token);
      pref.setString("firstName", firstName);
      pref.setString("lastName", lastName);
      pref.setString("email", email);
      pref.setString("phone", phone);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()))
          .then((value) {
        setState(() {});
      });
    } catch (err) {
      print('LOGIN FAILED');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err.toString())));
    }
  }

    // Notifikasi/alert dialog

  void _showSuccessMessage(String message) {
    QuickAlert.show(
      context: context,
      title: 'Login Successfull!',
      text: 'Welcome to attendance app!',
      type: QuickAlertType.success,
    );
  }

    void _showErrorMessage(String message) {
    QuickAlert.show(
      context: context,
      title: 'Login Failed!',
      text: 'Periksa Kembali Email dan Password Anda',
      type: QuickAlertType.error,
    );
  }



 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          "Sign In",
          style: TextStyle(
            fontSize: 20,
            fontFamily: "Roboto-Bold",
            color: Colors.white,
            letterSpacing: 1,
          ),
        ),
        leading: Container(),
      ),
      body: ListView(
        children: [
          Form(
            key: formkey,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logoptsos.png',
                      width: 300,
                      height: 250,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.email_outlined,
                            color: Colors.black54),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "this field cannot be empty!";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: password,
                      obscureText: !passwordvisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            passwordvisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              passwordvisible = !passwordvisible;
                            });
                          },
                        ),
                        prefixIcon:
                            const Icon(Icons.lock, color: Colors.black54),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "this field cannot be empty!";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: const Text("Forgot Password?")),
                      ],
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          login(email.text, password.text).then((value) {
                            if (value) {}
                          });
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        minimumSize: MaterialStateProperty.all(
                          Size(MediaQuery.of(context).size.width, 50.0),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Roboto-Bold",
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
