package com.game.buff.message
{
    import com.game.utils.*;
    import net.*;

    public class ResRemoveBuffMessage extends Message
    {
        private var _personId:long;
        private var _fightState:int;
        private var _buffId:long;

        public function ResRemoveBuffMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._personId);
            writeInt(this._fightState);
            writeLong(this._buffId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._personId = readLong();
            this._fightState = readInt();
            this._buffId = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 113103;
        }// end function

        public function get personId() : long
        {
            return this._personId;
        }// end function

        public function set personId(param1:long) : void
        {
            this._personId = param1;
            return;
        }// end function

        public function get fightState() : int
        {
            return this._fightState;
        }// end function

        public function set fightState(param1:int) : void
        {
            this._fightState = param1;
            return;
        }// end function

        public function get buffId() : long
        {
            return this._buffId;
        }// end function

        public function set buffId(param1:long) : void
        {
            this._buffId = param1;
            return;
        }// end function

    }
}
