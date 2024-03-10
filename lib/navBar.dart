import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  @override
  State<NavBar> createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.menu))]),
    );
  }
}
