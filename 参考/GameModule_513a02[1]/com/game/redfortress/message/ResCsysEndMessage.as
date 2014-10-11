package com.game.redfortress.message
{
    import __AS3__.vec.*;
    import com.game.backpack.bean.*;
    import com.game.redfortress.bean.*;
    import net.*;

    public class ResCsysEndMessage extends Message
    {
        private var _infos:Vector.<CsysTopInfo>;
        private var _itemlist:Vector.<ItemInfo>;

        public function ResCsysEndMessage()
        {
            this._infos = new Vector.<CsysTopInfo>;
            this._itemlist = new Vector.<ItemInfo>;
            return;
        }// end function

        public function set infos(param1:Vector.<CsysTopInfo>) : void
        {
            this._infos = param1;
            return;
        }// end function

        public function get infos() : Vector.<CsysTopInfo>
        {
            return this._infos;
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
            return 550106;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._infos.length);
            _loc_1 = 0;
            while (_loc_1 < this._infos.length)
            {
                
                writeBean(this._infos[_loc_1]);
                _loc_1++;
            }
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
            var _loc_2:* = 0;
            var _loc_1:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._infos[_loc_2] = readBean(CsysTopInfo) as CsysTopInfo;
                _loc_2++;
            }
            var _loc_3:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                this._itemlist[_loc_2] = readBean(ItemInfo) as ItemInfo;
                _loc_2++;
            }
            return true;
        }// end function

    }
}
