import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:google_mlkit_entity_extraction/google_mlkit_entity_extraction.dart';
import 'package:money_cards/constants/colors.dart';
import 'package:money_cards/view/screens/gallery_view.dart';


class TextRecognizerView extends StatefulWidget {
  @override
  State<TextRecognizerView> createState() => _TextRecognizerViewState();
}

class _TextRecognizerViewState extends State<TextRecognizerView> {
  var _script = TextRecognitionScript.latin;
  var _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  bool _canProcess = true;
  bool _isBusy = false;
  String? _text;
   var _entities = <EntityAnnotation>[];
   final _entityExtractor =
      EntityExtractor(language: EntityExtractorLanguage.english);

  @override
  void dispose() async {
    _canProcess = false;
    _textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgDark,
      appBar: AppBar(
        backgroundColor: bgDark,
        title: Text("Text Detector",style: TextStyle(color: textMid),),
        actions: [
          Container(
              decoration: BoxDecoration(
                // color: Colors.black54,
                // borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: _buildDropdown(),
              )),
        ],
      ),
      body: GalleryView(
        text: _text,
        entities: _entities,
        onImage: _processImage,
      ),
    );
  }

  Widget _buildDropdown() => DropdownButton<TextRecognitionScript>(
        value: _script,
        icon: const Icon(Icons.arrow_downward,color: textMid,),
        elevation: 16,
        style: const TextStyle(color: textLight),
        underline: Container(
          height: 2,
          color: textDark,
        ),
        onChanged: (TextRecognitionScript? script) {
          if (script != null) {
            setState(() {
              _script = script;
              _textRecognizer.close();
              _textRecognizer = TextRecognizer(script: _script);
            });
          }
        },
        dropdownColor: bgDark,
        items: TextRecognitionScript.values.map<DropdownMenuItem<TextRecognitionScript>>((script) {
          return DropdownMenuItem<TextRecognitionScript>(
            value: script,
            child: Text(script.name),
          );
        }).toList(),
      );

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final recognizedText = await _textRecognizer.processImage(inputImage);
    _text = recognizedText.text;
    _extractEntities(recognizedText.text);
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _extractEntities(String text) async {
    FocusScope.of(context).unfocus();
    final result = await _entityExtractor.annotateText(text);
    setState(() {
      _entities = result;
    });
  }
}
