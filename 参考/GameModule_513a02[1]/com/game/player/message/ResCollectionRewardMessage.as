package com.game.player.message
{
    import __AS3__.vec.*;
    import com.game.backpack.bean.*;
    import net.*;

    public class ResCollectionRewardMessage extends Message
    {
        private var _itemlist:Vector.<ItemInfo>;

        public function ResCollectionRewardMessage()
        {
            this._itemlist = new Vector.<ItemInfo>;
            return;
        }// end function

        public function set itemlist(param1:Vector.<ItemInfo>) : void
        {
            this._itemlist = param1;
            return;
        }// end function

        public function get itemlist() : Vector.<ItemInfo>
        {
            return this._itemlist;
        }// end function

        override public function getId() : int
        {
            return 55001;
        }// end function

        override protected function writing() : Boolean
        {
            writeShort(this._itemlist.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._itemlist.length)
            {
                
                writeBean(this._itemlist[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._itemlist[_loc_2] = readBean(ItemInfo) as ItemInfo;
                _loc_2++;
            }
            return true;
        }// end function

    }
}
