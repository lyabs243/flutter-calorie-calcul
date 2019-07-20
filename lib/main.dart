import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calories Calculation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Calorie Calculation'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool genderMale = true;
  int age;
  int size=30;
  int weight;
  List sportActivities = [
    {
      'desc': 'Low',
      'rate': 1.2,
    },
    {
      'desc': 'Moderate',
      'rate': 1.5,
    },
    {
      'desc': 'High',
      'rate': 1.8,
    }
  ];
  int sportActivitySelected;
  DateTime birthDate;

  bool isIOS = Platform.isIOS;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: (isIOS)?
        new CupertinoPageScaffold(
          navigationBar: new CupertinoNavigationBar(
            backgroundColor: getColor(),
            middle: textWithStyle(widget.title,color: Colors.white),
          ),
          child: body(),
        )
            :
      new Scaffold(
        appBar: AppBar(
          title: textWithStyle(
            widget.title,
            color: Colors.white,
          ),
          backgroundColor: getColor(),
        ),
        body: body(),
      ),
    );
  }

  Widget getCalcButton(){
    if(isIOS){
      return new CupertinoButton(
        onPressed: (){
          calculCalories();
        },
        child: textWithStyle(
            'Calculate',
          color: Colors.white,
        ),
        color: getColor(),
      );
    }
    else{
      return new RaisedButton(
        onPressed: (){
          calculCalories();
        },
        child: textWithStyle(
            'Calculate',
          color: Colors.white,
        ),
        elevation: 15.0,
        color: getColor(),
        textColor: Colors.white,
      );
    }
  }

  void calculCalories(){
    if(age == null || weight == null || sportActivitySelected == null){
      showAlert(context, 'Warning', 'You must fill all fields!');
    }
    else{
      double cal =  (genderMale)?
      66.4730 + (13.7516 * weight) + (5.0033 * size) - (6.7550 * age) :
      655.0955 + (9.5634 * weight) + (1.8496 * size) - (4.6756 * age);

      double sportCal = sportActivities[sportActivitySelected]['rate']*cal;

      showAlert(context, 'Result', 'You need ${cal.round()} calories, relate to your sport activities, you needs ${sportCal.round()} calories.');
    }
  }

  Widget getAgeButton(){
    if(isIOS){
      return new CupertinoButton(
        onPressed: (){
          showDate();
        },
        child: textWithStyle(
            'Your age is ${age?? ''}',
          color: Colors.white,
        ),
        color: getColor(),
      );
    }
    else{
      return new RaisedButton(
        onPressed: (){
          showDate();
        },
        child: textWithStyle(
            'Your age is ${age?? ''}',
          color: Colors.white,
        ),
        color: getColor(),
        textColor: Colors.white,
      );
    }
  }

  Widget getSlider(){
    if(isIOS){
      return new CupertinoSlider(
        value: size.toDouble(),
        activeColor: getColor(),
        min: 1.0,
        max: 250.0,
        onChanged: (double _size){
          setState(() {
            size = _size.floor();
          });
        },
      );
    }
    else{
      return new Slider(
        value: size.toDouble(),
        activeColor: getColor(),
        min: 1.0,
        max: 250.0,
        onChanged: (double _size){
          setState(() {
            size = _size.floor();
          });
        },
      );
    }
  }

  Widget getSwitch(){
    if(isIOS){
      return new CupertinoSwitch(
        value: genderMale,
        activeColor: (genderMale)? Colors.blue : Colors.pink,
        onChanged: (bool gender){
          setState(() {
            genderMale = gender;
          });
        },
      );
    }
    else{
      return new Switch(
        value: genderMale,
        inactiveTrackColor: (genderMale)? Colors.blue[300] : Colors.pink[300],
        activeColor: (genderMale)? Colors.blue : Colors.pink,
        onChanged: (bool gender){
          setState(() {
            genderMale = gender;
          });
        },
      );
    }
  }

  Widget textWithStyle(String title,{color: Colors.black,fontSize: 15.0,textScaleFactor: 1.0}){
    if(isIOS){
      return new DefaultTextStyle(
          style: new TextStyle(
            color: color,
            fontSize: fontSize,
          ),
          child: new Text(
            title,
            textAlign: TextAlign.center,
            textScaleFactor: textScaleFactor,
          ),
      );
    }
    else{
      return new Text(
        title,
        textAlign: TextAlign.center,
        textScaleFactor: textScaleFactor,
        style: new TextStyle(
          color: color,
          fontSize: fontSize,
        ),
      );
    }
  }

  Widget body(){
    return new SingleChildScrollView(
      padding: EdgeInsets.only(top: 25.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            textWithStyle(
              'Fill all field to get needed calories!',
              textScaleFactor: 1.3,
            ),
            new Padding(padding: EdgeInsets.only(top: 30.0)),
            new Card(
              elevation: 15.0,
              child: new Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 1.8,
                padding: EdgeInsets.all(10.0),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        textWithStyle(
                          'Woman',
                          color: Colors.pink,
                        ),
                        getSwitch(),
                        textWithStyle(
                          'Man',
                          color: Colors.blue,
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                    ),
                    getAgeButton(),
                    textWithStyle(
                      'Your Size is ${size?? ''} cm',
                        color: getColor(),
                    ),
                    getSlider(),
                    new TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (String text){
                        setState(() {
                          weight = int.parse(text);
                        });
                      },
                      onSubmitted: (String text){
                        setState(() {
                          weight = int.parse(text);
                        });
                      },
                      decoration: new InputDecoration(
                        labelText: 'Your weight in Kg',
                      ),
                    ),
                    textWithStyle(
                      'Which Sport do you do?',
                        color: getColor(),
                    ),
                    new Row(
                      children: getSportActivities(),
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    ),
                  ],
                ),
              ),
            ),
            new Padding(padding: EdgeInsets.only(top: 30.0)),
            getCalcButton(),
          ],
        ),
      ),
    );
  }

  Color getColor(){
    if(genderMale){
      return Colors.blue;
    }
    return Colors.pink;
  }

  Future showDate() async{
    DateTime choice = await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.year,
      initialDate: birthDate?? new DateTime.now(),
      firstDate: new DateTime(1920),
      lastDate: new DateTime(2020),
    );

    if(choice != null) {
      setState(() {
        birthDate = choice;
        age = (DateTime
            .now()
            .difference(birthDate)
            .inDays / 365).floor();
      });
    }
  }

  List<Widget> getSportActivities(){
    List<Widget> l = [];
    for(int i=0;i<sportActivities.length;i++){
      Column column = new Column(
        children: <Widget>[
          new Radio(
            value: i,
            activeColor: getColor(),
            groupValue: sportActivitySelected,
            onChanged: (int value){
              setState(() {
                sportActivitySelected = value;
              });
            },
          ),
          new Text(
            sportActivities[i]['desc'],
            style: new TextStyle(
              color: getColor(),
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      );

      l.add(column);
    }
    return l;
  }

  Future showAlert(BuildContext context,String title,String description) async{

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        if(isIOS){
          return new CupertinoAlertDialog(
            title: new Text(
              title,
              textAlign: TextAlign.center,
              textScaleFactor: 1.2,
            ),
            content: new Text
              (
              description,
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: new Text(
                    'OK'
                ),
              ),
            ],
          );
        }
        else {
          return new AlertDialog(
            title: new Text(
              title,
              textAlign: TextAlign.center,
              textScaleFactor: 1.2,
            ),
            contentPadding: EdgeInsets.all(10.0),
            content: new Text
              (
              description,
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: new Text(
                    'OK'
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
