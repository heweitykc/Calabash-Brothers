package com.game.newactivity.message
{
    import __AS3__.vec.*;
    import net.*;

    public class ResGetNewActivityAward extends Message
    {
        private var _result:int;
        private var _activityId:int;
        private var _items:Vector.<int>;

        public function ResGetNewActivityAward()
        {
            this._items = new Vector.<int>;
            return;
        }// end function

        public function set result(param1:int) : void
        {
            this._result = param1;
            return;
        }// end function

        public function get result() : int
        {
            return this._result;
        }// end function

        public function set activityId(param1:int) : void
        {
            this._activityId = param1;
            return;
        }// end function

        public function get activityId() : int
        {
            return this._activityId;
        }// end function

        public function set items(param1:Vector.<int>) : void
        {
            this._items = param1;
            return;
        }// end function

        public function get items() : Vector.<int>
        {
            return this._items;
        }// end function

        override public function getId() : int
        {
            return 511004;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._result);
            writeInt(this._activityId);
            writeShort(this._items.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._items.length)
            {
                
                writeInt(this._items[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._result = readByte();
            this._activityId = readInt();
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._items[_loc_2] = readInt();
                _loc_2++;
            }
            return true;
        }// end function

    }
}
