package com.game.summonpet.message
{
    import __AS3__.vec.*;
    import com.game.structs.*;
    import com.game.utils.*;
    import net.*;

    public class ResSummonPetRunPositionsMessage extends Message
    {
        private var _petId:long;
        private var _position:Position;
        private var _positions:Vector.<int>;

        public function ResSummonPetRunPositionsMessage()
        {
            this._positions = new Vector.<int>;
            return;
        }// end function

        public function set petId(param1:long) : void
        {
            this._petId = param1;
            return;
        }// end function

        public function get petId() : long
        {
            return this._petId;
        }// end function

        public function set position(param1:Position) : void
        {
            this._position = param1;
            return;
        }// end function

        public function get position() : Position
        {
            return this._position;
        }// end function

        public function set positions(param1:Vector.<int>) : void
        {
            this._positions = param1;
            return;
        }// end function

        public function get positions() : Vector.<int>
        {
            return this._positions;
        }// end function

        override public function getId() : int
        {
            return 501122;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._petId);
            writeBean(this._position);
            writeShort(this._positions.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._positions.length)
            {
                
                writeByte(this._positions[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._petId = readLong();
            this._position = readBean(Position) as Position;
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._positions[_loc_2] = readByte();
                _loc_2++;
            }
            return true;
        }// end function

    }
}
