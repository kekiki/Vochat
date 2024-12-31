import '../common/widgets/vochat_base_controller.dart';
import 'vochat_bottom_tab_state.dart';

class VochatBottomTabController extends VochatBaseController {
  final state = VochatBottomTabState();

  void onTapTabItem(VochatBottomTabType tabType) async {
    state.selectedTabTypeObs.value = tabType;
  }
}
