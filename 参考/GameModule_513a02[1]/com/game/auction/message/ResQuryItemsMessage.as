package com.game.auction.message
{
    import __AS3__.vec.*;
    import com.game.auction.bean.*;
    import net.*;

    public class ResQuryItemsMessage extends Message
    {
        private var _list:Vector.<AuctionInfoBean>;
        private var _count:int;
        private var _start:int;
        private var _end:int;

        public function ResQuryItemsMessage()
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

        public function set count(param1:int) : void
        {
            this._count = param1;
            return;
        }// end function

        public function get count() : int
        {
            return this._count;
        }// end function

        public function set start(param1:int) : void
        {
            this._start = param1;
            return;
        }// end function

        public function get start() : int
        {
            return this._start;
        }// end function

        public function set end(param1:int) : void
        {
            this._end = param1;
            return;
        }// end function

        public function get end() : int
        {
            return this._end;
        }// end function

        override public function getId() : int
        {
            return 512005;
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
            writeInt(this._count);
            writeInt(this._start);
            writeInt(this._end);
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
            this._count = readInt();
            this._start = readInt();
            this._end = readInt();
            return true;
        }// end function

    }
}
