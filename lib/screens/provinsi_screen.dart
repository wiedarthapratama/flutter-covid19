import 'dart:convert';

import 'package:covid19/helpers/helper.dart';
import 'package:covid19/models/covid_provinsi.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ProvinsiScreen extends StatefulWidget {
  @override
  _ProvinsiScreenState createState() => _ProvinsiScreenState();
}

class _ProvinsiScreenState extends State<ProvinsiScreen> {
  bool loading = true;

  List<CovidProvinsi> covidProvinsi = [];

  getProvinsi() async {
    var url = Uri.parse("https://api.kawalcorona.com/indonesia/provinsi");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var bodyDecode = jsonDecode(response.body);
      List<dynamic> body = bodyDecode;
      List<CovidProvinsi> data = body
          .map(
            (dynamic item) => CovidProvinsi.fromJson(item),
          )
          .toList();
      setState(() {
        covidProvinsi = data;
        loading = false;
      });
    }
  }

  @override
  void initState() {
    getProvinsi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Provinsi'),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemBuilder: (context, i) {
                return Card(
                    child: Column(children: [
                  Text(
                    covidProvinsi[i].attributes.provinsi,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text('Kasus Positif:'),
                          Text(myNumberFormat(
                              covidProvinsi[i].attributes.kasusPosi)),
                        ],
                      ),
                      Column(
                        children: [
                          Text('Kasus Meninggal:'),
                          Text(myNumberFormat(
                              covidProvinsi[i].attributes.kasusMeni)),
                        ],
                      ),
                      Column(
                        children: [
                          Text('Kasus Sembuh:'),
                          Text(myNumberFormat(
                              covidProvinsi[i].attributes.kasusSemb)),
                        ],
                      )
                    ],
                  )
                ]));
              },
              itemCount: covidProvinsi.length,
            ),
    );
  }
}
