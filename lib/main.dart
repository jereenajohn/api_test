import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:apitest/viewusersdata.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyapI(),
    );
  }
}

class MyapI extends StatefulWidget {
  const MyapI({super.key});

  @override
  State<MyapI> createState() => _MyapIState();
}

class _MyapIState extends State<MyapI> {
  var url ="https://starter-scheduled-driven-stereo.trycloudflare.com/api/persons/";
  var ResponseData;
  TextEditingController con1 = TextEditingController();
  TextEditingController con2 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     getmethod(url);
    // postmethod(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        children: [
          TextField(
            controller: con1,
          ),
          TextField(
            controller: con2,
          ),
          ElevatedButton(
              onPressed: () {
                postmethod(url = url, con1.text, int.parse(con2.text));
              },
              child: Text("submit")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => viewuserdata()));
              },
              child: Text("view user"))
        ],
      ),
    ));
  }

  void getmethod(var url) async {
    var response = await http.get(Uri.parse(url));

    setState(() {
      ResponseData = jsonDecode(response.body);
      print(ResponseData);
    });
  }

  void postmethod(String url, String text, int age) async {
    var response = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"id": 1, "name": text, "age": age}));
    if (response.statusCode == 201) {
      print("success");
    } else {
      print("something went wrong");
    }
  }
}
