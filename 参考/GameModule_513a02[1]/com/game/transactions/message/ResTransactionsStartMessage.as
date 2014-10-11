package com.game.transactions.message
{
    import com.game.transactions.bean.*;
    import net.*;

    public class ResTransactionsStartMessage extends Message
    {
        private var _arolemodeinfo:RoleModeInfo;
        private var _brolemodeinfo:RoleModeInfo;

        public function ResTransactionsStartMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._arolemodeinfo);
            writeBean(this._brolemodeinfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._arolemodeinfo = readBean(RoleModeInfo) as RoleModeInfo;
            this._brolemodeinfo = readBean(RoleModeInfo) as RoleModeInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 122103;
        }// end function

        public function get arolemodeinfo() : RoleModeInfo
        {
            return this._arolemodeinfo;
        }// end function

        public function set arolemodeinfo(param1:RoleModeInfo) : void
        {
            this._arolemodeinfo = param1;
            return;
        }// end function

        public function get brolemodeinfo() : RoleModeInfo
        {
            return this._brolemodeinfo;
        }// end function

        public function set brolemodeinfo(param1:RoleModeInfo) : void
        {
            this._brolemodeinfo = param1;
            return;
        }// end function

    }
}
