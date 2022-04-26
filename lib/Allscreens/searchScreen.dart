// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, file_names

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:labour_app_wg/Config.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

import '../Datahandler/appdata.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController currentlocation = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    String myadres = Provider.of<AppData>(context).pickuplocation != null
        ? Provider.of<AppData>(context).pickuplocation.placeName
        : "";
    currentlocation.text = myadres;
    var place;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 255.0,
            // ignore: prefer_const_literals_to_create_immutables
            decoration: BoxDecoration(color: Color.fromARGB(255, 240, 237, 237),
                // ignore: prefer_const_literals_to_create_immutables
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5.0,
                      spreadRadius: 5.0,
                      offset: Offset(7.0, 7.0))
                ]),
            child: Padding(
              padding: EdgeInsets.only(
                  left: 25.0, right: 25.0, top: 25.0, bottom: 20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 40.0,
                  ),
                  Stack(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Icon(Icons.arrow_back),
                      Center(
                        child: Text(
                          "LOCATION",
                          style: TextStyle(
                              fontSize: 16.0, fontFamily: "Brand-Bold"),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 7.5,
                  ),
                  Divider(),
                  SizedBox(
                    height: 7.5,
                  ),
                  Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Icon(Icons.my_location),
                      SizedBox(
                        height: 7.5,
                      ),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Padding(
                          padding: EdgeInsets.all(3.0),
                          child: TextField(
                              onTap: () async => {
                                    place = await PlacesAutocomplete.show(
                                        context: context,
                                        apiKey: Mapkey,
                                        mode: Mode.overlay,
                                        types: [],
                                        strictbounds: false,
                                        components: [
                                          Component(Component.country, 'pk')
                                        ],
                                        //google_map_webservice package
                                        onError: (err) {
                                          print(err);
                                        }),
                                  }),
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void findPlaces(context) async {
  // if (places.length > 1) {
  //   String placeUrl =
  //       "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$places&key=$Mapkey&sessiontoken=1234567890";
  //   var response = await RequestAssitant.getRequest(placeUrl);
  //   if (response == "failed") {
  //     return;
  //   } else {
  //     print("Locations are ..");
  //     print(response);
  //   }
  // }
}
