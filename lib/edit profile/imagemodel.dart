// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:get/get.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';


// class ImageModelPage extends ChangeNotifier {
//   String? _selectedImagePath;
//   String? get selectedImagePath => _selectedImagePath;

//   String? _selectedImageSize;
//   String? get selectedImageSize => _selectedImageSize;

//   // Crop code
//   String? _cropImagePath;
//   String? get cropImagePath => _cropImagePath;

//   String? _cropImageSize;
//   String? get cropImageSize => _cropImageSize;

//   // Compress code
//   late File _compressImagePath;
//   File get compressImagePath => _compressImagePath;

//   String? _compressImageSize;
//   String? get compressImageSize => _compressImageSize;

//   late File _image;
// File  get image=> _image;
//   var imageName;
//   void getImage(ImageSource imageSource) async {
//    // print('vinay ');
//     final pickedFile = await ImagePicker().pickImage(source: imageSource);
//     if (pickedFile != null) {
//       _selectedImagePath = pickedFile.path;
//       _selectedImageSize = ((File(selectedImagePath!)).lengthSync() / 1024 / 1024).toStringAsFixed(2) + " Mb";
//       notifyListeners();
//      // print('vinay $selectedImagePath');
//      // print('vinay $selectedImageSize');
//       // Crop
//       final cropImageFile = await ImageCropper.cropImage(
//           sourcePath: selectedImagePath as String,
//           maxWidth: 512,
//           maxHeight: 512,
//           compressFormat: ImageCompressFormat.jpg);
//       _cropImagePath = cropImageFile!.path;
//       _cropImageSize = ((File(cropImagePath!)).lengthSync() / 1024 / 1024).toStringAsFixed(2) + " Mb";
//       notifyListeners();
//      // print('vinay crop $cropImagePath');
//      // print('vinay crop $cropImageSize');

//       // Compress
//       //  final dir = await getApplicationDocumentsDirectory();
//       //  final name = basename(image.path);
//       //  final image1 = File('${dir.path}/$name');
//        final dir =  Directory.systemTemp;
//        final targetPath = dir.absolute.path + "temp.jpg";
//     //  final targetPath = File(cropImagePath).copy(image1.path);
//       var compressedFile = await FlutterImageCompress.compressAndGetFile(cropImagePath!, targetPath, quality: 90);
//       _compressImagePath = compressedFile!;
//       _compressImageSize = (compressImagePath.lengthSync() / 1024 / 1024).toStringAsFixed(2) + " Mb";
//      // print('vinay compress $compressImagePath');
//      // print('vinay compress $compressImageSize');
//      _image  = compressImagePath ;
//       notifyListeners();
//      // print('selecte imagessss $image');
//       imageName = image.path.split('/').last;
//      // print('vinay imagename $imageName');
//       // uploadImage(compressedFile);
//     } else {
//       Get.back();
//       Get.snackbar('Error', 'No image selected',
//           snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
//     }
//   }

//   // void uploadImage(File file) {
//   //   Get.dialog(Center(child: CircularProgressIndicator(),),
//   //     barrierDismissible: false,);
//   //   ImageUploadProvider().uploadImage(file).then((resp) {
//   //     Get.back();
//   //     if (resp == "success") {
//   //       Get.snackbar('Success', 'File Uploaded',
//   //           snackPosition: SnackPosition.BOTTOM,
//   //           backgroundColor: Colors.green,
//   //           colorText: Colors.white);
//   //     } else if (resp == "fail") {
//   //       Get.snackbar('Error', 'File upload failed',
//   //           snackPosition: SnackPosition.BOTTOM,
//   //           backgroundColor: Colors.red,
//   //           colorText: Colors.white);
//   //     }
//   //   }, onError: (err) {
//   //     Get.back();
//   //     Get.snackbar('Error', 'File upload failed',
//   //         snackPosition: SnackPosition.BOTTOM,
//   //         backgroundColor: Colors.red,
//   //         colorText: Colors.white);
//   //   });
//   // }
// }
//   // Future<File> saveImagePermanently(String imagePath) async {
//   //   final direcotry = await getApplicationDocumentsDirectory();
//   //   final name = basename(imagePath);
//   //   final image1 = File('${direcotry.path}/$name');
//   //    final targetPath =image1.path;
//   //    var compressedFile = await FlutterImageCompress.compressAndGetFile(image!.path, targetPath, quality: 90);
//   //  // print('vkggg $compressedFile');
//   //   //// print('comprees size ${(compressedFile.lengthSync() / 1024 / 1024).toStringAsFixed(2) + " Mb"}');
//   //   notifyListeners();
//   //   // return File(imagePath).copy(compressedFile.path);
//   //   return File(imagePath).copy(compressedFile.path);
//   // }
