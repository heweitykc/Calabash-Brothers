package com.game.player.message
{
    import net.*;

    public class ResPlayerPrisonStateMessage extends Message
    {
        private var _prisontimes:int;
        private var _prisonremaintime:int;

        public function ResPlayerPrisonStateMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._prisontimes);
            writeInt(this._prisonremaintime);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._prisontimes = readInt();
            this._prisonremaintime = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 103134;
        }// end function

        public function get prisontimes() : int
        {
            return this._prisontimes;
        }// end function

        public function set prisontimes(param1:int) : void
        {
            this._prisontimes = param1;
            return;
        }// end function

        public function get prisonremaintime() : int
        {
            return this._prisonremaintime;
        }// end function

        public function set prisonremaintime(param1:int) : void
        {
            this._prisonremaintime = param1;
            return;
        }// end function

    }
}
