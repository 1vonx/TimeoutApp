import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:travell_app/model/place.dart';

import '../service/firebase_service.dart';

abstract class CubitState extends Equatable{}

class InitialState extends CubitState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class WelcomeState extends CubitState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AuthState extends CubitState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadingState extends CubitState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoadedState extends CubitState{
  final List<Place> places;
  LoadedState(this.places);
  @override
  // TODO: implement props
  List<Object> get props => [places];
}

class DetailState extends CubitState{
  final Place place;
  DetailState(this.place);
  @override
  // TODO: implement props
  List<Object> get props => [place];
}