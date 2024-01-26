// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

class CameraWithMap extends StatefulWidget {
  const CameraWithMap({super.key});

  @override
  State<CameraWithMap> createState() => _CameraWithMapState();
}

class _CameraWithMapState extends State<CameraWithMap> {
File? imageFile;

GoogleMapController? _controller;
  Location currentLocation = Location();
  final Set<Marker> _markers={};
 
 
  void getLocation() async{
    var location = await currentLocation.getLocation();
    currentLocation.onLocationChanged.listen((LocationData loc){
 
      _controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(loc.latitude ?? 0.0,loc.longitude?? 0.0),
        zoom: 20,
      )));
      setState(() {
        _markers.add(Marker(markerId: const MarkerId('Home'),
            position: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0)
        ));
      });
       });
  }
 
  @override
  void initState(){
    super.initState();
    setState(() {
      getLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Ambil Absensi",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            letterSpacing: 1,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    if(imageFile != null)
                    CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      radius: 160,
                      backgroundImage: FileImage(imageFile!),
                    ) else
                    CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      radius: 160,
                      child: Text("take a photo"),
                    ),
                  ],
                ),
              ), 
              
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                    Container(
                     padding: const EdgeInsets.all(8.0),
                     child: ElevatedButton.icon(
                      icon: Icon(Icons.photo_camera_rounded, color: Colors.white,),
                      onPressed: () {
                      getImage(source: ImageSource.camera);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shadowColor: Colors.grey,
                        elevation: 10,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                         )
                        ), label: Text("Take Snapshot",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                      ), 
                    ),  
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      width: 320,
                      height: 500,
                      color: Colors.grey[100],
                      child:GoogleMap(
                        zoomControlsEnabled: false,
                        initialCameraPosition:const CameraPosition(
                          target: LatLng(48.8561, 2.2930),
                          zoom: 12.0,
                        ),
                        onMapCreated: (GoogleMapController controller){
                          _controller = controller;
                        },
                        markers: _markers,
                      ) ,
                    ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(20),
              child: TextField(
                maxLines: null,
                decoration: InputDecoration(
                  fillColor: Colors.grey,
                  hintText: "Notes",
                  labelText: "Keterangan",
                  border: OutlineInputBorder(
                  borderSide: BorderSide(),
               ),
              ),
            ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    ElevatedButton.icon(
                      icon: Icon(Icons.comment, color: Colors.white54),
                     onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shadowColor: Colors.grey,
                      elevation: 10,
                       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(8)
                       )
                     ), label: Text("Absen Masuk",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ), 
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        ElevatedButton.icon(
                          icon: Icon(Icons.outbond, color: Colors.white54),
                         onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shadowColor: Colors.grey,
                          elevation: 10,
                           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(8)
                           )
                         ), label: Text("Absen Keluar",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ), 
                      ],
                    ),
                  ],
                ),
              ],
            ),

        ],
      ),
    );
  }   
  void getImage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(source: source);

    if(file?.path != null) {
      setState(() {
        imageFile = File(file!.path);
      });
    }
  }  
}