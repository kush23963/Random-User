import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import "package:http/http.dart" as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List usersData;
  bool isLoading = true;
  final Uri url = Uri.parse("https://randomuser.me/api/?results=50");
  Future getData() async{
    var response = await http.get(url,
    headers: {"Accept": "application/json"});

    List data = jsonDecode(response.body)['results'];
    setState(() {
      usersData = data;
      isLoading = false;
    });
  }

  @override
  void initState(){
    super.initState();
    this.getData();
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Random Users"),
      ),
      body: Container(
        child: Center(
          child: isLoading ? CircularProgressIndicator() : ListView.builder(
            itemCount: usersData == null ? 0: usersData.length,
            itemBuilder: (BuildContext context, int index){
              return Card(
                child: Row(
                 children: <Widget>[
                   Container(
                     margin: EdgeInsets.all(20.0),
                     child: Image(
                       width: 70.0,
                       height: 70.0,
                       fit: BoxFit.contain,
                       image: NetworkImage(
                         usersData[index]['picture']['thumbnail']
                       ),),
                   ),
                   Expanded(
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: <Widget>[
                         Text(usersData[index]['name']['first'] + " " + usersData[index]['name']['last'],style:TextStyle(fontSize: 20.0,
                         fontWeight: FontWeight.bold), 
                         ),
                         RichText(
                           text: TextSpan(
                             children: [
                               WidgetSpan(
                                child: Icon(Icons.phone),
                                alignment: PlaceholderAlignment.middle,
                              ),
                               TextSpan(
                                 text: "${usersData[index]['phone']}",
                                 style:TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                         ),
                        RichText(
                           text: TextSpan(
                             children: [
                               WidgetSpan(
                                child: Icon(Icons.person),
                                alignment: PlaceholderAlignment.middle,
                              ),
                               TextSpan(
                                 text: "${usersData[index]['gender']}",
                                 style:TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        Text("Age: ${usersData[index]['dob']['age']}"),
                        RichText(
                           text: TextSpan(
                             children: [
                               WidgetSpan(
                                child: Icon(Icons.email),
                                alignment: PlaceholderAlignment.middle,
                              ),
                               TextSpan(
                                 text: "${usersData[index]['email']}",
                                 style:TextStyle(color: Colors.black,fontSize: 15.0),
                              ),
                            ],
                          ),
                        ),
                       ],
                     ))
                 ], 
                ),
              );
            },
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){},
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
