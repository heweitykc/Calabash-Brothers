package com.game.toplist.view
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.events.ui.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.game.toplist.cfg.*;
    import com.game.toplist.control.*;
    import com.greensock.*;
    import com.model.vo.*;
    import com.view.*;
    import flash.display.*;
    import flash.events.*;

    public class TopListPanel extends BaseBox
    {
        private var _requestType:int;
        private var _currentList:int;
        private var _control:TopListControl;
        private const ITEM_COUNT:uint = 8;
        private var _selectIndex:int;
        private var isInit:Boolean;
        private var _closeBtn:BaseButton;
        private var _listBtns:Vector.<BaseButton>;
        private var _top5List:Vector.<Top5Item>;
        private var _titleItems:Vector.<Object>;
        private var _listItems:Vector.<TopListSelectItem>;
        private var _lastListItem:TopListSelectItem;
        private var _myItem:TopListSelectItem;
        private var _pageCounter:PageCounter;
        private var _roleView:TopListRoleView;
        private var myTitleMc:MovieClip;
        private var leaderIcon:MovieClip;

        public function TopListPanel()
        {
            setWH(763, 535);
            loadDisplay("res/toplistpanel.swf");
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            if (this.isInit)
            {
                this.reset();
                if (this._roleView)
                {
                    this._roleView.setAuto(true);
                }
            }
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            FrameworkGlobal.sendMsg(new WndCloseEvt(WndCloseEvt.CLOSE, getQualifiedClassName(this)));
            if (this._roleView)
            {
                this._roleView.setAuto(false);
            }
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_3:* = null;
            var _loc_5:* = null;
            var _loc_6:* = undefined;
            var _loc_7:* = null;
            this._control = TopListControl.getInstance();
            this._closeBtn = new BaseButton(getDisplayChildByName("btn_close"));
            this._listBtns = new Vector.<BaseButton>;
            var _loc_1:* = 0;
            var _loc_2:* = this._control.listType.length;
            var _loc_4:* = [LanguageCfgObj.getInstance().getByIndex("12271"), LanguageCfgObj.getInstance().getByIndex("12272"), LanguageCfgObj.getInstance().getByIndex("12273"), LanguageCfgObj.getInstance().getByIndex("12274"), LanguageCfgObj.getInstance().getByIndex("12275"), LanguageCfgObj.getInstance().getByIndex("12276"), LanguageCfgObj.getInstance().getByIndex("12457")];
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                _loc_3 = new BaseButton(getDisplayChildByName("tabBtn" + _loc_1));
                _loc_3.name = _loc_1 + "";
                _loc_3.setText(_loc_4[_loc_1]);
                _loc_3.addEvtListener(MouseEvent.CLICK, this.__typeBtnClick);
                this._listBtns.push(_loc_3);
                _loc_1++;
            }
            this._top5List = new Vector.<Top5Item>;
            _loc_1 = 0;
            while (_loc_1 < 5)
            {
                
                _loc_5 = new Top5Item(getDisplayChildByName("top" + _loc_1));
                _loc_5.name = "" + _loc_1;
                _loc_5.addEvtListener(MouseEvent.CLICK, this.onSelectTop5Item);
                this._top5List.push(_loc_5);
                _loc_1++;
            }
            this._titleItems = new Vector.<Object>;
            _loc_1 = 0;
            while (_loc_1 < 4)
            {
                
                _loc_6 = getDisplayChildByName("title" + _loc_1);
                this._titleItems.push(_loc_6);
                _loc_1++;
            }
            this._listItems = new Vector.<TopListSelectItem>;
            _loc_1 = 0;
            while (_loc_1 < (this.ITEM_COUNT + 1))
            {
                
                _loc_7 = new TopListSelectItem(getDisplayChildByName("item" + _loc_1), _loc_1);
                _loc_7.name = _loc_1 + "";
                _loc_7.visible = false;
                _loc_7.addEvtListener(MouseEvent.CLICK, this.__listItemClick);
                this._listItems.push(_loc_7);
                _loc_1++;
            }
            this._myItem = this._listItems[this.ITEM_COUNT];
            this._pageCounter = new PageCounter(getDisplayChildByName("pagecounter"));
            this._pageCounter.addEvtListener(Event.CHANGE, this.onPageChangeHandler);
            this._pageCounter.setVlaue(1, 1);
            this._roleView = new TopListRoleView(getDisplayChildByName("role"));
            this.myTitleMc = getDisplayChildByName("myTitleMc");
            this.leaderIcon = getDisplayChildByName("leaderIcon");
            this.leaderIcon.visible = false;
            this.addListener();
            this.isInit = true;
            this.reset();
            return;
        }// end function

        private function onPageChangeHandler(event:Event = null) : void
        {
            this._updateSelectIndex(0);
            var _loc_2:* = this._pageCounter.curPage;
            _loc_2 = _loc_2 < 1 ? (1) : (_loc_2);
            var _loc_3:* = (_loc_2 - 1) * this.ITEM_COUNT;
            var _loc_4:* = _loc_3 + this.ITEM_COUNT - 1;
            this._control.setType(this._requestType, _loc_3, _loc_4);
            return;
        }// end function

        private function reset() : void
        {
            this._requestType = TopCfg.LEVEL_TYPE;
            TweenLite.delayedCall(0.5, this.onPageChangeHandler);
            this.selectIndex = 0;
            return;
        }// end function

        private function addListener() : void
        {
            this._closeBtn.addEvtListener(MouseEvent.CLICK, this._clickHandler);
            return;
        }// end function

        private function __roleOut(event:MouseEvent) : void
        {
            event.currentTarget.filters = [];
            return;
        }// end function

        private function __imageClick(event:MouseEvent) : void
        {
            var _loc_2:* = int(event.currentTarget.name);
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("toplistpanel");
            this.initUI();
            super.displayReady();
            return;
        }// end function

        override public function finalize() : void
        {
            super.finalize();
            return;
        }// end function

        private function __typeBtnClick(event:MouseEvent) : void
        {
            var _loc_2:* = int(event.currentTarget.name);
            var _loc_3:* = this._control.listType[_loc_2];
            this._requestType = _loc_3;
            this._pageCounter.setVlaue(1, 1);
            this.onPageChangeHandler();
            return;
        }// end function

        private function __listItemClick(event:MouseEvent) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_2:* = event.currentTarget as TopListSelectItem;
            var _loc_3:* = _loc_2 ? (_loc_2.obj) : (null);
            if (_loc_3 && _loc_2.obj.topidx > 0)
            {
                _loc_4 = int(_loc_2.name);
                _loc_5 = this._control.listType.indexOf(_loc_4);
                this.selectIndex = _loc_4;
            }
            return;
        }// end function

        private function _clickHandler(event:MouseEvent) : void
        {
            switch(event.currentTarget)
            {
                case this._closeBtn:
                {
                    this.close();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function updateTitle(param1:int) : void
        {
            var _loc_2:* = null;
            var _loc_5:* = null;
            switch(param1)
            {
                case TopCfg.LEVEL_TYPE:
                {
                    _loc_2 = [LanguageCfgObj.getInstance().getByIndex("12277"), LanguageCfgObj.getInstance().getByIndex("12278"), LanguageCfgObj.getInstance().getByIndex("12279"), LanguageCfgObj.getInstance().getByIndex("12271")];
                    break;
                }
                case TopCfg.HORSE_TYPE:
                {
                    _loc_2 = [LanguageCfgObj.getInstance().getByIndex("12277"), LanguageCfgObj.getInstance().getByIndex("12278"), LanguageCfgObj.getInstance().getByIndex("12279"), LanguageCfgObj.getInstance().getByIndex("12280")];
                    break;
                }
                case TopCfg.COMBOS_TYPE:
                {
                    _loc_2 = [LanguageCfgObj.getInstance().getByIndex("12277"), LanguageCfgObj.getInstance().getByIndex("12278"), LanguageCfgObj.getInstance().getByIndex("12279"), LanguageCfgObj.getInstance().getByIndex("12281")];
                    break;
                }
                case TopCfg.FIGHT_FORCE_TYPE:
                {
                    _loc_2 = [LanguageCfgObj.getInstance().getByIndex("12277"), LanguageCfgObj.getInstance().getByIndex("12278"), LanguageCfgObj.getInstance().getByIndex("12279"), LanguageCfgObj.getInstance().getByIndex("12282")];
                    break;
                }
                case TopCfg.ARTIFACT_TYPE:
                {
                    _loc_2 = [LanguageCfgObj.getInstance().getByIndex("12277"), LanguageCfgObj.getInstance().getByIndex("12278"), LanguageCfgObj.getInstance().getByIndex("12279"), LanguageCfgObj.getInstance().getByIndex("12283")];
                    break;
                }
                case TopCfg.LABOUR_TYPE:
                {
                    _loc_2 = [LanguageCfgObj.getInstance().getByIndex("12277"), LanguageCfgObj.getInstance().getByIndex("12284"), LanguageCfgObj.getInstance().getByIndex("12285"), LanguageCfgObj.getInstance().getByIndex("12286")];
                    break;
                }
                case TopCfg.MAGIC_BOOK:
                {
                    _loc_2 = [LanguageCfgObj.getInstance().getByIndex("12277"), LanguageCfgObj.getInstance().getByIndex("12278"), LanguageCfgObj.getInstance().getByIndex("12279"), LanguageCfgObj.getInstance().getByIndex("12458")];
                    break;
                }
                default:
                {
                    break;
                }
            }
            var _loc_3:* = this._titleItems.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = this._titleItems[_loc_4];
                _loc_5.txt.text = _loc_2[_loc_4];
                _loc_4++;
            }
            return;
        }// end function

        private function _updateListView() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = TopListControl.getInstance().topSelfInfoList;
            var _loc_3:* = _loc_2.length;
            _loc_1 = 0;
            while (_loc_1 < _loc_3)
            {
                
                this._listItems[_loc_1].obj = _loc_2[_loc_1];
                _loc_1++;
            }
            while (_loc_1 < this.ITEM_COUNT)
            {
                
                this._listItems[_loc_1].obj = null;
                _loc_1++;
            }
            this.selectIndex = 0;
            return;
        }// end function

        private function updateTop5() : void
        {
            var _loc_3:* = null;
            var _loc_1:* = this._control.topFiveInfoList.length;
            var _loc_2:* = 0;
            while (_loc_2 < 5)
            {
                
                _loc_3 = this._top5List[_loc_2];
                if (_loc_2 < _loc_1)
                {
                    _loc_3.setData(this._control.topFiveInfoList[_loc_2]);
                }
                else
                {
                    _loc_3.setData(null);
                }
                _loc_2++;
            }
            return;
        }// end function

        public function set currentList(param1:int) : void
        {
            if (param1 < 0)
            {
                return;
            }
            this._currentList = this._control.listType[param1];
            this._updateListBtn(param1);
            this.updateTitle(this._currentList);
            this._updateListView();
            this._myItem.obj = this._control.selfInfo;
            this.updateTop5();
            this._pageCounter.setVlaue(this._control.startIndex / this.ITEM_COUNT + 1, Math.ceil(this._control.pageCount / this.ITEM_COUNT));
            if (this._currentList == TopCfg.LABOUR_TYPE)
            {
                this.myTitleMc.gotoAndStop(2);
                this.leaderIcon.visible = true;
            }
            else
            {
                this.myTitleMc.gotoAndStop(1);
                this.leaderIcon.visible = false;
            }
            return;
        }// end function

        public function get currentList() : int
        {
            return this._currentList;
        }// end function

        private function _updateListBtn(param1:int) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = this._control.listType.length;
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                if (this._listBtns[_loc_2].name == String(param1))
                {
                    this._listBtns[_loc_2].setSelected(true);
                    this._listBtns[_loc_2].enabled = false;
                }
                else
                {
                    this._listBtns[_loc_2].setSelected(false);
                    this._listBtns[_loc_2].enabled = true;
                }
                _loc_2++;
            }
            return;
        }// end function

        private function set selectIndex(param1:int) : void
        {
            this._updateSelectIndex(param1);
            this._updateRoleInfo();
            return;
        }// end function

        private function _updateSelectIndex(param1:int) : void
        {
            this._selectIndex = param1;
            if (this._lastListItem != null)
            {
                this._lastListItem.selected = false;
            }
            if (param1 != -1)
            {
                this._lastListItem = this._listItems[param1];
                this._listItems[param1].selected = true;
            }
            else
            {
                this._lastListItem = null;
            }
            return;
        }// end function

        private function _updateRoleInfo() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            if (this._currentList == TopCfg.HORSE_TYPE)
            {
                _loc_1 = TopListRoleView.HORSE_TYPE;
            }
            else if (this._currentList == TopCfg.ARTIFACT_TYPE)
            {
                _loc_1 = TopListRoleView.ARTIFACT_TYPE;
            }
            else if (this._currentList == TopCfg.MAGIC_BOOK)
            {
                _loc_1 = TopListRoleView.MAGIC_BOOK_TYPE;
            }
            else
            {
                _loc_1 = TopListRoleView.ITEM_TYPE;
            }
            if (this._selectIndex != -1)
            {
                _loc_2 = this._listItems[this._selectIndex].obj;
                this._roleView.setInfo(_loc_2, _loc_1);
            }
            else
            {
                this._roleView.setInfo(null, _loc_1);
            }
            return;
        }// end function

        private function onSelectTop5Item(event:MouseEvent) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_2:* = event.currentTarget as Top5Item;
            if (_loc_2 && _loc_2.topId)
            {
                this.selectIndex = _loc_2.topId - 1;
                if (this._pageCounter.curPage != 1)
                {
                    this._pageCounter.curPage = 1;
                    _loc_3 = this._pageCounter.curPage;
                    _loc_3 = _loc_3 < 1 ? (1) : (_loc_3);
                    _loc_4 = (_loc_3 - 1) * this.ITEM_COUNT;
                    _loc_5 = _loc_4 + this.ITEM_COUNT - 1;
                    this._control.setType(this._requestType, _loc_4, _loc_5);
                }
            }
            return;
        }// end function

    }
}
