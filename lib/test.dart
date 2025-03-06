import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GoogleVisionScreen extends StatefulWidget {
  @override
  _GoogleVisionScreenState createState() => _GoogleVisionScreenState();
}

class _GoogleVisionScreenState extends State<GoogleVisionScreen> {
  File? _selectedImage;
  String? _responseText;
  bool _isLoading = false;

  final ImagePicker _picker = ImagePicker();
  final String _apiKey = 'YOUR_GOOGLE_VISION_API_KEY'; // Replace with your API key

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _responseText = null; // Reset response when a new image is picked
      });
    }
  }

  Future<void> _sendImageToGoogleVision() async {
    if (_selectedImage == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final imageBytes = _selectedImage!.readAsBytesSync();
      final base64Image = base64Encode(imageBytes);

      final dio = Dio();
      final response = await dio.post(
        'https://vision.googleapis.com/v1/images:annotate?key=$_apiKey',
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: {
          "requests": [
            {
              "image": {"content": base64Image},
              "features": [{"type": "TEXT_DETECTION", "maxResults": 10}]
            }
          ]
        },
      );

      setState(() {
        _responseText = jsonEncode(response.data);
      });
    } catch (e) {
      setState(() {
        _responseText = "Error: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Vision API"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Animate(
              effects: [FadeEffect(), ScaleEffect()],
              child: _selectedImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.file(
                        _selectedImage!,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text("No Image Selected"),
                      ),
                    ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.camera),
                  icon: Icon(Icons.camera_alt),
                  label: Text("Camera"),
                ),
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  icon: Icon(Icons.photo),
                  label: Text("Gallery"),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _selectedImage != null && !_isLoading
                  ? _sendImageToGoogleVision
                  : null,
              child: _isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text("Analyze Image"),
            ),
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Animate(
                  effects: [FadeEffect(duration: 500.ms)],
                  child: _responseText != null
                      ? Text(
                          "Response: $_responseText",
                          style: TextStyle(fontSize: 14),
                        )
                      : Text("Response will appear here.",
                          style: TextStyle(fontSize: 14)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
