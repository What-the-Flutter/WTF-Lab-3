import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:firebase_database/firebase_database.dart';

extension SnapshotExtension on DataSnapshot {
  IList<E> toModels<E>(E Function(Map<String, Object?> modelMap) transformer) {
    if (!exists) {
      return IList([]);
    }

    final uncertainMap = value as Map<dynamic, dynamic>;

    final listOfMaps = uncertainMap.mapTo((key, value) => value).toIList();

    var firebaseModels = IList<E>();
    for (Map<dynamic, dynamic> map in listOfMaps) {
      final modelMap = map.map(
        (key, value) => MapEntry(
          key as String,
          value as Object?,
        ),
      );
      firebaseModels = firebaseModels.add(
        transformer(modelMap),
      );
    }
    return firebaseModels;
  }
}
