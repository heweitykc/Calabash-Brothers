package com.game.ybcard.message
{
    import net.*;

    public class ResYBCardToClientMessage extends Message
    {
        private var _yuanbaonum:int;
        private var _num:int;
        private var _type:int;

        public function ResYBCardToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._yuanbaonum);
            writeInt(this._num);
            writeByte(this._type);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._yuanbaonum = readInt();
            this._num = readInt();
            this._type = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 139101;
        }// end function

        public function get yuanbaonum() : int
        {
            return this._yuanbaonum;
        }// end function

        public function set yuanbaonum(param1:int) : void
        {
            this._yuanbaonum = param1;
            return;
        }// end function

        public function get num() : int
        {
            return this._num;
        }// end function

        public function set num(param1:int) : void
        {
            this._num = param1;
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
