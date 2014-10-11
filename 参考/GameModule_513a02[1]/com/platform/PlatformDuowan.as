package com.platform
{
    import com.game.map.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.yy.game.*;

    public class PlatformDuowan extends Platform
    {
        private var gameId:String = "DTSZJ";
        private var sceneId:String = "0";
        private var passport:String = "";
        private var udbid:int = 0;

        public function PlatformDuowan()
        {
            return;
        }// end function

        override protected function initUser() : void
        {
            this.udbid = int(userName);
            return;
        }// end function

        override public function onPlayerInfoReceived() : void
        {
            listenPlayerCreateAndLevelChange();
            return;
        }// end function

        override protected function onPlayerCreate() : void
        {
            this.reportPlayerInfo(GameEvents.NEW_ROLE);
            return;
        }// end function

        override protected function onPlayerLevelChange(param1:int) : void
        {
            this.reportPlayerInfo(GameEvents.LEVEL_CHANGE);
            return;
        }// end function

        private function reportPlayerInfo(param1:String) : void
        {
            var _loc_2:* = null;
            GameMsgCollector.instance.reportGameProfile(this.passport, this.udbid, this.gameId, serverId, playerName, playerLevel, param1, _loc_2);
            return;
        }// end function

        override public function onEnterMap() : void
        {
            var _loc_1:* = MapObj.getInstance().mapID;
            this.sceneId = _loc_1.toString();
            GameMsgCollector.instance.getReportable(playerName, this.sceneId, serverId, this.gameId);
            return;
        }// end function

        override public function onChatMessageReceived(param1:ChatInfo) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = param1.chatername;
            if (_loc_2 == playerName)
            {
                return;
            }
            switch(param1.chattype)
            {
                case ChatType.CHATTYPE_GM:
                case ChatType.CHATTYPE_SYSTEM:
                case ChatType.CHATTYPE_TRANSACTION:
                {
                    return;
                }
                case ChatType.CHATTYPE_ROLE:
                {
                    _loc_3 = MessageType.ONE_VS_ONE;
                    break;
                }
                default:
                {
                    _loc_3 = MessageType.ONE_VS_MULTIPLE;
                    break;
                }
            }
            var _loc_4:* = param1.condition;
            GameMsgCollector.instance.collectMessage(_loc_4, playerName, _loc_2, _loc_3, this.sceneId, serverId, this.gameId, this.onReportReceiveMessageOk);
            return;
        }// end function

        private function onReportReceiveMessageOk(param1:Boolean) : void
        {
            return;
        }// end function

    }
}
