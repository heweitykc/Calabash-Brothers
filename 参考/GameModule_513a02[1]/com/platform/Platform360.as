package com.platform
{
    import com.adobe.crypto.*;
    import flash.net.*;

    public class Platform360 extends Platform
    {
        private var reportPlayerInfoUrl:String = "http://game.api.1360.com/player";
        private var gkey:String = "dtszj";
        private var secretKey:String = "4706d7665f9f837649bed61767035ea5";

        public function Platform360()
        {
            return;
        }// end function

        override protected function initUser() : void
        {
            return;
        }// end function

        override public function onPlayerInfoReceived() : void
        {
            listenPlayerCreateAndLevelChange();
            return;
        }// end function

        override protected function onPlayerCreate() : void
        {
            this.reportPlayerInfo();
            return;
        }// end function

        override protected function onPlayerLevelChange(param1:int) : void
        {
            this.reportPlayerInfo();
            return;
        }// end function

        private function reportPlayerInfo() : void
        {
            var _loc_1:* = [["gkey", this.gkey], ["level", playerLevel.toString()], ["name", playerName], ["qid", userName], ["server_id", serverId]];
            var _loc_2:* = this.generateSign(_loc_1);
            _loc_1.push(["sign", _loc_2]);
            var _loc_3:* = this.reportPlayerInfoUrl;
            var _loc_4:* = createUrlVariables(_loc_1);
            postToUrl(_loc_3, _loc_4, this.onReportPlayerInfoResponse);
            return;
        }// end function

        private function onReportPlayerInfoResponse(param1:String) : void
        {
            return;
        }// end function

        private function generateSign(param1:Array) : String
        {
            var _loc_3:* = null;
            var _loc_2:* = "";
            for each (_loc_3 in param1)
            {
                
                _loc_2 = _loc_2 + _loc_3[1];
            }
            return MD5.hash(_loc_2 + this.secretKey).toLowerCase();
        }// end function

    }
}
