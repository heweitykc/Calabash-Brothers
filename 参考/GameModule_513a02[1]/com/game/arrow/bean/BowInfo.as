package com.game.arrow.bean
{
    import net.*;

    public class BowInfo extends Bean
    {
        private var _bowmainlv:int;
        private var _bowsublv:int;

        public function BowInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._bowmainlv);
            writeInt(this._bowsublv);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._bowmainlv = readInt();
            this._bowsublv = readInt();
            return true;
        }// end function

        public function get bowmainlv() : int
        {
            return this._bowmainlv;
        }// end function

        public function set bowmainlv(param1:int) : void
        {
            this._bowmainlv = param1;
            return;
        }// end function

        public function get bowsublv() : int
        {
            return this._bowsublv;
        }// end function

        public function set bowsublv(param1:int) : void
        {
            this._bowsublv = param1;
            return;
        }// end function

    }
}
