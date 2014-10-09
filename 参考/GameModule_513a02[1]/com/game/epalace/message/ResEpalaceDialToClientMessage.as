package com.game.epalace.message
{
    import net.*;

    public class ResEpalaceDialToClientMessage extends Message
    {
        private var _currentpos:int;
        private var _forkdirection:int;

        public function ResEpalaceDialToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._currentpos);
            writeByte(this._forkdirection);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._currentpos = readByte();
            this._forkdirection = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 143105;
        }// end function

        public function get currentpos() : int
        {
            return this._currentpos;
        }// end function

        public function set currentpos(param1:int) : void
        {
            this._currentpos = param1;
            return;
        }// end function

        public function get forkdirection() : int
        {
            return this._forkdirection;
        }// end function

        public function set forkdirection(param1:int) : void
        {
            this._forkdirection = param1;
            return;
        }// end function

    }
}
