package com.game.guild.message
{
    import net.*;

    public class ResGuildChangeBulletinToClientMessage extends Message
    {
        private var _btErrorCode:int;

        public function ResGuildChangeBulletinToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._btErrorCode);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._btErrorCode = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 121113;
        }// end function

        public function get btErrorCode() : int
        {
            return this._btErrorCode;
        }// end function

        public function set btErrorCode(param1:int) : void
        {
            this._btErrorCode = param1;
            return;
        }// end function

    }
}
