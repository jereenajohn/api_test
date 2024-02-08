import 'dart:convert';
import 'dart:io';

import 'package:apitest/viewusersdata.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateUserData extends StatelessWidget {
  var durl =
      "https://starter-scheduled-driven-stereo.trycloudflare.com/api/persons/delete/";

  var index;
  UpdateUserData(this.index);

  TextEditingController con1 = TextEditingController();

  TextEditingController con2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            TextField(controller: con1),
            TextField(controller: con2),
            ElevatedButton(
                onPressed: () {
                  Updatebutton(index);
                },
                child: Text("submit"))
          ],
        ),
      ),
    );
  }

  void Updatebutton(namelist) async {
    int id;

    if (namelist is Map<Object?, Object?>) {
      id = int.parse(namelist["id"].toString());

      var response = await http.put(Uri.parse('$durl$id/'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(
              {"id": id, "name": con1.text, "age": int.parse(con2.text)}));
    }
  }
}
