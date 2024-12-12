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
  bool isLoading = false; // For showing loading indicator

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
      const SnackBar(content: Text('Please select both face and pose images')),
    );
    return;
  }

  setState(() {
    isLoading = true;
    generatedImageUrl = null;
  });

  try {
    var uri = Uri.parse(apiUrl);
    var request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('face_image', faceImage!.path));
    request.files.add(await http.MultipartFile.fromPath('pose_image', poseImage!.path));
    request.fields['prompt'] = "a man doing a silly pose wearing a suit";

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      print('Decoded Response: $decodedResponse');

      // Extract the image URL
      String? imageUrl = decodedResponse['generatedImageUrl']?['url'];

      if (imageUrl != null) {
        setState(() {
          generatedImageUrl = imageUrl;
        });
      } else {
        print('Available keys: ${decodedResponse.keys}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Image URL not found in the response')),
        );
      }
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
  } finally {
    setState(() {
      isLoading = false;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('InstantID Image Generation')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Face Image Picker
            ElevatedButton(
              onPressed: () => pickImage(true),
              child: const Text('Pick Face Image'),
            ),
            faceImage != null
                ? Image.file(faceImage!, height: 150, width: 150, fit: BoxFit.cover)
                : const Placeholder(fallbackHeight: 150, fallbackWidth: 150),

            const SizedBox(height: 16),

            // Pose Image Picker
            ElevatedButton(
              onPressed: () => pickImage(false),
              child: const Text('Pick Pose Image'),
            ),
            poseImage != null
                ? Image.file(poseImage!, height: 150, width: 150, fit: BoxFit.cover)
                : const Placeholder(fallbackHeight: 150, fallbackWidth: 150),

            const SizedBox(height: 16),

            // Generate Image Button
            ElevatedButton(
              onPressed: generateImage,
              child: const Text('Generate Image'),
            ),

            const SizedBox(height: 16),

            // Loading Indicator
            if (isLoading) const CircularProgressIndicator(),

            // Display Generated Image
            if (generatedImageUrl != null)
              Image.network(generatedImageUrl!, height: 300, fit: BoxFit.cover),
          ],
        ),
      ),
    );
  }
}
