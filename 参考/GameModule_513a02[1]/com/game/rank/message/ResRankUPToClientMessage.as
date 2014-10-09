package com.game.rank.message
{
    import com.game.rank.bean.*;
    import com.game.utils.*;
    import net.*;

    public class ResRankUPToClientMessage extends Message
    {
        private var _playerid:long;
        private var _rankinfo:Rankinfo;

        public function ResRankUPToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._playerid);
            writeBean(this._rankinfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playerid = readLong();
            this._rankinfo = readBean(Rankinfo) as Rankinfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 117103;
        }// end function

        public function get playerid() : long
        {
            return this._playerid;
        }// end function

        public function set playerid(param1:long) : void
        {
            this._playerid = param1;
            return;
        }// end function

        public function get rankinfo() : Rankinfo
        {
            return this._rankinfo;
        }// end function

        public function set rankinfo(param1:Rankinfo) : void
        {
            this._rankinfo = param1;
            return;
        }// end function

    }
}
