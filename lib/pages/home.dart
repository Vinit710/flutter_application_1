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
  final String apiUrl = 'https://instantx-instantid.hf.space/run/generate_image'; // Update with the actual endpoint

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

  Future<void> generateImage() async {
    if (faceImage == null || poseImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select both images')),
      );
      return;
    }

    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      // Attach images
      request.files.add(await http.MultipartFile.fromPath('face_image_path', faceImage!.path));
      request.files.add(await http.MultipartFile.fromPath('pose_image_path', poseImage!.path));

      // Add other parameters (customize as needed)
      request.fields['prompt'] = "Hello!!";
      request.fields['negative_prompt'] = "(lowres, low quality)";
      request.fields['style_name'] = "(No style)";
      request.fields['num_steps'] = '30';
      request.fields['identitynet_strength_ratio'] = '0.8';
      request.fields['guidance_scale'] = '5';
      request.fields['enable_LCM'] = 'true';

      var response = await request.send();

      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        final decodedResponse = jsonDecode(respStr);

        setState(() {
          generatedImageUrl = decodedResponse['data'][0];
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
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
