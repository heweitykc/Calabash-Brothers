package com.game.guild.message
{
    import net.*;

    public class ResGuildImpeachToClientMessage extends Message
    {
        private var _isImpeach:int;

        public function ResGuildImpeachToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._isImpeach);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._isImpeach = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 529120;
        }// end function

        public function get isImpeach() : int
        {
            return this._isImpeach;
        }// end function

        public function set isImpeach(param1:int) : void
        {
            this._isImpeach = param1;
            return;
        }// end function

    }
}
