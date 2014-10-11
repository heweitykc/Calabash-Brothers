﻿package com.game.store.message
{
    import net.*;

    public class ReqStoreGetItemsMessage extends Message
    {
        private var _npcid:int;

        public function ReqStoreGetItemsMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._npcid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._npcid = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 112200;
        }// end function

        public function get npcid() : int
        {
            return this._npcid;
        }// end function

        public function set npcid(param1:int) : void
        {
            this._npcid = param1;
            return;
        }// end function

    }
}
