package com.game.country.message
{
    import net.*;

    public class ReqKingCityChestSelectToGameMessage extends Message
    {
        private var _idx:int;

        public function ReqKingCityChestSelectToGameMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._idx);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._idx = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 146205;
        }// end function

        public function get idx() : int
        {
            return this._idx;
        }// end function

        public function set idx(param1:int) : void
        {
            this._idx = param1;
            return;
        }// end function

    }
}
