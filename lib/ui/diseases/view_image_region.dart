import 'dart:async';
import 'dart:io';

import 'package:plantpulse/app_theme.dart';
import 'package:plantpulse/data/diseases/classifier.dart';
import 'package:plantpulse/data/diseases/disease_detection_model.dart';
import 'package:plantpulse/ui/diseases/diagnosis.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class ViewImageRegion extends StatefulWidget {
  const ViewImageRegion({required this.diagnosis});

  final Diagnosis diagnosis;

  @override
  _ViewImageRegionState createState() => _ViewImageRegionState();
}

class _ViewImageRegionState extends State<ViewImageRegion> {
  late XFile _image;
  File? plantImage;
  late dynamic _pickImageError;
  late Classifier _classifier;
  late var logger = Logger();
  late var _category;

  void _onImageButtonPressed(ImageSource source,
      {required BuildContext context}) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile == null) return;
      _image = pickedFile;
      final File _plantImage = File(_image.path);
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: _plantImage.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9,
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(minimumAspectRatio: 1.0),
        ],
      );
      if (croppedFile == null) return;

      plantImage = File(croppedFile.path);
      _predict(_plantImage);
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    //_classifier = DiseaseDetectionModel();
  }

  void _predict(File image) async {
    img.Image imageInput = img.decodeImage(image.readAsBytesSync())!;
     var prediction = _classifier.predict(imageInput);

     setState(() {
       this._category = prediction;
     });

    if (_category.score > 0.5) {
      Future.delayed(
        Duration.zero,
        () => widget.diagnosis.update(
            _category.label, (_category.score * 100).toStringAsFixed(2)),
      );
    } else {
      Future.delayed(
        Duration.zero,
        () => widget.diagnosis.update('Healthy', '0'),
      );
    }
  }

  void _cancelImage() {
    setState(() {
      plantImage = null;
    });
    Future.delayed(
      Duration.zero,
      () => widget.diagnosis.update('Disease', '0'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              height: 224.0,
              width: MediaQuery.of(context).size.width * .75,
              decoration: BoxDecoration(
                border: Border.all(color:AppTheme.appTheme.primaryColor, width: 1),
                borderRadius: BorderRadius.circular(18),
                color: Colors.white,
              ),
              child: Center(
                child: plantImage == null
                    ? Text(
                        'No image selected',
                        textAlign: TextAlign.center,
                        style: AppTheme.appTheme.textTheme.bodyMedium,
                      )
                    : Image.file(
                        plantImage!,
                        height: 224.0,
                        width: 225.0,
                        fit: BoxFit.fill,
                      ),
              ),
            ),
            Container(
              height: 90.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildButton(
                    Icon(Icons.add_a_photo_outlined),
                    () => _onImageButtonPressed(
                      ImageSource.camera,
                      context: context,
                    ),
                  ),
                  _buildButton(
                    Icon(Icons.image_outlined),
                    () => _onImageButtonPressed(
                      ImageSource.gallery,
                      context: context,
                    ),
                  ),
                  _buildButton(
                    Icon(Icons.image_not_supported_outlined),
                    () => _cancelImage(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(Icon icon, VoidCallback callback) {
    return ClipOval(
      child: Material(
        color: Colors.white,
        child: InkWell(
          splashColor: Colors.lightGreenAccent[100],
          child: SizedBox(
            width: 56,
            height: 56,
            child: icon,
          ),
          onTap: callback,
        ),
      ),
    );
  }
}
