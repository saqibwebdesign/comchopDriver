import 'package:geolocator/geolocator.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class uservendoes_location extends StatefulWidget {
  final orderid;
  final userlng;
  final customer_lat;
  final customer_lng;
  final vendor_lat;
  final vendor_lng;
  const uservendoes_location({
    Key? key,
    this.orderid,
    this.userlng,
    this.customer_lat,
    this.customer_lng,
    this.vendor_lat,
    this.vendor_lng,
  }) : super(key: key);

  @override
  State<uservendoes_location> createState() => _uservendoes_locationState();
}

class _uservendoes_locationState extends State<uservendoes_location> {
  GoogleMapController? mapController; //contrller for Google map
  Set<Marker> markers = Set(); //markers for google map
  late LatLng _initialPosition;

  @override
  void initState() {
    addMarkers();
    _getUserLocation();
    super.initState();
  }

  void _getUserLocation() async {
    var position = await GeolocatorPlatform.instance.getCurrentPosition(
        locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.bestForNavigation));

    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
    });
  }

  addMarkers() async {
    LatLng endLocation = LatLng(
        double.parse(widget.customer_lat), double.parse(widget.customer_lng));
    LatLng startLocation = LatLng(
        double.parse(widget.vendor_lat), double.parse(widget.vendor_lng));
    BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "images/resturent.png",
    );
    BitmapDescriptor markerbitmaps = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "images/user.png",
    );
    // setState(() {

    markers.add(Marker(
      //add start location marker
      markerId: MarkerId(startLocation.toString()),
      position: LatLng(
        double.parse(
          widget.vendor_lat,
        ),
        double.parse(
          widget.vendor_lng,
        ),
      ), //position of marker
      infoWindow: InfoWindow(
        //popup info
        title: 'Resturant',
        snippet: 'Start Marker',
      ),
      icon: markerbitmap, //Icon for Marker
    ));
    markers.add(
      Marker(
        //add start location marker
        markerId: MarkerId(endLocation.toString()),
        position: LatLng(double.parse(widget.customer_lat),
            double.parse(widget.customer_lng)), //position of marker
        rotation: -45,
        infoWindow: InfoWindow(
          //popup info
          title: 'Customer',
          snippet: 'End Marker',
        ),
        icon: markerbitmaps, //Icon for Marker
      ),
      //  );
      //   }
    );
  }

  @override
  Widget build(BuildContext context) {
    LatLng carLocation = LatLng(
      double.parse(
        widget.vendor_lat,
      ),
      double.parse(
        widget.vendor_lng,
      ),
    );
    return Scaffold(
        body: GoogleMap(
      myLocationEnabled: true,
      //Map widget from google_maps_flutter package
      zoomGesturesEnabled: true, //enable Zoom in, out on map
      initialCameraPosition: CameraPosition(
        //innital position in map
        target: carLocation, //initial position
        zoom: 14.0, //initial zoom level
      ),
      markers: markers,
      buildingsEnabled: false,
      mapType: MapType.normal,
      onMapCreated: (controller) {
        setState(() {
          mapController = controller;
        });
      },
    ));
  }
}
