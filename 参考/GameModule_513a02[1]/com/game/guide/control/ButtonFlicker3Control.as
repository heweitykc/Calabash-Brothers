package com.game.guide.control
{
    import com.f1.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;

    public class ButtonFlicker3Control extends Object
    {
        private var filter:GlowFilter;
        private var innerFilter:GlowFilter;
        private var targetList:Array;
        private var updateTime:int;
        private var note:int = 1;
        private static var _instance:ButtonFlicker3Control;

        public function ButtonFlicker3Control()
        {
            this.targetList = [];
            this.filter = new GlowFilter(51189, 1, 0, 0, 0, BitmapFilterQuality.LOW, false, false);
            this.innerFilter = new GlowFilter(51189, 1, 0, 0, 0, BitmapFilterQuality.LOW, true, false);
            return;
        }// end function

        public function addButtonFlicker(param1:DisplayObject) : void
        {
            var _loc_2:* = this.targetList.indexOf(param1);
            if (_loc_2 == -1)
            {
                this.targetList.push(param1);
                param1.filters = [this.filter, this.innerFilter];
            }
            if (this.targetList.length > 0)
            {
                this.setFlickEnable(true);
            }
            return;
        }// end function

        public function removeButtonFlicker(param1:DisplayObject) : void
        {
            var _loc_2:* = this.targetList.indexOf(param1);
            if (_loc_2 != -1)
            {
                param1.filters = [];
                this.targetList.splice(_loc_2, 1);
            }
            if (this.targetList.length == 0)
            {
                this.setFlickEnable(false);
            }
            return;
        }// end function

        public function setFlickEnable(param1:Boolean) : void
        {
            if (param1)
            {
                FrameworkGlobal.stage.addEventListener(Event.ENTER_FRAME, this.enterFrame);
            }
            else
            {
                FrameworkGlobal.stage.removeEventListener(Event.ENTER_FRAME, this.enterFrame);
            }
            return;
        }// end function

        private function enterFrame(event:Event) : void
        {
            var _loc_4:* = this;
            var _loc_5:* = this.updateTime + 1;
            _loc_4.updateTime = _loc_5;
            if (this.updateTime == 3)
            {
                this.updateTime = 0;
                if (this.filter.strength >= 1.5)
                {
                    this.note = -1;
                    var _loc_4:* = 5;
                    this.filter.blurY = 5;
                    this.filter.blurX = _loc_4;
                    this.filter.strength = 1.5;
                    var _loc_4:* = 1;
                    this.innerFilter.blurY = 1;
                    this.innerFilter.blurX = _loc_4;
                    this.innerFilter.strength = 1.5;
                }
                else if (this.filter.strength <= 0)
                {
                    this.note = 1;
                    var _loc_4:* = 0;
                    this.filter.blurY = 0;
                    this.filter.blurX = _loc_4;
                    this.filter.strength = 0;
                    var _loc_4:* = 0;
                    this.innerFilter.blurY = 0;
                    this.innerFilter.blurX = _loc_4;
                    this.innerFilter.strength = 0;
                }
                this.filter.blurX = this.filter.blurX + 0.5 * this.note * 1.2;
                this.filter.blurY = this.filter.blurY + 0.5 * this.note * 1.2;
                this.filter.strength = this.filter.strength + 0.15 * this.note * 1.2;
                this.innerFilter.blurX = this.innerFilter.blurX + 0.1 * this.note * 1.2;
                this.innerFilter.blurY = this.innerFilter.blurY + 0.1 * this.note * 1.2;
                this.innerFilter.strength = this.innerFilter.strength + 0.15 * this.note * 1.2;
            }
            var _loc_2:* = 0;
            var _loc_3:* = this.targetList.length;
            while (_loc_2 < _loc_3)
            {
                
                this.targetList[_loc_2].filters = [this.filter, this.innerFilter];
                _loc_2++;
            }
            return;
        }// end function

        public static function getInstance() : ButtonFlicker3Control
        {
            var _loc_1:* = new ButtonFlicker3Control;
            _instance = new ButtonFlicker3Control;
            return _instance || _loc_1;
        }// end function

    }
}
