package com.game.stalls.message
{
    import com.game.stalls.bean.*;
    import net.*;

    public class ResStallsBuyMessage extends Message
    {
        private var _stallsinfo:StallsInfo;
        private var _israting:int;

        public function ResStallsBuyMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._stallsinfo);
            writeByte(this._israting);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._stallsinfo = readBean(StallsInfo) as StallsInfo;
            this._israting = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 123104;
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

        public function get israting() : int
        {
            return this._israting;
        }// end function

        public function set israting(param1:int) : void
        {
            this._israting = param1;
            return;
        }// end function

    }
}
