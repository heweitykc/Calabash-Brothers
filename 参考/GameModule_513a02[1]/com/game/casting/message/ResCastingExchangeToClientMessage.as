package com.game.casting.message
{
    import net.*;

    public class ResCastingExchangeToClientMessage extends Message
    {
        private var _technologyPoint:int;
        private var _itemID:int;

        public function ResCastingExchangeToClientMessage()
        {
            return;
        }// end function

        public function set technologyPoint(param1:int) : void
        {
            this._technologyPoint = param1;
            return;
        }// end function

        public function get technologyPoint() : int
        {
            return this._technologyPoint;
        }// end function

        public function set itemID(param1:int) : void
        {
            this._itemID = param1;
            return;
        }// end function

        public function get itemID() : int
        {
            return this._itemID;
        }// end function

        override public function getId() : int
        {
            return 529106;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._technologyPoint);
            writeInt(this._itemID);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._technologyPoint = readInt();
            this._itemID = readInt();
            return true;
        }// end function

    }
}
