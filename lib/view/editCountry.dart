import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api/customisation/textfield.dart';
import 'package:flutter_api/view/show_countries.dart';
import 'package:flutter_api/view/country.dart';
import 'package:http/http.dart' as http;

class EditCountry extends StatefulWidget {
  final Country? country;
  const EditCountry({Key? key, this.country});

  @override
  _EditCountryState createState() => _EditCountryState();
}

class _EditCountryState extends State<EditCountry> {
  void editCountry(
    {String? name, String? code, String? timezone, String? uuid}) async {
      await http.put(
        Uri.parse(
          "http://localhost:8092/api/countries/${widget.country!.uuid}",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
        },
        body: jsonEncode(<String, String?>{
          'name': name,
          'code': code,
          'timezone': timezone,
        }));
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => const DisplayCountry()),
            (Route<dynamic> route) => false);
    
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController(text: widget.country!.name);
    TextEditingController codeController = TextEditingController(text: widget.country!.code);
    TextEditingController timezoneController = TextEditingController(text: widget.country!.timezone);
    TextEditingController uuidController = TextEditingController(text: widget.country!.uuid);


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[700],
        elevation: 0.0,
        title: const Text('Edit Country'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 100, bottom: 100, left: 18, right: 18),
          child: Container(
            height: 550,
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.indigo[700],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 300,
                    decoration: const BoxDecoration(boxShadow: [
                      
                    ]),
                    child: Textfield(
                      controller: nameController,
                      onChanged: (val) {
                        nameController.text = val;
                      },
                      hintText: 'Name',
                    )),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    width: 300,
                    decoration: const BoxDecoration(boxShadow: []),
                    child: Textfield(
                      controller: codeController,
                      onChanged: (val) {
                        codeController.text = val;
                      },
                      hintText: 'Code',
                    )),
                Container(
                    width: 300,
                    decoration: const BoxDecoration(boxShadow: []),
                    child: Textfield(
                      hintText: 'Timezone',
                      controller: timezoneController,
                      onChanged: (val) {
                        timezoneController.text = val;
                      },
                      
                    )),
                SizedBox(
                  width: 100,
                  child: TextButton(
                      style:
                          TextButton.styleFrom(backgroundColor: Colors.white),
                      onPressed: () {
                        editCountry(
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
