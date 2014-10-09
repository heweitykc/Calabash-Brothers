package com.game.masterequip.message
{
    import net.*;

    public class ResElementValueMessage extends Message
    {
        private var _value:int;

        public function ResElementValueMessage()
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
            return 600044;
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
