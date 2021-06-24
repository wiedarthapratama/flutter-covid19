import 'package:covid19/models/attribut.dart';

class CovidProvinsi {
  Attributes attributes;

  CovidProvinsi({this.attributes});

  CovidProvinsi.fromJson(Map<String, dynamic> json) {
    attributes = json['attributes'] != null
        ? new Attributes.fromJson(json['attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.attributes != null) {
      data['attributes'] = this.attributes.toJson();
    }
    return data;
  }
}
