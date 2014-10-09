﻿package com.game.masterequip.message
{
    import net.*;

    public class ReqGainOneMessage extends Message
    {
        private var _index:int;

        public function ReqGainOneMessage()
        {
            return;
        }// end function

        public function set index(param1:int) : void
        {
            this._index = param1;
            return;
        }// end function

        public function get index() : int
        {
            return this._index;
        }// end function

        override public function getId() : int
        {
            return 600220;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._index);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._index = readInt();
            return true;
        }// end function

    }
}
