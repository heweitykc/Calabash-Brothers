package com.game.task.bean
{
    import net.*;

    public class TargetMonsterInfo extends Bean
    {
        private var _state:int;
        private var _modelId:int;
        private var _serverId:int;
        private var _lineId:int;
        private var _hp:int;
        private var _mapId:int;
        private var _killer:String;
        private var _reliveTime:int;
        private var _birthX:int;
        private var _birthY:int;

        public function TargetMonsterInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._state);
            writeInt(this._modelId);
            writeInt(this._serverId);
            writeInt(this._lineId);
            writeInt(this._hp);
            writeInt(this._mapId);
            writeString(this._killer);
            writeInt(this._reliveTime);
            writeShort(this._birthX);
            writeShort(this._birthY);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._state = readByte();
            this._modelId = readInt();
            this._serverId = readInt();
            this._lineId = readInt();
            this._hp = readInt();
            this._mapId = readInt();
            this._killer = readString();
            this._reliveTime = readInt();
            this._birthX = readShort();
            this._birthY = readShort();
            return true;
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

        public function get modelId() : int
        {
            return this._modelId;
        }// end function

        public function set modelId(param1:int) : void
        {
            this._modelId = param1;
            return;
        }// end function

        public function get serverId() : int
        {
            return this._serverId;
        }// end function

        public function set serverId(param1:int) : void
        {
            this._serverId = param1;
            return;
        }// end function

        public function get lineId() : int
        {
            return this._lineId;
        }// end function

        public function set lineId(param1:int) : void
        {
            this._lineId = param1;
            return;
        }// end function

        public function get hp() : int
        {
            return this._hp;
        }// end function

        public function set hp(param1:int) : void
        {
            this._hp = param1;
            return;
        }// end function

        public function get mapId() : int
        {
            return this._mapId;
        }// end function

        public function set mapId(param1:int) : void
        {
            this._mapId = param1;
            return;
        }// end function

        public function get killer() : String
        {
            return this._killer;
        }// end function

        public function set killer(param1:String) : void
        {
            this._killer = param1;
            return;
        }// end function

        public function get reliveTime() : int
        {
            return this._reliveTime;
        }// end function

        public function set reliveTime(param1:int) : void
        {
            this._reliveTime = param1;
            return;
        }// end function

        public function get birthX() : int
        {
            return this._birthX;
        }// end function

        public function set birthX(param1:int) : void
        {
            this._birthX = param1;
            return;
        }// end function

        public function get birthY() : int
        {
            return this._birthY;
        }// end function

        public function set birthY(param1:int) : void
        {
            this._birthY = param1;
            return;
        }// end function

    }
}
