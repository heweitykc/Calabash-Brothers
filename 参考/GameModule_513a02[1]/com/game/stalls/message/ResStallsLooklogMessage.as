package com.game.stalls.message
{
    import com.game.stalls.bean.*;
    import net.*;

    public class ResStallsLooklogMessage extends Message
    {
        private var _stallslogInfo:StallsLogInfo;

        public function ResStallsLooklogMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._stallslogInfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._stallslogInfo = readBean(StallsLogInfo) as StallsLogInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 123109;
        }// end function

        public function get stallslogInfo() : StallsLogInfo
        {
            return this._stallslogInfo;
        }// end function

        public function set stallslogInfo(param1:StallsLogInfo) : void
        {
            this._stallslogInfo = param1;
            return;
        }// end function

    }
}
