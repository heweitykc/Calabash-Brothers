package com.game.equipstreng.message
{
    import com.game.utils.*;
    import net.*;

    public class ResStrengthenStateMessage extends Message
    {
        private var _itemid:long;
        private var _time:int;
        private var _timesum:int;
        private var _yuanbao:int;

        public function ResStrengthenStateMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._itemid);
            writeInt(this._time);
            writeInt(this._timesum);
            writeInt(this._yuanbao);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._itemid = readLong();
            this._time = readInt();
            this._timesum = readInt();
            this._yuanbao = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 130104;
        }// end function

        public function get itemid() : long
        {
            return this._itemid;
        }// end function

        public function set itemid(param1:long) : void
        {
            this._itemid = param1;
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

        public function get timesum() : int
        {
            return this._timesum;
        }// end function

        public function set timesum(param1:int) : void
        {
            this._timesum = param1;
            return;
        }// end function

        public function get yuanbao() : int
        {
            return this._yuanbao;
        }// end function

        public function set yuanbao(param1:int) : void
        {
            this._yuanbao = param1;
            return;
        }// end function

    }
}
