package com.game.arrow.bean
{
    import net.*;

    public class StarInfo extends Bean
    {
        private var _starmainlv:int;
        private var _starsublv:int;

        public function StarInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._starmainlv);
            writeInt(this._starsublv);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._starmainlv = readInt();
            this._starsublv = readInt();
            return true;
        }// end function

        public function get starmainlv() : int
        {
            return this._starmainlv;
        }// end function

        public function set starmainlv(param1:int) : void
        {
            this._starmainlv = param1;
            return;
        }// end function

        public function get starsublv() : int
        {
            return this._starsublv;
        }// end function

        public function set starsublv(param1:int) : void
        {
            this._starsublv = param1;
            return;
        }// end function

    }
}
