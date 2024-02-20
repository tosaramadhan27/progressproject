import 'dart:convert';


import 'package:attedance/auth/home_screen.dart';
import 'package:attedance/models/login_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
    if (
      tokenStr != "" && 
      emailStr != "" && 
      firstNameStr != "" && 
      lastNameStr != "" && 
      emailStr != "" && 
      phoneStr != "") {
      Future.delayed(Duration(seconds: 1), () async {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomeScreen()))
            .then((value) {
          setState(() {});
        });
      });
    }
  }

  Future login(email, password) async {
    Map<String, String> body = {"email": email, "password": password};
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${await _token}',
    'Access-Control-Allow-Origin': '*',
  };

  try {
    var response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/login'),
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      // Login berhasil
      var loginResponseModel =
          LoginResponseModel.fromJson(json.decode(response.body));
      print('HASIL ' + response.body);
      saveUser(
          loginResponseModel.token,
          loginResponseModel.user.firstName,
          loginResponseModel.user.lastName,
          loginResponseModel.user.email,
          loginResponseModel.user.phone);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      // Login gagal
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Email atau password salah")));
    }
  } catch (error) {
    // Exception saat melakukan request
    print('Error: $error');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Terjadi kesalahan saat melakukan login")));
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
          .push(MaterialPageRoute(builder: (context) => HomeScreen()))
          .then((value) {
        setState(() {});
      });
    } catch (err) {
      print('ERROR :' + err.toString());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text("LOGIN")),
              SizedBox(height: 20),
              Text("Email"),
              TextField(
                controller: emailController,
              ),
              SizedBox(height: 20),
              Text("Password"),
              TextField(
                controller: passwordController,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    login(emailController.text, passwordController.text);
                  },
                  child: Text("Masuk"))
            ],
          ),
        ),
      )),
    );
  }
}

