package com.game.batter.view
{
    import __AS3__.vec.*;
    import com.f1.*;
    import com.f1.utils.*;
    import flash.display.*;

    public class KillCountImage extends BaseSprite
    {
        private var _num:int;
        private var _vecNum:Vector.<MovieClip>;
        private var backKill:Bitmap;
        private var killChar:Bitmap;
        private var killSign:Bitmap;

        public function KillCountImage()
        {
            this._vecNum = new Vector.<MovieClip>;
            this.initImage();
            return;
        }// end function

        private function initImage() : void
        {
            this.backKill = new Bitmap(ToolKit.getNew("backKill") as BitmapData);
            this.killChar = new Bitmap(ToolKit.getNew("killCharact") as BitmapData);
            this.killSign = new Bitmap(ToolKit.getNew("killSign") as BitmapData);
            this.addChild(this.backKill);
            this.killChar.x = -20;
            this.killChar.y = -15;
            this.backKill.y = -65;
            this.addChild(this.killChar);
            this.addChild(this.killSign);
            this.killSign.x = 84;
            this.killSign.y = -4;
            return;
        }// end function

        public function setNumber(param1:int) : void
        {
            var _loc_2:* = null;
            if (this._num != param1)
            {
                _loc_2 = param1.toString().split("");
                this.creatNum(_loc_2);
                this.freshNum(_loc_2);
            }
            return;
        }// end function

        private function freshNum(param1:Array) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            _loc_2 = 0;
            while (_loc_2 < param1.length)
            {
                
                _loc_3 = this._vecNum[_loc_2];
                _loc_4 = param1[_loc_2];
                _loc_3.gotoAndStop((_loc_4 + 1));
                _loc_3.x = 110 + (_loc_3.width - 35) * _loc_2;
                _loc_3.y = _loc_2 * -15 - 40;
                this.addChild(_loc_3);
                _loc_2++;
            }
            return;
        }// end function

        private function creatNum(param1:Array) : void
        {
            var _loc_2:* = null;
            while (param1.length < this._vecNum.length)
            {
                
                _loc_2 = this._vecNum.pop();
                if (_loc_2.parent)
                {
                    _loc_2.parent.removeChild(_loc_2);
                    _loc_2.stop();
                }
            }
            while (param1.length > this._vecNum.length)
            {
                
                _loc_2 = ToolKit.getNew("numKillRandom");
                this._vecNum.push(_loc_2);
            }
            return;
        }// end function

        public function reset() : void
        {
            ToolKit.clearMcChild(this, true);
            return;
        }// end function

        public function get num() : int
        {
            return this._num;
        }// end function

        public function set num(param1:int) : void
        {
            this._num = param1;
            return;
        }// end function

    }
}
