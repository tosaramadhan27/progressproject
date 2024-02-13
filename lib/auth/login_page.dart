// import 'dart:convert';

// import 'package:auth/models/login_response.dart';
// import 'package:auth/pages/home_page.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   late Future<String> _token, _firstName, _lastName, _email, _phone;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _token = _prefs.then((SharedPreferences prefs) {
//       return prefs.getString("token") ?? "";
//     });

//     _firstName = _prefs.then((SharedPreferences prefs) {
//       return prefs.getString("firstName") ?? "";
//     });
//     _lastName = _prefs.then((SharedPreferences prefs) {
//       return prefs.getString("lastName") ?? "";
//     });
//     _email = _prefs.then((SharedPreferences prefs) {
//       return prefs.getString("email") ?? "";
//     });
//     _phone = _prefs.then((SharedPreferences prefs) {
//       return prefs.getString("phone") ?? "";
//     });
//     checkToken(_token, _firstName, _lastName, _email, _phone);
//   }

//   checkToken(token, firstName, lastName, email, phone) async {
//     String tokenStr = await token;
//     String firstNameStr = await firstName;
//     String lastNameStr = await lastName;
//     String emailStr = await email;
//     String phoneStr = await phone;
//     if (tokenStr != "" && emailStr != "" && firstNameStr != "" && lastNameStr != "" && emailStr != "" && phoneStr != "") {
//       Future.delayed(Duration(seconds: 1), () async {
//         Navigator.of(context)
//             .push(MaterialPageRoute(builder: (context) => HomePage()))
//             .then((value) {
//           setState(() {});
//         });
//       });
//     }
//   }

//   Future login(email, password) async {
//     LoginResponseModel? loginResponseModel;
//     Map<String, String> body = {"email": email, "password": password};
//     var response = await http.post(
//         Uri.parse('http://127.0.0.1:8000/api/login'),
//         body: body);
//     if (response.statusCode == 500) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("Email atau password salah")));
//     } else {
//       loginResponseModel =
//           LoginResponseModel.fromJson(json.decode(response.body));
//       print('HASIL ' + response.body);
//       saveUser(loginResponseModel.token, loginResponseModel.user.firstName, loginResponseModel.user.lastName, loginResponseModel.user.email, loginResponseModel.user.phone);
//     }
//   }

//   Future saveUser(token, firstName, lastName, email, phone) async {
//     try {
//       print("LEWAT SINI " + token + " | " + email);
//       final SharedPreferences pref = await _prefs;
//       pref.setString("token", token);
//       pref.setString("firstName", firstName);
//       pref.setString("lastName", lastName);
//       pref.setString("email", email);
//       pref.setString("phone", phone);
//       Navigator.of(context)
//           .push(MaterialPageRoute(builder: (context) => HomePage()))
//           .then((value) {
//         setState(() {});
//       });
//     } catch (err) {
//       print('ERROR :' + err.toString());
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text(err.toString())));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//           child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Center(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Center(child: Text("LOGIN")),
//               SizedBox(height: 20),
//               Text("Email"),
//               TextField(
//                 controller: emailController,
//               ),
//               SizedBox(height: 20),
//               Text("Password"),
//               TextField(
//                 controller: passwordController,
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                   onPressed: () {
//                     login(emailController.text, passwordController.text);
//                   },
//                   child: Text("Masuk"))
//             ],
//           ),
//         ),
//       )),
//     );
//   }
// }






//  // login
//   Future login(email, password) async {
//     LoginResponseModel? loginResponseModel;
//     Map<String, String> body = {"email": email, "password": password};
//     var response = await http.post(Uri.parse('http://127.0.0.1:8000/api/login'),
//         body: body);

//     if (response.statusCode == 200) {
//       print("success");
//       loginResponseModel =
//           loginResponseModel.fromJson(jsonDecode(response.body));
//       print('HASIL ' + response.body);

//       saveUser(
//           loginResponseModel.token,
//           loginResponseModel.user.firstName,
//           loginResponseModel.user.lastName,
//           loginResponseModel.user.email,
//           loginResponseModel.user.phone);

//       // panggil alert dialog notifikasi
//       _showSuccessMessage('Welcome to attendance app!');
//       // Redirect ke halaman beranda (HomePage) setelah beberapa detik
//       Future.delayed(const Duration(seconds: 2), () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const HomePage()),
//         );
//       });
//       return true;
//     } else if (response.statusCode == 401) {
//       // Login gagal
//       _showErrorMessage('Login gagal. Silakan coba lagi.');
//     } else {
//       // Error lainnya
//       _showErrorMessage('Terjadi kesalahan. Silakan coba lagi nanti.');
//     }
//   }

//   // save user di shared preferences
//    Future saveUser(token, firstName, lastName, email, phone) async {
//     try {
//       print("LEWAT SINI " + token + " | " + email);
//       final SharedPreferences pref = await _prefs;
//       pref.setString("token", token);
//       pref.setString("firstName", firstName);
//       pref.setString("lastName", lastName);
//       pref.setString("email", email);
//       pref.setString("phone", phone);
//       Navigator.of(context)
//           .push(MaterialPageRoute(builder: (context) => HomePage()))
//           .then((value) {
//         setState(() {});
//       });
//     } catch (err) {
//       print('ERROR :' + err.toString());
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text(err.toString())));
//     }
//   }



//   // Notifikasi/alert dialog
//   void _showErrorMessage(String message) {
//     QuickAlert.show(
//       context: context,
//       title: 'Login Failed!',
//       text: 'Periksa Kembali Email dan Password Anda',
//       type: QuickAlertType.error,
//     );
//   }

//   void _showSuccessMessage(String message) {
//     QuickAlert.show(
//       context: context,
//       title: 'Login Successfull!',
//       text: 'Welcome to attendance app!',
//       type: QuickAlertType.success,
//     );
//   }


//   // user profile
//   Container(
//         padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
//         child: GestureDetector(
//           onTap: () {
//             FocusScope.of(context).unfocus();
//           },
//           child: ListView(
//             children: [
//                Column(
//                  children: [
//                    Card(
//                     margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
//                     child: ListTile(
//                       leading: Icon(
//                         Icons.person,
//                         color: Colors.teal,
//                       ),
//                       title: FutureBuilder(
//                         future: _firstName,
//                         builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
//                           if (snapshot.connectionState ==  ConnectionState.waiting) {
//                             return CircularProgressIndicator();
//                           } else if (snapshot.hasData) {
//                             return Text(snapshot.data!);
//                           } else {
//                             return Text("gaada");
//                           }                 
//                         }
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                    Card(
//                     margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
//                     child: ListTile(
//                       leading: Icon(
//                         Icons.person,
//                         color: Colors.teal,
//                       ),
//                       title: FutureBuilder(
//                         future: _lastName,
//                         builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
//                           if (snapshot.connectionState ==  ConnectionState.waiting) {
//                             return CircularProgressIndicator();
//                           } else if (snapshot.hasData) {
//                             return Text(snapshot.data!);
//                           } else {
//                             return Text("gaada");
//                           }                 
//                         }
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 10,),
//                    Card(
//                     margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
//                     child: ListTile(
//                       leading: Icon(
//                         Icons.email,
//                         color: Colors.teal,
//                       ),
//                       title: FutureBuilder(
//                         future: _email,
//                         builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
//                           if (snapshot.connectionState ==  ConnectionState.waiting) {
//                             return CircularProgressIndicator();
//                           } else if (snapshot.hasData) {
//                             return Text(snapshot.data!);
//                           } else {
//                             return Text("gaada");
//                           }                 
//                         }
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 10,),
//                    Card(
//                     margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
//                     child: ListTile(
//                       leading: Icon(
//                         Icons.phone,
//                         color: Colors.teal,
//                       ),
//                       title: FutureBuilder(
//                         future: _phone,
//                         builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
//                           if (snapshot.connectionState ==  ConnectionState.waiting) {
//                             return CircularProgressIndicator();
//                           } else if (snapshot.hasData) {
//                             return Text(snapshot.data!);
//                           } else {
//                             return Text("gaada");
//                           }                 
//                         }
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 10,),
//                  ],
//                ),                 
//               SizedBox(height: 30,),
//             ],
//           ),
//         ),
//       ),