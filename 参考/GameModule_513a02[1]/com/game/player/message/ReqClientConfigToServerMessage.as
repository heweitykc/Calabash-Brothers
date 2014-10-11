package com.game.player.message
{
    import net.*;

    public class ReqClientConfigToServerMessage extends Message
    {
        private var _value:int;

        public function ReqClientConfigToServerMessage()
        {
            return;
        }// end function

        public function set value(param1:int) : void
        {
            this._value = param1;
            return;
        }// end function

        public function get value() : int
        {
            return this._value;
        }// end function

        override public function getId() : int
        {
            return 504301;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._value);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._value = readInt();
            return true;
        }// end function

    }
}
