import 'package:front/features/vehicule/data/models/vehicule_model.dart';
import 'package:hive/hive.dart';

class VehiculeLocalDataSource {
  late Box<VehiculeModel> _vehiculeBox;

  Future<void> initialize() async {
    _vehiculeBox = await Hive.openBox<VehiculeModel>('vehicules');
  }

  Future<void> addVehicule(VehiculeModel vehicule) async {
    await _vehiculeBox.add(vehicule);
  }

  Future<List<VehiculeModel>> getAllVehicules() async {
    return _vehiculeBox.values.toList();
  }

  Future<void> updateVehicule(VehiculeModel updatedVehicule) async {
    await _vehiculeBox.delete(updatedVehicule.id);
    await _vehiculeBox.put(updatedVehicule.id, updatedVehicule);
  }

  Future<void> deleteVehicule(String id) async {
    await _vehiculeBox.delete(id);
  }

  Future<void> closeBox() async {
    await _vehiculeBox.close();
  }

  Future<void> voidVehiculeBox() async {
    await _vehiculeBox.clear(); // Clears all entries from the box
  }
}
