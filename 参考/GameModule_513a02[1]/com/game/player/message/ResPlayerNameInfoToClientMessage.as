package com.game.player.message
{
    import net.*;

    public class ResPlayerNameInfoToClientMessage extends Message
    {
        private var _changeName:int;
        private var _changeUser:int;

        public function ResPlayerNameInfoToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._changeName);
            writeByte(this._changeUser);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._changeName = readByte();
            this._changeUser = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 103128;
        }// end function

        public function get changeName() : int
        {
            return this._changeName;
        }// end function

        public function set changeName(param1:int) : void
        {
            this._changeName = param1;
            return;
        }// end function

        public function get changeUser() : int
        {
            return this._changeUser;
        }// end function

        public function set changeUser(param1:int) : void
        {
            this._changeUser = param1;
            return;
        }// end function

    }
}
