package com.game.equipstreng.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqStrengItemToServerMessage extends Message
    {
        private var _itemid:long;
        private var _type:int;
        private var _prival:int;

        public function ReqStrengItemToServerMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._itemid);
            writeByte(this._type);
            writeByte(this._prival);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._itemid = readLong();
            this._type = readByte();
            this._prival = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 130201;
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

        public function get prival() : int
        {
            return this._prival;
        }// end function

        public function set prival(param1:int) : void
        {
            this._prival = param1;
            return;
        }// end function

    }
}
