package com.index
{
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.text.*;
    import flash.utils.*;

    public class Tips extends Sprite
    {
        private var tipsTimer:Timer;
        private var tipsArray:Array;
        private var tipsIndex:int = 0;
        private var tipspLen:int;
        private var tipsTxt:TextField;

        public function Tips(param1:TextField)
        {
            this.tipsArray = [];
            this.tipsTxt = param1;
            this.tipsDoubleCheck();
            var _loc_2:* = new Date().time / 43200000;
            var _loc_3:* = new URLLoader();
            _loc_3.addEventListener(Event.COMPLETE, this.__tipsOK, false, 0, true);
            _loc_3.load(new URLRequest("images/TipsCfg.xml?rdm=" + _loc_2));
            return;
        }// end function

        private function __tipsOK(event:Event) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = new XML((event.target as URLLoader).data);
            if (_loc_2 != null && _loc_2.tip != null)
            {
                for each (_loc_3 in _loc_2.tip)
                {
                    
                    if (_loc_3 != null && _loc_3.@desc != null)
                    {
                        this.tipsArray.push(_loc_3.@desc);
                    }
                }
            }
            this.tipsDoubleCheck();
            return;
        }// end function

        private function tipsDoubleCheck() : void
        {
            if (this.tipsArray.length > 0 && this.tipsTxt != null)
            {
                this.tipspLen = this.tipsArray.length;
                this.tipsIndex = 0;
                this.tipsTimer = new Timer(3000);
                this.tipsTimer.addEventListener(TimerEvent.TIMER, this.__tipsTimer);
                this.tipsTimer.start();
                this.__tipsTimer();
            }
            return;
        }// end function

        private function __tipsTimer(event:Event = null) : void
        {
            var _loc_2:* = this.tipsArray[this.tipsIndex];
            this.tipsTxt.text = _loc_2;
            var _loc_3:* = this;
            this.tipsIndex = (this.tipsIndex + 1);
            _loc_3.tipsIndex = this.tipsIndex + 1;
            this.tipsIndex = this.tipsIndex % this.tipspLen;
            return;
        }// end function

        public function destroy() : void
        {
            if (this.tipsTimer)
            {
                this.tipsTimer.stop();
                this.tipsTimer.removeEventListener(TimerEvent.TIMER, this.__tipsTimer);
                this.tipsTimer = null;
            }
            return;
        }// end function

    }
}
