package com.game.auction.cfg
{
    import com.game.utils.*;
    import com.model.vo.*;

    public class AuctionInfoMap extends Object
    {
        private var _map:LoopArray;
        private static const LENGTH:int = 50;
        private static var _inst:AuctionInfoMap;

        public function AuctionInfoMap()
        {
            this._map = new LoopArray(50);
            return;
        }// end function

        public function insertTo(param1:AuctionItemInfo) : void
        {
            this._map.push(param1);
            return;
        }// end function

        public function getAuctionByItemId(param1:String) : AuctionItemInfo
        {
            var _loc_2:* = long.parselong(param1);
            var _loc_3:* = 0;
            while (_loc_3 < LENGTH)
            {
                
                if ((this._map.dataLst[_loc_3] as AuctionItemInfo).itemId.equal(_loc_2))
                {
                    return this._map.dataLst[_loc_3];
                }
                _loc_3++;
            }
            return null;
        }// end function

        public static function getInstance() : AuctionInfoMap
        {
            var _loc_1:* = new AuctionInfoMap;
            _inst = new AuctionInfoMap;
            return _inst || _loc_1;
        }// end function

    }
}
