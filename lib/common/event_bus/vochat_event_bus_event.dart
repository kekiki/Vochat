import '../../services/models/vochat_call_settlement_model.dart';
import '../../services/models/vochat_chat_message_model.dart';

/// chat message
class VochatChatMessageEvent {
  VochatChatMessageModel data;

  VochatChatMessageEvent(this.data);
}

/// refresh home anchors
class VochatAnchorsRefreshEvent {}

/// anchor online status changed event
class VochatAnchorStatusChangedEvent {
  final int anchorId;
  final int online;

  VochatAnchorStatusChangedEvent({
    required this.anchorId,
    required this.online,
  });
}

/// refresh follow anchors
class VochatFollowRefreshEvent {}

/// call begin
class VochatCallBeginEvent {}

/// remote anchor refuse call event
class VochatAnchorsRefuseCallEvent {}

/// remote anchor refuse call event
class VochatCallSettlementEvent {
  VochatCallSettlementModel data;
  VochatCallSettlementEvent(this.data);
}

/// moment post succeed event
class VochatMomentPostSucceedEvent {}

/// current area changed event
class VochatCurrentAreaChangedEvent {}
