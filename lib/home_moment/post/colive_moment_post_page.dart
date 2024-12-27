import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/generated/assets.dart';

import '../../services/static/colive_colors.dart';
import '../../services/static/colive_styles.dart';
import '../../services/widgets/colive_app_bar.dart';
import '../../services/widgets/colive_app_scaffold.dart';
import 'colive_moment_post_controller.dart';
import 'colive_moment_post_state.dart';

class ColiveMomentPostPage extends GetView<ColiveMomentPostController> {
  const ColiveMomentPostPage({super.key});

  ColiveMomentPostState get state => controller.state;

  @override
  Widget build(BuildContext context) {
    return ColiveAppScaffold(
      appBar: ColiveAppBar(
        center: Text(
          'colive_post'.tr,
          style: ColiveStyles.title18w700,
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: AlignmentDirectional.centerStart,
              margin: EdgeInsets.symmetric(vertical: 12.pt, horizontal: 15.pt),
              padding: EdgeInsets.symmetric(horizontal: 16.pt),
              height: 160.pt,
              decoration: BoxDecoration(
                color: rgba(120, 136, 255, 0.05),
                borderRadius: BorderRadius.circular(16.pt),
              ),
              child: TextField(
                controller: controller.editingController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'colive_post_placeholder'.tr,
                  hintStyle: TextStyle(color: rgba(0, 0, 0, 0.3)),
                ),
                cursorColor: ColiveColors.primaryColor,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                style: TextStyle(
                  color: rgba(0, 0, 0, 1),
                  fontSize: 14.pt,
                ),
                maxLines: null,
                expands: true,
                autofocus: true,
                inputFormatters: [LengthLimitingTextInputFormatter(2000)],
                onChanged: (value) {
                  state.lengthObs.value = value.length;
                },
              ),
            ),
            Obx(() {
              final text = '(${state.lengthObs.value}/2000)';
              return Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15.pt),
                child: Text(
                  text,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: rgba(51, 51, 51, 0.77),
                    fontSize: 12.pt,
                  ),
                ),
              );
            }),
            SizedBox(height: 12.pt),
            Obx(() {
              final imageList = List.from(state.imageFileListObs);
              final itemCount = imageList.length < state.maxImageCount
                  ? imageList.length + 1
                  : imageList.length;
              return GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 15.pt),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 14.pt,
                  crossAxisSpacing: 13.pt,
                ),
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  if (index < imageList.length) {
                    final XFile file = imageList[index];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8.pt),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.file(
                            File(file.path),
                            fit: BoxFit.cover,
                          ),
                          PositionedDirectional(
                            top: 0,
                            end: 0,
                            child: GestureDetector(
                              onTap: () => controller.onTapDeleteImage(index),
                              child: Container(
                                width: 32.pt,
                                height: 32.pt,
                                padding: EdgeInsets.all(8.pt),
                                child: Image.asset(
                                  Assets.imagesColiveMomentImageDelete,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return GestureDetector(
                    onTap: controller.onTapAddImage,
                    child: Image.asset(
                      Assets.imagesColiveMomentImageAdd,
                    ),
                  );
                },
              );
            }),
            SizedBox(height: 24.pt),
            GestureDetector(
              onTap: controller.onTapPost,
              child: Obx(
                () => Container(
                  height: 50.pt,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 15.pt),
                  decoration: BoxDecoration(
                    color: state.isButtonEnableObs.value
                        ? ColiveColors.buttonNormalColor
                        : ColiveColors.buttonDisableColor,
                    borderRadius: BorderRadius.circular(25.pt),
                  ),
                  child: Text(
                    'colive_post'.tr,
                    style:
                        ColiveStyles.title16w700.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.pt),
          ],
        ),
      ),
    );
  }
}
