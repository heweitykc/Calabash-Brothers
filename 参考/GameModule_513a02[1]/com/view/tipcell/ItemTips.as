package com.view.tipcell
{
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.backpack.bean.*;
    import com.greensock.*;
    import com.model.vo.*;
    import com.util.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import interfaces.*;

    public class ItemTips extends BaseSprite
    {
        private var _target:DisplayObject;
        private var _tip:BaseTips;
        private static const MOUSE_ADJUST:uint = 25;
        private static const DELAY_TTIME:Number = 0.2;
        private static var targetsDict:Dictionary = new Dictionary(true);
        private static var classDict:Dictionary = new Dictionary(true);
        public static var equipcompareControl:IEquiptipControl;
        private static var _curTip:BaseTips;
        private static const BC_COLOR:uint = 16770997;

        public function ItemTips(param1:DisplayObject, param2:Object, param3:Class)
        {
            var _loc_4:* = false;
            this.mouseChildren = false;
            this.mouseEnabled = _loc_4;
            this._target = param1;
            this.setInfo(param2, param3);
            this.show();
            return;
        }// end function

        public function setInfo(param1, param2:Class) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (param1 == null)
            {
                trace("StringTip::setInfo,Error! tips string is empty.");
                return;
            }
            this.visible = true;
            var _loc_6:* = new param2;
            this._tip = new param2;
            _curTip = _loc_6;
            this._tip.target = this._target;
            addChild(this._tip);
            (this._tip as BaseTips).repaint(param1);
            if (this._tip is EquipTips)
            {
                _loc_3 = param1 as EquipmentInfo;
                if (_loc_3 && _loc_3.pos == 0 || equipcompareControl && equipcompareControl.isOtherEquip(_loc_3) && equipcompareControl)
                {
                    _loc_4 = equipcompareControl.getEquip(_loc_3);
                    if (_loc_4)
                    {
                        _loc_5 = new EquipTips();
                        _loc_5.isvice = true;
                        _loc_5.repaint(_loc_4);
                        (this._tip as EquipTips).compareTip = _loc_5;
                    }
                }
            }
            return;
        }// end function

        private function show() : void
        {
            TweenLite.delayedCall(DELAY_TTIME, this.__onShow);
            this._target.addEventListener(MouseEvent.ROLL_OUT, this.__mouseOut);
            this._target.addEventListener(Event.REMOVED_FROM_STAGE, this.__removeFromStage);
            return;
        }// end function

        private function __onShow() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            if (!this._tip)
            {
                this.__mouseOut();
                return;
            }
            if (!(this._tip is EquipTips))
            {
                this._tip.x = TipsUtil.getTipX(this._tip);
                this._tip.y = TipsUtil.getTipY(this._tip);
            }
            else
            {
                _loc_1 = this._tip as EquipTips;
                if (_loc_1)
                {
                    if (_loc_1.compareTip == null)
                    {
                        this._tip.x = TipsUtil.getEquipTipX(this._tip.width, _loc_1.height);
                        this._tip.y = TipsUtil.getTipY(this._tip);
                    }
                    else
                    {
                        _loc_2 = this._tip.width + _loc_1.compareTip.width + 3;
                        _loc_3 = Math.max(this._tip.height, _loc_1.compareTip.height);
                        _loc_4 = TipsUtil.getEquipTipX(_loc_2, _loc_3);
                        _loc_5 = _loc_1.compareTip ? (_loc_1.compareTip.height) : (0);
                        _loc_6 = TipsUtil.getEquipTipY2(_loc_2, _loc_5, _loc_1.height);
                        if (_loc_4 > FrameworkGlobal.stage.mouseX)
                        {
                            this._tip.x = _loc_4;
                            this._tip.y = _loc_6;
                            _loc_1.compareTip.x = _loc_4 + _loc_1.width + 3;
                            _loc_1.compareTip.y = _loc_6;
                        }
                        else
                        {
                            this._tip.x = _loc_4 + _loc_1.compareTip.width + 3;
                            this._tip.y = _loc_6;
                            _loc_1.compareTip.x = _loc_4;
                            _loc_1.compareTip.y = _loc_6;
                        }
                        FrameworkGlobal.stage.addChild(_loc_1.compareTip);
                    }
                }
            }
            FrameworkGlobal.stage.addChild(this._tip);
            this._target.addEventListener(MouseEvent.MOUSE_MOVE, this.__mouseMove);
            return;
        }// end function

        protected function __mouseMove(event:MouseEvent = null) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            if (!this._tip || !this._tip.parent)
            {
                this.__mouseOut();
                return;
            }
            if (!(this._tip is EquipTips))
            {
                this._tip.x = TipsUtil.getTipX(this._tip);
                this._tip.y = TipsUtil.getTipY(this._tip);
            }
            else
            {
                _loc_2 = this._tip as EquipTips;
                if (_loc_2)
                {
                    if (_loc_2.compareTip == null)
                    {
                        this._tip.x = TipsUtil.getEquipTipX(this._tip.width, _loc_2.height);
                        this._tip.y = TipsUtil.getTipY(this._tip);
                    }
                    else
                    {
                        _loc_3 = this._tip.width + _loc_2.compareTip.width + 3;
                        _loc_4 = Math.max(this._tip.height, _loc_2.compareTip.height);
                        _loc_5 = TipsUtil.getEquipTipX(_loc_3, _loc_4);
                        _loc_6 = _loc_2.compareTip ? (_loc_2.compareTip.height) : (0);
                        _loc_7 = TipsUtil.getEquipTipY2(_loc_3, _loc_6, _loc_2.height);
                        if (_loc_5 > FrameworkGlobal.stage.mouseX)
                        {
                            this._tip.x = _loc_5;
                            this._tip.y = _loc_7;
                            _loc_2.compareTip.x = _loc_5 + _loc_2.width + 3;
                            _loc_2.compareTip.y = _loc_7;
                        }
                        else
                        {
                            this._tip.x = _loc_5 + _loc_2.compareTip.width + 3;
                            this._tip.y = _loc_7;
                            _loc_2.compareTip.x = _loc_5;
                            _loc_2.compareTip.y = _loc_7;
                        }
                        FrameworkGlobal.stage.addChild(_loc_2.compareTip);
                    }
                }
            }
            FrameworkGlobal.stage.addChild(this._tip);
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
            if (this._target)
            {
                this._target.removeEventListener(MouseEvent.MOUSE_MOVE, this.__mouseMove, false);
                this._target.removeEventListener(MouseEvent.MOUSE_DOWN, this.__mouseOut);
                this._target.removeEventListener(MouseEvent.ROLL_OUT, this.__mouseOut);
                this._target.removeEventListener(Event.REMOVED_FROM_STAGE, this.__removeFromStage);
            }
            if (this._tip && this._tip.parent)
            {
                this._tip.parent.removeChild(this._tip);
            }
            this._tip.remove();
            this.finalize();
            return;
        }// end function

        public static function create(param1:DisplayObject, param2:Object, param3:Class = null, param4:Boolean = true) : void
        {
            if (!param1)
            {
                return;
            }
            if (!targetsDict[param1])
            {
                targetsDict[param1] = param2;
                if (param3)
                {
                    classDict[param1] = param3;
                }
                else if (param2 is EquipmentInfo)
                {
                    classDict[param1] = EquipTips;
                }
                else
                {
                    classDict[param1] = PropTips;
                }
                param1.addEventListener(MouseEvent.ROLL_OVER, __onRollOver);
            }
            else
            {
                update(param1, param2, param3);
            }
            return;
        }// end function

        public static function getTipsbyPropInfo(param1:PropInfo) : BaseTips
        {
            if (param1 is EquipmentInfo)
            {
                return new EquipTips();
            }
            return new PropTips();
        }// end function

        public static function getTipsbyItemInfo(param1:ItemInfo) : BaseTips
        {
            var _loc_2:* = null;
            var _loc_3:* = PropUtil.createItemByItemInfo(param1);
            if (_loc_3 is EquipmentInfo)
            {
                _loc_2 = new EquipTips();
            }
            else
            {
                _loc_2 = new PropTips();
            }
            _loc_2.repaint(_loc_3);
            return _loc_2;
        }// end function

        public static function update(param1:DisplayObject, param2:Object, param3:Class) : void
        {
            if (!param1)
            {
                return;
            }
            if (!targetsDict[param1])
            {
                create(param1, param2, param3);
                trace("Error!StringTip not find obj:" + param1);
            }
            else
            {
                targetsDict[param1] = param2;
                classDict[param1] = param3;
            }
            return;
        }// end function

        public static function dispose(param1:DisplayObject) : void
        {
            if (!param1)
            {
                return;
            }
            if (_curTip && _curTip.target == param1)
            {
                ToolKit.disappear(_curTip);
            }
            if (targetsDict[param1])
            {
                param1.removeEventListener(MouseEvent.ROLL_OVER, __onRollOver);
                delete targetsDict[param1];
                delete classDict[param1];
            }
            return;
        }// end function

        private static function __onRollOver(event:MouseEvent) : void
        {
            var _loc_2:* = event.currentTarget as DisplayObject;
            var _loc_3:* = targetsDict[_loc_2];
            var _loc_4:* = classDict[_loc_2];
            if (!_loc_3)
            {
                _loc_2.removeEventListener(MouseEvent.ROLL_OVER, __onRollOver);
                return;
            }
            new ItemTips(_loc_2, _loc_3, _loc_4);
            return;
        }// end function

        private static function __removeTarget(event:Event) : void
        {
            var _loc_2:* = DisplayObject(event.currentTarget);
            ItemTips.dispose(_loc_2);
            return;
        }// end function

        private static function getTipX(param1:BaseTips) : int
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
                _loc_3 = _loc_2 - param1.width - (MOUSE_ADJUST >> 1);
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

        private static function getTipY(param1:BaseTips) : int
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
