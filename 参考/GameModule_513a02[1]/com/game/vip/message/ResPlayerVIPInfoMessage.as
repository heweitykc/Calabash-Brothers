package com.game.vip.message
{
    import com.game.vip.bean.*;
    import net.*;

    public class ResPlayerVIPInfoMessage extends Message
    {
        private var _vipinfo:VipInfo;

        public function ResPlayerVIPInfoMessage()
        {
            return;
        }// end function

        public function set vipinfo(param1:VipInfo) : void
        {
            this._vipinfo = param1;
            return;
        }// end function

        public function get vipinfo() : VipInfo
        {
            return this._vipinfo;
        }// end function

        override public function getId() : int
        {
            return 147101;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._vipinfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._vipinfo = readBean(VipInfo) as VipInfo;
            return true;
        }// end function

    }
}
