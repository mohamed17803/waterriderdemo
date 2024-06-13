import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:math' as math;
import 'cubit/location_cubit.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key,this.determineToMap = false});
  final bool determineToMap;
  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  var myMarkers = HashSet<Marker>();
  List<Marker> markers = [];
  GoogleMapController? mapController;
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  static CameraPosition? _currentLocation;
  BitmapDescriptor? myLocationIcon;
  static double currentZoom = 17.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LocationCubit locationCubit = BlocProvider.of<LocationCubit>(context);
    _currentLocation ??=  CameraPosition(target:  LatLng(locationCubit.position!.latitude, locationCubit.position!.longitude), zoom: currentZoom);
    _controller.future.then((value) {
      mapController = value;
      onTapMap(_currentLocation!.target);
    });
    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(600, 600)), 'images/user_marker.png',)
        .then((onValue) {
      myLocationIcon = onValue;
    });
  }
  @override
  Widget build(BuildContext context) {
    LocationCubit locationCubit = BlocProvider.of<LocationCubit>(context);
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:  CameraPosition(
              target: LatLng(locationCubit.position!.latitude , locationCubit.position!.longitude),
              zoom: currentZoom,
            ),
            markers: Set.from(markers),
            trafficEnabled: false,
            tiltGesturesEnabled: false,
            zoomControlsEnabled: false,

            onTap: (lat) => changeMarkerByTapping(lat),
            onCameraMove: (c) {
              currentZoom = c.zoom;
            },
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
              markers.add(
                Marker(
                  icon: myLocationIcon!,
                  markerId: const MarkerId('1'),
                  position: LatLng(locationCubit.position!.latitude , locationCubit.position!.longitude),
                  infoWindow: InfoWindow(
                      title: "",
                      snippet: '',
                      onTap: () {
                        //debugPrint('my tap');
                      }),
                ),
              );
              setState(() {
                controller.setMapStyle('''
        [
  {
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#f5f5f5"
          }
        ]
  },
  {
        "elementType": "labels.icon",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
  },
  {
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#616161"
          }
        ]
  },
  {
        "elementType": "labels.text.stroke",
        "stylers": [
          {
            "color": "#f5f5f5"
          }
        ]
  },
  {
        "featureType": "administrative.land_parcel",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#bdbdbd"
          }
        ]
  },
  {
        "featureType": "poi",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#eeeeee"
          }
        ]
  },
  {
        "featureType": "poi",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#757575"
          }
        ]
  },
  {
        "featureType": "poi.park",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#e5e5e5"
          }
        ]
  },
  {
        "featureType": "poi.park",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#9e9e9e"
          }
        ]
  },
  {
        "featureType": "road",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#ffffff"
          }
        ]
  },
  {
        "featureType": "road.arterial",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#757575"
          }
        ]
  },
  {
        "featureType": "road.highway",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#dadada"
          }
        ]
  },
  {
        "featureType": "road.highway",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#616161"
          }
        ]
  },
  {
        "featureType": "road.local",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#9e9e9e"
          }
        ]
  },
  {
        "featureType": "transit.line",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#e5e5e5"
          }
        ]
  },
  {
        "featureType": "transit.station",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#eeeeee"
          }
        ]
  },
  {
        "featureType": "water",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#c9c9c9"
          }
        ]
  },
  {
        "featureType": "water",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#9e9e9e"
          }
        ]
  }
]
        ''');
                ///  my Location
              });

            },
            // zoomControlsEnabled: true,
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 25),
            child: Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () => Navigator.pop(context) ,
                child: Container(
                    width: 40,height: 40,
                    margin: EdgeInsets.symmetric(vertical: 50),
                    decoration:  BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(.2)
                    ),
                    child: const Icon(Icons.arrow_forward_ios,color: Colors.black,)),
              ),
            ),
          ),

        ],
      ),

    );

  }
// Scrum 93
  changeMarkerByTapping(LatLng latLng,) async
  {
    Map <String,double> locationData = Map();
    locationData["latitude"]= latLng.latitude;
    locationData["longitude"]= latLng.longitude;
    debugPrint("xxxxxxxxxxxxxx");

    LocationData locationDataValue =  LocationData.fromMap(locationData);
    LocationCubit locationCubit = BlocProvider.of<LocationCubit>(context);
    await changeMarkerPosition(latLng);


    setState(() {});
    mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: latLng,
          zoom: currentZoom,
        ),
      ),
    );
  }

  changeMarkerPosition(LatLng latLng) async
  {
    markers = [];
    markers.add(
      Marker(
        //location Detected
        icon: myLocationIcon!,
        markerId: const MarkerId('1'),
        position: LatLng(latLng.latitude , latLng.longitude),
        infoWindow: InfoWindow(
            title: "",
            snippet: '',
            onTap: () {
              //debugPrint('my tap');
            }),
      ),
    );
    setState(() {

    });
  }

  void onTapMap(LatLng latLng) async {
    Marker marker = Marker(
      markerId: MarkerId(latLng.toString()),
      position: latLng,
    );
    changeMarkerByTapping(latLng);
    if (markers.isEmpty) markers.add(marker);
    if (markers.isNotEmpty) markers[0] = marker;
    // location = place?.description.toString()??"nolocationinformation".tr();
    setState(() {});
  }





}
