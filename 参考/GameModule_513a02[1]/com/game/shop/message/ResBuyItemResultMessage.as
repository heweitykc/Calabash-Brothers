package com.game.shop.message
{
    import __AS3__.vec.*;
    import com.game.shop.bean.*;
    import net.*;

    public class ResBuyItemResultMessage extends Message
    {
        private var _sellId:int;
        private var _costType:int;
        private var _goodsinfo:Vector.<ShopBuyResultItemBean>;

        public function ResBuyItemResultMessage()
        {
            this._goodsinfo = new Vector.<ShopBuyResultItemBean>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeInt(this._sellId);
            writeInt(this._costType);
            writeShort(this._goodsinfo.length);
            _loc_1 = 0;
            while (_loc_1 < this._goodsinfo.length)
            {
                
                writeBean(this._goodsinfo[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            this._sellId = readInt();
            this._costType = readInt();
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._goodsinfo[_loc_1] = readBean(ShopBuyResultItemBean) as ShopBuyResultItemBean;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 105106;
        }// end function

        public function get sellId() : int
        {
            return this._sellId;
        }// end function

        public function set sellId(param1:int) : void
        {
            this._sellId = param1;
            return;
        }// end function

        public function get costType() : int
        {
            return this._costType;
        }// end function

        public function set costType(param1:int) : void
        {
            this._costType = param1;
            return;
        }// end function

        public function get goodsinfo() : Vector.<ShopBuyResultItemBean>
        {
            return this._goodsinfo;
        }// end function

        public function set goodsinfo(param1:Vector.<ShopBuyResultItemBean>) : void
        {
            this._goodsinfo = param1;
            return;
        }// end function

    }
}
