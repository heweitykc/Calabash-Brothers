package com.game.epalace.bean
{
    import net.*;

    public class EpalaceInfo extends Bean
    {
        private var _direction:int;
        private var _currentpos:int;
        private var _eventid:int;
        private var _forkdirection:int;

        public function EpalaceInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._direction);
            writeByte(this._currentpos);
            writeInt(this._eventid);
            writeByte(this._forkdirection);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._direction = readByte();
            this._currentpos = readByte();
            this._eventid = readInt();
            this._forkdirection = readByte();
            return true;
        }// end function

        public function get direction() : int
        {
            return this._direction;
        }// end function

        public function set direction(param1:int) : void
        {
            this._direction = param1;
            return;
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

        public function get eventid() : int
        {
            return this._eventid;
        }// end function

        public function set eventid(param1:int) : void
        {
            this._eventid = param1;
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
