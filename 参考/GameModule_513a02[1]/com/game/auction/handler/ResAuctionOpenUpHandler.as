package com.game.auction.handler
{
    import __AS3__.vec.*;
    import com.*;
    import com.f1.*;
    import com.game.auction.control.*;
    import com.game.auction.message.*;
    import com.game.auction.model.*;
    import com.model.vo.*;
    import com.util.*;
    import net.*;

    public class ResAuctionOpenUpHandler extends Handler
    {

        public function ResAuctionOpenUpHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_6:* = null;
            var _loc_1:* = ResQuryItemsMessage(this.message);
            var _loc_2:* = _loc_1.list.length;
            var _loc_3:* = new Vector.<AuctionItemInfo>;
            AuctionObj.getInstance().count = _loc_1.count;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_6 = new AuctionItemInfo();
                _loc_6.playerid = _loc_1.list[_loc_4].roleId;
                _loc_6.itemId = _loc_1.list[_loc_4].itemId;
                _loc_6.playername = _loc_1.list[_loc_4].playerName;
                _loc_6.unitprice = _loc_1.list[_loc_4].unitprice;
                _loc_6.price = _loc_1.list[_loc_4].price;
                _loc_6.item = PropUtil.createItemByItemInfo(_loc_1.list[_loc_4].itemdata);
                _loc_3.push(_loc_6);
                _loc_4++;
            }
            AuctionObj.getInstance().breflist = _loc_3;
            if (_loc_3.length == 0)
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10225"));
            }
            var _loc_5:* = AuctionObj.getInstance().count / AuctionControl.PAGESIZE;
            _loc_5 = AuctionObj.getInstance().count % AuctionControl.PAGESIZE == 0 ? (_loc_5) : ((_loc_5 + 1));
            AuctionObj.getInstance().pages = _loc_5 < 1 ? (1) : (_loc_5);
            AuctionObj.getInstance().indexLarge = _loc_1.end;
            AuctionObj.getInstance().indexlittle = _loc_1.start;
            _loc_5 = AuctionObj.getInstance().indexlittle / AuctionControl.PAGESIZE + 1;
            AuctionObj.getInstance().curpage = AuctionObj.getInstance().indexlittle % AuctionControl.PAGESIZE == 0 ? (_loc_5) : ((_loc_5 + 1));
            AuctionControl.getInstance().updateList();
            return;
        }// end function

    }
}
