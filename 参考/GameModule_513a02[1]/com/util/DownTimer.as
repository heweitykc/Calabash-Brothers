package com.util
{
    import com.f1.*;
    import com.f1.utils.*;
    import flash.events.*;
    import flash.utils.*;

    public class DownTimer extends Object
    {
        private const DELAY:int = 100;
        private var _count:int;
        public var callBack:Function;
        private var time:uint;

        public function DownTimer()
        {
            return;
        }// end function

        public function get count() : int
        {
            return this._count;
        }// end function

        public function set count(param1:int) : void
        {
            this._count = param1;
            this.setCount();
            return;
        }// end function

        private function setCount() : void
        {
            if (this._count > 0)
            {
                this.start();
            }
            else
            {
                this.stop();
            }
            return;
        }// end function

        private function stop() : void
        {
            FrameworkGlobal.stage.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            this.callBackFun();
            return;
        }// end function

        private function start() : void
        {
            FrameworkGlobal.stage.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            this.time = getTimer();
            return;
        }// end function

        protected function onEnterFrame(event:Event) : void
        {
            var _loc_2:* = getTimer() - this.time;
            if (_loc_2 > this.DELAY)
            {
                this.count = this.count - _loc_2;
                this.count = this.count < 0 ? (0) : (this.count);
                this.callBackFun();
            }
            return;
        }// end function

        private function callBackFun() : void
        {
            if (this.callBack != null)
            {
                switch(this.callBack.length)
                {
                    case 0:
                    {
                        this.callBack();
                        break;
                    }
                    case 1:
                    {
                        this.callBack(this.count);
                        break;
                    }
                    case 2:
                    {
                        this.callBack(this.count, this.getTimeBySecond());
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        public function getTimeBySecond() : String
        {
            return ToolKit.getTimeBySecond(this._count / 1000);
        }// end function

        public function second2TimeStr(param1:String = "hms") : String
        {
            return ToolKit.second2TimeStr(this.count / 1000, param1);
        }// end function

    }
}
