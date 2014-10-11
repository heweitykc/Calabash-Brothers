package com.game.team.message
{
    import net.*;

    public class ReqAutoIntoTeamApplyGameMessage extends Message
    {
        private var _autointoteamapply:int;

        public function ReqAutoIntoTeamApplyGameMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._autointoteamapply);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._autointoteamapply = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 118210;
        }// end function

        public function get autointoteamapply() : int
        {
            return this._autointoteamapply;
        }// end function

        public function set autointoteamapply(param1:int) : void
        {
            this._autointoteamapply = param1;
            return;
        }// end function

    }
}
