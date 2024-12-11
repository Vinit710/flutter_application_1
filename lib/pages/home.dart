import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? faceImage;
  File? poseImage;
  String? generatedImageUrl;
  final String apiUrl = 'https://backend-ps.onrender.com/generate-image'; // Replace with your actual Render URL

  // Function to pick images (face or pose)
  Future<void> pickImage(bool isFaceImage) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        if (isFaceImage) {
          faceImage = File(pickedFile.path);
        } else {
          poseImage = File(pickedFile.path);
        }
      });
    }
  }

  // Function to generate image
  Future<void> generateImage() async {
  if (faceImage == null || poseImage == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please select both face and pose images')),
    );
    return;
  }

  try {
    var uri = Uri.parse(apiUrl);
    
    var request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('face_image', faceImage!.path));
    request.files.add(await http.MultipartFile.fromPath('pose_image', poseImage!.path));

    request.fields['prompt'] = "a man doing a silly pose wearing a suit";
    // ... other fields

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      setState(() {
        generatedImageUrl = decodedResponse['generatedImageUrl'];
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to generate image. Status: ${response.statusCode}')),
      );
    }
  } catch (e) {
    print('Generation Error: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('InstantID Image Generation')),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Face Image Picker
            ElevatedButton(
              onPressed: () => pickImage(true),
              child: Text('Pick Face Image'),
            ),
            faceImage != null
                ? Image.file(faceImage!, height: 150, width: 150)
                : Container(),

            // Pose Image Picker
            ElevatedButton(
              onPressed: () => pickImage(false),
              child: Text('Pick Pose Image'),
            ),
            poseImage != null
                ? Image.file(poseImage!, height: 150, width: 150)
                : Container(),

            // Generate Image Button
            ElevatedButton(
              onPressed: generateImage,
              child: Text('Generate Image'),
            ),

            // Display Generated Image
            generatedImageUrl != null
                ? Image.network(generatedImageUrl!)
                : Container(),
          ],
        ),
      ),
    );
  }
}
