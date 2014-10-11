package com.game.map.bean
{
    import com.game.utils.*;
    import net.*;

    public class NpcInfo extends Bean
    {
        private var _npcId:long;
        private var _npcModelId:int;
        private var _npcName:String;
        private var _npcRes:String;
        private var _npcIcon:String;
        private var _dir:int;
        private var _x:int;
        private var _y:int;

        public function NpcInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._npcId);
            writeInt(this._npcModelId);
            writeString(this._npcName);
            writeString(this._npcRes);
            writeString(this._npcIcon);
            writeByte(this._dir);
            writeShort(this._x);
            writeShort(this._y);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._npcId = readLong();
            this._npcModelId = readInt();
            this._npcName = readString();
            this._npcRes = readString();
            this._npcIcon = readString();
            this._dir = readByte();
            this._x = readShort();
            this._y = readShort();
            return true;
        }// end function

        public function get npcId() : long
        {
            return this._npcId;
        }// end function

        public function set npcId(param1:long) : void
        {
            this._npcId = param1;
            return;
        }// end function

        public function get npcModelId() : int
        {
            return this._npcModelId;
        }// end function

        public function set npcModelId(param1:int) : void
        {
            this._npcModelId = param1;
            return;
        }// end function

        public function get npcName() : String
        {
            return this._npcName;
        }// end function

        public function set npcName(param1:String) : void
        {
            this._npcName = param1;
            return;
        }// end function

        public function get npcRes() : String
        {
            return this._npcRes;
        }// end function

        public function set npcRes(param1:String) : void
        {
            this._npcRes = param1;
            return;
        }// end function

        public function get npcIcon() : String
        {
            return this._npcIcon;
        }// end function

        public function set npcIcon(param1:String) : void
        {
            this._npcIcon = param1;
            return;
        }// end function

        public function get dir() : int
        {
            return this._dir;
        }// end function

        public function set dir(param1:int) : void
        {
            this._dir = param1;
            return;
        }// end function

        public function get x() : int
        {
            return this._x;
        }// end function

        public function set x(param1:int) : void
        {
            this._x = param1;
            return;
        }// end function

        public function get y() : int
        {
            return this._y;
        }// end function

        public function set y(param1:int) : void
        {
            this._y = param1;
            return;
        }// end function

    }
}
