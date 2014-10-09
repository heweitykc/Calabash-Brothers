package com.game.pray.message
{
    import com.game.pray.bean.*;
    import net.*;

    public class ResPrayInfoMessage extends Message
    {
        private var _prayInfo:PrayInfo;

        public function ResPrayInfoMessage()
        {
            return;
        }// end function

        public function set prayInfo(param1:PrayInfo) : void
        {
            this._prayInfo = param1;
            return;
        }// end function

        public function get prayInfo() : PrayInfo
        {
            return this._prayInfo;
        }// end function

        override public function getId() : int
        {
            return 528332;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._prayInfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._prayInfo = readBean(PrayInfo) as PrayInfo;
            return true;
        }// end function

    }
}
