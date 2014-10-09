package com.game.player.message
{
    import com.game.utils.*;
    import net.*;

    public class ResPlayerHpChangeMessage extends Message
    {
        private var _personId:long;
        private var _currentHp:int;

        public function ResPlayerHpChangeMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._personId);
            writeInt(this._currentHp);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._personId = readLong();
            this._currentHp = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 103101;
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

        public function get currentHp() : int
        {
            return this._currentHp;
        }// end function

        public function set currentHp(param1:int) : void
        {
            this._currentHp = param1;
            return;
        }// end function

    }
}
