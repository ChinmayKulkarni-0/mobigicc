import 'package:flutter/material.dart';

class GridView extends StatefulWidget {
  const GridView({Key? key}) : super(key: key);

  @override
  State<GridView> createState() => _GridViewState();
}

class _GridViewState extends State<GridView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [],
      )),
    );
  }
}
