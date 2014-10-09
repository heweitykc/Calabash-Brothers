package com.game.horse.message
{
    import net.*;

    public class ReshorseReceiveTimerMessage extends Message
    {
        private var _second:int;
        private var _secondsum:int;
        private var _type:int;

        public function ReshorseReceiveTimerMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._second);
            writeInt(this._secondsum);
            writeByte(this._type);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._second = readInt();
            this._secondsum = readInt();
            this._type = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 126109;
        }// end function

        public function get second() : int
        {
            return this._second;
        }// end function

        public function set second(param1:int) : void
        {
            this._second = param1;
            return;
        }// end function

        public function get secondsum() : int
        {
            return this._secondsum;
        }// end function

        public function set secondsum(param1:int) : void
        {
            this._secondsum = param1;
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
