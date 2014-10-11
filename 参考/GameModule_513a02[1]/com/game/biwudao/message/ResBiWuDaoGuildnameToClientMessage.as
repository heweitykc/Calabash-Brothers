package com.game.biwudao.message
{
    import com.game.utils.*;
    import net.*;

    public class ResBiWuDaoGuildnameToClientMessage extends Message
    {
        private var _guildname:String;
        private var _guildid:long;

        public function ResBiWuDaoGuildnameToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this._guildname);
            writeLong(this._guildid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._guildname = readString();
            this._guildid = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 157104;
        }// end function

        public function get guildname() : String
        {
            return this._guildname;
        }// end function

        public function set guildname(param1:String) : void
        {
            this._guildname = param1;
            return;
        }// end function

        public function get guildid() : long
        {
            return this._guildid;
        }// end function

        public function set guildid(param1:long) : void
        {
            this._guildid = param1;
            return;
        }// end function

    }
}
