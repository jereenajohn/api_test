import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:apitest/updateuserdata.dart';

class viewuserdata extends StatefulWidget {
  const viewuserdata({super.key});

  @override
  State<viewuserdata> createState() => _viewuserdataState();
}

class _viewuserdataState extends State<viewuserdata> {
  var url =
      "https://starter-scheduled-driven-stereo.trycloudflare.com/api/persons/";
  var durl =
      "https://starter-scheduled-driven-stereo.trycloudflare.com/api/persons/delete/";
  var responsedata;
  List<dynamic> namelist = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: namelist.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                Text(namelist[index].toString()),
                ElevatedButton(
                    onPressed: () {
                      deletebutton(namelist[index]);
                    },
                    child: Text("delete")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  UpdateUserData(namelist[index])));
                    },
                    child: Text("Update")),
              ],
            ),
          );
        },
      ),
    );
  }

  void getuserdata() async {
    var response = await http.get(Uri.parse(url));
    // print(response);

    setState(() {
      namelist = jsonDecode(response.body);
      print(namelist);
    });
  }

  void deletebutton(namelist) async {
    int id;

    if (namelist is Map<Object?, Object?>) {
      id = int.parse(namelist["id"].toString());

      var response = await http.delete(Uri.parse('$durl$id/'));

      getuserdata();
    }
  }
}

