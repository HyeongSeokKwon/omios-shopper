import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageController extends GetxController {
  PickedFile? upLoadimage;
  void getImageFromPhoto() async {
    var image = await ImagePicker.platform
        .pickImage(source: ImageSource.camera, imageQuality: 50);

    upLoadimage = image;
    update();
  }

  void getImageFromGallery() async {
    var image =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);

    upLoadimage = image;
    update();
  }
}
