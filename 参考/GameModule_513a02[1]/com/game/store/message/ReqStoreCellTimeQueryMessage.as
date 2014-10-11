package com.game.store.message
{
    import net.*;

    public class ReqStoreCellTimeQueryMessage extends Message
    {
        private var _cellId:int;
        private var _npcid:int;

        public function ReqStoreCellTimeQueryMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._cellId);
            writeInt(this._npcid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._cellId = readInt();
            this._npcid = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 112204;
        }// end function

        public function get cellId() : int
        {
            return this._cellId;
        }// end function

        public function set cellId(param1:int) : void
        {
            this._cellId = param1;
            return;
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
