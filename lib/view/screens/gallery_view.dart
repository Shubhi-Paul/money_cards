import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_cards/constants/colors.dart';
import 'package:money_cards/view/screens/hive_utils.dart';
import 'package:google_mlkit_entity_extraction/google_mlkit_entity_extraction.dart';
import 'utils.dart';

class GalleryView extends StatefulWidget {
  GalleryView({
    Key? key,
    // required this.title,
    this.text,
    this.entities,
    required this.onImage,
    // required this.onDetectorViewModeChanged
  }) : super(key: key);

  // final String title;
  final String? text;
  final List<EntityAnnotation>? entities;
  final Function(InputImage inputImage) onImage;
  // final Function()? onDetectorViewModeChanged;

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  File? _image;
  String? _path;
  ImagePicker? _imagePicker;

  @override
  void initState() {
    super.initState();

    _imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, children: [
      _image != null
          ? SizedBox(
              height: 400,
              width: 400,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.file(_image!),
                ],
              ),
            )
          : Icon(
              Icons.image,
              size: 200,
            ),
      if (_image != null)
        ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.entities!.length,
          itemBuilder: (context, index) =>
              ExpansionTile(title: Text(widget.entities![index].text), children: widget.entities![index].entities.map((e) => Text(e.toString())).toList()),
        ),
      if (_image != null)
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            '${_path == null ? '' : 'Image path: $_path'}\n\n${widget.text ?? ''}',
            style: TextStyle(color: textLight),
          ),
        ),
      if (_image != null)
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ElevatedButton(
            onPressed: () => saveData(widget.text),
            child: Text('Save to hive'),
          ),
        ),
      if (_image != null)
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _image = null;
                _path = "";
              });
            },
            child: Text('Retake'),
          ),
        ),
      if (_image == null)
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () => _getImageAsset(context),
                child: Text('From Assets'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                child: Text('From Gallery'),
                onPressed: () => _getImage(ImageSource.gallery),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                child: Text('Take a picture'),
                onPressed: () => _getImage(ImageSource.camera),
              ),
            ),
          ],
        ),
    ]);
  }

  Future _getImage(ImageSource source) async {
    setState(() {
      _image = null;
      _path = null;
    });
    final pickedFile = await _imagePicker?.pickImage(source: source);
    if (pickedFile != null) {
      _processFile(pickedFile.path);
    }
  }

  Future _getImageAsset(BuildContext context) async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final assets = manifestMap.keys
        .where((String key) => key.contains('assets/'))
        .where((String key) => key.contains('.jpg') || key.contains('.jpeg') || key.contains('.png') || key.contains('.webp'))
        .toList();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: bgLight,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select image',
                    style: TextStyle(fontSize: 20, color: textLight),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          for (final path in assets)
                            GestureDetector(
                              onTap: () async {
                                Navigator.of(context).pop();
                                _processFile(await getAssetPath(path));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(path),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: Text('Cancel')),
                ],
              ),
            ),
          );
        });
  }

  Future _processFile(String path) async {
    setState(() {
      _image = File(path);
    });
    _path = path;
    final inputImage = InputImage.fromFilePath(path);
    widget.onImage(inputImage);
  }
}
