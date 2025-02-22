import 'package:flutter_test/flutter_test.dart';
import 'package:tourist_guide/controllers/governorate_controller.dart';
import 'package:tourist_guide/controllers/places_controller.dart';
import 'package:tourist_guide/models/governorate_model.dart';
import 'package:tourist_guide/models/place_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  controllersTest();
}

void controllersTest() {
  group('GovernorateController', () {
    test('fetchGovernorates returns a list of Governorates', () async {
      final controller = GovernorateController();
      final governorates = await controller.fetchGovernorates();

      expect(governorates, isA<List<Governorate>>());
      expect(governorates.isNotEmpty, true);
    });
  });

  group('PlacesController', () {
    test('fetchSuggestedPlaces returns a list of Places', () async {
      final controller = PlacesController();
      final places = await controller.fetchSuggestedPlaces();

      expect(places, isA<List<Place>>());
      expect(places.length, 3); // Assuming limit is 3
    });

    test('fetchPopularPlaces returns a list of Places', () async {
      final controller = PlacesController();
      final places = await controller.fetchPopularPlaces();

      expect(places, isA<List<Place>>());
      expect(places.length, 3); // Assuming limit is 3
    });
  });
}
