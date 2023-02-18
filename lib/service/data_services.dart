import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:travell_app/model/place.dart';

// class DataServices {
//   final _fireCloud = FirebaseFirestore.instance.collection("places");
//
//   Future<List<Place>> getInfo() async {
//     List<Place> proList = [];
//     try {
//       final pro = await _fireCloud.get();
//
//       pro.docs.forEach((element) {
//         return proList.add(Place.fromJson(element.data()));
//       });
//
//       return proList;
//     } on FirebaseException catch (e) {
//       if(kDebugMode){
//         print(e);
//       }
//       return proList;
//     } catch (e){
//       throw Exception(e.toString());
//     }
//   }
//
// }
