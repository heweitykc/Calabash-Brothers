package com.game.guild.message
{
    import net.*;

    public class ReqGuildAutoArgeeAddGuildToServerMessage extends Message
    {
        private var _autoArgeeAddGuild:int;

        public function ReqGuildAutoArgeeAddGuildToServerMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._autoArgeeAddGuild);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._autoArgeeAddGuild = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 121202;
        }// end function

        public function get autoArgeeAddGuild() : int
        {
            return this._autoArgeeAddGuild;
        }// end function

        public function set autoArgeeAddGuild(param1:int) : void
        {
            this._autoArgeeAddGuild = param1;
            return;
        }// end function

    }
}
