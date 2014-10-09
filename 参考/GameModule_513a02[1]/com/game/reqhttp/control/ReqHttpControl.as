package com.game.reqhttp.control
{
    import com.adobe.crypto.*;
    import com.f1.*;
    import com.game.clickstream.*;
    import com.model.*;
    import com.staticdata.*;
    import flash.events.*;
    import flash.net.*;

    public class ReqHttpControl extends Object
    {
        private static var _instance:ReqHttpControl;

        public function ReqHttpControl()
        {
            return;
        }// end function

        public function getCardValidate(param1:String, param2:Function = null, param3:Function = null) : void
        {
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_4:* = "http://" + ClickStream.host + "/card/activiation";
            var _loc_5:* = new Date();
            var _loc_6:* = Math.floor(_loc_5.time / 1000);
            var _loc_7:* = UserObj.getInstance().playerInfo.personId.toString();
            var _loc_8:* = MD5.hash(Params.serverid + _loc_7 + param1 + _loc_6 + Params.activityCode);
            var _loc_9:* = _loc_4 + "?sid=" + Params.serverid + "&cardCode=" + param1 + "&roleId=" + _loc_7 + "&time=" + _loc_6 + "&sign=" + _loc_8.toLocaleLowerCase();
            _loc_10 = new URLLoader();
            _loc_11 = new URLRequest(_loc_9);
            _loc_11.method = URLRequestMethod.POST;
            this.configEvent(_loc_10, param2, param3);
            _loc_10.load(_loc_11);
            return;
        }// end function

        public function getPhoneValidate(param1:String, param2:Function = null, param3:Function = null) : void
        {
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_4:* = "http://" + ClickStream.host + "/sms/";
            if (FrameworkGlobal.usePhoneValidateTemp)
            {
                _loc_4 = "http://" + ClickStream.host + "/sms/t/";
            }
            var _loc_5:* = new Date();
            var _loc_6:* = Math.floor(_loc_5.time / 1000);
            var _loc_7:* = MD5.hash(Params.gameCode + Params.corpCode + Params.serverid + param1 + Params.username + _loc_6 + Params.smsOpenKey);
            var _loc_8:* = _loc_4 + "?action=get_code&game_code=" + Params.gameCode + "&corp_code=" + Params.corpCode + "&sid=" + Params.serverid + "&phone=" + param1 + "&login_account=" + Params.username + "&time=" + _loc_6 + "&sign=" + _loc_7.toLowerCase();
            _loc_9 = new URLLoader();
            _loc_10 = new URLRequest(_loc_8);
            _loc_10.method = URLRequestMethod.POST;
            this.configEvent(_loc_9, param2, param3);
            _loc_9.load(_loc_10);
            return;
        }// end function

        public function validateCode(param1:String, param2:Function = null, param3:Function = null) : void
        {
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_4:* = "http://" + ClickStream.host + "/sms/";
            var _loc_5:* = new Date();
            var _loc_6:* = Math.floor(_loc_5.time / 1000);
            var _loc_7:* = MD5.hash(Params.gameCode + Params.corpCode + Params.serverid + param1 + Params.username + _loc_6 + Params.smsOpenKey);
            var _loc_8:* = _loc_4 + "?action=verify_code&game_code=" + Params.gameCode + "&corp_code=" + Params.corpCode + "&sid=" + Params.serverid + "&code=" + param1 + "&login_account=" + Params.username + "&time=" + _loc_6 + "&sign=" + _loc_7.toLowerCase();
            _loc_9 = new URLLoader();
            _loc_10 = new URLRequest(_loc_8);
            _loc_10.method = URLRequestMethod.POST;
            this.configEvent(_loc_9, param2, param3);
            _loc_9.load(_loc_10);
            return;
        }// end function

        private function configEvent(param1:URLLoader, param2:Function, param3:Function = null) : void
        {
            var loader:* = param1;
            var successFun:* = param2;
            var errorFun:* = param3;
            loader.addEventListener(Event.COMPLETE, function (event:Event) : void
            {
                var _loc_2:* = String(event.target.data);
                if (successFun != null)
                {
                    successFun(_loc_2);
                    successFun = null;
                }
                loader = null;
                return;
            }// end function
            );
            loader.addEventListener(IOErrorEvent.IO_ERROR, function (event:Event) : void
            {
                if (errorFun != null)
                {
                    errorFun();
                    errorFun = null;
                }
                loader = null;
                return;
            }// end function
            );
            return;
        }// end function

        public static function getInstance() : ReqHttpControl
        {
            if (!_instance)
            {
                _instance = new ReqHttpControl;
            }
            return _instance;
        }// end function

    }
}
