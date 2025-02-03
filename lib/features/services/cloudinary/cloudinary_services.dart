import 'package:cloudinary/cloudinary.dart';
import 'package:whatsapp_clone_practice/features/app/const/app_const.dart';
class CloudinaryServices{
  String api = "584294984614684";
  String apisecret = "FwYcTKLFgZdy_9o76CKRck891nU";
  String cloudName = "dakek9qgq";

  late final Cloudinary cloudinary;

  CloudinaryServices() {
    cloudinary = Cloudinary.signedConfig(
      apiKey: api,
      apiSecret: apisecret,
      cloudName: cloudName,
    );
  }

   Future<String?> uploadImage({required String filePath,required String folderName}) async {
    try {
      final response = await cloudinary.upload(
        file: filePath,
        resourceType: CloudinaryResourceType.image,
        folder: folderName, // Specify the folder
      );

      if (response.isSuccessful) {
        return response.secureUrl; // URL of the uploaded image
      } else {
        print('Failed to upload: ${response.error}');
        return null;
      }
    } catch (e) {
      print('Error uploading to Cloudinary: $e');
      toast(message: "Error uploading photo");
      return null;
    }
  }
  Future<bool> deleteImage({required String publicId}) async {
    try {
      final response = await cloudinary.destroy(publicId);

      if (response.isSuccessful) {
        print('Image deleted successfully');
        return true;
      } else {
        print('Failed to delete image: ${response.error}');
        return false;
      }
    } catch (e) {
      print('Error deleting image: $e');
      return false;
    }
  }
}
