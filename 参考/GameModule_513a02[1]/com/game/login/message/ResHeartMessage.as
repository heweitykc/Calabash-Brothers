package com.game.login.message
{
    import net.*;

    public class ResHeartMessage extends Message
    {
        private var _time:int;
        private var _time2:int;

        public function ResHeartMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._time);
            writeInt(this._time2);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._time = readInt();
            this._time2 = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 100108;
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

        public function get time2() : int
        {
            return this._time2;
        }// end function

        public function set time2(param1:int) : void
        {
            this._time2 = param1;
            return;
        }// end function

    }
}
