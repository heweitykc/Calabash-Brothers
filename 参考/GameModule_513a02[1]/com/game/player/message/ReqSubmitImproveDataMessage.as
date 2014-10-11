package com.game.player.message
{
    import net.*;

    public class ReqSubmitImproveDataMessage extends Message
    {
        private var _name:String;
        private var _idCard:String;

        public function ReqSubmitImproveDataMessage()
        {
            return;
        }// end function

        public function set name(param1:String) : void
        {
            this._name = param1;
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function set idCard(param1:String) : void
        {
            this._idCard = param1;
            return;
        }// end function

        public function get idCard() : String
        {
            return this._idCard;
        }// end function

        override public function getId() : int
        {
            return 529214;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this._name);
            writeString(this._idCard);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._name = readString();
            this._idCard = readString();
            return true;
        }// end function

    }
}
