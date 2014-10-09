package com.game.team.message
{
    import net.*;

    public class ResTeamSetToClientMessage extends Message
    {
        private var _autoIntoteamapply:int;
        private var _autoTeaminvited:int;

        public function ResTeamSetToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._autoIntoteamapply);
            writeByte(this._autoTeaminvited);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._autoIntoteamapply = readByte();
            this._autoTeaminvited = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 118113;
        }// end function

        public function get autoIntoteamapply() : int
        {
            return this._autoIntoteamapply;
        }// end function

        public function set autoIntoteamapply(param1:int) : void
        {
            this._autoIntoteamapply = param1;
            return;
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
