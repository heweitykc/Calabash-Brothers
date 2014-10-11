package com.f1
{
    import com.f1.interfaces.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;

    public class FrameworkGlobal extends Object
    {
        public static var substituted:Boolean;
        public static const LOAD_PRELOAD_MAP:uint = 10;
        public static const LOAD_PRELOAD_PRI_ROLE:uint = 15;
        public static const LOAD_PRELOAD_PRI_ROLE_WING:uint = 14;
        public static const LOAD_PRELOAD_PRI_ROLE_HORSE:uint = 13;
        public static const LOAD_PRELOAD_HORSE:int = -4;
        public static const LOAD_PRELOAD_WING:int = -3;
        public static const LOAD_PRELOAD_WEAPON:int = -1;
        public static const LOAD_PRELOAD_MAGICBOOK:int = -5;
        public static const LOAD_PRELOAD_UI:uint = 9999;
        public static const LOAD_MAP_EFFECT:int = -10;
        public static const LOAD_PRELOAD_ROLE:uint = 1;
        public static var GLOBAL_BMP_MULTIPLE:Number = 1;
        public static const DIRECT_0:uint = 0;
        public static const DIRECT_45:uint = 45;
        public static const DIRECT_90:uint = 90;
        public static const DIRECT_135:uint = 135;
        public static const DIRECT_180:uint = 180;
        public static var showHighLevelShadow:Boolean = false;
        public static var showLightLevel:int = 10;
        public static var isShowGameEffect:Boolean = true;
        public static var FPS:int = 0;
        public static var reduceRender:Boolean = false;
        public static var memoryOut:Boolean = false;
        public static var rechargeFunction:Boolean = true;
        public static var usePhoneValidateTemp:Boolean = false;
        public static var language:String = "";
        public static const WHITE_FILTER:GlowFilter = new GlowFilter(16777215, 1, 3, 3, 3, 3, true);
        public static const BLACK_FILTER:GlowFilter = new GlowFilter(0, 1, 3, 3, 3);
        public static const BLUE_FILTER:GlowFilter = new GlowFilter(26316, 1, 2, 2, 4);
        public static const GREEN_FILTER:GlowFilter = new GlowFilter(65280, 1, 3, 3, 3, 3, true);
        public static const RED_FILTER:GlowFilter = new GlowFilter(16711680, 1, 3, 3, 3, 3, true);
        public static const ORANGE_FILTER:GlowFilter = new GlowFilter(13529621, 0.8, 4, 4);
        public static const DATA_GRID_ITEM_FILTER:GlowFilter = new GlowFilter(0, 0.5, 2, 2, 2);
        public static const YELLOW_TXT_FILTER:GlowFilter = new GlowFilter(16773120, 1, 3, 3, 3);
        public static const mat:Array = [0.3086, 0.6094, 0.082, 0, 0, 0.3086, 0.6094, 0.082, 0, 0, 0.3086, 0.6094, 0.082, 0, 0, 0, 0, 0, 1, 0];
        public static const colorMat:ColorMatrixFilter = new ColorMatrixFilter(mat);
        private static var _stage:Stage;
        public static var DEFAULT_FRAMERATE:uint = 51;
        private static var _frameRate:uint;
        public static var mainConnecter:IConnecter;
        private static var msgCenter:BaseEventDispatcher = new BaseEventDispatcher();
        private static var _published:Boolean = true;
        public static var debug:Boolean = false;
        private static var _flashvars:Object;
        public static var connectCallBack:Function;
        private static var _publishUrl:String = "";
        public static const CURRENT_DOMAIN:String = "currentdomain";

        public function FrameworkGlobal()
        {
            return;
        }// end function

        public static function get stage() : Stage
        {
            return _stage;
        }// end function

        public static function set stage(param1:Stage) : void
        {
            _stage = param1;
            _frameRate = _stage.frameRate;
            return;
        }// end function

        public static function get frameRate() : uint
        {
            if (_stage)
            {
                return _stage.frameRate;
            }
            return DEFAULT_FRAMERATE;
        }// end function

        public static function get stageW() : Number
        {
            if (_stage)
            {
                return _stage.stageWidth;
            }
            return 0;
        }// end function

        public static function get stageH() : Number
        {
            if (_stage)
            {
                return _stage.stageHeight;
            }
            return 0;
        }// end function

        public static function sendMsg(event:Event) : void
        {
            msgCenter.dispatchEvent(event);
            return;
        }// end function

        public static function addMsgListen(param1:String, param2:Function) : void
        {
            msgCenter.addEvtListener(param1, param2);
            return;
        }// end function

        public static function addMsgsListen(param1:Array, param2:Function) : void
        {
            msgCenter.addEvtListeners(param1, param2);
            return;
        }// end function

        public static function removeMsgListen(param1:String, param2:Function) : void
        {
            msgCenter.removeEvtListener(param1, param2);
            return;
        }// end function

        public static function stageAddEvtListener(param1:String, param2:Function, param3:Boolean = false, param4:Boolean = true) : void
        {
            if (stage && param1)
            {
                stage.addEventListener(param1, param2, param3, 0, param4);
            }
            return;
        }// end function

        public static function stageRemoveEvtListener(param1:String, param2:Function) : void
        {
            if (stage)
            {
                stage.removeEventListener(param1, param2);
            }
            return;
        }// end function

        public static function get flashvars() : Object
        {
            return _flashvars;
        }// end function

        public static function set flashvars(param1:Object) : void
        {
            _flashvars = param1;
            if (flashvars.publish != null)
            {
                _published = flashvars.publish == "true";
            }
            return;
        }// end function

        public static function get published() : Boolean
        {
            return _published;
        }// end function

        public static function set published(param1:Boolean) : void
        {
            _published = param1;
            return;
        }// end function

        public static function get publishUrl() : String
        {
            return _publishUrl;
        }// end function

        public static function set publishUrl(param1:String) : void
        {
            _publishUrl = param1;
            return;
        }// end function

    }
}
