import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart' as prefix0;

import 'dart:ui';

import 'package:project/font_dart_files/my_flutter_app_icons.dart';

class GraphPage extends StatefulWidget {
  String name;
  Map<String, dynamic> data;
  GraphPage(this.name, this.data);
  GraphPageState createState() => GraphPageState();
}

class GraphPageState extends State<GraphPage> {
  List<Data> graphData;
  List<dynamic> temp;

  String startDate;
  String endDate;

  DateTime initialDate;
  DateTime finalDate;

  @override
  void initState() {
    temp = widget.data["India"];
    graphData = List<Data>.generate(temp.length, (index) {
      Data d = new Data();
      d.activeCases = 0;
      d.totalCases = 0;
      d.dead = 0;
      d.recovered = 0;
      return d;
    });

    if (widget.name == "World") {
      List<String> countries = widget.data.keys.toList();
      countries.forEach((country) {
        List<dynamic> countryData = widget.data["$country"];
        for (int i = 0; i < countryData.length; i++) {
          Data data = new Data();
          data.totalCases =
              graphData[i].totalCases + countryData[i]["confirmed"];
          data.recovered = graphData[i].recovered + countryData[i]["recovered"];
          data.dead = graphData[i].dead + countryData[i]["deaths"];
          data.activeCases = data.totalCases - data.recovered - data.dead;
          graphData[i] = data;
        }
      });
    } else {
      List<dynamic> c = widget.data["${widget.name}"];
      for (int i = 0; i < c.length; i++) {
        Data e = new Data();
        e.totalCases = c[i]["confirmed"];
        e.recovered = c[i]["recovered"];
        e.dead = c[i]["deaths"];
        e.activeCases = e.totalCases - e.recovered - e.dead;
        graphData[i] = e;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: <Widget>[
        Align(
            child: Container(
          child: CustomPaint(
            painter: new GraphPainter(
                dates: temp,
                data: graphData,
                initialDate: startDate,
                finalDate: endDate),
            //child: Icon(Icons.ac_unit, color: Colors.white,),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        )),
        Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
            ),
            Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Icon(
                      MyFlutterApp.viruses_solid,
                      color: Colors.orange,
                      size: MediaQuery.of(context).size.width * 0.1,
                    ),
                    Text(
                      "Total Cases",
                      style: TextStyle(
                          color: Colors.orange, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Icon(
                      MyFlutterApp.head_side_mask_solid,
                      color: Colors.yellow,
                      size: MediaQuery.of(context).size.width * 0.1,
                    ),
                    Text(
                      "Active Cases",
                      style: TextStyle(
                          color: Colors.yellow, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Icon(
                      MyFlutterApp.hand_holding_medical_solid,
                      color: Colors.green,
                      size: MediaQuery.of(context).size.width * 0.1,
                    ),
                    Text(
                      "Recovered",
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Icon(
                      MyFlutterApp.skull_crossbones_solid,
                      color: Colors.red,
                      size: MediaQuery.of(context).size.width * 0.1,
                    ),
                    Text(
                      "Dead",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            )
          ],
        ),
        Column(children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.72,
          ),
          Row(
            children: <Widget>[
              RaisedButton(
                child: Text(
                    initialDate == null ? "Select Initial Date" : startDate),
                onPressed: () {
                  String date = temp[0]["date"];
                  List<String> dateSep = date.split('-');
                  String endDate = temp[temp.length - 1]["date"];
                  List<String> endDateSep = endDate.split('-');
                  showDatePicker(
                          context: context,
                          initialDate: initialDate == null
                              ? DateTime(int.parse(dateSep[0]),
                                  int.parse(dateSep[1]), int.parse(dateSep[2]))
                              : initialDate,
                          firstDate: DateTime(int.parse(dateSep[0]),
                              int.parse(dateSep[1]), int.parse(dateSep[2])),
                          lastDate: finalDate == null
                              ? DateTime(
                                  int.parse(endDateSep[0]),
                                  int.parse(endDateSep[1]),
                                  int.parse(endDateSep[2]))
                              : finalDate)
                      .then((d) {
                    initialDate = d;

                    setState(() {
                      startDate = "${d.year}-${d.month}-${d.day}";
                    });
                  }).catchError((e) {});
                },
              ),
              RaisedButton(
                child: Text(finalDate == null ? "Select Final Date" : endDate),
                onPressed: () {
                  String date = temp[0]["date"];
                  List<String> dateSep = date.split('-');
                  String endDate = temp[temp.length - 1]["date"];
                  List<String> endDateSep = endDate.split('-');
                  showDatePicker(
                          context: context,
                          initialDate: finalDate == null
                              ? DateTime(
                                  int.parse(endDateSep[0]),
                                  int.parse(endDateSep[1]),
                                  int.parse(endDateSep[2]))
                              : finalDate,
                          firstDate: initialDate != null
                              ? initialDate
                              : DateTime(int.parse(dateSep[0]),
                                  int.parse(dateSep[1]), int.parse(dateSep[2])),
                          lastDate: DateTime(
                              int.parse(endDateSep[0]),
                              int.parse(endDateSep[1]),
                              int.parse(endDateSep[2])))
                      .then((d) {
                    finalDate = d;

                    setState(() {
                      this.endDate = "${d.year}-${d.month}-${d.day}";
                    });
                  }).catchError((e) {});
                },
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          )
        ]),
      ]),
      appBar: AppBar(
        title: Text(widget.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
      ),
    );
  }
}

class GraphPainter extends CustomPainter {
  List<dynamic> dates;
  List<Data> data;
  String initialDate;
  String finalDate;

  GraphPainter({this.dates, this.data, this.initialDate, this.finalDate});

  @override
  void paint(Canvas canvas, Size size) {
    //print("$initialDate : $finalDate");
    final myPaint = Paint();
    myPaint.style = PaintingStyle.stroke;
    myPaint.color = Colors.white;
    myPaint.strokeWidth = 2.5;

    double width = size.width * 0.8;
    double height = size.height * 0.5;

    double a = size.width * 0.1;
    double b = size.width * 0.1 + height;

    double gap = height / 5;

    double pxPerDate;
    double pxPerCase;

    int start;
    int end;

    if (initialDate == null && finalDate == null) {
      pxPerDate = width / (dates.length - 1);
      pxPerCase = height / (data[data.length - 1].totalCases);
      start = 0;
      end = dates.length - 1;
    } else if (initialDate == null && finalDate != null) {
      bool found = false;
      start = 0;
      for (int i = 0; i < dates.length && found == false; i++) {
        if (finalDate == dates[i]["date"]) {
          pxPerDate = width / i;
          pxPerCase = height / data[i].totalCases;
          end = i;
          found = true;
        }
      }
    } else if (finalDate == null && initialDate != null) {
      end = dates.length - 1;
      bool found = false;
      for (int i = 0; i < dates.length && found == false; i++) {
        if (initialDate == dates[i]["date"]) {
          start = i;
          pxPerDate = width / (dates.length - i - 1);
          pxPerCase = height / data[data.length - 1].totalCases;
          found = true;
        }
      }
    } else {
      bool found = false;
      for (int i = 0; i < dates.length && found == false; i++) {
        if (initialDate == dates[i]["date"]) {
          start = i;
        }
        if (finalDate == dates[i]["date"]) {
          end = i;
          pxPerCase = height / (data[i].totalCases);
          found = true;
        }
      }
      pxPerDate = width / (end - start);
    }

    Paint totalCasesPlot = new Paint();
    totalCasesPlot.color = Colors.orange;
    totalCasesPlot.strokeWidth = 2;

    for (int i = start, j = 0; i < end; i++, j++) {
      canvas.drawLine(
          Offset(a + pxPerDate * j, b - pxPerCase * data[i].totalCases),
          Offset(
              a + pxPerDate * (j + 1), b - pxPerCase * data[i + 1].totalCases),
          totalCasesPlot);
    }

    Paint recoveredPlot = new Paint();
    recoveredPlot.color = Colors.green;
    recoveredPlot.strokeWidth = 2;

    for (int j = start, i = 0; j < end; j++, i++) {
      canvas.drawLine(
          Offset(a + pxPerDate * i, b - pxPerCase * data[j].recovered),
          Offset(
              a + pxPerDate * (i + 1), b - pxPerCase * data[j + 1].recovered),
          recoveredPlot);
    }

    Paint deadPlot = new Paint();
    deadPlot.color = Colors.red;
    deadPlot.strokeWidth = 2;

    for (int j = start, i = 0; j < end; j++, i++) {
      canvas.drawLine(
          Offset(a + pxPerDate * i, b - pxPerCase * data[j].dead),
          Offset(a + pxPerDate * (i + 1), b - pxPerCase * data[j + 1].dead),
          deadPlot);
    }

    Paint activeCasesPlot = new Paint();
    activeCasesPlot.color = Colors.yellow;
    activeCasesPlot.strokeWidth = 2;

    for (int j = start, i = 0; j < end; j++, i++) {
      canvas.drawLine(
          Offset(a + pxPerDate * i, b - pxPerCase * data[j].activeCases),
          Offset(
              a + pxPerDate * (i + 1), b - pxPerCase * data[j + 1].activeCases),
          activeCasesPlot);
    }

    canvas.drawLine(Offset(a, b - height), Offset(a, b), myPaint);
    canvas.drawLine(Offset(a, b), Offset(a + width, b), myPaint);
    canvas.drawLine(
        Offset(a, b - height), Offset(a + width, b - height), myPaint);

    Paint intermediateLines = new Paint();
    intermediateLines.color = Colors.white54;
    intermediateLines.strokeWidth = 0.5;

    for (int i = 1; i <= 4; i++) {
      canvas.drawLine(Offset(a, b - gap * i), Offset(a + width, b - gap * i),
          intermediateLines);
    }

    double xGap = width / 4;

    for (int i = 1; i <= 4; i++) {
      canvas.drawLine(Offset(a + xGap * i, b), Offset(a + xGap * i, b - height),
          intermediateLines);
    }

    final textStyle = TextStyle(color: Colors.white, fontSize: 10);

    if (end - start >= 5) {
      for (double i = 0; i <= width; i += width / 4) {
        String date = dates[(start + i / pxPerDate).round()]["date"];
        TextPainter textPainter = TextPainter(
            text: TextSpan(text: "$date", style: textStyle),
            textDirection: TextDirection.ltr);
        textPainter.layout(minWidth: 0, maxWidth: width);
        textPainter.paint(
            canvas, Offset(a - size.width * 0.05 + i, b + size.height * 0.01));
      }
    } else {
      String date1 = dates[start]["date"];
      String date2 = dates[end]["date"];
      TextPainter textPainter = TextPainter(
          text: TextSpan(text: "$date1", style: textStyle),
          textDirection: TextDirection.ltr);
      textPainter.layout(minWidth: 0, maxWidth: width);
      textPainter.paint(
          canvas, Offset(a - size.width * 0.05, b + size.height * 0.01));
      TextPainter textPainter2 = TextPainter(
          text: TextSpan(text: "$date2", style: textStyle),
          textDirection: TextDirection.ltr);
      textPainter2.layout(minWidth: 0, maxWidth: width);
      textPainter2.paint(canvas,
          Offset(a - size.width * 0.05 + width, b + size.height * 0.01));
    }

    for (double i = 0; i <= height; i += height / 5) {
      int cases = (i / pxPerCase).round();
      TextPainter textPainter = TextPainter(
          text: TextSpan(
              text: "$cases",
              style:
                  TextStyle(color: Colors.white, fontSize: size.width * 0.02)),
          textDirection: TextDirection.ltr);
      textPainter.layout(minWidth: 0, maxWidth: width);
      textPainter.paint(
          canvas, Offset(a - size.width * 0.085, b - i - size.height * 0.005));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class Data {
  int totalCases;
  int activeCases;
  int recovered;
  int dead;
}
