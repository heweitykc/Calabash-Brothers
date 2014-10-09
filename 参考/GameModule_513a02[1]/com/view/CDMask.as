package com.view
{
    import com.f1.*;
    import flash.events.*;
    import flash.utils.*;

    public class CDMask extends BaseSprite
    {
        private var fillAlpha:Number = 0.6;
        private var borderSize:uint = 1;
        private var borderColor:Number = 0;
        private var bgColor:Number = 0;
        private var _cdMax:int;
        private var _cd:int;
        private var _angle:int;
        private var curTime:uint;
        private var isShowZone:Boolean;
        private static const CD_DELAY:int = 50;

        public function CDMask(param1:uint, param2:uint, param3:Boolean = false)
        {
            this.isShowZone = param3;
            setWH(param1, param2);
            return;
        }// end function

        private function onEnterFrame(event:Event) : void
        {
            var _loc_2:* = getTimer() - this.curTime;
            if (_loc_2 >= CD_DELAY)
            {
                this._cd = this._cd - _loc_2;
                this.curTime = getTimer();
                if (this._cd <= 0)
                {
                    this._cd = 0;
                    removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
                }
                this.setAngle();
                this.setMask(this.angle);
            }
            return;
        }// end function

        private function start() : void
        {
            if (this._cd > 0)
            {
                if (!hasEventListener(Event.ENTER_FRAME))
                {
                    addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
                }
            }
            else if (hasEventListener(Event.ENTER_FRAME))
            {
                removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            }
            this.setMask(this.angle);
            return;
        }// end function

        private function setAngle() : void
        {
            this._cd = this._cd < 0 ? (0) : (this._cd);
            this._cd = this._cd > this._cdMax ? (this._cdMax) : (this._cd);
            this._angle = int(360 * (1 - this._cd / this._cdMax));
            if (this.isShowZone)
            {
                this._angle = this._angle <= 0 ? (0) : (this._angle);
            }
            else
            {
                this._angle = this._angle <= 0 ? (360) : (this._angle);
            }
            this._angle = this._angle > 360 ? (360) : (this._angle);
            return;
        }// end function

        private function get angle() : uint
        {
            return this._angle;
        }// end function

        public function setCD(param1:int, param2:int) : void
        {
            if (param2 <= 0)
            {
                return;
            }
            this._cd = param1;
            this._cdMax = param2;
            this.setAngle();
            this.start();
            this.curTime = getTimer();
            return;
        }// end function

        private function setMask(param1:Number) : void
        {
            var _loc_2:* = Math.PI * param1 / 180;
            graphics.clear();
            graphics.beginFill(this.bgColor, this.fillAlpha);
            if (_loc_2 >= 0 && _loc_2 <= Math.PI / 4)
            {
                graphics.moveTo(0, 0);
                graphics.lineTo(_w / 2, 0);
                graphics.lineTo(_w / 2, _h / 2);
                graphics.lineTo(_w / 2 + _h * Math.tan(_loc_2) / 2, 0);
                graphics.lineTo(_w, 0);
                graphics.lineTo(_w, _h);
                graphics.lineTo(0, _h);
            }
            else if (_loc_2 > Math.PI / 4 && _loc_2 <= 3 * Math.PI / 4)
            {
                graphics.moveTo(0, 0);
                graphics.lineTo(_w / 2, 0);
                graphics.lineTo(_w / 2, _h / 2);
                graphics.lineTo(_w, _h / 2 - _w / (2 * Math.tan(_loc_2)));
                graphics.lineTo(_w, 0);
                graphics.lineTo(_w, _h);
                graphics.lineTo(0, _h);
            }
            else if (_loc_2 > 3 * Math.PI / 4 && _loc_2 <= 5 * Math.PI / 4)
            {
                graphics.moveTo(0, 0);
                graphics.lineTo(_w / 2, 0);
                graphics.lineTo(_w / 2, _h / 2);
                graphics.lineTo(_w / 2 - Math.tan(_loc_2) * _h / 2, _h);
                graphics.lineTo(0, _h);
            }
            else if (_loc_2 > 5 * Math.PI / 4 && _loc_2 <= 7 * Math.PI / 4)
            {
                graphics.moveTo(0, 0);
                graphics.lineTo(_w / 2, 0);
                graphics.lineTo(_w / 2, _h / 2);
                graphics.lineTo(0, _h / 2 + _w / (2 * Math.tan(_loc_2)));
            }
            else
            {
                graphics.moveTo(_w / 2 + _h * Math.tan(_loc_2) / 2, 0);
                graphics.lineTo(_w / 2, 0);
                graphics.lineTo(_w / 2, _h / 2);
            }
            graphics.endFill();
            return;
        }// end function

    }
}
