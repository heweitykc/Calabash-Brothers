package com.game.player.message
{
    import net.*;

    public class ResGetActivatedStarInfo extends Message
    {
        private var _activeCount:int;
        private var _prob:int;

        public function ResGetActivatedStarInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._activeCount);
            writeByte(this._prob);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._activeCount = readByte();
            this._prob = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 575001;
        }// end function

        public function get activeCount() : int
        {
            return this._activeCount;
        }// end function

        public function set activeCount(param1:int) : void
        {
            this._activeCount = param1;
            return;
        }// end function

        public function get prob() : int
        {
            return this._prob;
        }// end function

        public function set prob(param1:int) : void
        {
            this._prob = param1;
            return;
        }// end function

    }
}
