import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ImageGenerationPage extends StatefulWidget {
  @override
  _ImageGenerationPageState createState() => _ImageGenerationPageState();
}

class _ImageGenerationPageState extends State<ImageGenerationPage> {
  File? faceImage;
  File? poseImage;
  String? generatedImageUrl;
  final String apiUrl = 'https://backend-ps.onrender.com/generate-image';
  bool isLoading = false;

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
        SnackBar(
          content: Text('Please select both face and pose images'),
          backgroundColor: Colors.red,
        ),
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

        String? imageUrl = decodedResponse['generatedImageUrl']?['url'];

        if (imageUrl != null) {
          setState(() {
            generatedImageUrl = imageUrl;
          });
        } else {
          print('Available keys: ${decodedResponse.keys}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Image URL not found in the response'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to generate image. Status: ${response.statusCode}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('Generation Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
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
      backgroundColor: const Color(0xFF0C081E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'InstantID Image Generation',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'poppins',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildImagePickerButton(true),
            const SizedBox(height: 16),
            _buildImageDisplay(faceImage),
            const SizedBox(height: 24),
            _buildImagePickerButton(false),
            const SizedBox(height: 16),
            _buildImageDisplay(poseImage),
            const SizedBox(height: 24),
            _buildGenerateButton(),
            const SizedBox(height: 24),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF8E37FE)),
                ),
              ),
            if (generatedImageUrl != null)
              _buildGeneratedImage(),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePickerButton(bool isFaceImage) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF8D37FE),
            const Color(0xFFFE37E0),
          ],
        ),
      ),
      child: ElevatedButton(
        onPressed: () => pickImage(isFaceImage),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          isFaceImage ? 'Pick Face Image' : 'Pick Pose Image',
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'poppins',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildImageDisplay(File? image) {
    return AspectRatio(
      aspectRatio: 1, // This will create a square container
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              const Color(0xFF8D37FE).withOpacity(0.2),
              const Color(0xFFFE37E0).withOpacity(0.2),
            ],
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: image != null
              ? Image.file(
                  image,
                  fit: BoxFit.contain, // This ensures the full image is shown
                )
              : const Center(
                  child: Icon(
                    Icons.image,
                    color: Colors.white54,
                    size: 50,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildGenerateButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF8D37FE),
            const Color(0xFFFE37E0),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFA5B9FF).withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: generateImage,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: const Text(
          'Generate Image',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'poppins',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildGeneratedImage() {
    return AspectRatio(
      aspectRatio: 16 / 9, // Adjust this ratio as needed
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFA5B9FF).withOpacity(0.3),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            generatedImageUrl!,
            fit: BoxFit.contain, // This ensures the full image is shown
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                      : null,
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF8E37FE)),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

