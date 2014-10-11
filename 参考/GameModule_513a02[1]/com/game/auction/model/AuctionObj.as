package com.game.auction.model
{
    import __AS3__.vec.*;
    import com.f1.*;
    import com.model.vo.*;

    public class AuctionObj extends Object
    {
        private var _breflist:Vector.<AuctionItemInfo>;
        private var _indexlittle:int;
        private var _indexLarge:int;
        private var _stallssnum:int;
        private var _type:int;
        private var _curpage:int;
        private var _list:Object;
        private var _pages:int;
        private var _count:int;
        private var _preBoardTime:int;
        private var _singlePriceDown:Boolean;
        private var _totalPriceDown:Boolean;
        private var _preOper:Boolean;
        private var _selfStalls:Vector.<AuctionItemInfo>;
        public var self:Boolean;
        private var _search:AuctionInfo;
        private var _maxPos:int;
        private var _sort:Boolean;
        public static const LEVEL:int = 1;
        public static const SELLNUM:int = 2;
        public static const BOARD_GAP:int = 10000;
        private static var _inst:AuctionObj;
        public static const PARSE:Array = [{label:LanguageCfgObj.getInstance().getByIndex("11652"), key:"zhuoyue", value:1}, {label:LanguageCfgObj.getInstance().getByIndex("11653"), key:"zhuoyue", value:2}, {label:LanguageCfgObj.getInstance().getByIndex("11654"), key:"zhuoyue", value:3}];

        public function AuctionObj()
        {
            this._search = new AuctionInfo();
            return;
        }// end function

        public function get preOper() : Boolean
        {
            return this._preOper;
        }// end function

        public function set preOper(param1:Boolean) : void
        {
            this._preOper = param1;
            return;
        }// end function

        public function get preBoardTime() : int
        {
            return this._preBoardTime;
        }// end function

        public function set preBoardTime(param1:int) : void
        {
            this._preBoardTime = param1;
            return;
        }// end function

        public function get totalPriceDown() : Boolean
        {
            return this._totalPriceDown;
        }// end function

        public function set totalPriceDown(param1:Boolean) : void
        {
            this._totalPriceDown = param1;
            return;
        }// end function

        public function get singlePriceDown() : Boolean
        {
            return this._singlePriceDown;
        }// end function

        public function set singlePriceDown(param1:Boolean) : void
        {
            this._singlePriceDown = param1;
            return;
        }// end function

        public function get curpage() : int
        {
            return this._curpage;
        }// end function

        public function set curpage(param1:int) : void
        {
            this._curpage = param1;
            return;
        }// end function

        public function get count() : int
        {
            return this._count;
        }// end function

        public function set count(param1:int) : void
        {
            this._count = param1;
            return;
        }// end function

        public function get pages() : int
        {
            return this._pages;
        }// end function

        public function set pages(param1:int) : void
        {
            this._pages = param1;
            return;
        }// end function

        public function get search() : AuctionInfo
        {
            return this._search;
        }// end function

        public function set search(param1:AuctionInfo) : void
        {
            this._search = param1;
            return;
        }// end function

        public function get maxPos() : int
        {
            return this._maxPos;
        }// end function

        public function set maxPos(param1:int) : void
        {
            this._maxPos = param1;
            return;
        }// end function

        public function get selfStalls() : Vector.<AuctionItemInfo>
        {
            return this._selfStalls;
        }// end function

        public function set selfStalls(param1:Vector.<AuctionItemInfo>) : void
        {
            this._selfStalls = param1;
            return;
        }// end function

        public function sort(param1:int, param2:Boolean) : void
        {
            var _loc_3:* = null;
            this._sort = param2;
            if (param1 == LEVEL)
            {
                this._breflist = this._breflist.sort(this.sortByLevel);
            }
            else if (param1 == SELLNUM)
            {
                this._breflist = this._breflist.sort(this.sortBySellNum);
            }
            return;
        }// end function

        private function sortByLevel(param1:StallsBriefInfo, param2:StallsBriefInfo) : int
        {
            if (param1.playerlv > param2.playerlv)
            {
                return this._sort ? (-1) : (1);
            }
            else
            {
                if (param1.playerlv < param2.playerlv)
                {
                    return this._sort ? (1) : (-1);
                }
            }
            return 0;
        }// end function

        private function sortBySellNum(param1:StallsBriefInfo, param2:StallsBriefInfo) : int
        {
            if (param1.sellgoodsnum > param2.sellgoodsnum)
            {
                return this._sort ? (-1) : (1);
            }
            else
            {
                if (param1.sellgoodsnum < param2.sellgoodsnum)
                {
                    return this._sort ? (1) : (-1);
                }
            }
            return 0;
        }// end function

        public function get breflist() : Vector.<AuctionItemInfo>
        {
            return this._breflist;
        }// end function

        public function set breflist(param1:Vector.<AuctionItemInfo>) : void
        {
            this._breflist = param1;
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

        public function get stallssnum() : int
        {
            return this._stallssnum;
        }// end function

        public function set stallssnum(param1:int) : void
        {
            this._stallssnum = param1;
            return;
        }// end function

        public function get indexLarge() : int
        {
            return this._indexLarge;
        }// end function

        public function set indexLarge(param1:int) : void
        {
            this._indexLarge = param1;
            return;
        }// end function

        public function get indexlittle() : int
        {
            return this._indexlittle;
        }// end function

        public function set indexlittle(param1:int) : void
        {
            this._indexlittle = param1;
            return;
        }// end function

        public function get list() : Object
        {
            return this._list;
        }// end function

        public static function getInstance() : AuctionObj
        {
            var _loc_1:* = new AuctionObj;
            _inst = new AuctionObj;
            return _inst || _loc_1;
        }// end function

    }
}
