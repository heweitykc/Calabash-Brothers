package com.game.zones.view.dekaron
{
    import __AS3__.vec.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.greensock.*;
    import flash.display.*;

    public class ZonesCycRotation extends BaseSprite
    {
        private var items:Vector.<ZonesCycRotationItem>;
        private var _currLevel:int = 1;
        private var _currStage:int;
        private var _localBack:MovieClip;
        private static var UFO_COUNT:int = 7;

        public function ZonesCycRotation()
        {
            this.items = new Vector.<ZonesCycRotationItem>;
            this.initCyc();
            this.addEvents();
            return;
        }// end function

        private function addEvents() : void
        {
            return;
        }// end function

        private function initCyc() : void
        {
            this._localBack = ToolKit.getNew("local_back");
            this.creatItem();
            return;
        }// end function

        private function creatItem() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_1:* = this._localBack.getChildByName("ufo1") as Sprite;
            var _loc_2:* = UFO_COUNT - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_3 = new ZonesCycRotationItem("ufo");
                this.addChild(_loc_3);
                _loc_3.index = _loc_2;
                _loc_3.levelStage = _loc_2;
                _loc_4 = this._localBack.getChildByName("ufo" + _loc_2) as Sprite;
                _loc_3.mLocalX = _loc_4.x;
                _loc_3.mLocalY = _loc_4.y;
                _loc_3.mScale = _loc_4.width / _loc_1.width;
                this.items.unshift(_loc_3);
                _loc_2 = _loc_2 - 1;
            }
            this.swapChildren(this.items[0], this.items[6]);
            return;
        }// end function

        public function adjustPosition() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_1:* = this._localBack.getChildByName("ufo1") as Sprite;
            var _loc_2:* = 0;
            while (_loc_2 < UFO_COUNT)
            {
                
                _loc_3 = this.items[_loc_2];
                _loc_4 = this.getCurIndex(_loc_2);
                _loc_3.levelStage = this.currStage;
                _loc_3.level = _loc_4;
                _loc_5 = this._localBack.getChildByName("ufo" + _loc_2) as Sprite;
                _loc_3.mLocalX = _loc_5.x;
                _loc_3.mLocalY = _loc_5.y;
                _loc_3.mScale = _loc_5.width / _loc_1.width;
                TweenLite.killTweensOf(_loc_3);
                if (this._currLevel == 0)
                {
                    _loc_3.setIsPass(_loc_4 != 0);
                }
                else
                {
                    _loc_3.setIsPass(this._currLevel > _loc_4);
                }
                _loc_2++;
            }
            return;
        }// end function

        public function showAllUfoEffect() : void
        {
            var _loc_1:* = null;
            var _loc_3:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < UFO_COUNT)
            {
                
                _loc_1 = this.items[_loc_2];
                _loc_1.y = _loc_1.y + 25;
                _loc_1.alpha = 0;
                _loc_3 = this._localBack.getChildByName("ufo" + _loc_2) as Sprite;
                TweenLite.killTweensOf(_loc_1);
                TweenLite.to(_loc_1, 2, {alpha:1, y:_loc_3.y});
                _loc_2++;
            }
            return;
        }// end function

        public function showOverGateEffect() : void
        {
            var _loc_1:* = this.items[1];
            TweenLite.to(_loc_1, 0.2, {mScale:0.01});
            return;
        }// end function

        private function getCurIndex(param1:int) : int
        {
            var _loc_2:* = this._currLevel + param1 - 1;
            _loc_2 = _loc_2 >= UFO_COUNT ? (_loc_2 - UFO_COUNT) : (_loc_2);
            _loc_2 = _loc_2 < 0 ? (UFO_COUNT + _loc_2) : (_loc_2);
            return _loc_2;
        }// end function

        public function get currLevel() : int
        {
            return this._currLevel;
        }// end function

        public function set currLevel(param1:int) : void
        {
            this._currLevel = param1;
            return;
        }// end function

        public function get currStage() : int
        {
            return this._currStage;
        }// end function

        public function set currStage(param1:int) : void
        {
            this._currStage = param1;
            return;
        }// end function

    }
}
