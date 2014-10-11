package com.game.backpack.message
{
    import com.game.backpack.bean.*;
    import net.*;

    public class ResItemAddMessage extends Message
    {
        private var _item:ItemInfo;
        private var _reason:int;

        public function ResItemAddMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._item);
            writeByte(this._reason);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._item = readBean(ItemInfo) as ItemInfo;
            this._reason = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 104102;
        }// end function

        public function get item() : ItemInfo
        {
            return this._item;
        }// end function

        public function set item(param1:ItemInfo) : void
        {
            this._item = param1;
            return;
        }// end function

        public function get reason() : int
        {
            return this._reason;
        }// end function

        public function set reason(param1:int) : void
        {
            this._reason = param1;
            return;
        }// end function

    }
}
