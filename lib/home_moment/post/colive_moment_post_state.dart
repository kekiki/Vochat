import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ColiveMomentPostState {
  int get maxImageCount => 9;
  final lengthObs = 0.obs;
  final imageFileListObs = <XFile>[].obs;
  final isButtonEnableObs = false.obs;
}
