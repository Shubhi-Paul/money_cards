import 'package:hive/hive.dart';

Future<List<String>> getSavedData() async {
  var box = await Hive.openBox<String>('contactDetails');
  // reveresed to get latest contacts first
  return box.values.toList().reversed.toList();
}

Future<void> saveData(String? data) async {
  if (data != null) {
    var box = await Hive.openBox<String>('contactDetails');
    await box.add(data);
  }
}

Future<void> clearData() async {
  var box = await Hive.openBox<String>('contactDetails');
  await box.clear();
}