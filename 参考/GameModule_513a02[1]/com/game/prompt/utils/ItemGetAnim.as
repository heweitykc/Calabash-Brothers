package com.game.prompt.utils
{
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.btn.*;
    import com.game.operationpanel.control.*;
    import com.game.prompt.view.*;
    import com.greensock.*;
    import com.greensock.events.*;
    import com.model.vo.*;
    import com.util.*;
    import com.view.icon.*;
    import flash.geom.*;

    public class ItemGetAnim extends Object
    {
        private var _startPt:Point;
        private var _endPt:Point;
        private var _duration:int;
        private var skillTween:TweenMax;
        private var _modelId:uint;
        private var icon:IconBase;

        public function ItemGetAnim(param1:SimpleTon)
        {
            return;
        }// end function

        private function doFly(param1:uint, param2:Point, param3:Point, param4:int = 3, param5:Number = 1) : void
        {
            this._modelId = param1;
            this._startPt = param2;
            this._endPt = param3;
            this._duration = param4;
            this.preFly();
            this.play(param5);
            return;
        }// end function

        private function preFly() : void
        {
            var _loc_2:* = null;
            this.icon = new FlyIcon(null);
            this.icon.mouseEnabled = false;
            this.icon.mouseChildren = false;
            var _loc_1:* = ItemCfgObj.getInstance().getCfgBy(this._modelId);
            if (_loc_1 == null)
            {
                return;
            }
            if (!PropUtil.isEquip(_loc_1.q_type))
            {
                _loc_2 = new PropInfo();
            }
            else
            {
                _loc_2 = new EquipmentInfo();
            }
            _loc_2.convByCfg(this._modelId);
            this.icon.setInfo(_loc_2);
            this.icon.move(this._startPt.x, this._startPt.y);
            FrameworkGlobal.stage.addChild(this.icon);
            return;
        }// end function

        private function play(param1:Number = 1) : void
        {
            if (param1 != 1)
            {
                this.skillTween = new TweenMax(this.icon, this._duration, {x:this._endPt.x, y:this._endPt.y, scaleX:param1, scaleY:param1});
            }
            else
            {
                this.skillTween = new TweenMax(this.icon, this._duration, {x:this._endPt.x, y:this._endPt.y});
            }
            this.skillTween.addEventListener(TweenEvent.COMPLETE, this.animOver);
            return;
        }// end function

        private function animOver(event:TweenEvent) : void
        {
            this.skillTween.removeEventListener(TweenEvent.COMPLETE, this.animOver);
            this.skillTween.kill();
            this.skillTween = null;
            if (this.icon && this.icon.parent)
            {
                this.icon.parent.removeChild(this.icon);
            }
            this.icon = null;
            return;
        }// end function

        public static function doFlyIcon(param1:uint, param2:Point, param3:Point, param4:int = 3) : void
        {
            new ItemGetAnim(new SimpleTon()).doFly(param1, param2, param3, param4);
            return;
        }// end function

        public static function doFlyToBackPack(param1:uint, param2:Point, param3:int = 1) : void
        {
            var _loc_4:* = OperationPanelControl.getInstance().getBtnForName(LanguageCfgObj.getInstance().getByIndex("11070"));
            var _loc_5:* = _loc_4.localToGlobal(new Point(0, 0));
            new ItemGetAnim(new SimpleTon()).doFly(param1, param2, _loc_5, param3);
            return;
        }// end function

        public static function doFlyGetItemToBack(param1:uint) : void
        {
            var _loc_2:* = OperationPanelControl.getInstance().getBtnForName(LanguageCfgObj.getInstance().getByIndex("11070"));
            if (!_loc_2)
            {
                return;
            }
            var _loc_3:* = _loc_2.localToGlobal(new Point(0, 0));
            var _loc_4:* = Math.random() * 3;
            var _loc_5:* = new Point(_loc_3.x + 50 + _loc_2.width * _loc_4, _loc_3.y - 260);
            new ItemGetAnim(new SimpleTon()).doFly(param1, _loc_5, _loc_3, 1.5);
            return;
        }// end function

        public static function doFlyGetItemToIslandBack(param1:uint, param2:Point) : void
        {
            var _loc_3:* = OperationPanelControl.getInstance().getBtnForName(LanguageCfgObj.getInstance().getByIndex("11070"));
            if (!_loc_3)
            {
                return;
            }
            var _loc_4:* = _loc_3.localToGlobal(new Point(0, 0));
            var _loc_5:* = Math.random() * 3;
            var _loc_6:* = new Point(_loc_4.x + 50 + _loc_3.width * _loc_5, _loc_4.y - 260);
            new ItemGetAnim(new SimpleTon()).doFly(param1, _loc_6, param2, 1.5, 1.5);
            return;
        }// end function

        public static function doFlyGetItemsToBack(param1:Array) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_8:* = null;
            var _loc_2:* = OperationPanelControl.getInstance().getBtnForName(LanguageCfgObj.getInstance().getByIndex("11070"));
            if (!_loc_2)
            {
                return;
            }
            var _loc_3:* = _loc_2.localToGlobal(new Point(4, 4));
            var _loc_6:* = param1.length;
            var _loc_7:* = 0;
            while (_loc_7 < _loc_6)
            {
                
                _loc_5 = param1[_loc_7];
                _loc_4 = 50 + _loc_7 * _loc_2.width;
                _loc_8 = new Point(_loc_3.x + _loc_4, _loc_3.y - 260);
                new ItemGetAnim(new SimpleTon()).doFly(_loc_5, _loc_8, _loc_3, 1.5);
                _loc_7++;
            }
            return;
        }// end function

        public static function doFlyGetItemsTo(param1:Array, param2:Point, param3:Point) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_8:* = null;
            var _loc_6:* = param1.length;
            var _loc_7:* = 0;
            while (_loc_7 < _loc_6)
            {
                
                _loc_5 = param1[_loc_7];
                _loc_4 = _loc_7 * 50;
                _loc_8 = new Point(param3.x + _loc_4, param3.y);
                new ItemGetAnim(new SimpleTon()).doFly(_loc_5, _loc_8, param2, 1.5);
                _loc_7++;
            }
            return;
        }// end function

    }
}

import com.cfg.obj.*;

import com.f1.*;

import com.f1.ui.btn.*;

import com.game.operationpanel.control.*;

import com.game.prompt.view.*;

import com.greensock.*;

import com.greensock.events.*;

import com.model.vo.*;

import com.util.*;

import com.view.icon.*;

import flash.geom.*;

class SimpleTon extends Object
{

    function SimpleTon()
    {
        return;
    }// end function

}

