package com.game.auction.handler
{
    import __AS3__.vec.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.auction.cfg.*;
    import com.game.auction.message.*;
    import com.game.chat.control.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import net.*;

    public class ResAuctionShowHandler extends Handler
    {

        public function ResAuctionShowHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResAuctionShowItemMessage(this.message);
            var _loc_2:* = _loc_1.viplv;
            var _loc_3:* = _loc_1.viptype;
            var _loc_4:* = new AuctionItemInfo();
            _loc_4.playerid = _loc_1.auctionInfo.roleId;
            _loc_4.itemId = _loc_1.auctionInfo.itemId;
            _loc_4.playername = _loc_1.auctionInfo.playerName;
            _loc_4.unitprice = _loc_1.auctionInfo.unitprice;
            _loc_4.price = _loc_1.auctionInfo.price;
            _loc_4.item = PropUtil.createItemByItemInfo(_loc_1.auctionInfo.itemdata);
            AuctionInfoMap.getInstance().insertTo(_loc_4);
            var _loc_5:* = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11888"), ["\f", _loc_4.item.num, _loc_4.price]);
            if (!_loc_4.playerid.equal(UserObj.getInstance().playerInfo.personId))
            {
                _loc_5 = _loc_5 + ("<font color = \'#1eff00\'><a href =\'event:attachtoauction|" + _loc_1.auctionInfo.itemId.toString() + "\'>[" + LanguageCfgObj.getInstance().getByIndex("10228") + "]</a></font>");
            }
            var _loc_6:* = new ChatInfo();
            _loc_6.chater = _loc_4.playerid;
            _loc_6.chatername = _loc_4.playername;
            _loc_6.chattype = ChatType.CHATTYPE_TRANSACTION;
            _loc_6.condition = _loc_5;
            var _loc_7:* = new ChatGoodInfo();
            _loc_7.propInfo = _loc_4.item;
            var _loc_8:* = new Vector.<ChatGoodInfo>;
            _loc_8.push(_loc_7);
            _loc_6.other = _loc_8;
            _loc_6.viptype = _loc_3;
            _loc_6.vipLevel = _loc_2;
            _loc_6.parse();
            ChatController.getInstance().accept(_loc_6);
            return;
        }// end function

    }
}
