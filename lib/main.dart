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

  List<String> sportActivities = ['Low','Moderate','High'];
  int sportActivitySelected;
  DateTime birthDate;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: new Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            textAlign: TextAlign.center,
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new Text(
                'Fill all field to get needed calories!',
                textScaleFactor: 1.3,
              ),
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
                          new Text(
                            'Woman',
                            style: new TextStyle(
                              color: Colors.pink,
                            ),
                          ),
                          new Switch(
                            value: genderMale,
                            inactiveTrackColor: (genderMale)? Colors.blue[300] : Colors.pink[300],
                            activeColor: (genderMale)? Colors.blue : Colors.pink,
                            onChanged: (bool gender){
                              setState(() {
                                genderMale = gender;
                              });
                            },
                          ),
                          new Text(
                            'Man',
                            style: new TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                      ),
                      new RaisedButton(
                        onPressed: (){
                          showDate();
                        },
                        child: new Text(
                            'Your age is ${age?? ''}'
                        ),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                      ),
                      new Text(
                        'Your Size is ${size?? ''} cm',
                        style: new TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      new Slider(
                        value: size.toDouble(),
                        min: 1.0,
                        max: 250.0,
                        onChanged: (double _size){
                          setState(() {
                            size = _size.floor();
                          });
                        },
                      ),
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
                      new Text(
                        'Which Sport do you do?',
                        style: new TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      new Row(
                        children: getSportActivities(),
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                    ],
                  ),
                ),
              ),
              new RaisedButton(
                onPressed: (){

                },
                child: new Text(
                    'Calculate'
                ),
                elevation: 15.0,
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future showDate() async{
    DateTime choice = await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.year,
      initialDate: birthDate?? new DateTime.now(),
      firstDate: new DateTime(1920),
      lastDate: new DateTime(2020),
    );

    setState(() {
      birthDate = choice;
      age = (DateTime.now().difference(birthDate).inDays/365).ceil();
    });
  }

  List<Widget> getSportActivities(){
    List<Widget> l = [];
    for(int i=0;i<sportActivities.length;i++){
      Column column = new Column(
        children: <Widget>[
          new Radio(
            value: i,
            groupValue: sportActivitySelected,
            onChanged: (int value){
              setState(() {
                sportActivitySelected = value;
              });
            },
          ),
          new Text(
            sportActivities[i],
            style: new TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      );

      l.add(column);
    }
    return l;
  }
}
