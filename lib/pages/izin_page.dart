import 'package:attedance/pages/buatizin_page.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class IzinPage extends StatefulWidget {
  const IzinPage({super.key});

  @override
  State<IzinPage> createState() => _IzinPageState();
}

class _IzinPageState extends State<IzinPage> {
  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQuerywidht = MediaQuery.of(context).size.width;
    final myAppBar = AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Pengajuan Izin",
          style: TextStyle(
            fontSize: 20,
            fontFamily: "Roboto-Bold",
            color: Colors.white,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
        leading: Container(),
      );
      final bodyHeight = mediaQueryHeight - myAppBar.preferredSize.height - MediaQuery.of(context).padding.top;
    
    return Scaffold(
      appBar: myAppBar,
      body: 
      ListView(
        children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                height: bodyHeight * 0.3,
                width: mediaQuerywidht,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 4,
                      offset: Offset(4, 8),
                    ),
                  ]
                ),
                child: const Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                       Column(
                         children: [
                            Icon(Icons.newspaper, size: 60, color: Colors.green,),
                             Text(
                              "Cuti",
                             style: TextStyle(
                             fontSize: 16,
                             letterSpacing: 2,
                            ),
                          ),
                         SizedBox(height: 10,),
                         Text("0")
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.notifications_active_outlined, size: 60, color: Colors.amber,),
                          Text(
                            "Izin",
                            style: TextStyle(
                              fontSize: 16,
                              letterSpacing: 2,
                          ),
                        ),
                          SizedBox(height: 10,),
                          Text("0")
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.medical_services, size: 60, color: Colors.red,),
                          Text(
                            "Sakit",
                            style: TextStyle(
                              fontSize: 16,
                              letterSpacing: 2,
                          ),
                        ),
                          SizedBox(height: 10,),
                          Text("0")
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return const BuatIzinPage();
                    })
                  );
                },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shadowColor: Colors.grey,
                    elevation: 10,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius:BorderRadius.circular(8)
                      )
                    ), child: const Text(
                        "Buat Izin",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Roboto-Bold",
                        color: Colors.white,
                      ),
                    ),
                ),
            ],
          ),
              const SizedBox(height: 30),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Pilih Tipe Izin",
                  style: TextStyle(
                     fontSize: 14,
                     fontWeight: FontWeight.bold
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              DropdownSearch<String>(
                popupProps: const PopupProps.menu(
                  showSelectedItems: true,
                ),
                items: const ["Pilih Izin", "Cuti", "Izin", "Sakit"],
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)
                    ),
                  hintText: "Pilih Izin"
                )),
                onChanged: (String? newValue) {
                  setState(() {
                  });
                },
              ),
              const SizedBox(height: 30),
              Divider(
                color: Colors.grey[300],
                thickness: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Riwayat Izin Karyawan",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  TextButton(onPressed: () {

                  }, child: const Text("See More"))
                ],
              ),
              SizedBox(height: 100,)
            ]
          ),
        ),
        ]
      ),
    );
  }
}