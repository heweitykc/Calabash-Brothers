package com.game.card.message
{
    import net.*;

    public class ReqCardToServerMessage extends Message
    {
        private var _card:String;

        public function ReqCardToServerMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this._card);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._card = readString();
            return true;
        }// end function

        override public function getId() : int
        {
            return 137101;
        }// end function

        public function get card() : String
        {
            return this._card;
        }// end function

        public function set card(param1:String) : void
        {
            this._card = param1;
            return;
        }// end function

    }
}
