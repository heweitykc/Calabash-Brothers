package com.platform
{
    import com.adobe.crypto.*;
    import flash.net.*;

    public class PlatformBaidu extends Platform
    {
        private var reportPlayerInfoUrl:String = "http://youxi.baidu.com/roleAction/gameRolePost.jsp";
        private var apiKey:String = "4641ecac0146e77e4a380fab45cfa6b9";
        private var appSecret:String = "8a9a5db84641ecac014645cfa6b90fac";
        private var role_online_time:int = 0;
        private var role_count_online_time:int = 0;
        private static var ACTION_CREATE:String = "CREATE";
        private static var ACTION_UPDATE:String = "UPDATE";

        public function PlatformBaidu()
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
            this.reportPlayerInfo(ACTION_CREATE, playerLevel);
            return;
        }// end function

        override protected function onPlayerLevelChange(param1:int) : void
        {
            var _loc_2:* = param1 + 1;
            while (_loc_2 <= playerLevel)
            {
                
                if (_loc_2 % 5 == 1)
                {
                    this.reportPlayerInfo(ACTION_UPDATE, _loc_2);
                }
                _loc_2++;
            }
            return;
        }// end function

        private function reportPlayerInfo(param1:String, param2:int) : void
        {
            var _loc_3:* = getTimestampString();
            var _loc_4:* = getTimestampCompactString();
            var _loc_5:* = "N";
            var _loc_6:* = [["api_key", this.apiKey], ["user_id", userName], ["server_id", serverId], ["timestamp", _loc_3, true], ["role_name", playerName], ["role_time", _loc_4], ["action", param1], ["multi_flag", _loc_5], ["role_level", param2.toString()], ["role_online_time", this.role_online_time.toString()], ["role_count_online_time", this.role_count_online_time.toString()]];
            var _loc_7:* = this.generateSign(_loc_6);
            _loc_6.push(["sign", _loc_7]);
            var _loc_8:* = this.reportPlayerInfoUrl;
            var _loc_9:* = createUrlVariables(_loc_6);
            postToUrl(_loc_8, _loc_9, this.onReportPlayerInfoResponse, null, "ERROR_300");
            return;
        }// end function

        private function onReportPlayerInfoResponse(param1:String) : void
        {
            return;
        }// end function

        private function generateSign(param1:Array) : String
        {
            var _loc_3:* = null;
            param1.sortOn("0");
            var _loc_2:* = new Array();
            for each (_loc_3 in param1)
            {
                
                _loc_2.push(this.formatParmForSign(_loc_3[0], _loc_3[1], _loc_3[2]));
            }
            return MD5.hash(this.appSecret + _loc_2.join("")).toUpperCase();
        }// end function

        private function formatParmForSign(param1:String, param2:String, param3:Boolean = false) : String
        {
            return param1 + (param3 ? (param2) : (param2.split(" ").join("")));
        }// end function

    }
}
