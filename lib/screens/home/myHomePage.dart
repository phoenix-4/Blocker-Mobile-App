import 'package:blocker_v1/model/owner.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String result ="Blocker";
  String result2 ="";
  String result3="";
  String hashStr = "";
  String vehicleType="";
  String colour ="";
  String country="";
  String regNo="";
  String manYr="";
  String manDes ="";
  String engNo="";
  String chasissNo="";
  String cylinderCap ="";

  Owner currentOwner = new Owner("","","");
  Owner preOwner1 = new Owner("", "", "");
  Owner preOwner2 = new Owner("", "", "");

  Future scanQR() async{
    print("dgfhgfffffffffffffffffff");
      try{
        
        String qrResult = await BarcodeScanner.scan();
        setState(() {
          result = qrResult;
           hashStr = qrResult;
        });
         if(hashStr.isNotEmpty){
          
          preOwner1.own_nic="";
          preOwner1.own_address="";
          preOwner1.own_name="";
          result="";
          result2="";
          result3="";
          vehicleType="";
          colour="";
          country="";
          regNo="";
          manDes="";
          manYr="";
          engNo="";
          chasissNo="";
          cylinderCap=""; 
          currentOwner.own_name="";
          currentOwner.own_address="";
          currentOwner.own_nic="";

          final databaseReference = Firestore.instance;
          // DocumentSnapshot userDocument= await databaseReference.collection('registeredVehicles').document('338d0377685c1b0fd043874beaac827f').get();

         databaseReference
            .collection('vehicles')
            .where("hash" , isEqualTo: hashStr)
            .limit(1)
            .snapshots().listen(
          (data) => 
              

              setState(() {
               
                print("1111111111111111111"+  data.documents.toString());

                if(data.documents.toString().trim().length !=2){
                result = "Vehicle Information";
                result2 = "Information Of Current Owner ";
                result3 ="Information Of Previous Owners";
                vehicleType = "Vehicle Type : " +data.documents[0]["classOfVehicle"];
                colour = "Colour : " + data.documents[0]["colour"];
                country = "Country of Origin : " + data.documents[0]["countryOfOrigin"];
                regNo = "Registered No : " + data.documents[0]["registrationNo"];
                manYr = "Manufactured Year : "  + data.documents[0]["yearOfManufacture"];
                manDes = "Manufactured Description : " + data.documents[0]["make"];
                engNo = "Engine Number : " + data.documents[0]["engineNo"];
                chasissNo = "Chassis Number : " +data.documents[0]["chassisNo"]; 
                cylinderCap = "Cylinder Capacity : " + data.documents[0]["cylinderCapacity"].toString();

                currentOwner.own_nic = "NIC: " + data.documents[0]["currentOwner"]["nic"];
                currentOwner.own_address = "Address: "+ data.documents[0]["currentOwner"]["address"];
                currentOwner.own_name = "Full Name : " +  data.documents[0]["currentOwner"]["owner"];

              
                 if(data.documents[0]["previousOwners"].toString().trim().length == 2){
                   print("3333333333333333333333"+data.documents[0]["previousOwners"].toString());
                    preOwner1.own_name = "No Previous Owners";
                   preOwner1.own_nic = "";
                   preOwner1.own_address = "";
                }else{
                    preOwner1.own_name = "Full Name " + data.documents[0]["previousOwners"][1]["owner"];
                   preOwner1.own_nic = "NIC: " + data.documents[0]["previousOwners"][1]["nic"];
                  preOwner1.own_address = "Address: "+ data.documents[0]["previousOwners"][1]["address"];
                  print("22222222222222222222222222"+data.documents[0]["previousOwners"].toString());
                }
                }else {
                   preOwner1.own_nic="";
                    preOwner1.own_address="";
                    preOwner1.own_name="";
                    result="Vehicle Not Registered";
                    result2="";
                    result3="";
                    vehicleType="";
                    colour="";
                    country="";
                    regNo="";
                    manDes="";
                    manYr="";
                    engNo="";
                    chasissNo="";
                    cylinderCap=""; 
                    currentOwner.own_name="";
                    currentOwner.own_address="";
                    currentOwner.own_nic="";
                }

               
                
              })
    );
           
          
         }
      }on PlatformException catch(ex){
        if(ex.code == BarcodeScanner.CameraAccessDenied){
          setState(() {
            result="Camera permission denied.";
          });
        }else{
          setState(() {
            result="Unknown Error. $ex";
          });
        }
      }on FormatException{
          setState(() {
            result ="You have pressed the back button before scanning.";
          });
      }catch (exe){
        setState(() {
          result= "Unkown Error $exe";
        });
      }
  }
  
   
     @override
     Widget build(BuildContext context) {
       
       return Scaffold(
         appBar: AppBar(
           title: Text("Blocker QR Scanner"),
         ),
         body: Center(
           child: Column(
             mainAxisSize: MainAxisSize.max,
             children: <Widget>[
   
                // start vehicle info container
               new Container(
                 padding: new EdgeInsets.only(top: 50.0),
                 
                 child: new Column(
                   children: <Widget>[
   
   
                 Text( result,
                                 textAlign: TextAlign.center,
                                 style: TextStyle(
                                   fontSize: 20.0,
                                 )
                               ),
                 new Container(
                   padding: new EdgeInsets.only(top: 10.0),
                   child:  Column(
                     children: <Widget>[
                         Text(vehicleType,
                         ),
                         Text(colour,
                         ),
                         Text(country,
                         ),
                         Text(regNo,
                         ),
                         Text(manYr,
                         ),
                         Text(manDes,
                         ),
                         Text(engNo,
                         ),
                         Text(chasissNo,
                         ),
                         Text(cylinderCap,
                         ),
                       
   
                     ],
                   ),
                 )
                      
                       
                   ],
                 ),
               ),
                 // end vehicle info container

                // start current owner info container
                 new Container(
                     padding: new EdgeInsets.only(top: 20.0),
                     
                     child: new Column(
                       children: <Widget>[
   
   
                     Text( result2,
                                     textAlign: TextAlign.center,
                                     style: TextStyle(
                                       fontSize: 20.0,
                                     )
                                   ),

                     new Container(
                       padding: new EdgeInsets.only(top: 10.0),
                       child:  Column(
                         children: <Widget>[
                             Text(currentOwner.own_name,
                             ),
                             Text(currentOwner.own_nic,
                             ),
                             Text(currentOwner.own_address,
                             ),
                         
   
                         ],
                       ),
                     )
                         
                         
                           
                       ],
                     ),
                   ),
                     // end current info container
              
                
                // start current owner info container
                 new Container(
                     padding: new EdgeInsets.only(top: 20.0),
                     
                     child: new Column(
                       children: <Widget>[
   
   
                     Text( result3,
                                     textAlign: TextAlign.center,
                                     style: TextStyle(
                                       fontSize: 20.0,
                                     )
                                   ),

                     new Container(
                       padding: new EdgeInsets.only(top: 10.0),
                       child:  Column(
                         children: <Widget>[
                             Text(preOwner1.own_name,
                             ),
                             Text(preOwner1.own_nic,
                             ),
                             Text(preOwner1.own_address,
                             ),
                         
   
                         ],
                       ),
                     )
                         
                         
                           
                       ],
                     ),
                   ),
                     // end current info container
              
             ],
             
             
           
           ),
           
         ),
         floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.camera_alt),
          label: Text("scan"),
          onPressed: scanQR,
         ), // This trailing comma makes auto-formatting nicer for build methods.
         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
       );
     }
   }
   
   class Class {
}
