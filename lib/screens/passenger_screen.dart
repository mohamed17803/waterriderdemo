import 'package:flutter/material.dart';
import 'package:waterriderdemo/core/navigation_constants.dart';
import 'package:waterriderdemo/screens/pre_home_screen.dart';
import 'package:waterriderdemo/screens/profile_screen.dart';
import '../core/widgets/card_trip_widget.dart';
import '../core/widgets/listTile_drawer.dart';
import 'google_map_screen.dart';

class PassengerScreen extends StatefulWidget {
  const PassengerScreen({super.key});
  @override
  State<PassengerScreen> createState() => _PassengerScreenState();
}

class _PassengerScreenState extends State<PassengerScreen> {
  var scaffoldKey = GlobalKey <ScaffoldState> ();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFF00B4DA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('My Trips',
          style: TextStyle(
            color: Colors.white
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white,),
          onPressed: (){
            scaffoldKey.currentState?.openDrawer ();
          },
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            const SizedBox(height: 40),
            ListTileDrawer(title: "Home", leadingWidget: const Icon(Icons.home_filled), onTap: (){
              scaffoldKey.currentState?.closeDrawer();
              navigateTo(context, const PreHomeScreen());
            },),
            ListTileDrawer(title: "Profile", leadingWidget: const Icon(Icons.person), onTap: (){
              scaffoldKey.currentState?.closeDrawer();
              navigateTo(context, const ProfileScreen());
            },),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => CardTripWidget(
                  tripDataModel: myTrips[index],
                ),
                separatorBuilder: (context, index) => const SizedBox(height: 12,),
                itemCount: myTrips.length
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(vertical: 12),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: MediaQuery.of(context).size.width * .7,
                  height: 48,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      navigateTo(context, const GoogleMapScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    child: const Text('My location', style: TextStyle(fontSize: 16),),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//  trips
List <TripDataModel> myTrips= [
  TripDataModel(
    location: "cairo",
    destination: "Giza",
    price: "200.0 EGP",
    establishTime: "10:00 pm",
    arrivalTime: "11:00 pm",
    riderName: "Mohamed",
    riderPhone: "01025588798"
  ),
  TripDataModel(
      location: "cairo",
      destination: "Giza",
      price: "200.0 EGP",
      establishTime: "10:00 pm",
      arrivalTime: "11:00 pm",
      riderName: "Mohamed",
      riderPhone: "01025588798"
  ),
  TripDataModel(
      location: "cairo",
      destination: "Giza",
      price: "200.0 EGP",
      establishTime: "10:00 pm",
      arrivalTime: "11:00 pm",
      riderName: "Mohamed",
      riderPhone: "01025588798"
  ),
  TripDataModel(
      location: "cairo",
      destination: "Giza",
      price: "200.0 EGP",
      establishTime: "10:00 pm",
      arrivalTime: "11:00 pm",
      riderName: "Mohamed",
      riderPhone: "01025588798"
  ),
  TripDataModel(
      location: "cairo",
      destination: "Giza",
      price: "200.0 EGP",
      establishTime: "10:00 pm",
      arrivalTime: "11:00 pm",
      riderName: "Mohamed",
      riderPhone: "01025588798"
  ),
  TripDataModel(
      location: "cairo",
      destination: "Giza",
      price: "200.0 EGP",
      establishTime: "10:00 pm",
      arrivalTime: "11:00 pm",
      riderName: "Mohamed",
      riderPhone: "01025588798"
  ),
  TripDataModel(
      location: "cairo",
      destination: "Giza",
      price: "200.0 EGP",
      establishTime: "10:00 pm",
      arrivalTime: "11:00 pm",
      riderName: "Mohamed",
      riderPhone: "01025588798"
  ),
  TripDataModel(
      location: "cairo",
      destination: "Giza",
      price: "200.0 EGP",
      establishTime: "10:00 pm",
      arrivalTime: "11:00 pm",
      riderName: "Mohamed",
      riderPhone: "01025588798"
  ),
];



