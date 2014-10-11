package com.game.horse.message
{
    import net.*;

    public class ResRidingCountdownMessage extends Message
    {
        private var _time:int;

        public function ResRidingCountdownMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._time);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._time = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 126102;
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

    }
}
