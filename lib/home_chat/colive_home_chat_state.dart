import 'package:get/get.dart';

import '../services/models/colive_chat_conversation_model.dart';
import '../services/models/colive_system_message_model.dart';

class ColiveHomeChatState {
  final conversationList = RxList<ColiveChatConversationModel>();
  final systemMessageModelObs = Rxn<ColiveSystemMessageModel>();
}
