package com.game.chestbox.bean
{
    import __AS3__.vec.*;
    import com.game.backpack.bean.*;
    import net.*;

    public class ChestGridInfo extends Bean
    {
        private var _grididx:int;
        private var _gridtype:int;
        private var _curiteminfo:ItemInfo;
        private var _itemlist:Vector.<ItemInfo>;

        public function ChestGridInfo()
        {
            this._itemlist = new Vector.<ItemInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._grididx);
            writeInt(this._gridtype);
            writeBean(this._curiteminfo);
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
            this._grididx = readInt();
            this._gridtype = readInt();
            this._curiteminfo = readBean(ItemInfo) as ItemInfo;
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._itemlist[_loc_2] = readBean(ItemInfo) as ItemInfo;
                _loc_2++;
            }
            return true;
        }// end function

        public function get grididx() : int
        {
            return this._grididx;
        }// end function

        public function set grididx(param1:int) : void
        {
            this._grididx = param1;
            return;
        }// end function

        public function get gridtype() : int
        {
            return this._gridtype;
        }// end function

        public function set gridtype(param1:int) : void
        {
            this._gridtype = param1;
            return;
        }// end function

        public function get curiteminfo() : ItemInfo
        {
            return this._curiteminfo;
        }// end function

        public function set curiteminfo(param1:ItemInfo) : void
        {
            this._curiteminfo = param1;
            return;
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
