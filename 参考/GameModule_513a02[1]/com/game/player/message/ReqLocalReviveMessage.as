package com.game.player.message
{
    import net.*;

    public class ReqLocalReviveMessage extends Message
    {
        private var _itemmodelid:int;
        private var _type:int;

        public function ReqLocalReviveMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._itemmodelid);
            writeByte(this._type);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._itemmodelid = readInt();
            this._type = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 103202;
        }// end function

        public function get itemmodelid() : int
        {
            return this._itemmodelid;
        }// end function

        public function set itemmodelid(param1:int) : void
        {
            this._itemmodelid = param1;
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
