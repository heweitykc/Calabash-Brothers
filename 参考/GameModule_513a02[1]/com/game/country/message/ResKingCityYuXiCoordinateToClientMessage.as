package com.game.country.message
{
    import net.*;

    public class ResKingCityYuXiCoordinateToClientMessage extends Message
    {
        private var _mx:int;
        private var _my:int;

        public function ResKingCityYuXiCoordinateToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeShort(this._mx);
            writeShort(this._my);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._mx = readShort();
            this._my = readShort();
            return true;
        }// end function

        override public function getId() : int
        {
            return 146111;
        }// end function

        public function get mx() : int
        {
            return this._mx;
        }// end function

        public function set mx(param1:int) : void
        {
            this._mx = param1;
            return;
        }// end function

        public function get my() : int
        {
            return this._my;
        }// end function

        public function set my(param1:int) : void
        {
            this._my = param1;
            return;
        }// end function

    }
}
