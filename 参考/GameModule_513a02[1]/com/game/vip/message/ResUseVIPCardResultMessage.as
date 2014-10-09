package com.game.vip.message
{
    import com.game.vip.bean.*;
    import net.*;

    public class ResUseVIPCardResultMessage extends Message
    {
        private var _usesuccess:int;
        private var _vipinfo:VipInfo;

        public function ResUseVIPCardResultMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._usesuccess);
            writeBean(this._vipinfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._usesuccess = readByte();
            this._vipinfo = readBean(VipInfo) as VipInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 147102;
        }// end function

        public function get usesuccess() : int
        {
            return this._usesuccess;
        }// end function

        public function set usesuccess(param1:int) : void
        {
            this._usesuccess = param1;
            return;
        }// end function

        public function get vipinfo() : VipInfo
        {
            return this._vipinfo;
        }// end function

        public function set vipinfo(param1:VipInfo) : void
        {
            this._vipinfo = param1;
            return;
        }// end function

    }
}
