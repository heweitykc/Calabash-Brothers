package com.game.stalls.view
{
    import __AS3__.vec.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.f1.ui.scroller.*;
    import com.f1.ui.tree.*;
    import com.game.player.control.*;
    import com.game.stalls.cfg.*;
    import com.game.stalls.control.*;
    import com.game.stalls.events.*;
    import com.game.stalls.model.*;
    import com.model.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class StallsSearchContainer extends Component
    {
        private var _searchBtn:BaseButton;
        private var _type:String;
        private var _resetBtn:BaseButton;
        private var _tree:Tree;
        private var mc_List:Sprite;
        private var _numSp:NumbericControl;
        private var _checkAddBtn:BaseButton;
        private var _checkUseableBtn:BaseButton;
        private var _checkSuitBtn:BaseButton;
        private var _checkRemarkBtn:BaseButton;
        private var _searchNameTxt:TextField;
        private var _searchGoodTxt:TextField;
        private var _indexBtn:BaseButton;
        private var _stallsNameBtn:BaseButton;
        private var _playerNameBtn:BaseButton;
        private var _goldBtn:BaseButton;
        private var _moneyBtn:BaseButton;
        private var _levelBtn:BaseButton;
        private var _numBtn:BaseButton;
        private var _updateBtn:BaseButton;
        private var _container:HBox;
        private var _playerInfoBtn:BaseButton;
        private var _info:Vector.<StallsBriefInfo>;
        private var _curPage:int;
        private var lastClickItem:StallsSearchItemBase;
        private var _infoBtn:BaseButton;
        private const PAGESIZE:int = 10;
        private var _levelSort:Boolean;
        private var _sellNumSort:Boolean;
        private var _scrollpanel:ScrollPanel;
        private var _numTxt:TextField;
        private var _curItem:BoothItem;
        public static var GOODTEMPLAETE:String = LanguageCfgObj.getInstance().getByIndex("10242");
        public static var NAMETEMPLAETE:String = LanguageCfgObj.getInstance().getByIndex("10243");

        public function StallsSearchContainer(param1 = "searchContainer")
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

        public function get info() : Vector.<StallsBriefInfo>
        {
            return this._info;
        }// end function

        public function set info(param1:Vector.<StallsBriefInfo>) : void
        {
            this._info = param1;
            this.update();
            return;
        }// end function

        private function initUI() : void
        {
            this._numSp = new NumbericControl(getDisplayChildByName("intensifycontainer"));
            addChild(this._numSp);
            this._numSp.max = 16;
            this._resetBtn = new BaseButton(getDisplayChildByName("btn_reset"));
            this._resetBtn.setText(LanguageCfgObj.getInstance().getByIndex("11266"));
            this._tree = new Tree(160, 300);
            this.mc_List = getDisplayChildByName("mc_List");
            this.mc_List.addChild(this._tree);
            this.refreshSearchList();
            this._checkAddBtn = new BaseButton(getDisplayChildByName("btn_checkadd"), true);
            this._checkAddBtn.setText(LanguageCfgObj.getInstance().getByIndex("11267"));
            this._checkUseableBtn = new BaseButton(getDisplayChildByName("btn_checkUseable"), true);
            this._checkUseableBtn._labelTxt.autoSize = "left";
            this._checkUseableBtn.setText(LanguageCfgObj.getInstance().getByIndex("11268"));
            this._checkRemarkBtn = new BaseButton(getDisplayChildByName("btn_checkRemark"), true);
            this._checkRemarkBtn._labelTxt.autoSize = "left";
            this._checkRemarkBtn.setText(LanguageCfgObj.getInstance().getByIndex("11269"));
            this._searchBtn = new BaseButton(getDisplayChildByName("btn_search"));
            this._indexBtn = new BaseButton(getDisplayChildByName("btn_index"));
            this._indexBtn.enabled = false;
            this._indexBtn.setText(LanguageCfgObj.getInstance().getByIndex("11270"));
            this._stallsNameBtn = new BaseButton(getDisplayChildByName("btn_stallsname"));
            this._stallsNameBtn.enabled = false;
            this._stallsNameBtn.setText(LanguageCfgObj.getInstance().getByIndex("11271"));
            this._playerNameBtn = new BaseButton(getDisplayChildByName("btn_playername"));
            this._playerNameBtn.enabled = false;
            this._playerNameBtn.setText(LanguageCfgObj.getInstance().getByIndex("11272"));
            this._levelBtn = new BaseButton(getDisplayChildByName("btn_level"));
            this._levelBtn.setText(LanguageCfgObj.getInstance().getByIndex("11273"));
            this._numBtn = new BaseButton(getDisplayChildByName("btn_num"));
            this._numBtn.setText(LanguageCfgObj.getInstance().getByIndex("11274"));
            this._searchGoodTxt = getDisplayChildByName("txt_searchGood");
            this._searchNameTxt = getDisplayChildByName("txt_searchName");
            this._numTxt = getDisplayChildByName("txt_num");
            this._container = new HBox();
            this._container.oneRow = 1;
            this._container.intervalY = 0;
            this._scrollpanel = new ScrollPanel(425, 280);
            this._scrollpanel.content = this._container;
            this._scrollpanel.move(193, 92);
            addChild(this._scrollpanel);
            this._playerInfoBtn = new BaseButton(getDisplayChildByName("btn_playerInfo"));
            this._playerInfoBtn.setText(LanguageCfgObj.getInstance().getByIndex("11275"));
            this._infoBtn = new BaseButton(getDisplayChildByName("btn_info"));
            this._infoBtn.setText(LanguageCfgObj.getInstance().getByIndex("11276"));
            this._updateBtn = new BaseButton(getDisplayChildByName("btn_update"));
            this._updateBtn.setText(LanguageCfgObj.getInstance().getByIndex("11277"));
            this._numSp.value = 0;
            if (StallsObj.getInstance().breflist)
            {
                this.info = StallsObj.getInstance().breflist;
            }
            this._searchGoodTxt.htmlText = GOODTEMPLAETE;
            this._searchNameTxt.htmlText = NAMETEMPLAETE;
            return;
        }// end function

        private function addListener() : void
        {
            this._playerInfoBtn.addEvtListener(MouseEvent.CLICK, this.__playerInfoClick);
            this._infoBtn.addEvtListener(MouseEvent.CLICK, this.__infoClick);
            this._checkAddBtn.addEvtListener(MouseEvent.CLICK, this.__checkAddClick);
            this._checkUseableBtn.addEvtListener(MouseEvent.CLICK, this.__checkUseableClick);
            this._checkRemarkBtn.addEvtListener(MouseEvent.CLICK, this.__checkRemarkClick);
            this._numBtn.addEvtListener(MouseEvent.CLICK, this.__numClick);
            addEvtListener(StallsEvent.SELECTED, this.__stallsItemSelected);
            this._updateBtn.addEvtListener(MouseEvent.CLICK, this.__update);
            this._searchBtn.addEvtListener(MouseEvent.CLICK, this.__searchClick);
            addEvtListener(StallsEvent.INFO, this.__stallsItemInfo);
            this._levelBtn.addEvtListener(MouseEvent.CLICK, this.__levelClick);
            this._resetBtn.addEvtListener(MouseEvent.CLICK, this.__resetClick);
            this._searchNameTxt.addEventListener(Event.CHANGE, this.__searchNameChange);
            this._searchGoodTxt.addEventListener(Event.CHANGE, this.__searchGoodChange);
            this._searchNameTxt.addEventListener(FocusEvent.FOCUS_IN, this.__focusIn);
            this._searchGoodTxt.addEventListener(FocusEvent.FOCUS_IN, this.__focusIn);
            this._numSp.addEventListener(Event.CHANGE, this.__intensifyChange);
            return;
        }// end function

        private function __intensifyChange(event:Event) : void
        {
            StallsObj.getInstance().search.intensify = this._numSp.value;
            return;
        }// end function

        private function __searchGoodChange(event:Event) : void
        {
            var _loc_2:* = this._searchGoodTxt.text;
            StallsObj.getInstance().search.goodsname = _loc_2;
            return;
        }// end function

        private function __searchNameChange(event:Event) : void
        {
            var _loc_2:* = this._searchNameTxt.text;
            StallsObj.getInstance().search.playername = _loc_2;
            return;
        }// end function

        private function __resetClick(event:MouseEvent) : void
        {
            this.reset();
            return;
        }// end function

        private function reset() : void
        {
            StallsObj.getInstance().search.clear();
            this._searchGoodTxt.htmlText = GOODTEMPLAETE;
            this._searchNameTxt.htmlText = NAMETEMPLAETE;
            this._checkAddBtn.selected = false;
            this._checkRemarkBtn.selected = false;
            this._checkUseableBtn.selected = false;
            this._numSp.value = 0;
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
            this._searchNameTxt.addEventListener(FocusEvent.FOCUS_IN, this.__focusIn);
            this._searchGoodTxt.addEventListener(FocusEvent.FOCUS_IN, this.__focusIn);
            return;
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
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = null;
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
                _loc_2[_loc_7[0]][_loc_7[1]] = _loc_1[_loc_3];
            }
            _loc_4 = 0;
            _loc_5 = 0;
            while (_loc_5 < _loc_2.length)
            {
                
                if (_loc_2[_loc_5])
                {
                    _loc_8 = _loc_2[_loc_5][1].item_type.lastIndexOf("_");
                    _loc_9 = _loc_2[_loc_5][1].item_type.slice((_loc_8 + 1));
                    this._tree.addTreeItem(_loc_9);
                    this._tree.getTreeItemByIndex((_loc_5 - 1)).addEvtListener(Event.CHANGE, this.__itemChange);
                    _loc_10 = 0;
                    while (_loc_10 < _loc_2[_loc_5].length)
                    {
                        
                        if (_loc_2[_loc_5][_loc_10])
                        {
                            if (_loc_2[_loc_5][_loc_10].item_key == 0)
                            {
                                _loc_11 = _loc_2[_loc_5][_loc_10].item_name;
                            }
                            else if (_loc_2[_loc_5][_loc_10].item_key == -1)
                            {
                                _loc_11 = "-1";
                            }
                            else if (_loc_2[_loc_5][_loc_10].item_key == -2)
                            {
                                _loc_11 = "-2";
                            }
                            else
                            {
                                _loc_11 = _loc_2[_loc_5][_loc_10].item_key;
                            }
                            _loc_12 = new StallsSearchItemBase();
                            _loc_12.index = _loc_10;
                            _loc_12.name = _loc_11;
                            _loc_12.addEventListener(MouseEvent.CLICK, this.selectItem);
                            _loc_12.txt.text = _loc_2[_loc_5][_loc_10].item_name;
                            this._tree.addSecondItem(_loc_12, _loc_4);
                        }
                        _loc_10++;
                    }
                    _loc_4++;
                }
                _loc_5++;
            }
            this._tree.setTreeItemUnfoldByIndex(0);
            var _loc_6:* = 0;
            while (this._tree && _loc_6 < this._tree.length)
            {
                
                this._tree.setTreeItemBgWidthByIndex(_loc_6, 140);
                _loc_6++;
            }
            return;
        }// end function

        private function __itemChange(event:Event) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_2:* = event.target as TreeItem;
            if (_loc_2)
            {
                if (_loc_2.isUnfold)
                {
                    if (this.lastClickItem && _loc_2.contain.contains(this.lastClickItem))
                    {
                        _loc_3 = this.lastClickItem.name;
                        if (_loc_3 == "-1")
                        {
                            StallsObj.getInstance().search.goldyuanbao = 0;
                        }
                        else if (_loc_3 == "-2")
                        {
                            StallsObj.getInstance().search.goldyuanbao = 0;
                        }
                        else
                        {
                            _loc_4 = int(_loc_3.charAt(0));
                            if (_loc_4 == 0)
                            {
                                StallsObj.getInstance().search.hide = "";
                            }
                            else
                            {
                                StallsObj.getInstance().search.type = 0;
                                StallsObj.getInstance().search.kind = 0;
                                StallsObj.getInstance().search.jobLimit = 0;
                            }
                        }
                    }
                }
            }
            return;
        }// end function

        private function selectItem(event:MouseEvent) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_2:* = event.currentTarget.name;
            if (_loc_2 == "-1")
            {
                StallsObj.getInstance().search.goldyuanbao = 1;
                StallsObj.getInstance().search.hide = "";
                StallsObj.getInstance().search.type = 0;
                StallsObj.getInstance().search.kind = 0;
                StallsObj.getInstance().search.jobLimit = 0;
            }
            else if (_loc_2 == "-2")
            {
                StallsObj.getInstance().search.goldyuanbao = 2;
                StallsObj.getInstance().search.hide = "";
                StallsObj.getInstance().search.type = 0;
                StallsObj.getInstance().search.kind = 0;
                StallsObj.getInstance().search.jobLimit = 0;
            }
            else
            {
                _loc_3 = int(_loc_2.charAt(0));
                if (_loc_3 == 0)
                {
                    StallsObj.getInstance().search.hide = _loc_2;
                    StallsObj.getInstance().search.type = 0;
                    StallsObj.getInstance().search.kind = 0;
                    StallsObj.getInstance().search.jobLimit = 0;
                    StallsObj.getInstance().search.goldyuanbao = 0;
                }
                else
                {
                    _loc_4 = _loc_2.split("_");
                    if (_loc_4[0])
                    {
                        StallsObj.getInstance().search.type = _loc_4[0];
                    }
                    else
                    {
                        StallsObj.getInstance().search.type = 0;
                    }
                    if (_loc_4[1])
                    {
                        StallsObj.getInstance().search.kind = _loc_4[1];
                    }
                    else
                    {
                        StallsObj.getInstance().search.kind = 0;
                    }
                    if (_loc_4[2])
                    {
                        StallsObj.getInstance().search.jobLimit = _loc_4[2];
                    }
                    else
                    {
                        StallsObj.getInstance().search.jobLimit = 0;
                    }
                    StallsObj.getInstance().search.hide = "";
                    StallsObj.getInstance().search.goldyuanbao = 0;
                }
            }
            if (this.lastClickItem)
            {
                this.lastClickItem.selected = false;
            }
            this.lastClickItem = event.currentTarget as StallsSearchItemBase;
            this.lastClickItem.selected = true;
            StallsControl.getInstance().search();
            return;
        }// end function

        private function __levelClick(event:MouseEvent) : void
        {
            this._levelSort = !this._levelSort;
            StallsObj.getInstance().sort(StallsObj.LEVEL, this._levelSort);
            this.info = StallsObj.getInstance().breflist;
            return;
        }// end function

        private function __numClick(event:MouseEvent) : void
        {
            this._sellNumSort = !this._sellNumSort;
            StallsObj.getInstance().sort(StallsObj.SELLNUM, this._sellNumSort);
            this.info = StallsObj.getInstance().breflist;
            return;
        }// end function

        private function __searchClick(event:MouseEvent = null) : void
        {
            if (StallsObj.getInstance().search.isNull())
            {
                StallsControl.getInstance().search();
            }
            else
            {
                StallsControl.getInstance().reqList();
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
            StallsControl.getInstance().reqList();
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
            if (this._curItem.info.isNpc)
            {
                StallsControl.getInstance().reqNPCData(this._curItem.info, (this._curItem.index - 1));
            }
            else if (this._curItem.info.playerid.equal(UserObj.getInstance().playerInfo.personId))
            {
                StallsControl.getInstance().openMystallsInfo();
            }
            else
            {
                StallsControl.getInstance().openStallsInfo(this._curItem.info, (this._curItem.index - 1));
            }
            return;
        }// end function

        private function __preClick(event:MouseEvent) : void
        {
            var _loc_2:* = this;
            var _loc_3:* = this._curPage - 1;
            _loc_2._curPage = _loc_3;
            if (this._curPage < 1)
            {
                this._curPage = 1;
            }
            this.info = StallsObj.getInstance().breflist.slice((this._curPage - 1) * this.PAGESIZE, this._curPage * this.PAGESIZE);
            return;
        }// end function

        private function __nextClick(event:MouseEvent) : void
        {
            var _loc_3:* = this;
            var _loc_4:* = this._curPage + 1;
            _loc_3._curPage = _loc_4;
            var _loc_2:* = Math.ceil(StallsObj.getInstance().stallssnum / this.PAGESIZE);
            if (this._curPage > _loc_2)
            {
                this._curPage = _loc_2;
            }
            this.info = StallsObj.getInstance().breflist.slice((this._curPage - 1) * this.PAGESIZE, this._curPage * this.PAGESIZE);
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
            if (this._curItem.info.isNpc)
            {
                StallsControl.getInstance().reqNPCData(this._curItem.info, (this._curItem.index - 1));
            }
            else if (this._curItem.info.playerid.equal(UserObj.getInstance().playerInfo.personId))
            {
                StallsControl.getInstance().openMystallsInfo();
            }
            else
            {
                StallsControl.getInstance().openStallsInfo(this._curItem.info, (this._curItem.index - 1));
            }
            return;
        }// end function

        private function __checkAddClick(event:MouseEvent) : void
        {
            if (StallsObj.getInstance().search.addAttribute == 0)
            {
                StallsObj.getInstance().search.addAttribute = 1;
            }
            else if (StallsObj.getInstance().search.addAttribute == 1)
            {
                StallsObj.getInstance().search.addAttribute = 0;
            }
            return;
        }// end function

        private function __checkSuitClick() : void
        {
            return;
        }// end function

        private function __checkUseableClick(event:MouseEvent) : void
        {
            if (StallsObj.getInstance().search.useable == 0)
            {
                StallsObj.getInstance().search.useable = 1;
            }
            else if (StallsObj.getInstance().search.useable == 1)
            {
                StallsObj.getInstance().search.useable = 0;
            }
            return;
        }// end function

        private function __checkRemarkClick(event:MouseEvent) : void
        {
            if (StallsObj.getInstance().search.remark == 0)
            {
                StallsObj.getInstance().search.remark = 1;
            }
            else if (StallsObj.getInstance().search.remark == 1)
            {
                StallsObj.getInstance().search.remark = 0;
            }
            return;
        }// end function

        public function update() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            this._numTxt.text = this._info.length.toString();
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
                this._container.getContent(_loc_2).index = _loc_2 + 1;
                this._container.getContent(_loc_2).info = this._info[_loc_2];
                _loc_2++;
            }
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
                this._playerInfoBtn.enabled = false;
                return;
            }
            if (this._curItem.info.isNpc || this._curItem.info.playerid.equal(UserObj.getInstance().playerInfo.personId))
            {
                this._playerInfoBtn.enabled = false;
            }
            else
            {
                this._playerInfoBtn.enabled = true;
            }
            return;
        }// end function

    }
}
