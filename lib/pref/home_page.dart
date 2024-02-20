// import 'dart:convert';

// import 'package:crud_test/edit_data.dart';
// import 'package:crud_test/tambah_data.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List _listdata = [];

//   Future _getdata() async {
//     try {
//       final response =
//           await http.get(Uri.parse("http://192.168.1.9/crudtest/read.php"));
//       if (response.statusCode == 200) {
//         // print(response.body);
//         final data = jsonDecode(response.body);
//         setState(() {
//           _listdata = data;
//         });
//       }
//     } catch (e) {
//       // print(e);
//     }
//   }

//   Future _deletedata(String id) async {
//     try {
//       final response = await http
//           .post(Uri.parse("http://192.168.1.9/crudtest/delete.php"), body: {
//         "nisn": id,
//       });
//       if (response.statusCode == 200) {
//         return true;
//       }
//       return false;
//     } catch (e) {
//       // print(e);
//     }
//   }

//   @override
//   void initState() {
//     _getdata();
//     // print(_listdata);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: Text("Dashboard", style: TextStyle(color: Colors.white, letterSpacing: 2),),
//         centerTitle: true,
//       ),
//       body: ListView.builder(
//           itemCount: _listdata.length,
//           itemBuilder: ((context, index) {
//             return Card(
//               child: InkWell(
//                 onTap: () {
//                   Navigator.of(context)
//                       .push(MaterialPageRoute(builder: (context) {
//                     return EditData(
//                       listData: {
//                         "id": _listdata[index]['id'],
//                         "nisn": _listdata[index]['nisn'],
//                         "nama": _listdata[index]['nama'],
//                         "alamat": _listdata[index]['alamat'],
//                       },
//                     );
//                   }));
//                 },
//                 child: ListTile(
//                   title: Text(_listdata[index]['nama']),
//                   subtitle: Text(_listdata[index]['alamat']),
//                   trailing: IconButton(
//                       onPressed: () {
//                         showDialog(
//                           barrierDismissible: false,
//                             context: context,
//                             builder: (context) {
//                               return AlertDialog(
//                                 content: Text("Hapus Data?"),
//                                 actions: [
//                                   ElevatedButton(
//                                     onPressed: () {
//                                       _deletedata(_listdata[index]['nisn'])
//                                           .then((value) {
//                                         if (value) {
//                                           ScaffoldMessenger.of(context)
//                                               .showSnackBar(SnackBar(
//                                             content:
//                                                 Text('Data Berhasil Dihapus'),
//                                           ));
//                                         } else {
//                                           ScaffoldMessenger.of(context)
//                                               .showSnackBar(SnackBar(
//                                             content: Text('Data Gagal Dihapus'),
//                                           ));
//                                         }
//                                       });
//                                       Navigator.pushAndRemoveUntil(context,
//                                           MaterialPageRoute(builder: (context) {
//                                         return HomePage();
//                                       }), (route) => false);
//                                     },
//                                     child: Text("Hapus"),
//                                   ),
//                                   ElevatedButton(
//                                     onPressed: () {
//                                       Navigator.of(context).pop();
//                                     },
//                                     child: Text("Cancel"),
//                                   ),
//                                 ],
//                               );
//                             });
//                       },
//                       icon: Icon(Icons.delete)),
//                 ),
//               ),
//             );
//           })),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//             return TambahData();
//           }));
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
