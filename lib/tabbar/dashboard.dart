import 'dart:async';
import 'package:comchopdriver/details/available_deliveries.dart';
import 'package:comchopdriver/http_services/htt_services.dart';
import 'package:comchopdriver/http_services/location_services.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class dashboard extends StatefulWidget {
  dashboard({Key? key}) : super(key: key);

  @override
  _dashboardState createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  bool isSwitchedFT = false;
  LatLng startLocation = LatLng(33.720001, 73.059998);
  GoogleMapController? mapController; //contrller for Google map
  late Position position;
  var switch_value = false;
  var status;
  final status_store = GetStorage();
  void getLocation() async {
    Position res = await Geolocator.getCurrentPosition();
    setState(() {
      position = res;
    });
  }

  @override
  void initState() {
    location_data().currentlocation();
    // LocationData currentLocation;
    // var latitude = currentLocation.longitude as;
    // var  longtitude = currentLocation.latitude;
    getLocation();
    super.initState();

    if (status_store.read('switch_value') != null) {
      setState(() {
        switch_value = status_store.read('switch_value');
      });
    }
  }

  bool switchControl = false;
  Future<void> toggleSwitch(bool value) async {
    if (switch_value == false) {
      setState(() {
        switchControl = true;
        status = 1;
        http_service().driverworkstatus(status);
      });
      setState(() {
        switch_value = value;
        status_store.write('switch_value', switch_value);
      });
    } else {
      setState(() {
        switch_value = false;
        status_store.write('switch_value', switch_value);
        status = 0;
        http_service().driverworkstatus(status);
      });
    }
  }

  Future<bool> getSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isSwitchedFT = prefs.getBool("switchState") ?? false;
    print(isSwitchedFT);

    return isSwitchedFT;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        GoogleMap(
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          //Map widget from google_maps_flutter package
          zoomGesturesEnabled: true, //enable Zoom in, out on map
          initialCameraPosition: CameraPosition(
            //innital position in map
            target: startLocation, //initial position
            zoom: 14.0, //initial zoom level
          ),

          mapType: MapType.normal,
          onMapCreated: (controller) {
            setState(() {
              mapController = controller;
            });
          },
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 28.0,
              left: 8.0,
              right: 8.0,
            ),
            child: Container(
                padding: EdgeInsets.all(10),
                height: 50.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      switch_value ? 'You are Online' : 'You are Ofline',
                      style: TextStyle(fontSize: 15),
                    ),
                    Switch(
                      onChanged: toggleSwitch,
                      value: switch_value,
                      activeColor: Color.fromRGBO(252, 186, 24, 1),
                      activeTrackColor: Colors.grey[400],
                      inactiveThumbColor: Colors.grey[200],
                      inactiveTrackColor: Colors.grey,
                    ),
                  ],
                )),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: RaisedButton(
              onPressed: () {},
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ' You’re Online Available Delivery',
                    style: TextStyle(fontSize: 15),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  avilable_delievries()),
                        );
                      },
                      icon: Icon(Icons.arrow_forward_outlined))
                ],
              ),
              color: Colors.white,
              textColor: Colors.black,
              elevation: 5,
            ),
          ),
        ),
      ],
    ));
  }
}
