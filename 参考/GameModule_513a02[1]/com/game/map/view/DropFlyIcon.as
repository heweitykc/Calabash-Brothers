package com.game.map.view
{
    import com.cfg.obj.*;
    import com.f1.ui.image.*;
    import com.f1.utils.*;
    import com.game.map.bean.*;
    import com.game.map.model.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import flash.events.*;
    import flash.utils.*;
    import interfaces.role.*;

    public class DropFlyIcon extends Image
    {
        private var _info:DropGoodsInfo;
        private var _modelInfo:PropInfo;
        private var beginTime:Number;
        private var distanceTime:Number;
        private var lastTime:Number;
        private var distance:Number;
        private var disArr:Array;
        private var beginArr:Array;
        private var index:int;
        private const BEGIN_SPEED:uint = 200;
        private const SPEED_UP:uint = 50;
        private var SPEED:uint = 200;

        public function DropFlyIcon()
        {
            return;
        }// end function

        public function get info() : DropGoodsInfo
        {
            return this._info;
        }// end function

        public function set info(param1:DropGoodsInfo) : void
        {
            this._info = param1;
            var _loc_2:* = this._info.itemModelId;
            var _loc_3:* = ItemCfgObj.getInstance().getCfgBy(_loc_2);
            if (_loc_3 == null)
            {
                return;
            }
            if (!PropUtil.isEquip(_loc_3.q_type))
            {
                this._modelInfo = new PropInfo();
            }
            else
            {
                this._modelInfo = new EquipmentInfo();
            }
            this._modelInfo.convByCfg(_loc_2);
            load(Params.DROP_PATH + _loc_3.q_drop_model + ".png");
            this.move(this.info.x, this.info.y);
            return;
        }// end function

        public function moveToTarget() : void
        {
            var _loc_3:* = getTimer();
            this.beginTime = getTimer();
            this.lastTime = _loc_3;
            this.SPEED = this.BEGIN_SPEED + this.index * this.SPEED_UP;
            var _loc_1:* = CutePetList.getInstance().playerCutePet;
            var _loc_2:* = _loc_1._y - (_loc_1._h >> 1);
            this.distance = ToolKit.distance(x, y, _loc_1._x, _loc_2);
            this.distanceTime = this.distance / this.SPEED * 1000;
            this.disArr = [_loc_1._x - x, _loc_2 - y];
            this.beginArr = [x, y];
            stage.addEventListener(Event.ENTER_FRAME, this.enterFrame);
            return;
        }// end function

        private function enterFrame(event:Event) : void
        {
            var _loc_7:* = NaN;
            var _loc_2:* = CutePetList.getInstance().playerCutePet;
            if (!_loc_2)
            {
                this.dispose();
                return;
            }
            var _loc_3:* = _loc_2._y - (_loc_2._h >> 1);
            var _loc_4:* = ToolKit.distance(this.beginArr[0], this.beginArr[1], _loc_2._x, _loc_3);
            var _loc_5:* = getTimer();
            var _loc_6:* = getTimer() - this.beginTime;
            if (getTimer() - this.beginTime < this.distanceTime && _loc_4 > 10)
            {
                _loc_7 = (_loc_5 - this.beginTime) / this.distanceTime;
                move(this.beginArr[0] + this.disArr[0] * _loc_7, this.beginArr[1] + this.disArr[1] * _loc_7);
                if (_loc_5 - this.lastTime > 200)
                {
                    var _loc_8:* = this;
                    var _loc_9:* = this.index + 1;
                    _loc_8.index = _loc_9;
                    this.moveToTarget();
                }
            }
            else
            {
                this.dispose();
            }
            return;
        }// end function

        override public function dispose() : void
        {
            DropFlyIconList.getInstance().removeDrop(this);
            stage.removeEventListener(Event.ENTER_FRAME, this.enterFrame);
            this._info = null;
            if (this.parent)
            {
                parent.removeChild(this);
            }
            super.dispose();
            return;
        }// end function

    }
}
