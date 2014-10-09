package com.game.country.message
{
    import __AS3__.vec.*;
    import com.game.backpack.bean.*;
    import net.*;

    public class ResKingCityChestPanelShowToClientMessage extends Message
    {
        private var _itemlist:Vector.<ItemInfo>;

        public function ResKingCityChestPanelShowToClientMessage()
        {
            this._itemlist = new Vector.<ItemInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._itemlist.length);
            _loc_1 = 0;
            while (_loc_1 < this._itemlist.length)
            {
                
                writeBean(this._itemlist[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._itemlist[_loc_1] = readBean(ItemInfo) as ItemInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 146108;
        }// end function

        public function get itemlist() : Vector.<ItemInfo>
        {
            return this._itemlist;
        }// end function

        public function set itemlist(param1:Vector.<ItemInfo>) : void
        {
            this._itemlist = param1;
            return;
        }// end function

    }
}
