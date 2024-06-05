import 'package:flutter/material.dart';

navigateAndRemove(BuildContext context, Widget screen){
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => screen), (route) => false);
}

navigateAndReplace(BuildContext context, Widget screen){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => screen));
}

navigateTo(BuildContext context, Widget screen){
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}

