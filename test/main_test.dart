import 'package:flutter_test/flutter_test.dart';
import 'controllers/controllers_test.dart';
import 'widgets/governorate_list_tile_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  //tests GovernorateController and PlacesController
  controllersTest();
  //tests Governorate List Tile Widget functions
  governorateListTileTest();
}
