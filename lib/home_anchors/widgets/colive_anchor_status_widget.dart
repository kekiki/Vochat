// import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:colive/services/database/colive_database.dart';

import '../../common/adapts/colive_screen_adapt.dart';
import '../../services/static/colive_styles.dart';
import '../../services/models/colive_anchor_model.dart';

// class ColiveAnchorStatusWidget extends StatefulWidget {
//   final ColiveAnchorModel anchor;
//   const ColiveAnchorStatusWidget({
//     super.key,
//     required this.anchor,
//   });

//   @override
//   State<ColiveAnchorStatusWidget> createState() =>
//       _ColiveAnchorStatusWidgetState();
// }

// class _ColiveAnchorStatusWidgetState
//     extends State<ColiveAnchorStatusWidget> {
//   late ColiveAnchorModel anchor;
//   final List<StreamSubscription> _streams = [];
//   final anchorDao = Get.find<ColiveDatabase>().anchorDao;

//   @override
//   void initState() {
//     anchor = widget.anchor;
//     super.initState();
//     _setupListener();
//   }

//   @override
//   void dispose() {
//     _clear();
//     super.dispose();
//   }

//   @override
//   void didUpdateWidget(covariant ColiveAnchorStatusWidget oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     _setupListener();
//   }

//   void _setupListener() {
//     _clear();
//     _streams.add(
//         anchorDao.findAnchorByIdAsStream(widget.anchor.id).listen((anchorInfo) {
//       if (anchorInfo == null) return;
//       anchor = anchorInfo;
//       if (mounted) {
//         setState(() {});
//       }
//     }));
//   }

//   void _clear() {
//     for (var stream in _streams) {
//       stream.cancel();
//     }
//     _streams.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return UnconstrainedBox(
//       child: Container(
//         height: 20.pt,
//         padding: EdgeInsets.symmetric(horizontal: 4.pt),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10.pt),
//           color: Colors.black.withOpacity(0.6),
//         ),
//         child: Row(
//           children: [
//             Container(
//               width: 6.pt,
//               height: 6.pt,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(3.pt),
//                 color: anchor.statusColor,
//               ),
//             ),
//             SizedBox(width: 2.pt),
//             Text(
//               anchor.statusText,
//               style: ColiveStyles.body10w400.copyWith(
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class ColiveAnchorStatusWidget extends StatelessWidget {
  final ColiveAnchorModel anchor;
  const ColiveAnchorStatusWidget({
    super.key,
    required this.anchor,
  });

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        height: 20.pt,
        padding: EdgeInsets.symmetric(horizontal: 6.pt),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.pt),
          color: Colors.black.withOpacity(0.5),
        ),
        child: Row(
          children: [
            Container(
              width: 6.pt,
              height: 6.pt,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.pt),
                color: anchor.statusColor,
              ),
            ),
            SizedBox(width: 2.pt),
            Text(
              anchor.statusText,
              style: ColiveStyles.body10w400.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
