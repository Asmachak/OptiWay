import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/user/data/data_sources/local_data_source.dart';
import 'package:get_it/get_it.dart';

final jsonDataProvider = Provider<Map<String, dynamic>>((ref) {
  return {
    "idparking": "",
    "CreatedAt": null,
    "EndedAt": null,
    "iduser": GetIt.instance.get<AuthLocalDataSource>().currentUser!.id!,
    "idResEvent": null,
    "idvehicule": null,
    "parking": null,
    "vehicle": null,
    "amount": ""
  };
});

final reservationParkingDataProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {
    "idparking": "",
    "CreatedAt": null,
    "EndedAt": null,
    "iduser": GetIt.instance.get<AuthLocalDataSource>().currentUser!.id!,
    "idvehicule": null,
    "tarif": null
  };
});

final reservationEventDataProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {
    "idevent": "",
    "idparking": "",
    "EndedAt": null,
    "iduser": GetIt.instance.get<AuthLocalDataSource>().currentUser!.id!,
    "idvehicule": null,
    "Nbreticket": 1,
    "parking": null
  };
});
