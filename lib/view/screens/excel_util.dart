import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:excel/excel.dart';
import 'package:path/path.dart';
import 'dart:io';

class FileAndExcelUtility {
  final excel = Excel.createExcel();
  late Sheet sheet;

  FileAndExcelUtility() {
    sheet = excel[excel.getDefaultSheet()!];
  }

  Future<void> createDirectory() async {
    try {
      var appDocDirectory = await getApplicationDocumentsDirectory();
      var newDir = Directory('${appDocDirectory.path}/dir');
      await newDir.create(recursive: true);
      print('Path of New Dir: ${newDir.path}');
    } catch (e) {
      print('Error creating directory: $e');
    }
  }

  void shareFile() async {
    try {
      var directory = await getApplicationDocumentsDirectory();
      var savePath = '${directory.path}/dir/MyContacts.xlsx';

      if (await File(savePath).exists()) {
        Share.shareFiles([savePath], text: 'Tasks Excel File');
        print("File shared");
      } else {
        print("File not found at location: $savePath");
      }
    } catch (e) {
      print("Error sharing file: $e");
    }
  }

  Future<void> saveToExcel(List<String> contacts) async {
    for (var i = 0; i < contacts.length; i++) {
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1)).value = contacts[i];
    }

    try {
      var fileBytes = excel.encode();
      var directory = await getApplicationDocumentsDirectory();
      var savePath = '${directory.path}/dir/MyContacts.xlsx';

      File(savePath)
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes!);
      
      print("Excel file created at $savePath");
    } catch (e) {
      print("Error creating Excel file: $e");
    }
  }
}
