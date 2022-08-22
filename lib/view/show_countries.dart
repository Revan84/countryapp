import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api/view/add_country.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_api/view/country.dart';
import 'package:flutter_api/view/countryDetails.dart';

class DisplayCountry extends StatefulWidget {
  const DisplayCountry({Key? key}) : super(key: key);

  @override
  _DisplayCountryState createState() => _DisplayCountryState();
}

class _DisplayCountryState extends State<DisplayCountry> {
  List<Country> country = [];
  Future<List<Country>> getAll() async {
    var response = await http.get(Uri.parse("http://localhost:8092/api/countries"));
  
    if(response.statusCode==200){
      country.clear();
    }
    var decodedData = jsonDecode(response.body);

    for (var u in decodedData) {
      country.add(Country(u['name'], u['code'], u['timezone'], u['uuid']));
    }
    return country;
  }

  @override
  Widget build(BuildContext context) {
    getAll();
    
    return Scaffold(
        appBar: AppBar(
          title: const Text('Affichage Country'),
          automaticallyImplyLeading: true,
          elevation: 0.0,
          backgroundColor: Colors.indigo[700],
          leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed:() => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateCountry())),
  ), 
        ),
        body: FutureBuilder(
            future: getAll(),
            builder: (context, AsyncSnapshot<List<Country>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, index) => 
                  InkWell(
                    child: ListTile(
                      title: Text(snapshot.data![index].name),
                      subtitle: Text(snapshot.data![index].code),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>MyDetails(country: snapshot.data![index],)));
                      },
                    ),
                  )
                );
              }
            ));
  }
}
