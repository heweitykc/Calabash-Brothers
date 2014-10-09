package com.hexagonstar.util.debug
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class FPSMeter extends EventDispatcher
    {
        private var _stage:Stage;
        private var _timer:Timer;
        private var _pollInterval:int;
        private var _fps:int;
        private var _frt:int;
        private var _ms:int;
        private var _isRunning:Boolean;
        private var _delay:int;
        private var _delayMax:int = 10;
        private var _prev:int;
        public static const FPS_UPDATE:String = "fpsUpdate";

        public function FPSMeter(param1:Stage, param2:int = 500)
        {
            this._stage = param1;
            this._fps = this._stage.frameRate;
            this._pollInterval = param2;
            this.reset();
            return;
        }// end function

        public function start() : void
        {
            if (!this._isRunning)
            {
                this._isRunning = true;
                this._timer = new Timer(this._pollInterval, 0);
                this._timer.addEventListener(TimerEvent.TIMER, this.onTimer);
                this._stage.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
                this._timer.start();
            }
            return;
        }// end function

        public function stop() : void
        {
            if (this._isRunning)
            {
                this._timer.stop();
                this._timer.removeEventListener(TimerEvent.TIMER, this.onTimer);
                this._stage.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
                this._timer = null;
                this.reset();
            }
            return;
        }// end function

        public function reset() : void
        {
            this._fps = 0;
            this._frt = 0;
            this._ms = 0;
            this._delay = 0;
            this._prev = 0;
            this._isRunning = false;
            return;
        }// end function

        public function get fps() : int
        {
            return this._fps;
        }// end function

        public function get frt() : int
        {
            return this._frt;
        }// end function

        private function onTimer(event:TimerEvent) : void
        {
            dispatchEvent(new Event(FPSMeter.FPS_UPDATE));
            return;
        }// end function

        private function onEnterFrame(event:Event) : void
        {
            var _loc_2:* = getTimer();
            var _loc_3:* = this;
            var _loc_4:* = this._delay + 1;
            _loc_3._delay = _loc_4;
            if (this._delay >= this._delayMax)
            {
                this._delay = 0;
                this._fps = int(1000 * this._delayMax / (_loc_2 - this._prev));
                this._prev = _loc_2;
            }
            this._frt = _loc_2 - this._ms;
            this._ms = _loc_2;
            return;
        }// end function

    }
}
