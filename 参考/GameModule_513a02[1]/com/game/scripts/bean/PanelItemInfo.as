package com.game.scripts.bean
{
    import com.game.backpack.bean.*;
    import net.*;

    public class PanelItemInfo extends Bean
    {
        private var _name:String;
        private var _iteminfo:ItemInfo;

        public function PanelItemInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this._name);
            writeBean(this._iteminfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._name = readString();
            this._iteminfo = readBean(ItemInfo) as ItemInfo;
            return true;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function set name(param1:String) : void
        {
            this._name = param1;
            return;
        }// end function

        public function get iteminfo() : ItemInfo
        {
            return this._iteminfo;
        }// end function

        public function set iteminfo(param1:ItemInfo) : void
        {
            this._iteminfo = param1;
            return;
        }// end function

    }
}
