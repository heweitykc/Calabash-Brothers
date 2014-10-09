package com.game.stalls.bean
{
    import com.game.backpack.bean.*;
    import net.*;

    public class StallsGoodsInfo extends Bean
    {
        private var _pricegold:int;
        private var _priceyuanbao:int;
        private var _iteminfo:ItemInfo;

        public function StallsGoodsInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._pricegold);
            writeInt(this._priceyuanbao);
            writeBean(this._iteminfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._pricegold = readInt();
            this._priceyuanbao = readInt();
            this._iteminfo = readBean(ItemInfo) as ItemInfo;
            return true;
        }// end function

        public function get pricegold() : int
        {
            return this._pricegold;
        }// end function

        public function set pricegold(param1:int) : void
        {
            this._pricegold = param1;
            return;
        }// end function

        public function get priceyuanbao() : int
        {
            return this._priceyuanbao;
        }// end function

        public function set priceyuanbao(param1:int) : void
        {
            this._priceyuanbao = param1;
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
