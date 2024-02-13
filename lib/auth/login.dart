// ignore_for_file: empty_catches

import 'package:attedance/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formkey = GlobalKey<FormState>();
  bool passwordvisible = false;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  // login
  Future login() async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/login'),
        body: {
          'email': email.text,
          'password': password.text,
        },
      );
      
      if (response.statusCode == 200) {
        print("success");
         _showSuccessMessage('Welcome to attendance app!');
         // Redirect ke halaman beranda (HomePage) setelah beberapa detik
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        });
        return true;
      } else if (response.statusCode == 401) {
        // Login gagal
        _showErrorMessage('Login gagal. Silakan coba lagi.');
      } else {
        // Error lainnya
        _showErrorMessage('Terjadi kesalahan. Silakan coba lagi nanti.');
      }    
    } catch (e) {
      return false;
    }
  }
  void _showErrorMessage(String message) {
    QuickAlert.show(
      context: context,
      title: 'Login Failed!',
      text: 'Periksa Kembali Email dan Password Anda',
      type: QuickAlertType.error,
    );
  }

  void _showSuccessMessage(String message) {
    QuickAlert.show(
      context: context,
      title: 'Login Successfull!',
      text: 'Welcome to attendance app!',
      type: QuickAlertType.success,
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
                        prefixIcon: const Icon(Icons.email_outlined, color: Colors.black54),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)
                        ),
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
                            passwordvisible ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              passwordvisible = !passwordvisible;
                            });
                          },
                        ),
                        prefixIcon: const Icon(Icons.lock, color: Colors.black54),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)
                        ),
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
                        TextButton(onPressed: () {},
                        child: const Text("Forgot Password?")
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                  
                    ElevatedButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          login().then((value) {
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