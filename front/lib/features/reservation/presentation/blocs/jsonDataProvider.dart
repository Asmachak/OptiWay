import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/user/data/data_sources/local_data_source.dart';
import 'package:get_it/get_it.dart';

final reservationParkingDataProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {
    "idparking": "",
    "CreatedAt": "",
    "EndedAt": "",
    "iduser": GetIt.instance.get<AuthLocalDataSource>().currentUser!.id!,
    "idvehicule": "",
    "tarif": "",
    "parking": "",
    "idevent": "",
    "Nbreticket": 1,
  };
});

final reservationEventDataProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {
    "idevent": "",
    "idparking": "",
    "EndedAt": "",
    "iduser": GetIt.instance.get<AuthLocalDataSource>().currentUser!.id!,
    "idvehicule": "",
    "Nbreticket": 1,
    "parking": "",
    "CreatedAt": ""
  };
});

// Function to reset the providers
void resetReservationProviders(WidgetRef ref) {
  ref.read(reservationParkingDataProvider.notifier).state = {
    "idparking": "",
    "CreatedAt": "",
    "EndedAt": "",
    "iduser": GetIt.instance.get<AuthLocalDataSource>().currentUser!.id!,
    "idvehicule": "",
    "tarif": "",
    "parking": "",
    "idevent": "",
    "Nbreticket": 1,
  };

  ref.read(reservationEventDataProvider.notifier).state = {
    "idevent": "",
    "idparking": "",
    "EndedAt": "",
    "iduser": GetIt.instance.get<AuthLocalDataSource>().currentUser!.id!,
    "idvehicule": "",
    "Nbreticket": 1,
    "parking": "",
    "CreatedAt": ""
  };
}
