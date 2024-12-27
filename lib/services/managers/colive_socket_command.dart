/// define socket commands
enum ColiveSocketCommand {
  ///////////////////////////////////////////////////////////////
  /// go up command
  //////////////////////////////////////////////////////////////

  /// heartbeat
  heartbeat('10000'),

  /// binding user id and token
  bindingUser('11111'),

  // start the calling, server need start timer
  startCalling('60001'),

  // local user pause receive call
  pauseReceiveCall('60002'),

  ///////////////////////////////////////////////////////////////
  /// go down command
  //////////////////////////////////////////////////////////////

  /// received aib call
  receivedAIBCall('70001'),

  /// received aia call
  receivedAIACall('70002'),

  /// update user's diamonds balance and vip days
  updateBalance('70003'),

  /// preload videos before aia call
  preloadVideo('70004'),

  /// the account was blocked
  accountBlocked('80001'),

  /// have discount profuct recomment
  rechargeDiscount('80002'),

  /// anchor online status changed
  anchorStatusChanged('80003'),

  /// received anchor call
  receivedCall('80004'),

  /// settlement when call end
  settlementCall('80005'),

  /// anchor refuse your call
  anchorRefuseCall('80006'),

  /// follow, fans or blocked update
  followUpdate('80007'),

  /// sensitive update
  sensitiveUpdate('80008'),

  /// call card update
  cardUpdate('80009'),

  /// show recharge view
  showRecharge('80010'),

  /// diamonds product list update
  productUpdate('80011'),

  /// unknow command
  unknow('');

  final String command;
  const ColiveSocketCommand(this.command);
  static fromCommand(String command) => ColiveSocketCommand.values
      .firstWhere((element) => element.command == command);
}
