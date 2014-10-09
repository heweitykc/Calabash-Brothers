package com
{
    import com.f1.interfaces.manager.*;
    import interfaces.game.*;
    import interfaces.net.*;

    public class BasicGlobal extends Object
    {
        public static var will:Boolean = false;
        public static var neil:Boolean = false;
        public static var jim:Boolean = false;
        public static var taddy:Boolean = false;
        public static var gongxi:Boolean = false;
        public static var jinhui:BasicGlobalJinhui = new BasicGlobalJinhui();
        public static var xupeitao:Boolean = false;
        public static var skey:String;
        public static var openid:String = "00000000000000000000000023577374";
        public static var gameModule:IGameModule;
        public static var messagePool:IMessagePool;
        public static var sceneManager:ISceneManager;
        private static var _popManager:IPopManager;
        private static var popManagerInitCompleteCallback:Function;

        public function BasicGlobal()
        {
            return;
        }// end function

        public static function get popManager() : IPopManager
        {
            return _popManager;
        }// end function

        public static function set popManager(param1:IPopManager) : void
        {
            var _loc_2:* = null;
            _popManager = param1;
            if (popManagerInitCompleteCallback != null)
            {
                _loc_2 = popManagerInitCompleteCallback;
                popManagerInitCompleteCallback = null;
                BasicGlobal._loc_2();
            }
            return;
        }// end function

        public static function usePopManager(param1:Function) : void
        {
            if (popManager)
            {
                BasicGlobal.param1();
            }
            else
            {
                popManagerInitCompleteCallback = param1;
            }
            return;
        }// end function

    }
}
