package com.game.dazuo.message
{
    import __AS3__.vec.*;
    import com.game.utils.*;
    import net.*;

    public class ResDazuoStateChangeMessage extends Message
    {
        private var _state:int;
        private var _otherid:long;
        private var _otherx:int;
        private var _othery:int;
        private var _startTime:long;
        private var _eruptCount:int;
        private var _eruptExp:int;
        private var _eruptZQ:int;
        private var _onwerPets:Vector.<long>;
        private var _otherPets:Vector.<long>;

        public function ResDazuoStateChangeMessage()
        {
            this._onwerPets = new Vector.<long>;
            this._otherPets = new Vector.<long>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeByte(this._state);
            writeLong(this._otherid);
            writeShort(this._otherx);
            writeShort(this._othery);
            writeLong(this._startTime);
            writeInt(this._eruptCount);
            writeInt(this._eruptExp);
            writeInt(this._eruptZQ);
            writeShort(this._onwerPets.length);
            _loc_1 = 0;
            while (_loc_1 < this._onwerPets.length)
            {
                
                writeLong(this._onwerPets[_loc_1]);
                _loc_1++;
            }
            writeShort(this._otherPets.length);
            _loc_1 = 0;
            while (_loc_1 < this._otherPets.length)
            {
                
                writeLong(this._otherPets[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            this._state = readByte();
            this._otherid = readLong();
            this._otherx = readShort();
            this._othery = readShort();
            this._startTime = readLong();
            this._eruptCount = readInt();
            this._eruptExp = readInt();
            this._eruptZQ = readInt();
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._onwerPets[_loc_1] = readLong();
                _loc_1++;
            }
            var _loc_3:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_3)
            {
                
                this._otherPets[_loc_1] = readLong();
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 136101;
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

        public function get otherid() : long
        {
            return this._otherid;
        }// end function

        public function set otherid(param1:long) : void
        {
            this._otherid = param1;
            return;
        }// end function

        public function get otherx() : int
        {
            return this._otherx;
        }// end function

        public function set otherx(param1:int) : void
        {
            this._otherx = param1;
            return;
        }// end function

        public function get othery() : int
        {
            return this._othery;
        }// end function

        public function set othery(param1:int) : void
        {
            this._othery = param1;
            return;
        }// end function

        public function get startTime() : long
        {
            return this._startTime;
        }// end function

        public function set startTime(param1:long) : void
        {
            this._startTime = param1;
            return;
        }// end function

        public function get eruptCount() : int
        {
            return this._eruptCount;
        }// end function

        public function set eruptCount(param1:int) : void
        {
            this._eruptCount = param1;
            return;
        }// end function

        public function get eruptExp() : int
        {
            return this._eruptExp;
        }// end function

        public function set eruptExp(param1:int) : void
        {
            this._eruptExp = param1;
            return;
        }// end function

        public function get eruptZQ() : int
        {
            return this._eruptZQ;
        }// end function

        public function set eruptZQ(param1:int) : void
        {
            this._eruptZQ = param1;
            return;
        }// end function

        public function get onwerPets() : Vector.<long>
        {
            return this._onwerPets;
        }// end function

        public function set onwerPets(param1:Vector.<long>) : void
        {
            this._onwerPets = param1;
            return;
        }// end function

        public function get otherPets() : Vector.<long>
        {
            return this._otherPets;
        }// end function

        public function set otherPets(param1:Vector.<long>) : void
        {
            this._otherPets = param1;
            return;
        }// end function

    }
}
