package com.game.auction.view
{
    import __AS3__.vec.*;
    import com.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.f1.ui.list.*;
    import com.f1.ui.scroller.*;
    import com.f1.ui.tips.*;
    import com.f1.ui.tree.*;
    import com.f1.utils.*;
    import com.game.auction.cfg.*;
    import com.game.auction.control.*;
    import com.game.auction.events.*;
    import com.game.auction.model.*;
    import com.game.player.control.*;
    import com.model.*;
    import com.staticdata.*;
    import com.view.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class AuctionSearchContainer extends Component
    {
        private var _searchBtn:BaseButton;
        private var _type:String;
        private var _tree:Tree;
        private var mc_List:Sprite;
        private var _searchGoodTxt:TextField;
        private var _indexBtn:BaseButton;
        private var _singlePriceBtn:BaseButton;
        private var _totalPriceBtn:BaseButton;
        private var _goldBtn:BaseButton;
        private var _moneyBtn:BaseButton;
        private var _levelBtn:BaseButton;
        private var _numBtn:BaseButton;
        private var _updateBtn:BaseButton;
        private var _container:HBox;
        private var _info:Vector.<AuctionItemInfo>;
        private var _curPage:int;
        private var lastClickItem:StallsSearchItemBase;
        private var _qualityDrop:DropList;
        private var _intensifyDrop:DropList;
        private var _stageLevelDrop:DropList;
        private const PAGESIZE:int = 10;
        private var _levelSort:Boolean;
        private var _sellNumSort:Boolean;
        private var _scrollpanel:ScrollPanel;
        private var _numTxt:TextField;
        private var _pageCounter:PageCounter;
        private var _intensifyBtn:BaseButton;
        private var _qualityBtn:BaseButton;
        private var _stagelevelBtn:BaseButton;
        private var _searchList:List;
        private var _resetBtn:BaseButton;
        private var _sortup:Bitmap;
        private var _sortdown:Bitmap;
        private var _curSortBtn:BaseButton;
        private var _sortY:int = 9;
        private var _sortX:int = 68;
        private var _requestId:int;
        private var _curItem:BoothItem;
        public static var GOODTEMPLAETE:String = LanguageCfgObj.getInstance().getByIndex("10242");
        public static var NAMETEMPLAETE:String = LanguageCfgObj.getInstance().getByIndex("10243");

        public function AuctionSearchContainer(param1 = "searchContainer")
        {
            super(param1);
            this.initUI();
            this.addListener();
            return;
        }// end function

        public function get type() : String
        {
            return this._type;
        }// end function

        public function set type(param1:String) : void
        {
            this._type = param1;
            return;
        }// end function

        public function get info() : Vector.<AuctionItemInfo>
        {
            return this._info;
        }// end function

        public function set info(param1:Vector.<AuctionItemInfo>) : void
        {
            this._info = param1;
            this.update();
            return;
        }// end function

        private function initUI() : void
        {
            this._tree = new Tree(152, 392);
            this.mc_List = getDisplayChildByName("mc_List");
            this.mc_List.addChild(this._tree);
            this.refreshSearchList();
            this._searchBtn = new BaseButton(getDisplayChildByName("btn_search"));
            this._resetBtn = new BaseButton(getDisplayChildByName("btn_reset"));
            this._indexBtn = new BaseButton(getDisplayChildByName("btn_index"));
            this._indexBtn.enabled = false;
            this._indexBtn.setText(LanguageCfgObj.getInstance().getByIndex("10244"));
            this._singlePriceBtn = new BaseButton(getDisplayChildByName("btn_stallsname"), true);
            this._singlePriceBtn.setText(LanguageCfgObj.getInstance().getByIndex("10245"));
            this._totalPriceBtn = new BaseButton(getDisplayChildByName("btn_playername"), true);
            this._totalPriceBtn.setText(LanguageCfgObj.getInstance().getByIndex("10246"));
            this._levelBtn = new BaseButton(getDisplayChildByName("btn_level"));
            this._levelBtn.setText(LanguageCfgObj.getInstance().getByIndex("10247"));
            this._levelBtn.enabled = false;
            this._intensifyBtn = new BaseButton(getDisplayChildByName("drop_intensify"));
            this._stagelevelBtn = new BaseButton(getDisplayChildByName("drop_stagelevel"));
            this._qualityBtn = new BaseButton(getDisplayChildByName("drop_quality"));
            this._stageLevelDrop = new DropList(this._stagelevelBtn, 0, 120, "double_menu_bg");
            this._stageLevelDrop.cellRenderer = AuctionDropItem;
            this._stageLevelDrop.getViewList().intervalY = 3;
            this._qualityDrop = new DropList(this._qualityBtn, 0, 100, "double_menu_bg");
            this._qualityDrop.cellRenderer = AuctionDropItem;
            this._qualityDrop.getViewList().intervalY = 3;
            this._intensifyDrop = new DropList(this._intensifyBtn, 0, 85, "double_menu_bg");
            this._intensifyDrop.cellRenderer = AuctionDropItem;
            this._intensifyDrop.getViewList().intervalY = 3;
            var _loc_1:* = new Array();
            _loc_1.push({label:LanguageCfgObj.getInstance().getByIndex("10248"), data:0});
            var _loc_2:* = 0;
            while (_loc_2 < EquipConsts.MAX_STAGLEVEL)
            {
                
                _loc_1.push({label:(_loc_2 + 1) + LanguageCfgObj.getInstance().getByIndex("11881"), data:(_loc_2 + 1)});
                _loc_2++;
            }
            this._stageLevelDrop.objs = _loc_1;
            _loc_1 = new Array();
            _loc_1.push({label:LanguageCfgObj.getInstance().getByIndex("10249"), data:-1});
            _loc_1.push({label:LanguageCfgObj.getInstance().getByIndex("10250"), data:0});
            _loc_1.push({label:LanguageCfgObj.getInstance().getByIndex("10251"), data:1});
            _loc_1.push({label:LanguageCfgObj.getInstance().getByIndex("10252"), data:2});
            _loc_1.push({label:LanguageCfgObj.getInstance().getByIndex("10253"), data:3});
            this._qualityDrop.objs = _loc_1;
            _loc_1 = [];
            _loc_1.push({label:LanguageCfgObj.getInstance().getByIndex("10254"), data:0});
            _loc_1.push({label:LanguageCfgObj.getInstance().getByIndex("10255"), data:1});
            _loc_1.push({label:LanguageCfgObj.getInstance().getByIndex("10256"), data:2});
            _loc_1.push({label:LanguageCfgObj.getInstance().getByIndex("10257"), data:3});
            StringTip.create(this._singlePriceBtn, LanguageCfgObj.getInstance().getByIndex("10258"));
            StringTip.create(this._totalPriceBtn, LanguageCfgObj.getInstance().getByIndex("10259"));
            this._intensifyDrop.objs = _loc_1;
            this._numBtn = new BaseButton(getDisplayChildByName("btn_num"));
            this._numBtn.setText(LanguageCfgObj.getInstance().getByIndex("10260"));
            this._numBtn.enabled = false;
            this._pageCounter = new PageCounter(getDisplayChildByName("pagecounter"));
            this._pageCounter.disable = true;
            this._searchGoodTxt = getDisplayChildByName("txt_searchGood");
            this._numTxt = getDisplayChildByName("txt_num");
            this._searchGoodTxt.maxChars = 15;
            this._container = new HBox();
            this._container.oneRow = 1;
            this._container.intervalY = 0;
            this._scrollpanel = new ScrollPanel(634, 324);
            this._scrollpanel.content = this._container;
            this._scrollpanel.move(175, 67);
            addChild(this._scrollpanel);
            addChild(this._qualityDrop);
            addChild(this._stageLevelDrop);
            addChild(this._intensifyDrop);
            this._searchList = new List(this._searchGoodTxt.width);
            this._searchList.barCanVisible = true;
            this._searchList.oneRow = 1;
            this._searchList.initCellH();
            this._sortup = ToolKit.getNewDO("auctionsortup") as Bitmap;
            this._sortdown = ToolKit.getNewDO("auctionsortdown") as Bitmap;
            this._updateBtn = new BaseButton(getDisplayChildByName("btn_update"));
            this._updateBtn.setText(LanguageCfgObj.getInstance().getByIndex("10261"));
            if (AuctionObj.getInstance().breflist)
            {
                this.info = AuctionObj.getInstance().breflist;
            }
            this._searchGoodTxt.htmlText = GOODTEMPLAETE;
            this.resetDrop();
            return;
        }// end function

        private function resetGoodName() : void
        {
            this._searchGoodTxt.htmlText = GOODTEMPLAETE;
            AuctionObj.getInstance().search.goodsname = "";
            return;
        }// end function

        private function __resetClick(event:MouseEvent) : void
        {
            this.reset();
            return;
        }// end function

        private function __totalClick(event:MouseEvent) : void
        {
            if (this._curSortBtn != event.target)
            {
                if (this._curSortBtn)
                {
                    this._curSortBtn.selected = false;
                }
                this._curSortBtn = event.target as BaseButton;
                AuctionObj.getInstance().totalPriceDown = true;
            }
            else
            {
                AuctionObj.getInstance().totalPriceDown = !AuctionObj.getInstance().totalPriceDown;
                this._totalPriceBtn.selected = true;
            }
            AuctionObj.getInstance().search.sort = AuctionObj.getInstance().totalPriceDown == true ? (3) : (2);
            if (AuctionObj.getInstance().search.sort == 2)
            {
                ToolKit.disappear(this._sortdown);
                addChild(this._sortup);
                this._sortup.x = this._totalPriceBtn.x + this._sortX;
                this._sortup.y = this._totalPriceBtn.y + this._sortY;
            }
            else
            {
                ToolKit.disappear(this._sortup);
                addChild(this._sortdown);
                this._sortdown.x = this._totalPriceBtn.x + this._sortX;
                this._sortdown.y = this._totalPriceBtn.y + this._sortY;
            }
            AuctionControl.getInstance().reqStart(AuctionObj.getInstance().preOper);
            return;
        }// end function

        private function __singleClick(event:MouseEvent) : void
        {
            if (this._curSortBtn != event.target)
            {
                if (this._curSortBtn)
                {
                    this._curSortBtn.selected = false;
                }
                this._curSortBtn = event.target as BaseButton;
                AuctionObj.getInstance().singlePriceDown = true;
            }
            else
            {
                AuctionObj.getInstance().singlePriceDown = !AuctionObj.getInstance().singlePriceDown;
                this._singlePriceBtn.selected = true;
            }
            AuctionObj.getInstance().search.sort = AuctionObj.getInstance().singlePriceDown == true ? (1) : (0);
            if (AuctionObj.getInstance().search.sort == 0)
            {
                ToolKit.disappear(this._sortdown);
                addChild(this._sortup);
                this._sortup.x = this._singlePriceBtn.x + this._sortX;
                this._sortup.y = this._singlePriceBtn.y + this._sortY;
            }
            else
            {
                ToolKit.disappear(this._sortup);
                addChild(this._sortdown);
                this._sortdown.x = this._singlePriceBtn.x + this._sortX;
                this._sortdown.y = this._singlePriceBtn.y + this._sortY;
            }
            AuctionControl.getInstance().reqStart(AuctionObj.getInstance().preOper);
            return;
        }// end function

        private function addListener() : void
        {
            this._pageCounter.addEvtListener(PageEvent.PAGE_CHANGE, this.__pageChange);
            this._resetBtn.addEvtListener(MouseEvent.CLICK, this.__resetClick);
            addEvtListener(StallsEvent.SELECTED, this.__stallsItemSelected);
            this._updateBtn.addEvtListener(MouseEvent.CLICK, this.__update);
            this._searchBtn.addEvtListener(MouseEvent.CLICK, this.__searchClick);
            this._singlePriceBtn.addEvtListener(MouseEvent.CLICK, this.__singleClick);
            this._totalPriceBtn.addEvtListener(MouseEvent.CLICK, this.__totalClick);
            addEvtListener(StallsEvent.INFO, this.__stallsItemInfo);
            this._levelBtn.addEvtListener(MouseEvent.CLICK, this.__levelClick);
            this._qualityDrop.addEvtListener(Event.CHANGE, this.__qualityCheckChange);
            this._stageLevelDrop.addEvtListener(Event.CHANGE, this.__stagelevelChange);
            this._intensifyDrop.addEvtListener(Event.CHANGE, this.__intensifyChange);
            this._searchList.addEvtListener(Event.CHANGE, this.__searchSelect);
            this._qualityDrop.addEvtListener(MouseEvent.MOUSE_DOWN, this.__dropDown);
            this._stageLevelDrop.addEvtListener(MouseEvent.MOUSE_DOWN, this.__dropDown);
            this._intensifyDrop.addEvtListener(MouseEvent.MOUSE_DOWN, this.__dropDown);
            this._searchGoodTxt.addEventListener(Event.CHANGE, this.__searchGoodChange);
            this._searchGoodTxt.addEventListener(FocusEvent.FOCUS_IN, this.__focusIn);
            return;
        }// end function

        private function __dropDown(event:Event) : void
        {
            switch(event.currentTarget)
            {
                case this._qualityDrop:
                {
                    if (!this._qualityDrop.enable)
                    {
                        Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10263"));
                    }
                    break;
                }
                case this._stageLevelDrop:
                {
                    if (!this._stageLevelDrop.enable)
                    {
                        Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10262"));
                    }
                    break;
                }
                case this._intensifyDrop:
                {
                    if (!this._intensifyDrop.enable)
                    {
                        Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10264"));
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function __searchSelect(event:Event) : void
        {
            this._searchGoodTxt.text = event.target.selectObj.label;
            AuctionObj.getInstance().search.goodsname = this._searchGoodTxt.text;
            AuctionControl.getInstance().reqStart(true);
            return;
        }// end function

        private function __pageChange(event:PageEvent) : void
        {
            var _loc_2:* = event.data.page;
            _loc_2 = _loc_2 < 1 ? (1) : (_loc_2);
            if (_loc_2 <= AuctionObj.getInstance().pages)
            {
                _loc_2 = _loc_2 - 1;
                AuctionControl.getInstance().reqList(_loc_2 * AuctionControl.PAGESIZE, (_loc_2 + 1) * AuctionControl.PAGESIZE - 1, AuctionObj.getInstance().preOper);
            }
            return;
        }// end function

        private function __stagelevelChange(event:Event) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (event.target.selectObj)
            {
                _loc_2 = event.target.selectObj.data;
                AuctionObj.getInstance().search.stagelevel = _loc_2;
                _loc_3 = event.target.selectObj.label;
                this._stagelevelBtn.setText(_loc_3);
                AuctionControl.getInstance().reqStart(AuctionObj.getInstance().preOper);
            }
            return;
        }// end function

        private function __qualityCheckChange(event:Event) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (event.target.selectObj)
            {
                _loc_2 = event.target.selectObj.data;
                AuctionObj.getInstance().search.quality = _loc_2;
                _loc_3 = event.target.selectObj.label;
                this._qualityBtn.setText(_loc_3);
                AuctionControl.getInstance().reqStart(AuctionObj.getInstance().preOper);
            }
            return;
        }// end function

        private function __intensifyChange(event:Event) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (event.target.selectObj)
            {
                _loc_2 = event.target.selectObj.data;
                AuctionObj.getInstance().search.luck = _loc_2;
                _loc_3 = event.target.selectObj.label;
                this._intensifyBtn.setText(_loc_3);
                AuctionControl.getInstance().reqStart(AuctionObj.getInstance().preOper);
            }
            return;
        }// end function

        private function __searchGoodChange(event:Event) : void
        {
            var _loc_2:* = this._searchGoodTxt.text;
            var _loc_3:* = AuctionSearchCfgObj.getInstance().getRelateArr(_loc_2);
            if (_loc_3 == null)
            {
                ToolKit.disappear(this._searchList);
            }
            else
            {
                this._searchList.move(this._searchGoodTxt.x, this._searchGoodTxt.y + this._searchGoodTxt.height + 2);
                if (_loc_3.length < 7)
                {
                    this._searchList.setWH(this._searchList._w, _loc_3.length * (this._searchList.intervalY + this._searchList.cellH));
                }
                else
                {
                    this._searchList.setWH(this._searchList._w, 140);
                }
                this._searchList.objs = _loc_3;
                addChild(this._searchList);
                FrameworkGlobal.stage.addEventListener(MouseEvent.CLICK, this.__stageClick, false, 0, true);
            }
            this.resetDrop();
            AuctionObj.getInstance().search.goodsname = _loc_2;
            this.decideDropVisible();
            return;
        }// end function

        private function resetTree() : void
        {
            var _loc_1:* = 0;
            while (this._tree && _loc_1 < this._tree.length)
            {
                
                this._tree.setTreeItemFoldByIndex(_loc_1);
                _loc_1++;
            }
            this._tree.scrollTo(0);
            AuctionObj.getInstance().search.type = 0;
            AuctionObj.getInstance().search.kind = 0;
            AuctionObj.getInstance().search.jobLimit = 0;
            AuctionObj.getInstance().search.modelId = 0;
            this.decideDropVisible();
            return;
        }// end function

        private function __stageClick(event:MouseEvent) : void
        {
            ToolKit.disappear(this._searchList);
            return;
        }// end function

        private function __searchNameChange(event:Event) : void
        {
            return;
        }// end function

        private function resetDrop() : void
        {
            var _loc_1:* = this._intensifyDrop.objs[0].label;
            var _loc_2:* = this._intensifyDrop.objs[0].data;
            this._intensifyBtn.setText(_loc_1);
            AuctionObj.getInstance().search.luck = _loc_2;
            _loc_1 = this._stageLevelDrop.objs[0].label;
            _loc_2 = this._stageLevelDrop.objs[0].data;
            AuctionObj.getInstance().search.stagelevel = _loc_2;
            this._stagelevelBtn.setText(_loc_1);
            _loc_1 = this._qualityDrop.objs[0].label;
            _loc_2 = this._qualityDrop.objs[0].data;
            AuctionObj.getInstance().search.quality = _loc_2;
            this._qualityBtn.setText(_loc_1);
            return;
        }// end function

        public function reset() : void
        {
            AuctionObj.getInstance().search.clear();
            this.resetTree();
            this.resetDrop();
            this.resetGoodName();
            this._singlePriceBtn.selected = true;
            this._curSortBtn = this._singlePriceBtn;
            this._totalPriceBtn.selected = false;
            AuctionObj.getInstance().singlePriceDown = true;
            AuctionObj.getInstance().totalPriceDown = false;
            AuctionObj.getInstance().search.sort = 1;
            ToolKit.disappear(this._sortup);
            addChild(this._sortdown);
            this._sortdown.x = this._singlePriceBtn.x + this._sortX;
            this._sortdown.y = this._singlePriceBtn.y + this._sortY;
            if (this.lastClickItem)
            {
                this.lastClickItem.selected = false;
            }
            this.lastClickItem = null;
            var _loc_1:* = 0;
            while (this._tree && _loc_1 < this._tree.length)
            {
                
                this._tree.setTreeItemFoldByIndex(_loc_1);
                _loc_1++;
            }
            this._tree.scrollTo(0);
            var _loc_2:* = this.getSelfProfessionIndex();
            this._tree.setTreeItemUnfoldByIndex(_loc_2);
            AuctionObj.getInstance().search.type = 1;
            this.decideDropVisible();
            AuctionObj.getInstance().search.jobLimit = 6 + UserObj.getInstance().playerInfo.jobkind;
            AuctionControl.getInstance().reqStart(false);
            this._searchGoodTxt.addEventListener(FocusEvent.FOCUS_IN, this.__focusIn);
            return;
        }// end function

        private function getSelfProfessionIndex() : int
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_1:* = this._tree.branch.length;
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = this._tree.branch[_loc_2].name;
                _loc_4 = _loc_3.split("_");
                if (_loc_4.length == 3)
                {
                    if ((_loc_4[2] - 1) % 3 + 1 == UserObj.getInstance().playerInfo.jobkind)
                    {
                        return _loc_2;
                    }
                }
                _loc_2++;
            }
            return 0;
        }// end function

        private function __focusIn(event:FocusEvent) : void
        {
            (event.target as TextField).text = "";
            (event.target as TextField).removeEventListener(FocusEvent.FOCUS_IN, this.__focusIn);
            return;
        }// end function

        private function refreshSearchList() : void
        {
            var _loc_3:* = undefined;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            this._tree.reset();
            var _loc_1:* = StallsSearchCfgObj.getInstance().map;
            var _loc_2:* = new Array();
            for (_loc_3 in _loc_1)
            {
                
                _loc_7 = _loc_3.split("_");
                if (_loc_2[_loc_7[0]] == null)
                {
                    _loc_2[_loc_7[0]] = new Array();
                }
                if (_loc_7.length == 2)
                {
                    _loc_2[_loc_7[0]][0] = _loc_1[_loc_3];
                    continue;
                }
                _loc_2[_loc_7[0]][_loc_7[1]] = _loc_1[_loc_3];
            }
            _loc_4 = 0;
            _loc_5 = 0;
            while (_loc_5 < _loc_2.length)
            {
                
                if (_loc_2[_loc_5])
                {
                    _loc_8 = _loc_2[_loc_5][0].item_type.lastIndexOf("_");
                    _loc_9 = _loc_2[_loc_5][0].item_type.slice((_loc_8 + 1));
                    _loc_10 = this._tree.addTreeItem(_loc_9);
                    _loc_10.name = _loc_2[_loc_5][0].item_key;
                    _loc_10.addEvtListener(MouseEvent.CLICK, this.selectItem);
                    _loc_11 = 0;
                    while (_loc_11 < _loc_2[_loc_5].length)
                    {
                        
                        if (_loc_2[_loc_5][_loc_11])
                        {
                            if (_loc_2[_loc_5][_loc_11].item_key == 0)
                            {
                                _loc_12 = _loc_2[_loc_5][_loc_11].item_name;
                            }
                            else if (_loc_2[_loc_5][_loc_11].item_key == -1)
                            {
                                _loc_12 = "-1";
                            }
                            else if (_loc_2[_loc_5][_loc_11].item_key == -2)
                            {
                                _loc_12 = "-2";
                            }
                            else
                            {
                                _loc_12 = _loc_2[_loc_5][_loc_11].item_key;
                            }
                            if (_loc_11 != 0)
                            {
                                _loc_13 = (_loc_2[_loc_5][_loc_11].item_type as String).split("_");
                                _loc_14 = _loc_13[(_loc_13.length - 1)];
                                _loc_15 = new StallsSearchItemBase();
                                _loc_15.index = _loc_11;
                                _loc_15.name = _loc_12;
                                _loc_15.addEventListener(MouseEvent.CLICK, this.selectItem);
                                _loc_15.txt.text = _loc_14 || "";
                                this._tree.addSecondItem(_loc_15, _loc_4);
                            }
                        }
                        _loc_11++;
                    }
                    _loc_4++;
                }
                _loc_5++;
            }
            var _loc_6:* = 0;
            while (this._tree && _loc_6 < this._tree.length)
            {
                
                this._tree.setTreeItemBgWidthByIndex(_loc_6, 134);
                _loc_6++;
            }
            return;
        }// end function

        private function selectItem(event:MouseEvent) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_2:* = event.currentTarget.name;
            event.stopImmediatePropagation();
            if (_loc_2 == "0")
            {
                AuctionObj.getInstance().search.type = 0;
                AuctionObj.getInstance().search.kind = 0;
                AuctionObj.getInstance().search.jobLimit = 0;
                AuctionObj.getInstance().search.modelId = 0;
            }
            else if (_loc_2 == "-1")
            {
                AuctionObj.getInstance().search.type = -1;
                AuctionObj.getInstance().search.kind = 0;
                AuctionObj.getInstance().search.jobLimit = 0;
                AuctionObj.getInstance().search.modelId = 0;
            }
            else
            {
                _loc_3 = int(_loc_2.charAt(0));
                if (_loc_3 == 0)
                {
                    AuctionObj.getInstance().search.type = 0;
                    AuctionObj.getInstance().search.kind = 0;
                    AuctionObj.getInstance().search.modelId = 0;
                    AuctionObj.getInstance().search.jobLimit = 0;
                }
                else
                {
                    _loc_4 = _loc_2.split("_");
                    if (_loc_4[0])
                    {
                        if (_loc_4[0].length > 4)
                        {
                            AuctionObj.getInstance().search.type = ItemType.MATERIAL;
                            AuctionObj.getInstance().search.modelId = _loc_4[0];
                        }
                        else
                        {
                            AuctionObj.getInstance().search.type = _loc_4[0];
                            AuctionObj.getInstance().search.modelId = 0;
                        }
                    }
                    else
                    {
                        AuctionObj.getInstance().search.type = 0;
                        AuctionObj.getInstance().search.modelId = 0;
                    }
                    if (_loc_4[1])
                    {
                        AuctionObj.getInstance().search.kind = _loc_4[1];
                    }
                    else
                    {
                        AuctionObj.getInstance().search.kind = 0;
                    }
                    if (_loc_4[2])
                    {
                        AuctionObj.getInstance().search.jobLimit = _loc_4[2];
                    }
                    else
                    {
                        AuctionObj.getInstance().search.jobLimit = 0;
                    }
                }
            }
            if (this.lastClickItem)
            {
                this.lastClickItem.selected = false;
            }
            this.lastClickItem = event.currentTarget as StallsSearchItemBase;
            if (this.lastClickItem)
            {
                this.lastClickItem.selected = true;
            }
            this.resetDrop();
            AuctionControl.getInstance().reqStart(false);
            this.decideDropVisible();
            return;
        }// end function

        private function decideDropVisible() : void
        {
            var _loc_1:* = AuctionObj.getInstance().search;
            if (_loc_1.type == ItemType.EQUIP || _loc_1.type == ItemType.WING || _loc_1.goodsname != "" && _loc_1.goodsname != null)
            {
                this._qualityDrop.enable = true;
                this._stageLevelDrop.enable = true;
                this._intensifyDrop.enable = true;
            }
            else
            {
                this._qualityDrop.enable = false;
                this._stageLevelDrop.enable = false;
                this._intensifyDrop.enable = false;
            }
            return;
        }// end function

        private function __levelClick(event:MouseEvent) : void
        {
            this._levelSort = !this._levelSort;
            AuctionObj.getInstance().sort(AuctionObj.LEVEL, this._levelSort);
            this.info = AuctionObj.getInstance().breflist;
            return;
        }// end function

        private function __numClick(event:MouseEvent) : void
        {
            this._sellNumSort = !this._sellNumSort;
            AuctionObj.getInstance().sort(AuctionObj.SELLNUM, this._sellNumSort);
            this.info = AuctionObj.getInstance().breflist;
            return;
        }// end function

        private function __searchClick(event:MouseEvent = null) : void
        {
            if (AuctionObj.getInstance().search.goodsname != "" && AuctionObj.getInstance().search.goodsname != null)
            {
                AuctionControl.getInstance().reqList(0, (AuctionControl.PAGESIZE - 1), true);
            }
            else
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10265"));
            }
            return;
        }// end function

        private function __update(event:MouseEvent) : void
        {
            if (this._curItem)
            {
                this._curItem.selected = false;
            }
            this._curItem = null;
            AuctionControl.getInstance().reqList(0, (AuctionControl.PAGESIZE - 1), AuctionObj.getInstance().preOper);
            return;
        }// end function

        private function __stallsItemInfo(event:StallsEvent) : void
        {
            if (this._curItem != event.data)
            {
                if (this._curItem != null)
                {
                    this._curItem.selected = false;
                }
                this._curItem = event.data;
                this._curItem.selected = true;
            }
            return;
        }// end function

        private function __playerInfoClick(event:MouseEvent) : void
        {
            if (this._curItem == null)
            {
                return;
            }
            PlayerControl.getInstance().reqForPlayer(this._curItem.info.playerid);
            return;
        }// end function

        private function __infoClick(event:MouseEvent) : void
        {
            if (this._curItem == null)
            {
                return;
            }
            return;
        }// end function

        private function __checkAddClick(event:MouseEvent) : void
        {
            if (AuctionObj.getInstance().search.addAttribute == 0)
            {
                AuctionObj.getInstance().search.addAttribute = 1;
            }
            else if (AuctionObj.getInstance().search.addAttribute == 1)
            {
                AuctionObj.getInstance().search.addAttribute = 0;
            }
            return;
        }// end function

        private function __checkSuitClick() : void
        {
            return;
        }// end function

        private function __checkUseableClick(event:MouseEvent) : void
        {
            if (AuctionObj.getInstance().search.useable == 0)
            {
                AuctionObj.getInstance().search.useable = 1;
            }
            else if (AuctionObj.getInstance().search.useable == 1)
            {
                AuctionObj.getInstance().search.useable = 0;
            }
            return;
        }// end function

        private function __checkRemarkClick(event:MouseEvent) : void
        {
            if (AuctionObj.getInstance().search.remark == 0)
            {
                AuctionObj.getInstance().search.remark = 1;
            }
            else if (AuctionObj.getInstance().search.remark == 1)
            {
                AuctionObj.getInstance().search.remark = 0;
            }
            return;
        }// end function

        public function update() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_1:* = this._container.length - this._info.length;
            if (_loc_1 < 0)
            {
                _loc_1 = -_loc_1;
                _loc_2 = 0;
                while (_loc_2 < _loc_1)
                {
                    
                    _loc_3 = new BoothItem();
                    this._container.add(_loc_3);
                    _loc_2++;
                }
            }
            else
            {
                _loc_4 = this._container.length;
                _loc_2 = this._container.length - 1;
                while (_loc_2 >= _loc_4 - _loc_1)
                {
                    
                    this._container.removeByIndex(_loc_2);
                    _loc_2 = _loc_2 - 1;
                }
            }
            _loc_2 = 0;
            while (_loc_2 < this._info.length)
            {
                
                (this._container.getContent(_loc_2) as BoothItem).selectIndex = _loc_2;
                (this._container.getContent(_loc_2) as BoothItem).index = _loc_2 + 1;
                this._container.getContent(_loc_2).info = this._info[_loc_2];
                _loc_2++;
            }
            this._scrollpanel.scrollTo(0);
            this._pageCounter.curPage = AuctionObj.getInstance().curpage;
            this._pageCounter.pageTotal = AuctionObj.getInstance().pages;
            this._pageCounter.setVlaue(this._pageCounter.curPage, this._pageCounter.pageTotal, true);
            if (this._curItem)
            {
                this._curItem.selected = false;
            }
            this._curItem = this._container.getContent(0);
            if (this._curItem)
            {
                this._curItem.selected = true;
            }
            this.updateInfoBtn();
            this.decideDropVisible();
            this._scrollpanel.updateThumb();
            return;
        }// end function

        private function __stallsItemSelected(event:StallsEvent) : void
        {
            if (this._curItem != event.data)
            {
                if (this._curItem != null)
                {
                    this._curItem.selected = false;
                }
                this._curItem = event.data;
                this._curItem.selected = true;
                this.updateInfoBtn();
            }
            return;
        }// end function

        private function updateInfoBtn() : void
        {
            if (this._curItem == null)
            {
                return;
            }
            if (this._curItem.info.isNpc || this._curItem.info.playerid.equal(UserObj.getInstance().playerInfo.personId))
            {
            }
            return;
        }// end function

    }
}
