import 'package:flutter/material.dart';
import 'package:money_cards/view/screens/saved_data.dart';
import 'package:money_cards/view/screens/text_extractor.dart';
// import 'package:money_cards/view/widgets/business_card.dart';
import 'package:money_cards/constants/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Text Extractor"),
      ),
      backgroundColor: bgDark,
      // appBar: AppBar(),
      body: 
      // GestureDetector(
      //   onTap: () {
      //     FocusScope.of(context).requestFocus(FocusNode());
      //   },
      //   child: 
      SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Container(
                //   padding: EdgeInsets.all(12),
                //   decoration: const BoxDecoration(
                //     color: bgDark,
                //     borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.black38,
                //         offset: Offset(
                //           3.0,
                //           2.0,
                //         ),
                //         blurRadius: 3.0,
                //         spreadRadius: 2.0,
                //       ),
                //     ],
                //   ),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Container(
                //           height: 40,
                //           padding: EdgeInsets.all(8),
                //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(32), color: bgMid, border: Border.all(color: Colors.grey)),
                //           child: TextField(
                //             // onChanged: ,
                //             // controller: ,
                //             decoration: InputDecoration(
                //               contentPadding: EdgeInsets.all(8),
                //               prefixIcon: Container(margin: EdgeInsets.symmetric(horizontal: 8), child: Icon(Icons.search)),
                //               prefixIconConstraints: BoxConstraints(
                //                 maxHeight: 25,
                //                 minWidth: 20,
                //               ),
                //               prefixIconColor: Colors.grey[400],
                //               alignLabelWithHint: true,
                //               border: InputBorder.none,
                //               hintText: 'Search',
                //               hintStyle: TextStyle(color: Colors.grey),
                //             ),
                //           ),
                //         ),
                //       ),
                //       Container(
                //           margin: EdgeInsets.symmetric(horizontal: 8),
                //           child: Icon(
                //             Icons.menu,
                //             color: bgLighter,
                //           ))
                //     ],
                //   ),
                // ),
                // Expanded(
                //   child: ListView.builder(
                //     shrinkWrap: true,
                //     scrollDirection: Axis.vertical,
                //     itemCount: 3,
                //     itemBuilder: (context, index) {
                //       return BusinessCard();
                //     },
                //   ),
                // ),
                Icon(Icons.image,color: bgLight,size: 200,),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TextRecognizerView()));
                  },
                  child: Container(
                    width: 200,
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(color: bgLight, borderRadius: BorderRadius.circular(24)),
                    child: Text(
                      "Detect Text",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: textLight),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SavedDataPage()));
                  },
                  child: Container(
                    width: 200,
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(color: bgLight, borderRadius: BorderRadius.circular(24)),
                    child: Text(
                      "Check Saved Data",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: textLight),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    // );
  }
}
