import 'package:attedance/auth/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
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
        MaterialPageRoute(builder: (BuildContext context) => AuthPage()),
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
                child: Container(
                  width: 100,
                  height: 100,
                  // hanya untuk menampilkan inisial dari first name dan last name menggunakan iamge network
                  child: FutureBuilder(
                    future: Future.wait([_firstName, _lastName]),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<String>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
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
                    return CircularProgressIndicator();
                  } else if (snapshot.hasData) {
                    List<String> data = snapshot.data!;
                    String fullName = "${data[0]} ${data[1]}";
                    return Text(
                      fullName,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    );
                  } else {
                    return CircularProgressIndicator(); // atau Widget lain untuk menunjukkan bahwa tidak ada data
                  }
                },
              ),
              SizedBox(height: 5),
              FutureBuilder(
                future: _email,
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasData) {
                    return Text(snapshot.data!);
                  } else {
                    return const Text("tidak ada data");
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.person),
                title: Text("Update Profile"),
              ),
              SizedBox(height: 10),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.vpn_key),
                title: Text("Update Password"),
              ),
              SizedBox(height: 10),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.person_add),
                title: Text("User Registration"),
              ),
              SizedBox(height: 10),
              ListTile(
                onTap: logout,
                leading: Icon(Icons.logout),
                title: Text("Logout"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
