package com.game.backpack.message
{
    import net.*;

    public class ResSpiritChangeMessage extends Message
    {
        private var _spirit:int;

        public function ResSpiritChangeMessage()
        {
            return;
        }// end function

        public function set spirit(param1:int) : void
        {
            this._spirit = param1;
            return;
        }// end function

        public function get spirit() : int
        {
            return this._spirit;
        }// end function

        override public function getId() : int
        {
            return 600011;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._spirit);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._spirit = readInt();
            return true;
        }// end function

    }
}
