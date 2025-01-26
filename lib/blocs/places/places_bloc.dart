import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_guide/controllers/places_controller.dart';
import 'package:tourist_guide/models/place_model.dart';

part 'places_event.dart';
part 'places_state.dart';

class PlacesBloc extends Bloc<PlacesEvent, PlacesState> {
  final PlacesController placesController;
  List<Place> _suggestedPlaces = [];
  List<Place> _popularPlaces = [];
  int _suggestedPlacesPage = 0;
  int _popularPlacesPage = 0;
  final int _pageSize = 3;

  PlacesBloc(this.placesController) : super(PlacesInitial()) {
    on<LoadPlaces>(onLoadPlaces);
    on<LoadMorePlaces>(onLoadMorePlaces);
  }

  void onLoadPlaces(LoadPlaces event, Emitter<PlacesState> emit) async {
    emit(PlacesLoading());
    try {
      _suggestedPlacesPage = 0;
      _popularPlacesPage = 0;
      _suggestedPlaces = await placesController.fetchSuggestedPlaces(
        start: _suggestedPlacesPage * _pageSize,
        limit: _pageSize,
      );
      _popularPlaces = await placesController.fetchPopularPlaces(
        start: _popularPlacesPage * _pageSize,
        limit: _pageSize,
      );
      emit(PlacesLoaded(
        suggestedPlaces: _suggestedPlaces,
        popularPlaces: _popularPlaces,
      ));
    } catch (e) {
      emit(PlacesError(message: e.toString()));
    }
  }

  void onLoadMorePlaces(LoadMorePlaces event, Emitter<PlacesState> emit) async {
    emit(PlacesLoading());
    try {
      _suggestedPlacesPage++;
      _popularPlacesPage++;
      final List<Place> moreSuggestedPlaces = await placesController.fetchSuggestedPlaces(
        start: _suggestedPlacesPage * _pageSize,
        limit: _pageSize,
      );
      final List<Place> morePopularPlaces = await placesController.fetchPopularPlaces(
        start: _popularPlacesPage * _pageSize,
        limit: _pageSize,
      );
      _suggestedPlaces.addAll(moreSuggestedPlaces);
      _popularPlaces.addAll(morePopularPlaces);
      emit(PlacesLoaded(
        suggestedPlaces: _suggestedPlaces,
        popularPlaces: _popularPlaces,
      ));
    } catch (e) {
      emit(PlacesError(message: e.toString()));
    }
  }
}