package com.platform
{
    import com.events.*;
    import com.f1.utils.*;
    import com.game.guild.message.*;
    import com.game.login.control.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.events.*;
    import flash.external.*;
    import flash.net.*;
    import flash.utils.*;

    public class Platform extends Object
    {
        protected var serverId:String;
        protected var userName:String;
        private var postId:uint = 0;
        public static var instance:Platform;

        public function Platform()
        {
            return;
        }// end function

        public function testPlayer() : void
        {
            this.playerInfo.name = "中文名1";
            this.playerInfo.level = 1;
            this.onPlayerCreate();
            var _loc_1:* = 10;
            var _loc_2:* = 1;
            this.nextLevel(6, _loc_2++ * _loc_1);
            this.nextLevel(11, _loc_2++ * _loc_1);
            this.nextLevel(21, _loc_2++ * _loc_1);
            this.nextLevel(26, _loc_2++ * _loc_1);
            return;
        }// end function

        private function nextLevel(param1:int, param2:Number) : void
        {
            var level:* = param1;
            var timeout:* = param2;
            var fun:* = function () : void
            {
                playerInfo.level = level;
                return;
            }// end function
            ;
            if (timeout != 0)
            {
                setTimeout(fun, timeout);
            }
            else
            {
                this.fun();
            }
            return;
        }// end function

        protected function init() : void
        {
            this.serverId = Params.serverOuterId;
            this.userName = Params.username;
            this.initUser();
            return;
        }// end function

        protected function initUser() : void
        {
            return;
        }// end function

        public function onPlayerInfoReceived() : void
        {
            return;
        }// end function

        public function onEnterMap() : void
        {
            return;
        }// end function

        public function onChatMessageReceived(param1:ChatInfo) : void
        {
            return;
        }// end function

        public function guildMemberListNotify(param1:ResGuildMemberListToKugooClientMessage) : void
        {
            return;
        }// end function

        public function guildLeaveNotify(param1:ResGuildLeaveToKugooClientMessage) : void
        {
            return;
        }// end function

        public function guildInfoChange(param1:ResGuildBulletinToKugooClientMessage) : void
        {
            return;
        }// end function

        public function guildDeleteNotify(param1:ResGuildDeleteToKugooClientMessage) : void
        {
            return;
        }// end function

        protected function listenPlayerCreateAndLevelChange() : void
        {
            this.listenPlayerCreate();
            this.listenPlayerLevelChange();
            return;
        }// end function

        protected function listenPlayerCreate() : void
        {
            if (RegistControl.getInstance().roleCreated)
            {
                this.onPlayerCreate();
            }
            else
            {
                RegistControl.getInstance().createRoleCallback = this.onPlayerCreate;
            }
            return;
        }// end function

        protected function onPlayerCreate() : void
        {
            return;
        }// end function

        protected function listenPlayerLevelChange() : void
        {
            this.playerInfo.addEventListener(RoleEvent.UPDATE_LEVEL, function (event:RoleEvent) : void
            {
                onPlayerLevelChange(event.obj.pre);
                return;
            }// end function
            );
            return;
        }// end function

        protected function onPlayerLevelChange(param1:int) : void
        {
            return;
        }// end function

        protected function get playerInfo() : PlayerInfo
        {
            return UserObj.getInstance().playerInfo;
        }// end function

        protected function get playerLevel() : int
        {
            return this.playerInfo.level;
        }// end function

        protected function get playerName() : String
        {
            return this.playerInfo.name;
        }// end function

        protected function createUrlVariables(param1:Array) : URLVariables
        {
            var _loc_3:* = null;
            var _loc_2:* = new URLVariables();
            for each (_loc_3 in param1)
            {
                
                _loc_2[_loc_3[0]] = _loc_3[1];
            }
            return _loc_2;
        }// end function

        protected function joinParms(param1:Array) : String
        {
            var _loc_3:* = null;
            var _loc_2:* = "";
            for each (_loc_3 in param1)
            {
                
                if (_loc_2.length > 0)
                {
                    _loc_2 = _loc_2 + "&";
                }
                _loc_2 = _loc_2 + (_loc_3[0] + "=" + encodeURIComponent(_loc_3[1]));
            }
            return _loc_2;
        }// end function

        protected function postToUrl(param1:String, param2:URLVariables, param3:Function = null, param4:Function = null, param5:String = null) : void
        {
            var loader:URLLoader;
            var request:URLRequest;
            var tryTimes:uint;
            var postId:uint;
            var key:String;
            var errorHandler:Function;
            var url:* = param1;
            var urlVariables:* = param2;
            var completeCallback:* = param3;
            var errorCallback:* = param4;
            var retryResult:* = param5;
            loader = new URLLoader();
            request = new URLRequest(url);
            request.method = URLRequestMethod.POST;
            request.data = urlVariables;
            tryTimes;
            var _loc_7:* = this;
            this.postId = (this.postId + 1);
            _loc_7.postId = this.postId + 1;
            postId = this.postId;
            var urlVariablesStr:String;
            var _loc_7:* = 0;
            var _loc_8:* = urlVariables;
            while (_loc_8 in _loc_7)
            {
                
                key = _loc_8[_loc_7];
                urlVariablesStr = urlVariablesStr + (key + "=" + _loc_8[key] + ",");
            }
            Log.log("Platform.postToUrl-send: " + postId + " " + url + "?" + urlVariablesStr);
            loader.addEventListener(Event.COMPLETE, function (event:Event) : void
            {
                var _loc_2:* = String(event.target.data);
                if (retryResult != null && _loc_2 == retryResult && tryTimes < 3)
                {
                    Log.log("Platform.postToUrl-retry: " + postId + " " + tryTimes);
                    var _loc_4:* = tryTimes + 1;
                    tryTimes = _loc_4;
                    loader.load(request);
                    return;
                }
                Log.log("Platform.postToUrl-complete: " + postId + " " + _loc_2);
                if (completeCallback != null)
                {
                    completeCallback(_loc_2);
                }
                return;
            }// end function
            );
            errorHandler = function (event:Event) : void
            {
                Log.log("Platform.postToUrl-error: " + postId + " " + event);
                if (errorCallback != null)
                {
                    errorCallback();
                }
                return;
            }// end function
            ;
            loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
            loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
            loader.load(request);
            return;
        }// end function

        protected function callJs(param1:String, ... args)
        {
            if (ExternalInterface.available)
            {
                return ExternalInterface.call.apply(null, [param1].concat(args));
            }
            return null;
        }// end function

        protected function getTimestampString() : String
        {
            var _loc_1:* = new Date();
            var _loc_2:* = ToolKit.getServerTime();
            _loc_1.time = _loc_2;
            return this.timeString(_loc_1);
        }// end function

        protected function getTimestampCompactString() : String
        {
            var _loc_1:* = new Date();
            var _loc_2:* = ToolKit.getServerTime();
            _loc_1.time = _loc_2;
            return this.timeCompactString(_loc_1);
        }// end function

        private function timeString(param1:Date) : String
        {
            return this.numberFixedLenChars(param1.fullYear, 4) + "-" + this.numberFixedLenChars((param1.month + 1), 2) + "-" + this.numberFixedLenChars(param1.date, 2) + " " + this.numberFixedLenChars(param1.hours, 2) + ":" + this.numberFixedLenChars(param1.minutes, 2) + ":" + this.numberFixedLenChars(param1.seconds, 2);
        }// end function

        private function timeCompactString(param1:Date) : String
        {
            return this.numberFixedLenChars(param1.fullYear, 4) + this.numberFixedLenChars((param1.month + 1), 2) + this.numberFixedLenChars(param1.date, 2) + this.numberFixedLenChars(param1.hours, 2) + this.numberFixedLenChars(param1.minutes, 2) + this.numberFixedLenChars(param1.seconds, 2);
        }// end function

        private function numberFixedLenChars(param1:uint, param2:uint) : String
        {
            var _loc_3:* = param1.toString();
            while (_loc_3.length < param2)
            {
                
                _loc_3 = "0" + _loc_3;
            }
            return _loc_3;
        }// end function

        public static function createInstance() : void
        {
            switch(Params.pf)
            {
                case Params.PF_DUOWAN:
                {
                    instance = new PlatformDuowan();
                    break;
                }
                case Params.PF_BAIDU:
                {
                    instance = new PlatformBaidu();
                    break;
                }
                case Params.PF_1360:
                {
                    instance = new Platform360();
                    break;
                }
                case Params.PF_KUGOU:
                {
                    instance = new PlatformKugou();
                    break;
                }
                default:
                {
                    instance = new PlatformNone();
                    break;
                }
            }
            instance.init();
            return;
        }// end function

        public static function test() : void
        {
            Params.pf = Params.PF_BAIDU;
            Params.serverOuterId = "S1";
            Params.username = "1240709255";
            createInstance();
            instance.testPlayer();
            return;
        }// end function

    }
}
