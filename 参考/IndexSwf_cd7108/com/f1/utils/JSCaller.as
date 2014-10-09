package com.f1.utils
{
    import flash.events.*;
    import flash.external.*;
    import flash.utils.*;

    public class JSCaller extends Object
    {
        public static const F2J_NEED_LOGIN:String = "ch200908NeedLogin";
        public static const F2J_NEED_VERIFY:String = "ch200908NeedVerify";
        public static const F2J_IS_WEB_READY:String = "ch200901IsWebReady";
        public static const F2J_SET_SWF_READY:String = "ch200901SetSwfReady";
        public static const F2J_LOGOUT:String = "ch200901Logout";
        public static const J2F_ON_LOGIN_OK:String = "OnLoginOK";
        public static const J2F_ON_VERIFY_OK:String = "OnVerifyOK";
        public static const GET_SKEY:String = "chGetSKey";
        public static const GET_UIN:String = "chGetUin";
        public static const CLOSE:String = "minigame_display_object_close";
        public static const GAME_READY:String = "gameReadyHandler";
        public static const HEART_BEAT:String = "heartBeatHandler";

        public function JSCaller()
        {
            return;
        }// end function

        public static function getContainerReady(param1:Function) : void
        {
            var OnStateTimer:Function;
            var stReadyTimer:Timer;
            var callBack:* = param1;
            OnStateTimer = function (event:TimerEvent) : void
            {
                if (this.IsContainerReady())
                {
                    containerReady = true;
                    if (event)
                    {
                        Timer(event.target).stop();
                    }
                    this.SetupCallbacks(callBack);
                }
                return;
            }// end function
            ;
            if (!ExternalInterface.available)
            {
                trace("External interface is not available for this container");
                throw new Error("External interface is not available for this container");
            }
            var containerReady:Boolean;
            JSCaller.OnStateTimer(null);
            if (!containerReady)
            {
                stReadyTimer = new Timer(100);
                stReadyTimer.addEventListener(TimerEvent.TIMER, OnStateTimer);
                stReadyTimer.start();
            }
            return;
        }// end function

        public static function SetupCallbacks(param1:Function) : void
        {
            ExternalInterface.addCallback(J2F_ON_LOGIN_OK, param1);
            return;
        }// end function

        public static function chIsLogin() : void
        {
            ExternalInterface.call(F2J_NEED_LOGIN);
            return;
        }// end function

        public static function GetUin()
        {
            var _loc_1:* = ExternalInterface.call(GET_UIN);
            return _loc_1;
        }// end function

        public static function GetSkey()
        {
            var _loc_1:* = ExternalInterface.call(GET_SKEY);
            return _loc_1;
        }// end function

        public static function IsContainerReady() : Boolean
        {
            var _loc_1:* = ExternalInterface.call(F2J_IS_WEB_READY);
            return _loc_1;
        }// end function

        public static function ShowLoginDlg() : void
        {
            trace("未登录");
            ExternalInterface.call(F2J_NEED_LOGIN);
            return;
        }// end function

        public static function ShowVerifyDlg(param1:String)
        {
            ExternalInterface.call(F2J_NEED_VERIFY, param1);
            return;
        }// end function

        public static function Logout() : void
        {
            ExternalInterface.call(F2J_LOGOUT);
            return;
        }// end function

        public static function OpenWindow(param1:String) : void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("window.open(\'" + param1 + "\')");
            }
            return;
        }// end function

        public static function GetUrlSearch(param1:String) : String
        {
            return ExternalInterface.call("ch200901GetUrlParam", param1);
        }// end function

        public static function JSAlert(param1:String) : void
        {
            ExternalInterface.call("alert(\'" + param1 + "\')");
            return;
        }// end function

        public static function GameReady(param1:Boolean) : void
        {
            Log.log("----------------NotifyGameReady");
            if (ExternalInterface.available)
            {
                ExternalInterface.call(GAME_READY, param1);
            }
            return;
        }// end function

        public static function heartBeat() : void
        {
            Log.log("--------------HeartBeatJS");
            if (ExternalInterface.available)
            {
                ExternalInterface.call(HEART_BEAT);
            }
            return;
        }// end function

    }
}
