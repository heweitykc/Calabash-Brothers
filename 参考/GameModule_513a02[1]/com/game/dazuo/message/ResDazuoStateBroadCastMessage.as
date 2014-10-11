package com.game.dazuo.message
{
    import __AS3__.vec.*;
    import com.game.utils.*;
    import net.*;

    public class ResDazuoStateBroadCastMessage extends Message
    {
        private var _state:int;
        private var _roleAId:long;
        private var _roleAX:int;
        private var _roleAY:int;
        private var _roleAPets:Vector.<long>;
        private var _roleBId:long;
        private var _roleBX:int;
        private var _roleBY:int;
        private var _roleBPets:Vector.<long>;

        public function ResDazuoStateBroadCastMessage()
        {
            this._roleAPets = new Vector.<long>;
            this._roleBPets = new Vector.<long>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeByte(this._state);
            writeLong(this._roleAId);
            writeShort(this._roleAX);
            writeShort(this._roleAY);
            writeShort(this._roleAPets.length);
            _loc_1 = 0;
            while (_loc_1 < this._roleAPets.length)
            {
                
                writeLong(this._roleAPets[_loc_1]);
                _loc_1++;
            }
            writeLong(this._roleBId);
            writeShort(this._roleBX);
            writeShort(this._roleBY);
            writeShort(this._roleBPets.length);
            _loc_1 = 0;
            while (_loc_1 < this._roleBPets.length)
            {
                
                writeLong(this._roleBPets[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            this._state = readByte();
            this._roleAId = readLong();
            this._roleAX = readShort();
            this._roleAY = readShort();
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._roleAPets[_loc_1] = readLong();
                _loc_1++;
            }
            this._roleBId = readLong();
            this._roleBX = readShort();
            this._roleBY = readShort();
            var _loc_3:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_3)
            {
                
                this._roleBPets[_loc_1] = readLong();
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 136102;
        }// end function

        public function get state() : int
        {
            return this._state;
        }// end function

        public function set state(param1:int) : void
        {
            this._state = param1;
            return;
        }// end function

        public function get roleAId() : long
        {
            return this._roleAId;
        }// end function

        public function set roleAId(param1:long) : void
        {
            this._roleAId = param1;
            return;
        }// end function

        public function get roleAX() : int
        {
            return this._roleAX;
        }// end function

        public function set roleAX(param1:int) : void
        {
            this._roleAX = param1;
            return;
        }// end function

        public function get roleAY() : int
        {
            return this._roleAY;
        }// end function

        public function set roleAY(param1:int) : void
        {
            this._roleAY = param1;
            return;
        }// end function

        public function get roleAPets() : Vector.<long>
        {
            return this._roleAPets;
        }// end function

        public function set roleAPets(param1:Vector.<long>) : void
        {
            this._roleAPets = param1;
            return;
        }// end function

        public function get roleBId() : long
        {
            return this._roleBId;
        }// end function

        public function set roleBId(param1:long) : void
        {
            this._roleBId = param1;
            return;
        }// end function

        public function get roleBX() : int
        {
            return this._roleBX;
        }// end function

        public function set roleBX(param1:int) : void
        {
            this._roleBX = param1;
            return;
        }// end function

        public function get roleBY() : int
        {
            return this._roleBY;
        }// end function

        public function set roleBY(param1:int) : void
        {
            this._roleBY = param1;
            return;
        }// end function

        public function get roleBPets() : Vector.<long>
        {
            return this._roleBPets;
        }// end function

        public function set roleBPets(param1:Vector.<long>) : void
        {
            this._roleBPets = param1;
            return;
        }// end function

    }
}
