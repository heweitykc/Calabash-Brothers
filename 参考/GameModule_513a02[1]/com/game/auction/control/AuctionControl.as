package com.game.auction.control
{
    import __AS3__.vec.*;
    import com.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.auction.cfg.*;
    import com.game.auction.model.*;
    import com.game.auction.protocol.*;
    import com.game.auction.view.*;
    import com.game.backpack.control.*;
    import com.game.chat.control.*;
    import com.game.clickstream.*;
    import com.game.player.control.*;
    import com.game.shop.control.*;
    import com.game.shop.model.*;
    import com.game.stalls.bean.*;
    import com.game.utils.*;
    import com.game.vip.model.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.utils.*;

    public class AuctionControl extends Object
    {
        private const LENGTH:int = 150;
        private var _sysList:StallsList;
        private var _mainBox:StallsBox;
        private var _status:String;
        private var _startIndex:int;
        private var _fastChoose:Boolean;
        private var _curIndex:int;
        private var _mineContainer:MineBoothContainer;
        private var _searchContainer:AuctionSearchContainer;
        private var _stallsObj:AuctionObj;
        private var _protocol:AuctionProtocol;
        private var _curPage:int;
        private var _list:StallsList;
        private var _reqIndex:int = -1;
        private var _itemChangePanel:StallsItemChangePanel;
        private var _stallsBuyPanel:AuctionBuyPanel;
        private var _itemStallsPanel:AuctionItemPanel;
        public var sellNum:int;
        private var _isNPC:Boolean;
        private var _logTime:int;
        private var _lastTime:Number = 0;
        private var _selfIndex:int;
        private var _currencyPanel:CurrencyStallsPanel;
        public var otherInfo:StallsInfo;
        private var _logInfo:StallsLogInfo;
        private var _npcBrief:StallsBriefInfo;
        private var _log:LogContainer;
        private static var _inst:AuctionControl;
        public static const NORMAL:String = "normal";
        public static const GOLD:int = -2;
        public static const MONEY:int = -1;
        public static const MINE:String = "mine";
        public static const LOG:String = "log";
        public static const LIST:String = "list";
        public static const PAGESIZE:int = 12;

        public function AuctionControl()
        {
            this._stallsObj = AuctionObj.getInstance();
            this._protocol = new AuctionProtocol();
            return;
        }// end function

        public function get startIndex() : int
        {
            return this._startIndex;
        }// end function

        public function set startIndex(param1:int) : void
        {
            this._startIndex = param1;
            return;
        }// end function

        public function get fastChoose() : Boolean
        {
            return this._fastChoose;
        }// end function

        public function set fastChoose(param1:Boolean) : void
        {
            this._fastChoose = param1;
            return;
        }// end function

        public function get log() : LogContainer
        {
            return this._log;
        }// end function

        public function set log(param1:LogContainer) : void
        {
            this._log = param1;
            return;
        }// end function

        public function toBuyByChat(param1:String) : void
        {
            var _loc_2:* = AuctionInfoMap.getInstance().getAuctionByItemId(param1);
            if (_loc_2)
            {
                this.openBuyStallsInfo(_loc_2);
            }
            else
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10221"));
            }
            return;
        }// end function

        public function reqStart(param1:Boolean = false) : void
        {
            this.reqList(0, PAGESIZE, param1);
            return;
        }// end function

        public function board(param1:AuctionItemInfo) : void
        {
            if (!UserObj.getInstance().playerInfo.isBlack())
            {
                this._protocol.board(param1.playerid, param1.itemId);
            }
            else
            {
                this.clientBoard(param1);
            }
            return;
        }// end function

        private function clientBoard(param1:AuctionItemInfo) : void
        {
            AuctionInfoMap.getInstance().insertTo(param1);
            var _loc_2:* = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11888"), ["\f", param1.item.num, param1.price]);
            if (!param1.playerid.equal(UserObj.getInstance().playerInfo.personId))
            {
                _loc_2 = _loc_2 + ("<font color = \'#1eff00\'><a href =\'event:attachtoauction|" + param1.itemId.toString() + "\'>[" + LanguageCfgObj.getInstance().getByIndex("10228") + "]</a></font>");
            }
            var _loc_3:* = new ChatInfo();
            _loc_3.chater = param1.playerid;
            _loc_3.chatername = param1.playername;
            _loc_3.chattype = ChatType.CHATTYPE_TRANSACTION;
            _loc_3.condition = _loc_2;
            var _loc_4:* = new ChatGoodInfo();
            _loc_4.propInfo = param1.item;
            var _loc_5:* = new Vector.<ChatGoodInfo>;
            _loc_5.push(_loc_4);
            _loc_3.other = _loc_5;
            _loc_3.viptype = VipModel.getInstance().info.stageLevel;
            _loc_3.vipLevel = VipModel.getInstance().info.level;
            _loc_3.parse();
            ChatController.getInstance().accept(_loc_3);
            return;
        }// end function

        public function get status() : String
        {
            return this._status;
        }// end function

        public function set status(param1:String) : void
        {
            this._status = param1;
            return;
        }// end function

        public function get selfIndex() : int
        {
            return this._selfIndex;
        }// end function

        public function set selfIndex(param1:int) : void
        {
            this._selfIndex = param1;
            return;
        }// end function

        public function get logInfo() : StallsLogInfo
        {
            return this._logInfo;
        }// end function

        public function set logInfo(param1:StallsLogInfo) : void
        {
            this._logInfo = param1;
            return;
        }// end function

        public function get list() : StallsList
        {
            return this._list;
        }// end function

        public function set list(param1:StallsList) : void
        {
            this._list = param1;
            return;
        }// end function

        public function get mainBox() : StallsBox
        {
            return this._mainBox;
        }// end function

        public function set mainBox(param1:StallsBox) : void
        {
            this._mainBox = param1;
            return;
        }// end function

        public function get mineContainer() : MineBoothContainer
        {
            return this._mineContainer;
        }// end function

        public function set mineContainer(param1:MineBoothContainer) : void
        {
            this._mineContainer = param1;
            return;
        }// end function

        public function get searchContainer() : AuctionSearchContainer
        {
            return this._searchContainer;
        }// end function

        public function set searchContainer(param1:AuctionSearchContainer) : void
        {
            this._searchContainer = param1;
            return;
        }// end function

        public function get curIndex() : int
        {
            return this._curIndex;
        }// end function

        public function set curIndex(param1:int) : void
        {
            this._curIndex = param1;
            return;
        }// end function

        public function reqPre() : void
        {
            var _loc_1:* = null;
            this._reqIndex = this._curIndex - 1;
            if (this._stallsObj.breflist[this._reqIndex].playerid.equal(UserObj.getInstance().playerInfo.personId))
            {
                var _loc_2:* = this;
                var _loc_3:* = this._reqIndex - 1;
                _loc_2._reqIndex = _loc_3;
            }
            if (!this._stallsObj.breflist[this._reqIndex].isNpc)
            {
                _loc_1 = this._stallsObj.breflist[this._reqIndex].playerid;
                this._protocol.reqStallsInfo(_loc_1);
            }
            this._curIndex = this._reqIndex;
            return;
        }// end function

        public function openStalls(param1:String = "") : void
        {
            if (param1 == "")
            {
                this._status = LIST;
            }
            else
            {
                this._status = param1;
            }
            if (this._mainBox == null)
            {
                this._mainBox = new StallsBox();
                Global.popManager.addPop(this._mainBox);
            }
            if (!this._mainBox.isOpen)
            {
                BackPackControl.getInstance().inStalls();
                if (this._list)
                {
                    this._mainBox.openTab(LIST);
                    this._list.openSearch();
                }
                ClickStream.add(ClickStreamId.OPEN_TanWei);
            }
            this._mainBox.openOrClose();
            return;
        }// end function

        public function openOtherBooth(param1:long) : void
        {
            return;
        }// end function

        public function openBuyStallsInfo(param1:AuctionItemInfo) : void
        {
            if (this._stallsBuyPanel == null)
            {
                this._stallsBuyPanel = new AuctionBuyPanel();
                Global.popManager.addPop(this._stallsBuyPanel, true, true, true, true, false, true);
            }
            this._stallsBuyPanel.info = param1;
            if (!this._stallsBuyPanel.isOpen)
            {
                Global.primaryCursorManager.showSellIcon();
            }
            this._stallsBuyPanel.open();
            return;
        }// end function

        public function reqLog() : void
        {
            var _loc_1:* = getTimer();
            if (this._logInfo != null)
            {
                if (_loc_1 - this._logTime < 1000)
                {
                    return;
                }
            }
            this._logTime = _loc_1;
            this._protocol.reqLog();
            return;
        }// end function

        public function reqList(param1:int, param2:int, param3:Boolean = false) : void
        {
            AuctionObj.getInstance().preOper = param3;
            var _loc_4:* = getTimer();
            if (getTimer() - this._lastTime > 10)
            {
                this._protocol.reqIndex(param1, param2, AuctionObj.getInstance().search, param3);
            }
            else
            {
                ChatController.getInstance().systemCue(LanguageCfgObj.getInstance().getByIndex("10223"));
            }
            return;
        }// end function

        public function buy(param1:long) : void
        {
            this._protocol.reqBuy(param1);
            return;
        }// end function

        public function changeToAdd() : void
        {
            this._fastChoose = true;
            Global.primaryCursorManager.showSellIcon();
            BackPackControl.getInstance().changeToAddedStalls();
            return;
        }// end function

        public function search() : void
        {
            var _loc_1:* = AuctionObj.getInstance().search;
            this._protocol.reqIndex(0, PAGESIZE, _loc_1);
            return;
        }// end function

        public function closeAdd() : void
        {
            this._fastChoose = false;
            Global.primaryCursorManager.hide();
            BackPackControl.getInstance().closeSelectStatus();
            return;
        }// end function

        public function closeStalls() : void
        {
            Global.primaryCursorManager.hide();
            BackPackControl.getInstance().closeSell(BackPackControl.ADDTOSTALLS);
            return;
        }// end function

        public function addjust(param1:Vector.<AuctionItemInfo>) : void
        {
            return;
        }// end function

        public function openMystallsInfo(param1:StallsInfo = null) : void
        {
            if (AuctionObj.getInstance().selfStalls == null)
            {
                this._protocol.reqStallsInfo(UserObj.getInstance().playerInfo.personId);
            }
            else
            {
                this._status = MINE;
                this._mainBox.openTab(this._status);
            }
            return;
        }// end function

        public function callForMyAuction() : void
        {
            this._protocol.reqStallsInfo(UserObj.getInstance().playerInfo.personId);
            return;
        }// end function

        public function upload(param1:long, param2:int, param3:int) : void
        {
            this._protocol.upload(param1, param2, param3);
            return;
        }// end function

        public function addToStalls(param1:PropInfo) : void
        {
            if (this.sellNum >= 8)
            {
                this.closeAdd();
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10224"));
                this._mineContainer.reset();
                return;
            }
            if (this._itemStallsPanel == null)
            {
                this._itemStallsPanel = new AuctionItemPanel();
                Global.popManager.addPop(this._itemStallsPanel, true, true, true, true, false, true);
            }
            if (param1 == null)
            {
                return;
            }
            param1.isUsing = true;
            this._itemStallsPanel.info = param1;
            if (!this._itemStallsPanel.isOpen)
            {
                Global.primaryCursorManager.showSellIcon();
            }
            this._itemStallsPanel.open();
            return;
        }// end function

        public function changeStallsGoods(param1:StallsGoodInfo) : void
        {
            return;
        }// end function

        public function refreshStalls(param1:long) : void
        {
            this._protocol.reqStallsInfo(param1);
            return;
        }// end function

        public function reqNext() : void
        {
            var _loc_1:* = null;
            this._reqIndex = this._curIndex + 1;
            if (this._stallsObj.breflist[this._reqIndex].playerid.equal(UserObj.getInstance().playerInfo.personId))
            {
                var _loc_2:* = this;
                var _loc_3:* = this._reqIndex + 1;
                _loc_2._reqIndex = _loc_3;
            }
            if (!this._stallsObj.breflist[this._reqIndex].isNpc)
            {
                _loc_1 = this._stallsObj.breflist[this._reqIndex].playerid;
                this._protocol.reqStallsInfo(_loc_1);
            }
            this._curIndex = this._reqIndex;
            return;
        }// end function

        public function isPreAble() : Boolean
        {
            var _loc_1:* = this.curIndex - 1;
            if (_loc_1 < 0)
            {
                return false;
            }
            if (this._stallsObj.breflist[_loc_1].playerid.equal(UserObj.getInstance().playerInfo.personId))
            {
                this._selfIndex = _loc_1;
                _loc_1 = _loc_1 - 1;
                if (_loc_1 < 0)
                {
                    return false;
                }
            }
            if (this._stallsObj.breflist[_loc_1])
            {
                return true;
            }
            return false;
        }// end function

        public function isNextAble() : Boolean
        {
            var _loc_1:* = this.curIndex + 1;
            if ((_loc_1 + 1) >= this._stallsObj.breflist.length)
            {
                return false;
            }
            if (this._stallsObj.breflist[_loc_1].playerid.equal(UserObj.getInstance().playerInfo.personId))
            {
                this._selfIndex = _loc_1;
                _loc_1++;
                if ((_loc_1 + 1) >= this._stallsObj.breflist.length)
                {
                    return false;
                }
            }
            if (this._stallsObj.breflist[_loc_1])
            {
                return true;
            }
            return false;
        }// end function

        public function changeTitle(param1:String) : void
        {
            this._protocol.changeTitle(param1);
            return;
        }// end function

        public function downLoad(param1:long) : void
        {
            this._protocol.download(param1);
            return;
        }// end function

        public function changeItem(param1:long, param2:int, param3:int, param4:int, param5:int = 0) : void
        {
            this._protocol.changeItem(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function updateSelfAuction() : void
        {
            if (this._mainBox && this._mainBox.isOpen)
            {
                this._mainBox.openTab(MINE);
                if (this._mineContainer)
                {
                    this._mineContainer.update();
                }
            }
            return;
        }// end function

        public function openCurrencyPanel(param1:StallsGoodInfo) : void
        {
            if (this._currencyPanel == null)
            {
                this._currencyPanel = new CurrencyStallsPanel();
                Global.popManager.addPop(this._currencyPanel, true, true, true, true, false, true);
            }
            if (!this._currencyPanel.isOpen)
            {
                Global.primaryCursorManager.showSellIcon();
            }
            this._currencyPanel.info = param1;
            this._currencyPanel.openOrClose();
            return;
        }// end function

        public function openStallsInfo(param1:StallsBriefInfo, param2:int) : void
        {
            this._reqIndex = param2;
            this._protocol.reqStallsInfo(param1.playerid);
            return;
        }// end function

        public function openStallsInfoRes(param1:StallsInfo) : void
        {
            if (!this._mainBox)
            {
                this._mainBox = new StallsBox();
                Global.popManager.addPop(this._mainBox);
            }
            if (!this._mainBox.isOpen)
            {
                this._mainBox.open();
            }
            this._mainBox.openTab(LIST);
            if (this._list)
            {
                this._list.openBooth();
            }
            if (this._reqIndex != -1)
            {
                this._curIndex = this._reqIndex;
                this._reqIndex = -1;
            }
            this.otherInfo = param1;
            return;
        }// end function

        public function chat(param1:String) : void
        {
            ChatController.getInstance().toRole(param1);
            return;
        }// end function

        public function playerInfo(param1:long) : void
        {
            PlayerControl.getInstance().reqForPlayer(param1);
            return;
        }// end function

        public function setLog(param1:StallsLogInfo) : void
        {
            this._logInfo = param1;
            if (this._log)
            {
                this._log.info = this._logInfo;
            }
            return;
        }// end function

        public function updateList() : void
        {
            if (this._list)
            {
                if (this._status != LIST)
                {
                    this._list.openSearch();
                }
                if (this._searchContainer)
                {
                    this._searchContainer.info = AuctionObj.getInstance().breflist;
                }
            }
            return;
        }// end function

        public function buyRes() : void
        {
            var _loc_1:* = 0;
            if (this._mainBox && this._mainBox.isOpen && this.status == LIST)
            {
                _loc_1 = AuctionObj.getInstance().curpage;
                _loc_1 = _loc_1 - 1;
                this.reqList(_loc_1 * AuctionControl.PAGESIZE, (_loc_1 + 1) * AuctionControl.PAGESIZE - 1, AuctionObj.getInstance().preOper);
            }
            return;
        }// end function

        public function openListSearch(param1:String) : void
        {
            this._list.openSearch();
            return;
        }// end function

        public function acceptShopData(param1:ShopItemsInfo) : void
        {
            var _loc_5:* = null;
            if (this._npcBrief == null)
            {
                return;
            }
            var _loc_2:* = new StallsInfo();
            _loc_2.isNpc = param1.shopModelId;
            _loc_2.stallsname = this._npcBrief.stallsname;
            _loc_2.playerid = this._npcBrief.playerid;
            var _loc_3:* = new Vector.<StallsGoodInfo>;
            var _loc_4:* = 0;
            while (_loc_4 < param1.shopItemList.length)
            {
                
                _loc_5 = new StallsGoodInfo();
                _loc_5.pricegold = param1.shopItemList[_loc_4].coin;
                _loc_5.priceyuanbao = param1.shopItemList[_loc_4].gold;
                _loc_5.orgincoin = param1.shopItemList[_loc_4].originalCoin;
                _loc_5.orgingold = param1.shopItemList[_loc_4].originalGold;
                _loc_5.souldiamond = param1.shopItemList[_loc_4].q_souldiamond;
                _loc_5.show_soldiamond = param1.shopItemList[_loc_4].q_show_souldiamond;
                _loc_5.prop = param1.shopItemList[_loc_4].prop;
                _loc_5.prop.num = 1;
                _loc_5.sellid = param1.shopItemList[_loc_4].sellId;
                _loc_3.push(_loc_5);
                _loc_4++;
            }
            _loc_2.stallsgoodsinfo = _loc_3;
            if (this._reqIndex != -1)
            {
                this._curIndex = this._reqIndex;
                this._reqIndex = -1;
            }
            if (this._list.visible == false)
            {
                this._mainBox.openTab(LIST);
            }
            return;
        }// end function

        public function buyShopItem(param1:int, param2:StallsGoodInfo) : void
        {
            var _loc_9:* = 0;
            var _loc_3:* = param2.sellid;
            var _loc_4:* = param2.priceyuanbao;
            var _loc_5:* = param2.pricegold;
            var _loc_6:* = param2.souldiamond;
            var _loc_7:* = param2.prop.itemModelId;
            var _loc_8:* = param2.prop.num;
            if (_loc_4 > 0)
            {
                _loc_9 = CostType.GOLD;
            }
            if (_loc_5 > 0)
            {
                _loc_9 = CostType.COIN;
            }
            if (_loc_6 > 0)
            {
                _loc_9 = CostType.SOULDIAMOND;
            }
            ShopController.getInstance().buyFromOther(_loc_3, _loc_4, _loc_5, param2.orgincoin, param2.orgingold, param2.souldiamond, param2.show_soldiamond, _loc_7, _loc_9, 0, _loc_8);
            return;
        }// end function

        public function refreshNPCData(param1:int) : void
        {
            ShopController.getInstance().getItems(1, param1);
            return;
        }// end function

        public function cancelSelectFromBackpack() : void
        {
            Global.primaryCursorManager.hide();
            if (this._mineContainer)
            {
                this._mineContainer.reset();
            }
            return;
        }// end function

        public static function getInstance() : AuctionControl
        {
            var _loc_1:* = new AuctionControl;
            _inst = new AuctionControl;
            return _inst || _loc_1;
        }// end function

    }
}
