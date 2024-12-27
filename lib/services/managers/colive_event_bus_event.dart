import '../models/colive_call_settlement_model.dart';
import '../models/colive_chat_message_model.dart';

/// chat message
class ColiveChatMessageEvent {
  ColiveChatMessageModel data;

  ColiveChatMessageEvent(this.data);
}

/// refresh home anchors
class ColiveAnchorsRefreshEvent {}

/// anchor online status changed event
class ColiveAnchorStatusChangedEvent {
  final int anchorId;
  final int online;

  ColiveAnchorStatusChangedEvent({
    required this.anchorId,
    required this.online,
  });
}

/// refresh follow anchors
class ColiveFollowRefreshEvent {}

/// call begin
class ColiveCallBeginEvent {}

/// remote anchor refuse call event
class ColiveAnchorsRefuseCallEvent {}

/// remote anchor refuse call event
class ColiveCallSettlementEvent {
  ColiveCallSettlementModel data;
  ColiveCallSettlementEvent(this.data);
}

/// moment post succeed event
class ColiveMomentPostSucceedEvent {}

/// current area changed event
class ColiveCurrentAreaChangedEvent {}
