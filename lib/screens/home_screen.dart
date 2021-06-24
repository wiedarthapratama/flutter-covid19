import 'dart:convert';

import 'package:covid19/helpers/helper.dart';
import 'package:covid19/models/covid.dart';
import 'package:covid19/models/vaksin.dart';
import 'package:covid19/screens/provinsi_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading = true;
  List<Covid> covid = [];
  Vaksin vaksin = Vaksin();
  getCovid() async {
    var url = Uri.parse("https://api.kawalcorona.com/indonesia");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var bodyDecode = jsonDecode(response.body);
      List<dynamic> body = bodyDecode;
      List<Covid> data = body
          .map(
            (dynamic item) => Covid.fromJson(item),
          )
          .toList();
      setState(() {
        covid = data;
      });
      getVaksin();
    }
  }

  getVaksin() async {
    var url = Uri.parse("https://vaksincovid19-api.vercel.app/api/vaksin");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var bodyDecode = jsonDecode(response.body);
      vaksin = Vaksin.fromJson(bodyDecode);
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    getCovid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Covid Info'),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Penambahan Kasus Hari Ini:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        return Column(
                          children: [
                            Container(
                                width: double.infinity,
                                color: Colors.green,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Positif:",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30),
                                      ),
                                      Text(
                                        covid[i].positif + " Orang",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30),
                                      ),
                                    ],
                                  ),
                                )),
                            Container(
                                width: double.infinity,
                                color: Colors.blue,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Sembuh:",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30),
                                      ),
                                      Text(
                                        covid[i].sembuh + " Orang",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30),
                                      ),
                                    ],
                                  ),
                                )),
                            Container(
                                width: double.infinity,
                                color: Colors.red,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Meninggal:",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30),
                                      ),
                                      Text(
                                        covid[i].meninggal + " Orang",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30),
                                      ),
                                    ],
                                  ),
                                )),
                            Container(
                                width: double.infinity,
                                color: Colors.grey,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Dirawat:",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30),
                                      ),
                                      Text(
                                        covid[i].dirawat + " Orang",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30),
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        );
                      },
                      itemCount: covid.length,
                    ),
                    Center(
                      child: MaterialButton(
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProvinsiScreen()));
                        },
                        child: Text(
                          'Lihat Data Per Provinsi',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Text(
                      'Sasaran Vaksinasi:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: double.infinity,
                        color: Colors.green,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total \nSasaran:",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              ),
                              Text(
                                myNumberFormat(vaksin.totalsasaran),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              ),
                            ],
                          ),
                        )),
                    Container(
                        width: double.infinity,
                        color: Colors.blue,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Vaksinasi \nDomestik:",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              ),
                              Text(
                                myNumberFormat(vaksin.sasaranvaksinsdmk),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              ),
                            ],
                          ),
                        )),
                    Container(
                        width: double.infinity,
                        color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Vaksinasi \nLansia:",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              ),
                              Text(
                                myNumberFormat(vaksin.sasaranvaksinlansia),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              ),
                            ],
                          ),
                        )),
                    Container(
                        width: double.infinity,
                        color: Colors.grey,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Vaksinasi \nPetugas\nPublik:",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              ),
                              Text(
                                myNumberFormat(
                                    vaksin.sasaranvaksinpetugaspublik),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              ),
                            ],
                          ),
                        )),
                    Container(
                        width: double.infinity,
                        color: Colors.cyan,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Vaksinasi \nTahap 1:",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              ),
                              Text(
                                myNumberFormat(vaksin.vaksinasi1),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              ),
                            ],
                          ),
                        )),
                    Container(
                        width: double.infinity,
                        color: Colors.amber,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Vaksinasi \nTahap 2:",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              ),
                              Text(
                                myNumberFormat(vaksin.vaksinasi2),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
    );
  }
}
