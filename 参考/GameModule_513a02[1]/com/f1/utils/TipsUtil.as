package com.f1.utils
{
    import com.f1.*;
    import flash.display.*;

    public class TipsUtil extends Object
    {
        public static const MOUSE_ADJUST:int = 27;

        public function TipsUtil()
        {
            return;
        }// end function

        public static function getTipX(param1:DisplayObject) : int
        {
            var _loc_4:* = 0;
            if (!param1)
            {
                return 0;
            }
            var _loc_2:* = FrameworkGlobal.stage.mouseX;
            var _loc_3:* = FrameworkGlobal.stage.mouseX;
            if (_loc_2 + param1.width + MOUSE_ADJUST > FrameworkGlobal.stageW)
            {
                _loc_3 = _loc_2 - param1.width - MOUSE_ADJUST;
                if (_loc_3 < 0)
                {
                    _loc_3 = 0;
                }
            }
            else
            {
                _loc_4 = FrameworkGlobal.stage.mouseY;
                if (_loc_4 + param1.height + MOUSE_ADJUST > FrameworkGlobal.stageH)
                {
                    _loc_3 = _loc_3 + (MOUSE_ADJUST >> 1);
                }
                else
                {
                    _loc_3 = _loc_3 + MOUSE_ADJUST;
                }
            }
            return _loc_3;
        }// end function

        public static function getTipY(param1:DisplayObject) : int
        {
            var _loc_4:* = 0;
            var _loc_2:* = FrameworkGlobal.stage.mouseY;
            var _loc_3:* = _loc_2;
            if (_loc_2 + param1.height + MOUSE_ADJUST > FrameworkGlobal.stageH)
            {
                _loc_3 = _loc_2 - param1.height - MOUSE_ADJUST + 20;
                if (_loc_2 - param1.height < 0)
                {
                    _loc_3 = 0;
                    return _loc_3;
                }
            }
            else
            {
                if (_loc_3 + param1.height > FrameworkGlobal.stageH)
                {
                    _loc_3 = 0;
                    return _loc_3;
                }
                _loc_4 = FrameworkGlobal.stage.mouseX;
                if (_loc_4 + param1.width > FrameworkGlobal.stageW)
                {
                    _loc_3 = _loc_3 + (MOUSE_ADJUST >> 1);
                }
                else
                {
                    _loc_3 = _loc_3 + MOUSE_ADJUST;
                }
            }
            return _loc_3;
        }// end function

        public static function getEquipTipX(param1:int, param2:int) : int
        {
            var _loc_5:* = 0;
            var _loc_3:* = FrameworkGlobal.stage.mouseX;
            var _loc_4:* = FrameworkGlobal.stage.mouseX;
            if (_loc_3 + param1 + MOUSE_ADJUST > FrameworkGlobal.stageW)
            {
                _loc_4 = _loc_3 - param1 - MOUSE_ADJUST;
                if (_loc_4 < 0)
                {
                    _loc_4 = 0;
                }
            }
            else
            {
                _loc_5 = FrameworkGlobal.stage.mouseY;
                if (_loc_5 + param2 + MOUSE_ADJUST > FrameworkGlobal.stageH)
                {
                    _loc_4 = _loc_4 + (MOUSE_ADJUST >> 1);
                }
                else
                {
                    _loc_4 = _loc_4 + MOUSE_ADJUST;
                }
            }
            return _loc_4;
        }// end function

        public static function getEquipTipY2(param1:int, param2:int, param3:int) : int
        {
            var _loc_4:* = FrameworkGlobal.stage.mouseY;
            var _loc_5:* = FrameworkGlobal.stage.mouseY;
            var _loc_6:* = Math.max(param2, param3);
            var _loc_7:* = Math.min(param2, param3);
            var _loc_8:* = MOUSE_ADJUST >> 1;
            var _loc_9:* = FrameworkGlobal.stage.mouseX;
            if (_loc_4 + _loc_6 + MOUSE_ADJUST > FrameworkGlobal.stageH)
            {
                if (_loc_4 - _loc_7 <= 0)
                {
                    _loc_5 = 0;
                    return _loc_5;
                }
                if (_loc_9 + param1 > FrameworkGlobal.stageW)
                {
                    _loc_5 = _loc_4 - _loc_7;
                }
                else
                {
                    _loc_5 = _loc_4 - _loc_7;
                }
                if (_loc_5 + _loc_6 > FrameworkGlobal.stageH)
                {
                    _loc_5 = FrameworkGlobal.stageH - _loc_6;
                }
                return _loc_5;
            }
            else if (_loc_9 + _loc_6 > FrameworkGlobal.stageW)
            {
                _loc_5 = _loc_5 + (MOUSE_ADJUST >> 1);
            }
            else
            {
                _loc_5 = _loc_5 + MOUSE_ADJUST;
            }
            return _loc_5;
        }// end function

        public static function getEquipTipY(param1:int, param2:int) : int
        {
            var _loc_5:* = 0;
            var _loc_3:* = FrameworkGlobal.stage.mouseY;
            var _loc_4:* = _loc_3;
            if (_loc_3 + param2 + MOUSE_ADJUST > FrameworkGlobal.stageH)
            {
                _loc_4 = _loc_3 - param2 - MOUSE_ADJUST + 20;
                if (_loc_3 - param2 < 0)
                {
                    _loc_4 = 0;
                    return _loc_4;
                }
            }
            else
            {
                _loc_5 = FrameworkGlobal.stage.mouseX;
                if (_loc_5 + param2 > FrameworkGlobal.stageW)
                {
                    _loc_4 = _loc_4 + (MOUSE_ADJUST >> 1);
                }
                else
                {
                    _loc_4 = _loc_4 + MOUSE_ADJUST;
                }
            }
            return _loc_4;
        }// end function

    }
}
