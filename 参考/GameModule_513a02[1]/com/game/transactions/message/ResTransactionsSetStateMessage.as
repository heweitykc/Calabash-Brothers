﻿package com.game.transactions.message
{
    import com.game.utils.*;
    import net.*;

    public class ResTransactionsSetStateMessage extends Message
    {
        private var _playerid:long;
        private var _state:int;

        public function ResTransactionsSetStateMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._playerid);
            writeByte(this._state);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playerid = readLong();
            this._state = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 122108;
        }// end function

        public function get playerid() : long
        {
            return this._playerid;
        }// end function

        public function set playerid(param1:long) : void
        {
            this._playerid = param1;
            return;
        }// end function

        public function get state() : int
        {
            return this._state;
        }// end function

        public function set state(param1:int) : void
        {
            this._state = param1;
            return;
        }// end function

    }
}
