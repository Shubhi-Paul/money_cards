import 'package:flutter/material.dart';
import 'package:money_cards/constants/colors.dart';
import 'package:money_cards/view/screens/excel_util.dart';
import 'package:money_cards/view/screens/hive_utils.dart';

class SavedDataPage extends StatefulWidget {
  const SavedDataPage({super.key});

  @override
  State<SavedDataPage> createState() => _SavedDataPageState();
}

class _SavedDataPageState extends State<SavedDataPage> {
  List<String> savedData = [];
  final FileAndExcelUtility fileAndExcelUtility = FileAndExcelUtility();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    List<String> data = await getSavedData();
    setState(() {
      savedData = data;
    });
  }

Future<void> _performShare() async {
  await fileAndExcelUtility.createDirectory();
  await fileAndExcelUtility.saveToExcel(savedData);
  fileAndExcelUtility.shareFile();
  // fileAndExcelUtility.shareFile(); 
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgDark,
      appBar: AppBar(
        title: Text(
          "Saved Data",
          style: TextStyle(color: textDark),
        ),
        backgroundColor: bgLight,
        actions: [
          IconButton(icon: Icon(Icons.clear_all),onPressed: (){clearData();
          setState(() {
            savedData = [];
          });}),
          IconButton(onPressed: _performShare,
          icon: Icon(Icons.share))

        ],
      ),
      body: (!savedData.isEmpty)
          ? ListView.builder(
              itemCount: savedData.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: bgLighter),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Text(
                    savedData[index],
                    style: TextStyle(color: textDark),
                  ),
                );
              },
            )
          : Center(
              child: Text(
                "Box is empty",
                style: TextStyle(color: textDark),
              ),
            ),
    );
  }
}
