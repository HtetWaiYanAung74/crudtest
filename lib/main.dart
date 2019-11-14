import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Store',
      home: new Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState  createState() => new _HomeState();
}

class _HomeState extends State<Home> {

  Future<List> getData() async {
    final response = await http.get("https://storecrud.000webhost.com/getdata.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("My Store"),),
      body: new FutureBuilder<List>(
          future: getData(),
          builder: (context, snapshot) {
            if(snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? new ItemList()
                : new Center( child: new CircularProgressIndicator(),);
          }
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  List list;
  ItemList({this.list});
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: list==null ? 0 : list.length,
        itemBuilder: (context, i) {
          return new Container(
            padding: EdgeInsets.all(10.0),
            child: new GestureDetector(
              onTap: ()=>Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (BuildContext context) => new Detail(list: list, index: i,)
                )
              ) ,
              child: new Card(
                child: new ListTile(
                    title: new Text(list[i]['item_name']),
                    leading: new Icon(Icons.widgets),
                    subtitle: new Text("Stock : ${list[i]['stock']}"),
                )
              )
            )
          );
        }
    );
  }

}
