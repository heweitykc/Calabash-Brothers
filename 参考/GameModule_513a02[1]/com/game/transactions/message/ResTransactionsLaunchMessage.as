package com.game.transactions.message
{
    import com.game.transactions.bean.*;
    import com.game.utils.*;
    import net.*;

    public class ResTransactionsLaunchMessage extends Message
    {
        private var _rolemodeinfo:RoleModeInfo;
        private var _launchtime:int;
        private var _transid:long;

        public function ResTransactionsLaunchMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._rolemodeinfo);
            writeInt(this._launchtime);
            writeLong(this._transid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._rolemodeinfo = readBean(RoleModeInfo) as RoleModeInfo;
            this._launchtime = readInt();
            this._transid = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 122101;
        }// end function

        public function get rolemodeinfo() : RoleModeInfo
        {
            return this._rolemodeinfo;
        }// end function

        public function set rolemodeinfo(param1:RoleModeInfo) : void
        {
            this._rolemodeinfo = param1;
            return;
        }// end function

        public function get launchtime() : int
        {
            return this._launchtime;
        }// end function

        public function set launchtime(param1:int) : void
        {
            this._launchtime = param1;
            return;
        }// end function

        public function get transid() : long
        {
            return this._transid;
        }// end function

        public function set transid(param1:long) : void
        {
            this._transid = param1;
            return;
        }// end function

    }
}
