package com.game.auction.message
{
    import __AS3__.vec.*;
    import com.game.auction.bean.*;
    import net.*;

    public class ResQuryMyItemsMessage extends Message
    {
        private var _list:Vector.<AuctionInfoBean>;

        public function ResQuryMyItemsMessage()
        {
            this._list = new Vector.<AuctionInfoBean>;
            return;
        }// end function

        public function set list(param1:Vector.<AuctionInfoBean>) : void
        {
            this._list = param1;
            return;
        }// end function

        public function get list() : Vector.<AuctionInfoBean>
        {
            return this._list;
        }// end function

        override public function getId() : int
        {
            return 512007;
        }// end function

        override protected function writing() : Boolean
        {
            writeShort(this._list.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._list.length)
            {
                
                writeBean(this._list[_loc_1]);
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
                
                this._list[_loc_2] = readBean(AuctionInfoBean) as AuctionInfoBean;
                _loc_2++;
            }
            return true;
        }// end function

    }
}
