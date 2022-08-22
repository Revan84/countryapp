import 'package:flutter/material.dart';
import 'view/add_country.dart';
import 'config/palette.dart'; 

void main() {
  runApp(const Strapi());
}

class Strapi extends StatelessWidget {
  const Strapi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recolt Admin',
      theme: ThemeData(
        primarySwatch: Palette.kToDark,
      ),
      home:const CreateCountry()
    );
  }
}
