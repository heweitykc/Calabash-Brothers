package com.game.stalls.model
{
    import __AS3__.vec.*;
    import com.model.vo.*;

    public class StallsObj extends Object
    {
        private var _breflist:Vector.<StallsBriefInfo>;
        private var _indexlittle:int;
        private var _indexLarge:int;
        private var _stallssnum:int;
        private var _type:int;
        private var _list:Object;
        private var _selfStalls:StallsInfo;
        public var self:Boolean;
        private var _search:SearchInfo;
        private var _maxPos:int;
        private var _sort:Boolean;
        public static const LEVEL:int = 1;
        public static const SELLNUM:int = 2;
        private static var _inst:StallsObj;

        public function StallsObj()
        {
            this._search = new SearchInfo();
            return;
        }// end function

        public function get search() : SearchInfo
        {
            return this._search;
        }// end function

        public function set search(param1:SearchInfo) : void
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

        public function get selfStalls() : StallsInfo
        {
            return this._selfStalls;
        }// end function

        public function set selfStalls(param1:StallsInfo) : void
        {
            this._selfStalls = param1;
            this._maxPos = this.getMaxPos();
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

        public function getMaxPos() : int
        {
            var _loc_2:* = 0;
            var _loc_1:* = this._selfStalls.stallsgoodsinfo.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_1)
            {
                
                if (this._selfStalls.stallsgoodsinfo[_loc_3].prop.itemModelId == -1)
                {
                    _loc_2++;
                }
                if (this._selfStalls.stallsgoodsinfo[_loc_3].prop.itemModelId == -2)
                {
                    _loc_2++;
                }
                _loc_3++;
            }
            return _loc_1 - _loc_2;
        }// end function

        public function get breflist() : Vector.<StallsBriefInfo>
        {
            return this._breflist;
        }// end function

        public function set breflist(param1:Vector.<StallsBriefInfo>) : void
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

        public static function getInstance() : StallsObj
        {
            var _loc_1:* = new StallsObj;
            _inst = new StallsObj;
            return _inst || _loc_1;
        }// end function

    }
}
