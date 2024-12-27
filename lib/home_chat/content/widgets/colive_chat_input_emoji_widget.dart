import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:sprintf/sprintf.dart';

class ColiveChatInputEmojiWidget extends StatelessWidget {
  const ColiveChatInputEmojiWidget({
    super.key,
    required this.emojiList,
    required this.onTapSendEmoji,
  });

  final List<Map<String, dynamic>> emojiList;
  final ValueChanged<Map<String, dynamic>> onTapSendEmoji;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280.pt,
      width: ColiveScreenAdapt.screenWidth,
      color: Colors.white,
      child: GridView.builder(
        padding: EdgeInsets.all(14.pt),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
        ),
        itemCount: emojiList.length,
        itemBuilder: (context, index) {
          final String path =
              sprintf('assets/emoji/expression_%d.gif', [index + 1]);
          return InkWell(
            onTap: () => onTapSendEmoji(emojiList[index]),
            child: Transform.scale(
              scale: 0.8,
              child: GifView.asset(
                path,
                frameRate: 5,
              ),
            ),
          );
        },
      ),
    );
  }
}
