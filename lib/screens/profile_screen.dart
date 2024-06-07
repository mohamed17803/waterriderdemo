import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:waterriderdemo/core/navigation_constants.dart';
import 'package:waterriderdemo/screens/passenger_screen.dart';

// SignUpScreen is a stateful widget
class ProfileScreen extends StatefulWidget {
  final VoidCallback? onSignUpComplete; // Callback function when sign up is complete

  const ProfileScreen({super.key, this.onSignUpComplete});

  @override
  ProfileScreenState createState() => ProfileScreenState(); // Creates the state for this widget
}

class ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  String gender = '';

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getProfileData();
    super.initState();
  }

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Map<String, dynamic> profileData = {};
  getProfileData() async {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    await fireStore.collection('users').where('emailAddress' , isEqualTo: FirebaseAuth.instance.currentUser?.email).get().then((value) {
      if (profileData == {}) {
        profileData = value.docs[0].data();
      } else {
        profileData = {};
        profileData = value.docs[0].data();
      }
      setState(() {
        emailController.text = profileData['emailAddress'] ?? "";
        passwordController.text = profileData['password'] ?? "";
        phoneController.text = profileData['phone'] ?? "";
        dateController.text = profileData['birthday'] ?? "";
        gender = profileData['gender'] ?? "Male";
      });
      print("alaa = ${profileData['emailAddress']}");
    }).catchError((error) {});
    return profileData;
  }

  updateProfile({emailAddress, password, phone, genderType, birthday}){
    FirebaseAuth.instance.currentUser?.updatePassword(password).then((value){
      users.doc(FirebaseAuth.instance.currentUser?.uid).set({
        'emailAddress': emailAddress,
        'password': password,
        'phone': phone,
        'gender': genderType,
        'birthday': birthday,
      }).then((value){
        setState(() {
          navigateTo(context, const PassengerScreen());
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00B4DA),
      appBar: AppBar(
        title: const Text('My profile', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: profileData.isNotEmpty ? SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 20,),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  value: gender,
                  onChanged: (String? newValue) {
                    gender = newValue!;
                    print("gender = $gender");
                  },
                  items: <String>['Male', 'Female'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your gender';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  controller: dateController,
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.parse ('2100-10-20')
                    ).then((value){
                      dateController.text = DateFormat.yMMMd().format(value!);
                    });
                  },
                  validator: (value) {
                    if (dateController.text.isEmpty) {
                      return 'Please select your date of birth';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 50),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: MediaQuery.of(context).size.width * .8,
                    height: 48,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        if(_formKey.currentState!.validate() && gender != ""){
                          updateProfile(
                              emailAddress: emailController.text,
                              password: passwordController.text,
                              phone: phoneController.text,
                              birthday: dateController.text,
                              genderType: gender
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blue.withOpacity(.9)
                      ),
                      child: const Text('Update', style: TextStyle(
                          fontSize: 16
                      ),),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ) : const Center(child: CircularProgressIndicator(),),
    );
  }
}
