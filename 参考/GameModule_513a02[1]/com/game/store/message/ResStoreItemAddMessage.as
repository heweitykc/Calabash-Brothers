package com.game.store.message
{
    import com.game.backpack.bean.*;
    import net.*;

    public class ResStoreItemAddMessage extends Message
    {
        private var _item:ItemInfo;

        public function ResStoreItemAddMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._item);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._item = readBean(ItemInfo) as ItemInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 112101;
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

    }
}
