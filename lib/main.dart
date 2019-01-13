import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    title: 'Listview Json',
    home: Home(/*data: List<String>.generate(300, (i) => 'Ini Data Ke $i'),*/),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List dataJSON;
  Future<String> ambildata() async {
    http.Response hasil = await http.get(
        Uri.encodeFull('https://jsonplaceholder.typicode.com/posts'),
        headers: {'Accept': 'application/json'});

    this.setState(() {
      dataJSON = jsonDecode(hasil.body);
    });
  }

  @override
  void initState() {
    this.ambildata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listview Json'),
      ),
      body: ListView.builder(
        itemCount: dataJSON == null ? 0 : dataJSON.length,
        itemBuilder: (context, i) {
          return Container(
            padding: const EdgeInsets.all(5),
            child: Card(
                child: Container(
                  padding: const EdgeInsets.all(15),
                    child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(dataJSON[i]['title'],
                    style: TextStyle(fontSize: 20, color: Colors.orange)),
                Padding(
                  padding: const EdgeInsets.all(5),
                ),
                Text(dataJSON[i]['body']),
              ],
            ))),
          );
        },
      ),
    );
  }
}

/*class Home extends StatelessWidget {
  final List<String> data;
  Home ({this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
        title: Text('Listview Json'),
      ),

      body: Container(
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index){
            return ListTile(
              leading: Icon(Icons.widgets),
              title: Text('${data[index]}'),
            );
          },
        ),
      ),
    );
  }
}*/
