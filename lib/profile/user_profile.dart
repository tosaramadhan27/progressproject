// ignore_for_file: use_build_context_synchronously

import 'package:attedance/auth/auth_page.dart';
import 'package:attedance/auth/register.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> _firstName, _lastName, _email;

  @override
  void initState() {
    super.initState();
    _firstName = _prefs.then((SharedPreferences prefs) {
      return prefs.getString("firstName") ?? "";
    });
    _lastName = _prefs.then((SharedPreferences prefs) {
      return prefs.getString("lastName") ?? "";
    });
    _email = _prefs.then((SharedPreferences prefs) {
      return prefs.getString("email") ?? "";
    });
  }

  // logout
  Future<void> logout() async {
    final SharedPreferences prefs = await _prefs;
    await prefs.remove("token");
    await prefs.remove("firstName");
    await prefs.remove("lastName");
    await prefs.remove("email");
    await prefs.remove("phone");
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => const AuthPage()),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text(
          "Profile",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              color: Colors.white),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  // hanya untuk menampilkan inisial dari first name dan last name menggunakan iamge network
                  child: FutureBuilder(
                    future: Future.wait([_firstName, _lastName]),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<String>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasData) {
                        List<String> data = snapshot.data!;
                        String firstInitial = data[0].isNotEmpty
                            ? data[0][0].toUpperCase()
                            : ''; // Inisial dari first_name
                        String lastInitial = data[1].isNotEmpty
                            ? data[1][0].toUpperCase()
                            : ''; // Inisial dari last_name
                        String initials =
                            '$firstInitial$lastInitial'; // Menggabungkan inisial
                        return Image.network(
                          "https://ui-avatars.com/api/?name=$initials",
                          fit: BoxFit.cover,
                        );
                      } else {
                        return const Text(
                          "tidak ada data",
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Column(
            children: [
              // menampilkan dan menggabungkan nama, email, phone dari database user dan inisial nama lengakap didalam clip oval
              FutureBuilder(
                future: Future.wait([_firstName, _lastName]),
                builder: (BuildContext context,
                    AsyncSnapshot<List<String>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasData) {
                    List<String> data = snapshot.data!;
                    String fullName = "${data[0]} ${data[1]}";
                    return Text(
                      fullName,
                      style:
                          const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    );
                  } else {
                    return const CircularProgressIndicator(); // atau Widget lain untuk menunjukkan bahwa tidak ada data
                  }
                },
              ),
              const SizedBox(height: 5),
              FutureBuilder(
                future: _email,
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasData) {
                    return Text(snapshot.data!);
                  } else {
                    return const Text("tidak ada data");
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.person),
                title: const Text("Update Profile"),
              ),
              const SizedBox(height: 10),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.vpn_key),
                title: const Text("Update Password"),
              ),
              const SizedBox(height: 10),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const Register()));
                },
                leading: const Icon(Icons.person_add),
                title: const Text("User Registration"),
              ),
              const SizedBox(height: 10),
              ListTile(
                onTap: logout,
                leading: const Icon(Icons.logout),
                title: const Text("Logout"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
