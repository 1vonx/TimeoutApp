import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:travell_app/cubit/place_cubit_states.dart';
import 'package:travell_app/model/place.dart';
import 'package:travell_app/service/firebase_service.dart';

class PlaceCubit extends Cubit<PlaceState>{
  PlaceCubit() : super(InitialState()){
    emit(WelcomeState());
  }

  final FirebaseService _firebaseService = GetIt.I.get<FirebaseService>();
  late final List<Place> places;

  void getData() async{
    try{
      emit(LoadingState());
      places = await _firebaseService.getPlacesFromFirebase();
      emit(LoadedState(places));
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
  }

  detailPage(Place data){
    emit(DetailState(data));
  }

  goHome(){
    emit(LoadedState(places));
  }

}