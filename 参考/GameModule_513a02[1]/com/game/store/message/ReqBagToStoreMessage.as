package com.game.store.message
{
    import net.*;

    public class ReqBagToStoreMessage extends Message
    {
        private var _bagCellId:int;
        private var _npcid:int;

        public function ReqBagToStoreMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._bagCellId);
            writeInt(this._npcid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._bagCellId = readInt();
            this._npcid = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 112206;
        }// end function

        public function get bagCellId() : int
        {
            return this._bagCellId;
        }// end function

        public function set bagCellId(param1:int) : void
        {
            this._bagCellId = param1;
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
