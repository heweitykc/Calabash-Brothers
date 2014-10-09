package com.game.store.message
{
    import net.*;

    public class ReqStoreToBagMessage extends Message
    {
        private var _storeCellId:int;
        private var _npcid:int;

        public function ReqStoreToBagMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._storeCellId);
            writeInt(this._npcid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._storeCellId = readInt();
            this._npcid = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 112207;
        }// end function

        public function get storeCellId() : int
        {
            return this._storeCellId;
        }// end function

        public function set storeCellId(param1:int) : void
        {
            this._storeCellId = param1;
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
