import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';



part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());
  Position? position;
  List<Position>? positionAddRecipient = [];
  var location = Location();





  Future<bool?> getGeoLocation(BuildContext context,{bool determineToMap = false}) async {
    print("from get locatopn here");
    Location location =  Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    if(Platform.isAndroid){
       serviceEnabled = await location.serviceEnabled();
       if (!serviceEnabled) {
         serviceEnabled = await location.requestService();
         if (!serviceEnabled) {
            //await _onWillPop(context);
            return false;
         }
       }

       permissionGranted = await location.hasPermission();
       if (permissionGranted == PermissionStatus.denied) {
         permissionGranted = await location.requestPermission();
         if (permissionGranted != PermissionStatus.granted) {
          // await _onWillPop(context);
           return false;
         }
       }
       print("_permissionGranted.index");
       print(permissionGranted.index);
       if(permissionGranted.index == 0){
         position =  await Geolocator.getCurrentPosition();
         // if(determineToMap == false){
         //   determineTheLoadingPointLongitudeController.text = position!.longitude.toString();
         //   determineTheLoadingPointLatitudeController.text = position!.latitude.toString();
         // }else{
         //   determineTheReceivingPointToLongitudeController.text = position!.longitude.toString();
         //   determineTheReceivingPointToLatitudeController.text = position!.latitude.toString();
         // }
       }
       //position =  await Geolocator.getCurrentPosition();
     }
    else{
      final accuracyStatus = await Geolocator.getLocationAccuracy();
      switch(accuracyStatus) {
        case LocationAccuracyStatus.reduced:
          //await _onWillPop(context);
         bool openLocation =  await Geolocator.openLocationSettings();
         exit(0);
          return false;
        // Precise location switch is OFF.
          break;
        case LocationAccuracyStatus.precise:
          serviceEnabled = await location.serviceEnabled();
          if (!serviceEnabled) {
            serviceEnabled = await location.requestService();
            if (!serviceEnabled) {
             // await _onWillPop(context);
              return false;
            }
          }

          permissionGranted = await location.hasPermission();
          if (permissionGranted == PermissionStatus.denied) {
            permissionGranted = await location.requestPermission();
            if (permissionGranted != PermissionStatus.granted) {
             // await _onWillPop(context);
              return false;
            }
          }
          print("_permissionGranted.index");
          print(permissionGranted.index);
          if(permissionGranted.index == 0){
            position =  await Geolocator.getCurrentPosition();

          }
          break;
        case LocationAccuracyStatus.unknown:
        // The platform doesn't support this feature, for example an Android device.
          break;
      }
    }

  //  codedAddress = await Geocoder.local.findAddressesFromCoordinates(Coordinates(position!.latitude, position!.longitude));
    return true;
  }

  /// assign determine from map


  /// assign determine to map




}
