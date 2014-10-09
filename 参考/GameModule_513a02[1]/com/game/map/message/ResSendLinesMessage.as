package com.game.map.message
{
    import __AS3__.vec.*;
    import net.*;

    public class ResSendLinesMessage extends Message
    {
        private var _lines:Vector.<int>;
        private var _numbers:Vector.<int>;

        public function ResSendLinesMessage()
        {
            this._lines = new Vector.<int>;
            this._numbers = new Vector.<int>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._lines.length);
            _loc_1 = 0;
            while (_loc_1 < this._lines.length)
            {
                
                writeInt(this._lines[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._lines[_loc_1] = readInt();
                _loc_1++;
            }
            var _loc_3:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._numbers[_loc_1] = readInt();
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 101124;
        }// end function

        public function get lines() : Vector.<int>
        {
            return this._lines;
        }// end function

        public function set lines(param1:Vector.<int>) : void
        {
            this._lines = param1;
            return;
        }// end function

        public function get numbers() : Vector.<int>
        {
            return this._numbers;
        }// end function

        public function set numbers(param1:Vector.<int>) : void
        {
            this._numbers = param1;
            return;
        }// end function

    }
}
