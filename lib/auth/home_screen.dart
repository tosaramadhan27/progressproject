import 'dart:convert';

import 'package:attedance/auth/absen.dart';
import 'package:attedance/auth/login_page.dart';
import 'package:attedance/models/home_response.dart';
import 'package:attedance/profile/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late final Future<String> _firstName, _token;
  HomeResponseModel? homeResponseModel;
  late Future<HomeResponseModel> futureHomeData;
  Datum? user;
  List<Datum> riwayat = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureHomeData = fetchHomeData();
    _token = _prefs.then((SharedPreferences prefs) {
      return prefs.getString("token") ?? "";
    });

    _firstName = _prefs.then((SharedPreferences prefs) {
      return prefs.getString("firstName") ?? "";
    });
  }

  Future<HomeResponseModel> fetchHomeData() async {
    Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${await _token}',
    'Access-Control-Allow-Origin': '*',
  };
  try {
      final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/absensi_detail'),
      headers: headers);
  
    if (response.statusCode == 200) {
      return homeResponseModelFromJson(response.body);
    } else {
      throw Exception('Failed to load home data');
    }
      
    } catch (e) {
      return Future.error('failed');
    }
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
      MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
      (Route<dynamic> route) => false);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HOME"),
      leading: IconButton(onPressed: logout, icon: Icon(Icons.logout)),
      actions: [
        IconButton(onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (contex)=>UserProfile()));
        }, icon: Icon(Icons.person))
      ],),
      body: FutureBuilder(
          future: futureHomeData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return SafeArea(
                  child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder(
                        future: _firstName,
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else {
                            if (snapshot.hasData) {
                              print(snapshot.data);
                              return Text(snapshot.data!,
                                  style: TextStyle(fontSize: 18));
                            } else {
                              return Text("-", style: TextStyle(fontSize: 18));
                            }
                          }
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 400,
                      decoration: BoxDecoration(color: Colors.blue[800]),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(children: [
                          Text(user?.keterangan ?? '-',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(user?.absenMasuk ?? '-',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 24)),
                                  Text("Masuk",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16))
                                ],
                              ),
                              Column(
                                children: [
                                  Text(user?.absenKeluar ?? '-',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 24)),
                                  Text("Pulang",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16))
                                ],
                              )
                            ],
                          )
                        ]),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text("Riwayat Absensi"),
                    Expanded(
                      child: ListView.builder(
                        itemCount: riwayat.length,
                        itemBuilder: (context, index) => Card(
                          child: ListTile(
                            leading: Text(riwayat[index].keterangan),
                            title: Row(children: [
                              Column(
                                children: [
                                  Text(riwayat[index].absenMasuk,
                                      style: TextStyle(fontSize: 18)),
                                  Text("Masuk", style: TextStyle(fontSize: 14))
                                ],
                              ),
                              SizedBox(width: 20),
                              Column(
                                children: [
                                  Text(riwayat[index].absenKeluar,
                                      style: TextStyle(fontSize: 18)),
                                  Text("Pulang", style: TextStyle(fontSize: 14))
                                ],
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AbsenPage()))
              .then((value) {
            setState(() {});
          });
        },
        child: Icon(Icons.add),
      ),

    );
  }
}