package com.game.map.message
{
    import __AS3__.vec.*;
    import com.game.structs.*;
    import net.*;

    public class ReqRunningMessage extends Message
    {
        private var _position:Position;
        private var _positions:Vector.<int>;

        public function ReqRunningMessage()
        {
            this._positions = new Vector.<int>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
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
            return 101201;
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
