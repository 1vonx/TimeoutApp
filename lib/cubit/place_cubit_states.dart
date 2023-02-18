import 'package:equatable/equatable.dart';
import 'package:travell_app/model/place.dart';

abstract class PlaceState extends Equatable{}

class InitialState extends PlaceState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class WelcomeState extends PlaceState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoadingState extends PlaceState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoadedState extends PlaceState{
  final List<Place> places;
  LoadedState(this.places);
  @override
  // TODO: implement props
  List<Object> get props => [places];
}

class DetailState extends PlaceState{
  final Place place;
  DetailState(this.place);
  @override
  // TODO: implement props
  List<Object> get props => [place];
}