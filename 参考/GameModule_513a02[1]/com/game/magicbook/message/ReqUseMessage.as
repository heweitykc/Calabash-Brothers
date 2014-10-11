package com.game.magicbook.message
{
    import net.*;

    public class ReqUseMessage extends Message
    {
        private var _itemId:int;

        public function ReqUseMessage()
        {
            return;
        }// end function

        public function set itemId(param1:int) : void
        {
            this._itemId = param1;
            return;
        }// end function

        public function get itemId() : int
        {
            return this._itemId;
        }// end function

        override public function getId() : int
        {
            return 600213;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._itemId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._itemId = readInt();
            return true;
        }// end function

    }
}
