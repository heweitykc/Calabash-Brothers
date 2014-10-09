package com.f1.ui.timeCount
{
    import com.f1.*;
    import com.f1.utils.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.text.*;
    import flash.utils.*;

    public class TimeCountDown extends BaseSprite
    {
        private var _txt:TextField;
        private var timer:Timer;
        private var _remainTime:int;
        private var format:String;
        private var tickInter:uint;
        private var prefix:String;
        private static const BLACK_FILTER:GlowFilter = new GlowFilter(0, 1, 4, 4, 2);
        private static var tf1:TextFormat = new TextFormat("Arial", 12, 16777215);

        public function TimeCountDown(param1:String = "hms", param2:TextField = null)
        {
            mouseEnabled = false;
            mouseChildren = false;
            if (!param2)
            {
                this._txt = new TextField();
                this._txt.width = 60;
                this._txt.height = 22;
                this._txt.defaultTextFormat = tf1;
                this._txt.filters = [BLACK_FILTER];
                this._txt.autoSize = TextFieldAutoSize.LEFT;
                this._txt.selectable = false;
                addChild(this._txt);
            }
            else
            {
                this._txt = param2;
            }
            this.format = param1;
            if (param1.indexOf(LanguageCfgObj.getInstance().getByIndex("11552")) >= 0 || param1.indexOf("s") >= 0)
            {
                this.tickInter = 1;
            }
            else if (param1.indexOf(LanguageCfgObj.getInstance().getByIndex("11571")) >= 0 || param1.indexOf("m") >= 0)
            {
                this.tickInter = 60;
            }
            else if (param1.indexOf(LanguageCfgObj.getInstance().getByIndex("11570")) >= 0 || param1.indexOf("h") >= 0)
            {
                this.tickInter = 3600;
            }
            return;
        }// end function

        public function setTextFormat(param1:TextFormat) : void
        {
            if (this._txt)
            {
                this._txt.defaultTextFormat = param1;
            }
            return;
        }// end function

        public function inCounting() : Boolean
        {
            return this._remainTime > 0;
        }// end function

        public function setCDTime(param1:int, param2:String = "") : void
        {
            this.prefix = param2;
            if (param1 == 0)
            {
                if (this.timer)
                {
                    this.timer.stop();
                }
                this.showTime(0);
                return;
            }
            this._remainTime = param1;
            this.showTime(this._remainTime);
            if (!this.timer)
            {
                this.timer = new Timer(this.tickInter * 1000, param1);
                this.timer.addEventListener(TimerEvent.TIMER, this.__onTick);
                this.timer.addEventListener(TimerEvent.TIMER_COMPLETE, this.__onTickDone);
            }
            else
            {
                this.timer.reset();
                this.timer.repeatCount = param1;
            }
            this.timer.start();
            return;
        }// end function

        private function __onTick(event:TimerEvent) : void
        {
            var _loc_2:* = this._remainTime - event.target.currentCount * this.tickInter;
            if (_loc_2 >= 0)
            {
                this.showTime(_loc_2);
            }
            return;
        }// end function

        private function showTime(param1:int) : void
        {
            if (param1 > 0)
            {
                this._txt.htmlText = this.prefix + ToolKit.second2TimeStr(param1, this.format);
            }
            else
            {
                this._txt.htmlText = "";
            }
            return;
        }// end function

        private function __onTickDone(event:TimerEvent) : void
        {
            this.clearCD();
            dispatchEvent(new Event(Event.COMPLETE));
            return;
        }// end function

        public function reset() : void
        {
            if (this.timer)
            {
                this.timer.stop();
            }
            return;
        }// end function

        public function stop() : void
        {
            if (this.timer)
            {
                this.timer.stop();
            }
            return;
        }// end function

        public function clearCD() : void
        {
            this._remainTime = 0;
            this._txt.htmlText = "";
            return;
        }// end function

        public function getRemainTime() : int
        {
            return this._remainTime;
        }// end function

    }
}
