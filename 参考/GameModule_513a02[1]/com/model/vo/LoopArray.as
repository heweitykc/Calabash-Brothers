package com.model.vo
{

    public class LoopArray extends Object
    {
        private var _dataLst:Array;
        private var _maxLen:uint = 0;
        private var _startIdx:uint = 0;

        public function LoopArray(param1:uint)
        {
            this._maxLen = param1;
            this._dataLst = [];
            return;
        }// end function

        public function get dataLst() : Array
        {
            return this._dataLst;
        }// end function

        public function push(param1) : void
        {
            if (this._dataLst.length < this._maxLen)
            {
                this._dataLst.push(param1);
            }
            else
            {
                this._dataLst[this._startIdx % this._maxLen] = param1;
                var _loc_2:* = this;
                var _loc_3:* = this._startIdx + 1;
                _loc_2._startIdx = _loc_3;
            }
            return;
        }// end function

        public function shift(param1) : void
        {
            this._dataLst.unshift(param1);
            if (this._dataLst.length > this._maxLen)
            {
                this._dataLst.pop();
            }
            return;
        }// end function

        public function getObj(param1:uint)
        {
            var _loc_2:* = this._startIdx + param1;
            _loc_2 = _loc_2 % this._maxLen;
            return this._dataLst[_loc_2];
        }// end function

        public function get length() : uint
        {
            return this._dataLst.length;
        }// end function

    }
}
