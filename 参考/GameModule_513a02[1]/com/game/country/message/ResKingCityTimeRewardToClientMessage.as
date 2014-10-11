package com.game.country.message
{
    import com.game.country.bean.*;
    import net.*;

    public class ResKingCityTimeRewardToClientMessage extends Message
    {
        private var _warrewardinfo:WarRewardInfo;

        public function ResKingCityTimeRewardToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._warrewardinfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._warrewardinfo = readBean(WarRewardInfo) as WarRewardInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 146110;
        }// end function

        public function get warrewardinfo() : WarRewardInfo
        {
            return this._warrewardinfo;
        }// end function

        public function set warrewardinfo(param1:WarRewardInfo) : void
        {
            this._warrewardinfo = param1;
            return;
        }// end function

    }
}
