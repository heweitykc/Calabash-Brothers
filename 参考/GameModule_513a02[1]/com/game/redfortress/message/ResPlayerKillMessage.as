package com.game.redfortress.message
{
    import com.game.utils.*;
    import net.*;

    public class ResPlayerKillMessage extends Message
    {
        private var _playerId:long;
        private var _count:int;

        public function ResPlayerKillMessage()
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

        public function set count(param1:int) : void
        {
            this._count = param1;
            return;
        }// end function

        public function get count() : int
        {
            return this._count;
        }// end function

        override public function getId() : int
        {
            return 550105;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._playerId);
            writeInt(this._count);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playerId = readLong();
            this._count = readInt();
            return true;
        }// end function

    }
}
