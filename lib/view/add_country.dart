import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api/customisation/textfield.dart';
import 'package:flutter_api/view/show_countries.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_api/view/country.dart';
import 'package:flutter_api/config/palette.dart'; 


class CreateCountry extends StatefulWidget {
  final int? uuid;
  const CreateCountry({ Key? key,this.uuid});

  @override
  _CreateCountryState createState() => _CreateCountryState();
}
  TextEditingController nameController = TextEditingController(text: country.name);
  TextEditingController codeController = TextEditingController(text: country.code);
  TextEditingController timezoneController = TextEditingController(text: country.timezone);
  TextEditingController uuidController = TextEditingController(text: country.uuid);

  Country country = Country('', '', '', '');

class _CreateCountryState extends State<CreateCountry> {
  void save(
    {String? name, String? code, String? timezone, String? uuid}) async {
    // var jsonResponse = null;
    await http.post(Uri.parse("http://localhost:8092/api/countries",)
    ,headers:<String, String> {
      'Content-Type': 'application/json; charset=UTF-8',
    },body: jsonEncode(<String,String?> {  
      'name': name,
      'code': code,
      'timezone': timezone,
      }),
    );
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => const DisplayCountry()), (Route<dynamic> route) => false);
  }
  
   
  @override
  Widget build(BuildContext context) {
    //  print(widget.id);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.kToDark,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: const Text('Create Country'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  const EdgeInsets.only(top: 100,bottom: 100,left: 18,right: 18),
          child: Container(
            height: 550,
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
               color: Palette.kToDark,
            ),
           
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               Container(
                 width: 300,
                 decoration: const BoxDecoration(boxShadow: [
                        ]),
                 child: Textfield(
                   controller:nameController ,
                   onChanged: (val){
                     country.name = val;
                   },
                   hintText: 'Name',
                 )
                 ),
                 const SizedBox(height: 10,),
                 Container(
                     width: 300,
                 decoration: const BoxDecoration(boxShadow: [
                        ]),
                 child: Textfield(
                   controller: codeController,
                   onChanged: (val) {
                     country.code = val;
                   },
                   hintText: 'Code',
                 )
                 ),
                   Container(
                     width: 300,
                 decoration: const BoxDecoration(boxShadow: [
                        ]),
                 child: Textfield(
                   hintText: 'Timezone',
                   onChanged: (val){
                     timezoneController.text = val;
                   },
                   controller: timezoneController,
                 )
                 ),
                 SizedBox(
                   width: 100,
                   child: TextButton(
                     style: TextButton.styleFrom(backgroundColor: Colors.white),
                     onPressed: () {
                        save(
                            name: nameController.text,
                            code: codeController.text,
                            timezone: timezoneController.text,
                            uuid: uuidController.text);
                      },
                     child: const Text('Enregistrer')),
                 )
              ],
            ),
          ),
        ),
      ),
    );
    
  }
  
}

 