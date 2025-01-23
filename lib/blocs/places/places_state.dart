part of 'places_bloc.dart';

@immutable
abstract class PlacesState {}

class PlacesInitial extends PlacesState {}

class PlacesLoading extends PlacesState {}

class PlacesLoaded extends PlacesState {
  final List<Place> suggestedPlaces;
  final List<Place> popularPlaces;
  PlacesLoaded({required this.suggestedPlaces, required this.popularPlaces});
}

class PlacesError extends PlacesState {
  final String message;
  PlacesError({required this.message});
}

