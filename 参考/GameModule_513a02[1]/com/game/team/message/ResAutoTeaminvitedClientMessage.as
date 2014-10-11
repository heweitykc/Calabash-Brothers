package com.game.team.message
{
    import net.*;

    public class ResAutoTeaminvitedClientMessage extends Message
    {
        private var _autoTeaminvited:int;

        public function ResAutoTeaminvitedClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._autoTeaminvited);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._autoTeaminvited = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 118106;
        }// end function

        public function get autoTeaminvited() : int
        {
            return this._autoTeaminvited;
        }// end function

        public function set autoTeaminvited(param1:int) : void
        {
            this._autoTeaminvited = param1;
            return;
        }// end function

    }
}
