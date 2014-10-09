package com.game.equipstreng.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqAddAttributeItemToServerMessage extends Message
    {
        private var _itemid:long;
        private var _type:int;

        public function ReqAddAttributeItemToServerMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._itemid);
            writeByte(this._type);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._itemid = readLong();
            this._type = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 103892;
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
