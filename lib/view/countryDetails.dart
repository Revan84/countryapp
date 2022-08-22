
import 'package:flutter/material.dart';
import 'package:flutter_api/view/editCountry.dart';
import 'package:flutter_api/view/show_countries.dart';
import 'package:flutter_api/view/country.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_api/config/palette.dart'; 

class MyDetails extends StatefulWidget {
  final  Country? country;
  const MyDetails({ Key? key, this.country}) ;
  

  @override
  _MyDetailsState createState() => _MyDetailsState();
}
 
class _MyDetailsState extends State<MyDetails> {
  @override
  Widget build(BuildContext context) {
    void deleteCountry() async{
      await http.delete(Uri.parse("http://localhost:8092/api/countries/${widget.country!.uuid}"));
       Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => const DisplayCountry()),
          (Route<dynamic> route) => false);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails'),
        elevation: 0.0,
        backgroundColor: Palette.kToDark,
      ),
      body: Center(
        child: Padding(
          padding:  const EdgeInsets.symmetric(horizontal: 18,vertical:32),
          child: Column(
            children: [
              Container(
                height:50,
                width: MediaQuery.of(context).size.width,
                color: Palette.kToDark,
                child: const Center(child: Text('Fiche',style: TextStyle(color: Color(0xffFFFFFF)),)),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Text(widget.country!.name),
                      const SizedBox(height: 10,),
                      Text(widget.country!.code),
                      const SizedBox(height: 10,),
                      Text(widget.country!.timezone),
                      
                    ],
                  ),
                ),
                // height: 455 ,
                width:  MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                   color: Color(0xffFFFFFF),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0,1),

                    ),
                  ]
                ),
                
              ),
              Row(
                children:[
                  TextButton(
                    onPressed: (){
                         Navigator.push(context, MaterialPageRoute(builder: (_)=>EditCountry(country: widget.country,)));
                     
                    }, child:const Text('Edit'),
                  ),
                  TextButton(
                    onPressed:(){
                      deleteCountry();

                    }, child:const Text('Delete'),
                  ),
                ]
              )
            ],
          ),
        ),
      ),
    );
  }
}