package com.manager.cd
{
    import flash.utils.*;

    public class CDInfo extends Object
    {
        private var _type:String;
        private var _key:String;
        private var _start:uint;
        private var _end:uint;
        private var _delay:uint;

        public function CDInfo()
        {
            return;
        }// end function

        public function get end() : uint
        {
            return this._end;
        }// end function

        public function get type() : String
        {
            return this._type;
        }// end function

        public function set type(param1:String) : void
        {
            this._type = param1;
            return;
        }// end function

        public function get key() : String
        {
            return this._key;
        }// end function

        public function set key(param1:String) : void
        {
            this._key = param1;
            return;
        }// end function

        public function get start() : uint
        {
            return this._start;
        }// end function

        public function get delay() : uint
        {
            return this._delay;
        }// end function

        public function update(param1:uint, param2:uint) : void
        {
            this._start = getTimer() - param2 + param1;
            this._delay = param2;
            this._end = this._start + this._delay;
            return;
        }// end function

        public function get remainTime() : uint
        {
            return Math.max(0, this._end - getTimer());
        }// end function

    }
}
