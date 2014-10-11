package com.hexagonstar.util.debug
{
    import flash.utils.*;

    public class StopWatch extends Object
    {
        private var _started:Boolean = false;
        private var _startTimeKeys:Array;
        private var _stopTimeKeys:Array;
        private var _title:String;

        public function StopWatch()
        {
            this.reset();
            return;
        }// end function

        public function start(param1:String = "") : void
        {
            if (!this._started)
            {
                this._title = param1;
                this._started = true;
                this._startTimeKeys.push(getTimer());
            }
            return;
        }// end function

        public function stop() : void
        {
            var _loc_1:* = 0;
            if (this._started)
            {
                _loc_1 = getTimer();
                this._stopTimeKeys[(this._startTimeKeys.length - 1)] = _loc_1;
                this._started = false;
            }
            return;
        }// end function

        public function reset() : void
        {
            this._startTimeKeys = [];
            this._stopTimeKeys = [];
            this._started = false;
            return;
        }// end function

        public function toString() : String
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_1:* = "\n ********************* [STOPWATCH] *********************";
            if (this._title != "")
            {
                _loc_1 = _loc_1 + ("\n * " + this._title);
            }
            var _loc_2:* = 0;
            while (_loc_2 < this._startTimeKeys.length)
            {
                
                _loc_3 = this._startTimeKeys[_loc_2];
                _loc_4 = this._stopTimeKeys[_loc_2];
                _loc_1 = _loc_1 + ("\n * started [" + this.format(_loc_3) + "ms] stopped [" + this.format(_loc_4) + "ms] time [" + this.format(_loc_4 - _loc_3) + "ms]");
                _loc_2++;
            }
            if (_loc_2 == 0)
            {
                _loc_1 = _loc_1 + "\n * never started.";
            }
            else
            {
                _loc_1 = _loc_1 + ("\n * total runnning time: " + this.timeInSeconds + "s");
            }
            _loc_1 = _loc_1 + "\n *******************************************************";
            return _loc_1;
        }// end function

        public function get started() : Boolean
        {
            return this._started;
        }// end function

        public function get timeInMilliSeconds() : int
        {
            if (this._started)
            {
                this._stopTimeKeys[(this._startTimeKeys.length - 1)] = getTimer();
            }
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            while (_loc_2 < this._startTimeKeys.length)
            {
                
                _loc_1 = _loc_1 + (this._stopTimeKeys[_loc_2] - this._startTimeKeys[_loc_2]);
                _loc_2++;
            }
            return _loc_1;
        }// end function

        public function get timeInSeconds() : Number
        {
            return this.timeInMilliSeconds / 1000;
        }// end function

        private function format(param1:int) : String
        {
            var _loc_2:* = "";
            var _loc_3:* = param1.toString().length;
            var _loc_4:* = 0;
            while (_loc_4 < 5 - _loc_3)
            {
                
                _loc_2 = _loc_2 + "0";
                _loc_4++;
            }
            return _loc_2 + param1;
        }// end function

    }
}
