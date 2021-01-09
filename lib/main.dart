import 'package:flutter/material.dart';
import 'package:project/font_dart_files/my_flutter_app_icons.dart';

import 'graph.dart';
import 'getData.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(primaryColor: Colors.black),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>{
  bool gotData = false;

  int totalCases = 0;
  int activeCases = 0;
  int recovered = 0;
  int dead = 0;

  int ctotalCases = 0;
  int cactiveCases = 0;
  int crecovered = 0;
  int cdead = 0;

  String selectedCountry = "India";
  List<String> allCountries = new List<String>();

  Map<String, dynamic> coronaData;

  String error;

  @override
  void initState() {
    getCoronaData.getData().then((map) {
      coronaData = map;
      List<String> countries = map.keys.toList();
      allCountries = countries;
      countries.forEach((String country) {
        List<dynamic> data = map[country];
        totalCases += data[data.length - 1]["confirmed"];
        recovered += data[data.length - 1]["recovered"];
        dead += data[data.length - 1]["deaths"];
      });
      activeCases = totalCases - recovered - dead;

      List<dynamic> d = map["$selectedCountry"];
      ctotalCases = d[d.length - 1]["confirmed"];
      crecovered = d[d.length - 1]["recovered"];
      cdead = d[d.length - 1]["deaths"];
      cactiveCases = ctotalCases - crecovered - cdead;
      setState(() {
        //print(totalCases);
        gotData = true;
      });
    }).catchError((e) {
      setState(() {
        error = e.message;
      });
    });
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  GetData getCoronaData = new GetData();

  Color cardColor = new Color(0xff252525);

  @override
  Widget build(BuildContext context) {
    double iconSize = MediaQuery.of(context).size.width * 0.07;
    double titleSize = MediaQuery.of(context).size.width * 0.09;
    double ctitleSize = MediaQuery.of(context).size.width * 0.06125;
    double tileTitleSize = MediaQuery.of(context).size.width * 0.04;
    double dataSize = MediaQuery.of(context).size.width * 0.075;

    double cardHeightRatio = 0.45;
    double cardWidthRatio = 0.95;

    return Scaffold(
      backgroundColor: Colors.black,
      body: gotData
          ? GestureDetector(
              child: Container(
                child: Center(
                    child: Column(
                  children: <Widget>[
                    InkWell(
                      child: Container(
                        child: Card(
                          color: cardColor,
                          elevation: 10,
                          child: Column(
                            children: <Widget>[
                              Center(
                                child: Text(
                                  "World",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: titleSize,
                                    fontFamily: "Ubuntu",
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Icon(
                                  MyFlutterApp.viruses_solid,
                                  color: Colors.orange,
                                  size: iconSize,
                                ),
                                title: Padding(
                                  child: Text(
                                    "Total Cases",
                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontSize: tileTitleSize),
                                  ),
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.02),
                                ),
                                trailing: Text(
                                  "$totalCases",
                                  style: TextStyle(
                                      color: Colors.orange, fontSize: dataSize),
                                ),
                              ),
                              ListTile(
                                leading: Icon(
                                  MyFlutterApp.head_side_mask_solid,
                                  color: Colors.yellow,
                                  size: iconSize,
                                ),
                                title: Padding(
                                  child: Text(
                                    "Active Cases",
                                    style: TextStyle(
                                        color: Colors.yellow,
                                        fontSize: tileTitleSize),
                                  ),
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.02),
                                ),
                                trailing: Text(
                                  "$activeCases",
                                  style: TextStyle(
                                      color: Colors.yellow, fontSize: dataSize),
                                ),
                              ),
                              ListTile(
                                leading: Icon(
                                  MyFlutterApp.hand_holding_medical_solid,
                                  color: Colors.green,
                                  size: iconSize,
                                ),
                                title: Padding(
                                  child: Text(
                                    "Recovered",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: tileTitleSize),
                                  ),
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.02),
                                ),
                                trailing: Text(
                                  "$recovered",
                                  style: TextStyle(
                                      color: Colors.green, fontSize: dataSize),
                                ),
                              ),
                              ListTile(
                                leading: Icon(
                                  MyFlutterApp.skull_crossbones_solid,
                                  color: Colors.red,
                                  size: iconSize,
                                ),
                                title: Padding(
                                  child: Text(
                                    "Dead",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: tileTitleSize),
                                  ),
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.02),
                                ),
                                trailing: Text(
                                  "$dead",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: dataSize),
                                ),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          ),
                        ),
                        width:
                            MediaQuery.of(context).size.width * cardWidthRatio,
                        height: MediaQuery.of(context).size.height *
                            cardHeightRatio,
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext c) {
                          return GraphPage("World", coronaData);
                        }));
                      },
                    ),
                    InkWell(
                      child: Container(
                        child: Card(
                          color: cardColor,
                          elevation: 10,
                          child: Column(
                            children: <Widget>[
                              Text(
                                "$selectedCountry",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: ctitleSize,
                                  fontFamily: "Ubuntu",
                                ),
                                textAlign: TextAlign.center,
                              ),
                              PopupMenuButton<String>(
                                  child: Text(
                                    "Change\nCountry",
                                    style: TextStyle(
                                        color: Colors.blue[200], fontSize: 10),
                                  ),
                                  onSelected: (String country) {
                                    List<dynamic> d = coronaData["$country"];
                                    ctotalCases = d[d.length - 1]["confirmed"];
                                    crecovered = d[d.length - 1]["recovered"];
                                    cdead = d[d.length - 1]["deaths"];
                                    cactiveCases =
                                        ctotalCases - crecovered - cdead;
                                    setState(() {
                                      selectedCountry = country;
                                    });
                                  },
                                  initialValue: selectedCountry,
                                  itemBuilder: (BuildContext c) {
                                    return allCountries
                                        .map<PopupMenuEntry<String>>(
                                            (String countryString) {
                                      return PopupMenuItem(
                                        value: countryString,
                                        child: Text("$countryString"),
                                      );
                                    }).toList();
                                  }),
                              ListTile(
                                leading: Icon(
                                  MyFlutterApp.viruses_solid,
                                  color: Colors.orange,
                                  size: iconSize,
                                ),
                                title: Padding(
                                  child: Text(
                                    "Total Cases",
                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontSize: tileTitleSize),
                                  ),
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.02),
                                ),
                                trailing: Text(
                                  "$ctotalCases",
                                  style: TextStyle(
                                      color: Colors.orange, fontSize: dataSize),
                                ),
                              ),
                              ListTile(
                                leading: Icon(
                                  MyFlutterApp.head_side_mask_solid,
                                  color: Colors.yellow,
                                  size: iconSize,
                                ),
                                title: Padding(
                                  child: Text(
                                    "Active Cases",
                                    style: TextStyle(
                                        color: Colors.yellow,
                                        fontSize: tileTitleSize),
                                  ),
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.02),
                                ),
                                trailing: Text(
                                  "$cactiveCases",
                                  style: TextStyle(
                                      color: Colors.yellow, fontSize: dataSize),
                                ),
                              ),
                              ListTile(
                                leading: Icon(
                                  MyFlutterApp.hand_holding_medical_solid,
                                  color: Colors.green,
                                  size: iconSize,
                                ),
                                title: Padding(
                                  child: Text(
                                    "Recovered",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: tileTitleSize),
                                  ),
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.02),
                                ),
                                trailing: Text(
                                  "$crecovered",
                                  style: TextStyle(
                                      color: Colors.green, fontSize: dataSize),
                                ),
                              ),
                              ListTile(
                                leading: Icon(
                                  MyFlutterApp.skull_crossbones_solid,
                                  color: Colors.red,
                                  size: iconSize,
                                ),
                                title: Padding(
                                  child: Text(
                                    "Dead",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: tileTitleSize),
                                  ),
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.02),
                                ),
                                trailing: Text(
                                  "$cdead",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: dataSize),
                                ),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          ),
                        ),
                        width:
                            MediaQuery.of(context).size.width * cardWidthRatio,
                        height: MediaQuery.of(context).size.height *
                            cardHeightRatio,
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext c) {
                          return GraphPage(selectedCountry, coronaData);
                        }));
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                )),
              ),
              excludeFromSemantics: true,
            )
          : Center(
              child: Container(
              child: error == null
                  ? CircularProgressIndicator()
                  : Text(
                      "$error\nPlease restart the App",
                      style: TextStyle(color: Colors.white),textAlign: TextAlign.center,
                    ),
              //width: MediaQuery.of(context).size.width,
            )),
    );
  }
}
