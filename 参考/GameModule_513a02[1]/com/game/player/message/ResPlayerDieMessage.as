package com.game.player.message
{
    import com.game.structs.*;
    import com.game.utils.*;
    import net.*;

    public class ResPlayerDieMessage extends Message
    {
        private var _personId:long;
        private var _autoRevive:int;
        private var _monstermodelid:int;
        private var _attackerid:long;
        private var _attackername:String;
        private var _position:Position;
        private var _time:int;
        private var _type:int;

        public function ResPlayerDieMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._personId);
            writeByte(this._autoRevive);
            writeInt(this._monstermodelid);
            writeLong(this._attackerid);
            writeString(this._attackername);
            writeBean(this._position);
            writeInt(this._time);
            writeByte(this._type);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._personId = readLong();
            this._autoRevive = readByte();
            this._monstermodelid = readInt();
            this._attackerid = readLong();
            this._attackername = readString();
            this._position = readBean(Position) as Position;
            this._time = readInt();
            this._type = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 103115;
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

        public function get autoRevive() : int
        {
            return this._autoRevive;
        }// end function

        public function set autoRevive(param1:int) : void
        {
            this._autoRevive = param1;
            return;
        }// end function

        public function get monstermodelid() : int
        {
            return this._monstermodelid;
        }// end function

        public function set monstermodelid(param1:int) : void
        {
            this._monstermodelid = param1;
            return;
        }// end function

        public function get attackerid() : long
        {
            return this._attackerid;
        }// end function

        public function set attackerid(param1:long) : void
        {
            this._attackerid = param1;
            return;
        }// end function

        public function get attackername() : String
        {
            return this._attackername;
        }// end function

        public function set attackername(param1:String) : void
        {
            this._attackername = param1;
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

        public function get time() : int
        {
            return this._time;
        }// end function

        public function set time(param1:int) : void
        {
            this._time = param1;
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

    }
}
