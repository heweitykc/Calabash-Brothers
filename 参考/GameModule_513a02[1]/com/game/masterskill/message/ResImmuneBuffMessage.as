package com.game.masterskill.message
{
    import com.game.utils.*;
    import net.*;

    public class ResImmuneBuffMessage extends Message
    {
        private var _playerId:long;
        private var _type:int;

        public function ResImmuneBuffMessage()
        {
            return;
        }// end function

        public function set playerId(param1:long) : void
        {
            this._playerId = param1;
            return;
        }// end function

        public function get playerId() : long
        {
            return this._playerId;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        override public function getId() : int
        {
            return 504109;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._playerId);
            writeByte(this._type);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playerId = readLong();
            this._type = readByte();
            return true;
        }// end function

    }
}
