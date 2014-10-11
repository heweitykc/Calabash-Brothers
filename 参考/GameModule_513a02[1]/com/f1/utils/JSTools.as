package com.f1.utils
{
    import flash.display.*;
    import flash.events.*;
    import flash.external.*;
    import flash.geom.*;
    import flash.utils.*;

    public class JSTools extends Object
    {
        public static const GET_SKEY:String = "chGetSkey";
        public static const GET_UIN:String = "chGetUin";
        private static var STAGE:Stage;
        private static var isFullScreen:Boolean = false;
        private static var ls:Array = [];
        private static var rs:Array = [];
        public static var N:int = 1;
        private static var inited:Boolean = false;
        private static var funcMap:Dictionary = new Dictionary(true);

        public function JSTools()
        {
            return;
        }// end function

        public static function callJS(... args) : void
        {
            if (ExternalInterface.available)
            {
                try
                {
                    ExternalInterface.call.apply(null, args);
                }
                catch (e:Error)
                {
                }
            }
            return;
        }// end function

        public static function exeJS(param1:String) : void
        {
            callJS("eval", param1);
            return;
        }// end function

        public static function addCallback(param1:String, param2:Function) : void
        {
            if (ExternalInterface.available)
            {
                try
                {
                    ExternalInterface.addCallback(param1, param2);
                }
                catch (e:Error)
                {
                }
            }
            return;
        }// end function

        public static function openWindow(param1:String, param2:String = "_blank") : void
        {
            if (param1)
            {
                callJS("openWindow", param1, param2);
            }
            return;
        }// end function

        public static function reload() : void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("window.location.reload()");
            }
            return;
        }// end function

        public static function getUin() : String
        {
            if (ExternalInterface.available)
            {
                return ExternalInterface.call(GET_UIN);
            }
            return null;
        }// end function

        public static function getSkey() : String
        {
            if (ExternalInterface.available)
            {
                return ExternalInterface.call(GET_SKEY);
            }
            return null;
        }// end function

        public static function init(param1:Stage, param2:Boolean = true, param3:Boolean = true) : void
        {
            STAGE = param1;
            STAGE.addEventListener(FullScreenEvent.FULL_SCREEN, __fs);
            addCallback("jsMouseWheel", __defaultWheel);
            if (param2)
            {
                exeJS("RightClick.init(flashObjectIDName, flashContainer);");
            }
            if (param3)
            {
                exeJS("MouseWheel.init(flashObjectIDName);");
            }
            initBgsCallback();
            return;
        }// end function

        private static function __fs(event:FullScreenEvent) : void
        {
            isFullScreen = event.fullScreen;
            STAGE.removeEventListener(MouseEvent.MOUSE_WHEEL, __fsWheel);
            if (event.fullScreen)
            {
                STAGE.addEventListener(MouseEvent.MOUSE_WHEEL, __fsWheel);
            }
            return;
        }// end function

        private static function __fsWheel(event:MouseEvent) : void
        {
            if (STAGE.displayState == StageDisplayState.FULL_SCREEN)
            {
                onMouseWheel(event.delta);
            }
            return;
        }// end function

        private static function __defaultWheel(param1:int) : void
        {
            if (STAGE.displayState == StageDisplayState.NORMAL)
            {
                onMouseWheel(param1);
            }
            return;
        }// end function

        public static function addWheelListener(param1:Function) : void
        {
            if (ls.indexOf(param1) < 0)
            {
                ls.push(param1);
            }
            return;
        }// end function

        public static function removeWheelListener(param1:Function) : void
        {
            var _loc_2:* = ls.indexOf(param1);
            if (_loc_2 >= 0)
            {
                ls.splice(_loc_2, 1);
            }
            return;
        }// end function

        private static function onMouseWheel(param1:int) : void
        {
            var _loc_5:* = null;
            var _loc_2:* = STAGE.mouseX;
            var _loc_3:* = STAGE.mouseY;
            var _loc_4:* = STAGE.getObjectsUnderPoint(new Point(_loc_2, _loc_3));
            for each (_loc_5 in ls)
            {
                
                JSTools._loc_5(param1, _loc_2, _loc_3, _loc_4);
            }
            return;
        }// end function

        public static function addRightClickListener(param1:Function) : void
        {
            if (rs.indexOf(param1) < 0)
            {
                rs.push(param1);
            }
            return;
        }// end function

        public static function removeRightClickListener(param1:Function) : void
        {
            var _loc_2:* = rs.indexOf(param1);
            if (_loc_2 >= 0)
            {
                rs.splice(_loc_2, 1);
            }
            return;
        }// end function

        private static function onRightClick() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in rs)
            {
                
                JSTools._loc_1();
            }
            return;
        }// end function

        public static function createOneCallback(param1:Function) : String
        {
            var _loc_2:* = "bgsCallback" + N++;
            addBgsCallback(_loc_2, param1);
            return _loc_2;
        }// end function

        private static function addBgsCallback(param1:String, param2:Function) : void
        {
            initBgsCallback();
            var _loc_3:* = funcMap[param1] as Array;
            if (_loc_3 == null)
            {
                funcMap[param1] = [param2];
            }
            else
            {
                _loc_3.push(param2);
            }
            return;
        }// end function

        private static function callBgsCallback(param1:String, param2:Array) : void
        {
            var _loc_4:* = null;
            var _loc_3:* = funcMap[param1] as Array;
            if (_loc_3 != null)
            {
                try
                {
                    for each (_loc_4 in _loc_3)
                    {
                        
                        _loc_4.apply(null, param2);
                    }
                }
                catch (e:Error)
                {
                }
            }
            return;
        }// end function

        public static function initBgsCallback() : void
        {
            if (!inited)
            {
                inited = true;
                addCallback("bgsCallback", callBgsCallback);
            }
            return;
        }// end function

    }
}
