import 'package:flutter/material.dart';

class ListTileDrawer extends StatelessWidget{
  final Widget leadingWidget;
  final String title;
  final void Function()? onTap;
  const ListTileDrawer({super.key, required this.leadingWidget, required this.title, this.onTap});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leadingWidget,
      title: Text(
        title,
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}