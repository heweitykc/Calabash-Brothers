package com.game.map.message
{
    import __AS3__.vec.*;
    import com.game.structs.*;
    import com.game.utils.*;
    import net.*;

    public class ResRunPositionsMessage extends Message
    {
        private var _personId:long;
        private var _position:Position;
        private var _positions:Vector.<int>;

        public function ResRunPositionsMessage()
        {
            this._positions = new Vector.<int>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeLong(this._personId);
            writeBean(this._position);
            writeShort(this._positions.length);
            _loc_1 = 0;
            while (_loc_1 < this._positions.length)
            {
                
                writeByte(this._positions[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            this._personId = readLong();
            this._position = readBean(Position) as Position;
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._positions[_loc_1] = readByte();
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 101110;
        }// end function

        public function get personId() : long
        {
            return this._personId;
        }// end function

        public function set personId(param1:long) : void
        {
            this._personId = param1;
            return;
        }// end function

        public function get position() : Position
        {
            return this._position;
        }// end function

        public function set position(param1:Position) : void
        {
            this._position = param1;
            return;
        }// end function

        public function get positions() : Vector.<int>
        {
            return this._positions;
        }// end function

        public function set positions(param1:Vector.<int>) : void
        {
            this._positions = param1;
            return;
        }// end function

    }
}
