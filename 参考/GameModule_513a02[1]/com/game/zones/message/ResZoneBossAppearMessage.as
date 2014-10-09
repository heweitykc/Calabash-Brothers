package com.game.zones.message
{
    import com.game.zones.bean.*;
    import net.*;

    public class ResZoneBossAppearMessage extends Message
    {
        private var _zoenmonstrinfo:ZoneMonstrInfo;

        public function ResZoneBossAppearMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._zoenmonstrinfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._zoenmonstrinfo = readBean(ZoneMonstrInfo) as ZoneMonstrInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 128111;
        }// end function

        public function get zoenmonstrinfo() : ZoneMonstrInfo
        {
            return this._zoenmonstrinfo;
        }// end function

        public function set zoenmonstrinfo(param1:ZoneMonstrInfo) : void
        {
            this._zoenmonstrinfo = param1;
            return;
        }// end function

    }
}
