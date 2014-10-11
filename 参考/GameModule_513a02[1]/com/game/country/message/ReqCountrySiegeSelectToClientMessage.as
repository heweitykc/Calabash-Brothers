package com.game.country.message
{
    import net.*;

    public class ReqCountrySiegeSelectToClientMessage extends Message
    {
        private var _guildString:String;

        public function ReqCountrySiegeSelectToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this._guildString);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._guildString = readString();
            return true;
        }// end function

        override public function getId() : int
        {
            return 146101;
        }// end function

        public function get guildString() : String
        {
            return this._guildString;
        }// end function

        public function set guildString(param1:String) : void
        {
            this._guildString = param1;
            return;
        }// end function

    }
}
