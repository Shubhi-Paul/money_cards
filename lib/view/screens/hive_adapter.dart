import 'package:hive/hive.dart';


class HiveAdapter extends TypeAdapter<String> {
  @override
  final typeId = 0;

  @override
  String read(BinaryReader reader) {
    return  reader.readString();
  }

  @override
  void write(BinaryWriter writer, String data) {
    writer.writeString(data);
  }
}