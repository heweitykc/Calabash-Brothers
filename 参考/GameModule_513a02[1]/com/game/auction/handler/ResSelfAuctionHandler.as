package com.game.auction.handler
{
    import __AS3__.vec.*;
    import com.game.auction.control.*;
    import com.game.auction.message.*;
    import com.game.auction.model.*;
    import com.model.vo.*;
    import com.util.*;
    import net.*;

    public class ResSelfAuctionHandler extends Handler
    {

        public function ResSelfAuctionHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_4:* = null;
            var _loc_1:* = ResQuryMyItemsMessage(this.message);
            var _loc_2:* = new Vector.<AuctionItemInfo>;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_1.list.length)
            {
                
                _loc_4 = new AuctionItemInfo();
                _loc_4.playerid = _loc_1.list[_loc_3].roleId;
                _loc_4.itemId = _loc_1.list[_loc_3].itemId;
                _loc_4.playername = _loc_1.list[_loc_3].playerName;
                _loc_4.unitprice = _loc_1.list[_loc_3].unitprice;
                _loc_4.price = _loc_1.list[_loc_3].price;
                _loc_4.item = PropUtil.createItemByItemInfo(_loc_1.list[_loc_3].itemdata);
                _loc_2.push(_loc_4);
                _loc_3++;
            }
            AuctionObj.getInstance().selfStalls = _loc_2;
            if (AuctionControl.getInstance().status == AuctionControl.MINE)
            {
                AuctionControl.getInstance().updateSelfAuction();
            }
            return;
        }// end function

    }
}
