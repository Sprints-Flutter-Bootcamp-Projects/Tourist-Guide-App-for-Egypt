import 'package:easy_localization/easy_localization.dart';

List<Map<String, dynamic>> govData = [
  {
    "governorate": tr('cairo'),
    "landmarks": [
      {
        "name": tr('cairo_tower'),
        "description": tr('cairo_tower_description'),
        "image": "https://www.egypttoursportal.com/images/2021/04/Cairo-Tower-Egypt-Tours-Portal-1.jpg",
        "location": tr('cairo_tower_location'),
      },
      {
        "name": tr('egyptian_museum'),
        "description":
            tr('egyptian_museum_description'),
        "image": "https://egyptianstreets.com/wp-content/uploads/2021/04/museum2.jpg",
        "location": tr('egyptian_museum_location'),
      }
    ]
  },
  {
    "governorate": tr('alexandria'),
    "landmarks": [
      {
        "name": tr('bibliotheca_alexandrina'),
        "description":
            tr('bibliotheca_alexandrina_description'),
        "image": "https://www.cascadianabroad.com/wp-content/uploads/2016/11/featured-image.jpg",
        "location": tr('bibliotheca_alexandrina_location'),
      },
      {
        "name": tr('qaitbey_fortress'),
        "description":tr('qaitbey_fortress_description'),
        "image": "https://www.luxorandaswan.com/images/16586178660Citadel-Of-Qaitbay.jpg",
        "location": tr('qaitbey_fortress_location'),
      }
    ]
  },
  {
    "governorate": tr('al_fayoum'),
    "landmarks": [
      {
        "name": tr('wadi_el_rayan'),
        "description":tr('wadi_el_rayan_description'),
        "image":"https://holidaytours.one/wp-content/uploads/2020/09/fayoum.jpg",
        "location": tr('wadi_el_rayan_location'),
      },
      {
        "name": tr('lake_qaron'),
        "description": tr('lake_qaron_description'),
        "image": "https://medomed.org/wp-content/uploads/2017/06/Fayoum-egypt.jpg",
        "location": tr('lake_qaron_location'),
      }
    ]
  }
];
