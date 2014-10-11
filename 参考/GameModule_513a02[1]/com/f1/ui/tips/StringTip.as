package com.f1.ui.tips
{
    import com.f1.*;
    import com.f1.utils.*;
    import com.greensock.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class StringTip extends Sprite
    {
        private var _time:int;
        private static const MOUSE_ADJUST:uint = 27;
        private static const DELAY_TTIME:Number = 0.2;
        private static var targetsDict:Dictionary = new Dictionary(true);
        private static var _tip:OneItemTip;
        private static var _target:DisplayObject;
        private static const BC_COLOR:uint = 16770997;

        public function StringTip(param1:DisplayObject, param2:String)
        {
            var _loc_3:* = false;
            this.mouseChildren = false;
            this.mouseEnabled = _loc_3;
            _target = param1;
            this.setInfo(param2);
            this.show();
            return;
        }// end function

        public function finalize() : void
        {
            if (_tip)
            {
                if (_tip.parent)
                {
                    _tip.parent.removeEventListener(MouseEvent.MOUSE_MOVE, this.__mouseMove);
                    _tip.parent.removeChild(_tip);
                }
                _tip.finalize();
            }
            if (_target)
            {
                _target.removeEventListener(MouseEvent.ROLL_OUT, this.__mouseOut);
            }
            _tip = null;
            _target = null;
            return;
        }// end function

        public function setInfo(param1:String) : void
        {
            if (param1 == null || param1.length == 0)
            {
                trace("StringTip::setInfo,Error! tips string is empty.");
                return;
            }
            this.visible = true;
            _tip = new OneItemTip(false);
            addChild(_tip);
            this.buildStringTip(_tip, param1);
            return;
        }// end function

        private function buildStringTip(param1:OneItemTip, param2:String) : void
        {
            var _loc_3:* = param2;
            param1.repaint(_loc_3, BC_COLOR);
            return;
        }// end function

        private function show() : void
        {
            TweenLite.delayedCall(DELAY_TTIME, this.__onShow);
            _target.addEventListener(MouseEvent.ROLL_OUT, this.__mouseOut);
            _target.addEventListener(Event.REMOVED_FROM_STAGE, this.__removeFromStage);
            return;
        }// end function

        private function __onShow() : void
        {
            if (!_tip)
            {
                this.__mouseOut();
                return;
            }
            _tip.x = TipsUtil.getTipX(_tip);
            _tip.y = TipsUtil.getTipY(_tip);
            FrameworkGlobal.stage.addChild(_tip);
            _target.removeEventListener(MouseEvent.MOUSE_MOVE, this.__mouseMove);
            _target.addEventListener(MouseEvent.MOUSE_MOVE, this.__mouseMove);
            return;
        }// end function

        protected function __mouseMove(event:MouseEvent = null) : void
        {
            if (!_tip || !_tip.parent)
            {
                this.__mouseOut();
                return;
            }
            _tip.x = TipsUtil.getTipX(_tip);
            _tip.y = TipsUtil.getTipY(_tip);
            return;
        }// end function

        private function __removeFromStage(event:Event) : void
        {
            this.__mouseOut();
            return;
        }// end function

        protected function __mouseOut(event:MouseEvent = null) : void
        {
            TweenLite.killDelayedCallsTo(this.__onShow);
            if (_target)
            {
                _target.removeEventListener(MouseEvent.MOUSE_MOVE, this.__mouseMove, false);
                _target.removeEventListener(MouseEvent.MOUSE_DOWN, this.__mouseOut);
                _target.removeEventListener(MouseEvent.ROLL_OUT, this.__mouseOut);
                _target.removeEventListener(Event.REMOVED_FROM_STAGE, this.__removeFromStage);
            }
            if (_tip && _tip.parent)
            {
                _tip.parent.removeChild(_tip);
            }
            this.finalize();
            return;
        }// end function

        public static function create(param1:DisplayObject, param2:String, param3:Boolean = true) : void
        {
            if (!param1)
            {
                return;
            }
            if (!targetsDict[param1])
            {
                targetsDict[param1] = param2;
                param1.addEventListener(MouseEvent.ROLL_OVER, __onRollOver);
            }
            else
            {
                update(param1, param2);
            }
            return;
        }// end function

        private static function __onRollOver(event:MouseEvent) : void
        {
            var _loc_2:* = event.currentTarget as DisplayObject;
            var _loc_3:* = targetsDict[_loc_2];
            if (_loc_3.length <= 0)
            {
                _loc_2.removeEventListener(MouseEvent.ROLL_OVER, __onRollOver);
                return;
            }
            new StringTip(_loc_2, _loc_3);
            return;
        }// end function

        private static function __removeTarget(event:Event) : void
        {
            var _loc_2:* = DisplayObject(event.currentTarget);
            StringTip.dispose(_loc_2);
            return;
        }// end function

        public static function update(param1:DisplayObject, param2:String) : void
        {
            if (!param1)
            {
                return;
            }
            if (!targetsDict[param1])
            {
                create(param1, param2);
                trace("Error!StringTip not find obj:" + param1);
            }
            else
            {
                targetsDict[param1] = param2;
            }
            if (_target && _target == param1)
            {
                if (_tip)
                {
                    _tip.resetStr(param2);
                }
            }
            return;
        }// end function

        public static function getMsg(param1:DisplayObject) : String
        {
            if (!param1)
            {
                return "";
            }
            if (targetsDict[param1])
            {
                return targetsDict[param1];
            }
            return "";
        }// end function

        public static function dispose(param1:DisplayObject) : void
        {
            if (!param1)
            {
                return;
            }
            if (targetsDict[param1])
            {
                param1.removeEventListener(MouseEvent.ROLL_OVER, __onRollOver);
                delete targetsDict[param1];
            }
            return;
        }// end function

        public static function newTipSp(param1:String) : Sprite
        {
            var _loc_2:* = new OneItemTip();
            _loc_2.repaint(param1, BC_COLOR);
            return _loc_2;
        }// end function

        public static function splitStr(param1:String, param2:uint = 10) : String
        {
            if (param1 == null)
            {
                return "";
            }
            var _loc_3:* = "";
            var _loc_4:* = 0;
            while (_loc_4 + param2 < param1.length)
            {
                
                _loc_3 = _loc_3 + param1.substr(_loc_4, param2) + "<br/>";
                _loc_4 = _loc_4 + param2;
            }
            _loc_3 = _loc_3 + param1.substr(_loc_4) + "<br/>";
            return _loc_3;
        }// end function

        public static function splitHtmlStr(param1:String, param2:uint = 10) : String
        {
            var _loc_8:* = null;
            if (param1 == null)
            {
                return "";
            }
            var _loc_3:* = "";
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_9:* = false;
            var _loc_10:* = 0;
            while (_loc_10 < param1.length)
            {
                
                _loc_8 = param1.charAt(_loc_10);
                if (_loc_8 == "<")
                {
                    _loc_5++;
                }
                else if (_loc_8 == ">")
                {
                    _loc_5 = _loc_5 - 1;
                }
                else if (_loc_5 <= 0)
                {
                    _loc_7 = _loc_7 + 1;
                }
                _loc_6 = _loc_6 + 1;
                if (_loc_5 > 0)
                {
                }
                else
                {
                    if (_loc_9 && _loc_7 > 0 && _loc_5 <= 0)
                    {
                        _loc_3 = _loc_3 + "<br/>";
                        _loc_9 = false;
                    }
                    if (_loc_7 >= param2 && _loc_5 <= 0)
                    {
                        _loc_9 = true;
                        _loc_3 = _loc_3 + param1.substr(_loc_4, _loc_6);
                        _loc_4 = _loc_4 + _loc_6;
                        _loc_6 = 0;
                        _loc_5 = 0;
                        _loc_7 = 0;
                    }
                }
                _loc_10++;
            }
            _loc_3 = _loc_3 + param1.substr(_loc_4);
            return _loc_3;
        }// end function

        private static function getTipX(param1:OneItemTip) : int
        {
            var _loc_4:* = 0;
            if (!param1)
            {
                return 0;
            }
            var _loc_2:* = FrameworkGlobal.stage.mouseX;
            var _loc_3:* = FrameworkGlobal.stage.mouseX;
            if (_loc_2 + param1.width > FrameworkGlobal.stageW)
            {
                _loc_3 = _loc_2 - param1.width;
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

        private static function getTipY(param1:OneItemTip) : int
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
                if (_loc_3 - param1.height < 0)
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

    }
}

import com.f1.*;

import com.f1.utils.*;

import com.greensock.*;

import flash.display.*;

import flash.events.*;

import flash.utils.*;

class OneItemTip extends Sprite
{
    private var txt:TextField;
    private var bg1:Shape;
    private var bg2:Shape;
    private var bg3:Shape;
    private var borderColor:uint;

    function OneItemTip(param1:Boolean = false)
    {
        var _loc_2:* = false;
        this.mouseChildren = false;
        this.mouseEnabled = _loc_2;
        this.bg1 = new Shape();
        addChild(this.bg1);
        this.bg2 = new Shape();
        addChild(this.bg2);
        this.bg3 = new Shape();
        addChild(this.bg3);
        this.txt = new TextField();
        var _loc_2:* = 5;
        this.txt.y = 5;
        this.txt.x = _loc_2;
        this.txt.mouseEnabled = false;
        this.txt.autoSize = TextFieldAutoSize.LEFT;
        this.txt.multiline = true;
        this.txt.defaultTextFormat = new TextFormat("Tahoma", 12, 16777215, null, null, null, null, null, null, null, null, null, 5);
        addChild(this.txt);
        return;
    }// end function

    public function finalize() : void
    {
        this.txt = null;
        var _loc_1:* = null;
        this.bg3 = null;
        this.bg2 = _loc_1;
        this.bg1 = _loc_1;
        return;
    }// end function

    public function repaint(param1:String, param2:uint) : void
    {
        this.borderColor = param2;
        this.resetStr(param1);
        return;
    }// end function

    public function resetStr(param1:String) : void
    {
        this.txt.htmlText = param1;
        var _loc_2:* = this.txt.width + 5;
        var _loc_3:* = this.txt.height + 5;
        this.bg3.graphics.clear();
        this.bg3.graphics.beginFill(1184274, 1);
        this.bg3.graphics.drawRoundRect(2, 2, _loc_2 + 0, _loc_3 + 0, 8, 8);
        this.bg2.graphics.clear();
        this.bg2.graphics.beginFill(this.borderColor, 0.6);
        this.bg2.graphics.drawRoundRect(1, 1, _loc_2 + 2, _loc_3 + 2, 8, 8);
        this.bg1.graphics.clear();
        this.bg1.graphics.beginFill(0, 1);
        this.bg1.graphics.drawRoundRect(0, 0, _loc_2 + 4, _loc_3 + 4, 8, 8);
        return;
    }// end function

}

