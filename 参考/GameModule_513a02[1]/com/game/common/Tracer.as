package com.game.common
{
    import com.*;
    import com.f1.*;
    import flash.events.*;
    import flash.text.*;

    public class Tracer extends BaseSprite
    {
        private static var debugText:TextField;
        private static var debugNum:int;
        public static var OFF:Boolean = true;
        private static const ITEM_LIMIT:int = 50;
        private static var lock:Boolean = true;

        public function Tracer()
        {
            return;
        }// end function

        public static function debug(param1:String) : void
        {
            if (OFF)
            {
                return;
            }
            if (lock)
            {
                return;
            }
            if (debugNum > ITEM_LIMIT)
            {
                clear();
            }
            create();
            debugText.htmlText = "<font color=\'#ffffff\'>[DUBUG]</font>" + param1 + "<br />" + debugText.htmlText;
            var _loc_3:* = debugNum + 1;
            debugNum = _loc_3;
            return;
        }// end function

        public static function error(param1:String) : void
        {
            if (OFF)
            {
                return;
            }
            if (lock)
            {
                return;
            }
            if (debugNum > ITEM_LIMIT)
            {
                clear();
            }
            create();
            debugText.htmlText = "<font color=\'#ff0000\'>[ERROR]</font>" + param1 + "<br />" + debugText.htmlText;
            var _loc_3:* = debugNum + 1;
            debugNum = _loc_3;
            return;
        }// end function

        public static function fight(param1:String) : void
        {
            if (OFF)
            {
                return;
            }
            if (lock)
            {
                return;
            }
            if (debugNum > ITEM_LIMIT)
            {
                clear();
            }
            create();
            debugText.htmlText = "<font color=\'#ffcc00\'>[FIGHT]</font>" + param1 + "<br />" + debugText.htmlText;
            var _loc_3:* = debugNum + 1;
            debugNum = _loc_3;
            return;
        }// end function

        public static function skill(param1:String) : void
        {
            if (debugNum > ITEM_LIMIT)
            {
                clear();
            }
            create();
            debugText.htmlText = "<font color=\'#ffcc00\'>[FIGHT]</font>" + param1 + "<br />" + debugText.htmlText;
            var _loc_3:* = debugNum + 1;
            debugNum = _loc_3;
            return;
        }// end function

        private static function create() : void
        {
            var _loc_1:* = null;
            if (!debugText)
            {
                debugText = new TextField();
                debugText.textColor = 16777215;
                debugText.wordWrap = true;
                debugText.multiline = true;
                debugText.width = 380;
                debugText.height = 600;
                _loc_1 = new BaseSprite();
                _loc_1.addChild(debugText);
                _loc_1.y = 180;
                _loc_1.x = 80;
                _loc_1.addEventListener(MouseEvent.CLICK, onClickHandle);
                Global.mainUIManager.addUI(_loc_1);
            }
            return;
        }// end function

        private static function onClickHandle(event:MouseEvent) : void
        {
            lock = !lock;
            if (!lock)
            {
                debugText.text = "";
            }
            return;
        }// end function

        private static function clear(param1 = null) : void
        {
            var _loc_2:* = 0;
            if (debugText)
            {
                debugNum = 30;
                _loc_2 = debugText.htmlText.length * 0.5;
                debugText.htmlText = debugText.htmlText.substr(0, _loc_2);
            }
            return;
        }// end function

    }
}
