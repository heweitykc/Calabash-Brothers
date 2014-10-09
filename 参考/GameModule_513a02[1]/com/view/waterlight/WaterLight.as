package com.view.waterlight
{
    import __AS3__.vec.*;
    import com.f1.ui.*;
    import com.f1.vmc.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;

    public class WaterLight extends BMPView
    {
        private var _color:uint;
        public var onComplete:Function;
        private var _sourceBmd:BitmapData;
        private var w1:int;
        private var h1:int;
        private var _url:String;
        private var _page:int;
        private var pixel1Dic:Array;
        private var poseInfo:PoseInfo;

        public function WaterLight(param1:BitmapData = null, param2:uint = 16777215, param3:Function = null)
        {
            this.pixel1Dic = [];
            this._color = param2;
            this._sourceBmd = param1;
            this.onComplete = param3;
            this.updateWaterLight();
            blendMode = BlendMode.ADD;
            return;
        }// end function

        public function get color() : uint
        {
            return this._color;
        }// end function

        public function set color(param1:uint) : void
        {
            this._color = param1;
            this.drawLight();
            return;
        }// end function

        public function updateWaterLight() : void
        {
            var _loc_1:* = null;
            if (!this._sourceBmd)
            {
                return;
            }
            if (this._sourceBmd.width <= 60 && this._sourceBmd.height <= 60)
            {
                _loc_1 = "res/effect/waterlight.png";
            }
            else
            {
                _loc_1 = "res/effect/waterlightBig.png";
            }
            VMCManager.addRes(_loc_1, this.loadComplete, [_loc_1], null, null, true);
            return;
        }// end function

        private function loadComplete(param1:String) : void
        {
            this._url = param1;
            this.initLight();
            this.drawLight();
            if (this.onComplete != null)
            {
                this.onComplete();
            }
            return;
        }// end function

        private function initLight() : void
        {
            var _loc_5:* = null;
            if (!this._url || !this._sourceBmd)
            {
                return;
            }
            this.poseInfo = VMCManager.getPoseInfo(this._url, "90");
            var _loc_1:* = this.poseInfo.poses;
            this._page = _loc_1.length;
            var _loc_2:* = VMCManager.getBmd(this._url, _loc_1[0]);
            this.w1 = Math.min(_loc_2.width, this._sourceBmd.width);
            this.h1 = Math.min(_loc_2.height, this._sourceBmd.height);
            var _loc_3:* = new Rectangle(0, 0, this.w1, this.h1);
            var _loc_4:* = this.w1 * this.h1;
            for each (_loc_5 in _loc_1)
            {
                
                _loc_2 = VMCManager.getBmd(this._url, _loc_5);
                this.pixel1Dic.push(_loc_2.getVector(_loc_3));
            }
            return;
        }// end function

        private function drawLight() : void
        {
            var _loc_4:* = false;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            if (!this.poseInfo || !this._sourceBmd || this.pixel1Dic.length <= 0)
            {
                return;
            }
            var _loc_1:* = new Rectangle(0, 0, this.w1, this.h1);
            var _loc_2:* = this._sourceBmd.getVector(_loc_1);
            var _loc_3:* = this.w1 * this.h1;
            var _loc_7:* = getTimer();
            _loc_5 = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_4 = (_loc_2[_loc_5] >> 24 & 255) == 0;
                _loc_6 = 0;
                while (_loc_6 < this._page)
                {
                    
                    if (_loc_4)
                    {
                        this.pixel1Dic[_loc_6][_loc_5] = 0;
                    }
                    else
                    {
                        _loc_10 = this.pixel1Dic[_loc_6][_loc_5];
                        _loc_11 = _loc_10 >> 24 & 255;
                        _loc_10 = this._color & 16777215 | _loc_11 << 24;
                        this.pixel1Dic[_loc_6][_loc_5] = _loc_10;
                    }
                    _loc_6 = _loc_6 + 1;
                }
                _loc_5 = _loc_5 + 1;
            }
            var _loc_8:* = [];
            _loc_6 = 0;
            while (_loc_6 < this._page)
            {
                
                _loc_9 = new BitmapData(this.w1, this.h1, true);
                _loc_9.setVector(_loc_1, this.pixel1Dic[_loc_6]);
                _loc_8.push(_loc_9);
                _loc_6 = _loc_6 + 1;
            }
            auto = true;
            _repeat = true;
            update(_loc_8, this.poseInfo.inters, this.poseInfo.offsets);
            return;
        }// end function

        public function get sourceBmd() : BitmapData
        {
            return this._sourceBmd;
        }// end function

        public function set sourceBmd(param1:BitmapData) : void
        {
            this._sourceBmd = param1;
            return;
        }// end function

        override public function finalize() : void
        {
            super.finalize();
            this._color = 0;
            this._sourceBmd = null;
            this.pixel1Dic = [];
            return;
        }// end function

    }
}
