package com.game.country.bean
{
    import net.*;

    public class JobAwardInfo extends Bean
    {
        private var _level:int;
        private var _status:int;

        public function JobAwardInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._level);
            writeInt(this._status);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._level = readInt();
            this._status = readInt();
            return true;
        }// end function

        public function get level() : int
        {
            return this._level;
        }// end function

        public function set level(param1:int) : void
        {
            this._level = param1;
            return;
        }// end function

        public function get status() : int
        {
            return this._status;
        }// end function

        public function set status(param1:int) : void
        {
            this._status = param1;
            return;
        }// end function

    }
}
