// ignore_for_file: use_build_context_synchronously, empty_catches
import 'package:attedance/pages/home_page.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formkey = GlobalKey<FormState>();
  String selectedRole = 'karyawan';

  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool passwordvisible = false;

  // register
  Future register() async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/register'),
        body: {
          'first_name': firstname.text,
          'last_name': lastname.text,
          'phone': phone.text,
          'email': email.text,
          'password': password.text,
          'role_id' : "karyawan",
        },
      );

      if (response.statusCode == 201) {
        // print('Success');
        _showSuccessMessage('Complete!');
        // Redirect ke halaman beranda (HomePage) setelah beberapa detik
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        });
      } else if (response.statusCode == 401) {
        // Login gagal
        _showErrorMessage('Login gagal. Silakan coba lagi.');
      } else {
        // Error lainnya
        _showErrorMessage('Terjadi kesalahan. Silakan coba lagi nanti.');
      }
    } catch (e) {}
  }

  void _showErrorMessage(String message) {
    QuickAlert.show(
      context: context,
      title: 'Registration Failed!',
      text: 'Input form tidak valid atau email sudah terdaftar!',
      type: QuickAlertType.error,
    );
  }

  void _showSuccessMessage(String message) {
    QuickAlert.show(
      context: context,
      title: 'Registration Successfull!',
      text: 'Congratulationts!',
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
            "Add Employe",
            style: TextStyle(
              fontSize: 20,
              fontFamily: "Roboto-Bold",
              color: Colors.white,
              letterSpacing: 1,
            ),
          ),
        ),
        body: ListView(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 2, right: 16),
                              child: TextFormField(
                                controller: firstname,
                                maxLines: null,
                                decoration: InputDecoration(
                                  labelText: 'First Name',
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
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 2),
                              child: TextFormField(
                                controller: lastname,
                                maxLines: null,
                                decoration: InputDecoration(
                                  labelText: 'Last Name',
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
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 2, right: 16),
                              child: TextFormField(
                                controller: email,
                                keyboardType: TextInputType.emailAddress,
                                maxLines: null,
                                decoration: InputDecoration(
                                  labelText: 'Email',
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
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 2),
                              child: TextFormField(
                                controller: phone,
                                keyboardType: TextInputType.number,
                                maxLines: null,
                                decoration: InputDecoration(
                                  labelText: 'Phone',
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
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: password,
                        obscureText: !passwordvisible,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
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
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "this field cannot be empty!";
                          } else if (value.length < 6) {
                            return "password setidaknya 6 karakter atau lebih";
                          }
                          return null;
                        },
                      ),
                      // const SizedBox(height: 30),
                      // DropdownButtonFormField(
                      //   value: selectedRole,
                      //   items: const [
                      //     DropdownMenuItem(
                      //         value: 'karyawan', child: Text('Karyawan')),
                      //     DropdownMenuItem(
                      //         value: 'management', child: Text('Management')),
                      //     DropdownMenuItem(
                      //         value: 'admin', child: Text('Admin')),
                      //   ],
                      //   onChanged: (value) {
                      //     setState(() {
                      //       selectedRole = value.toString();
                      //     });
                      //   },
                      // ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            register().then((value) {
                              if (value) {}
                            });
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
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
                          'Add Employe',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Roboto-Bold",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
