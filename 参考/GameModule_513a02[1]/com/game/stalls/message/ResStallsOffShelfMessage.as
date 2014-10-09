package com.game.stalls.message
{
    import com.game.stalls.bean.*;
    import net.*;

    public class ResStallsOffShelfMessage extends Message
    {
        private var _stallsinfo:StallsInfo;

        public function ResStallsOffShelfMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._stallsinfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._stallsinfo = readBean(StallsInfo) as StallsInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 123107;
        }// end function

        public function get stallsinfo() : StallsInfo
        {
            return this._stallsinfo;
        }// end function

        public function set stallsinfo(param1:StallsInfo) : void
        {
            this._stallsinfo = param1;
            return;
        }// end function

    }
}
