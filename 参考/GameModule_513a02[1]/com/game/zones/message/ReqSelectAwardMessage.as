package com.game.zones.message
{
    import net.*;

    public class ReqSelectAwardMessage extends Message
    {
        private var _idx:int;
        private var _type:int;

        public function ReqSelectAwardMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._idx);
            writeByte(this._type);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._idx = readInt();
            this._type = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 128203;
        }// end function

        public function get idx() : int
        {
            return this._idx;
        }// end function

        public function set idx(param1:int) : void
        {
            this._idx = param1;
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
