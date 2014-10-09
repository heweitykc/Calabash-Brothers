package com
{
    import com.f1.interfaces.manager.*;
    import com.netease.protobuf.*;
    import interfaces.chat.*;
    import interfaces.fight.*;
    import interfaces.movie.*;
    import interfaces.role.*;

    public class Global extends Object
    {
        public static var usePointSeek:Boolean = true;
        public static var roleFactory:IRoleFactory;
        public static var movieModule:IMovieModule;
        public static var fightModule:IFightModule;
        public static var mainUIManager:IUIManager;
        public static var chatModule:IChatModule;
        public static var primaryCursorManager:IPrimaryCursorManager;
        public static var version:String = "Build";
        public static var LR:Object;
        private static var _uin:UInt64 = new UInt64(10001);
        private static var _from:uint = 2;
        public static var id:uint = 0;
        public static var buildTime:String = "";
        public static var WeblogCfg:Object = {};
        public static var playingRecord:Boolean;
        public static var autoFightTest:Boolean = false;
        public static var needHelpAutoFight:Boolean = true;

        public function Global()
        {
            return;
        }// end function

        public static function get popManager() : IPopManager
        {
            return BasicGlobal.popManager;
        }// end function

        public static function get sceneManager() : ISceneManager
        {
            return BasicGlobal.sceneManager;
        }// end function

        public static function get from() : uint
        {
            return _from;
        }// end function

        public static function set from(param1:uint) : void
        {
            _from = param1;
            return;
        }// end function

    }
}
