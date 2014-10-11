package com.game.stalls.view
{
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.f1.ui.scroller.*;
    import com.f1.utils.*;
    import com.game.stalls.control.*;
    import com.game.stalls.events.*;
    import com.game.stalls.model.*;
    import com.game.utils.*;
    import com.model.*;
    import com.model.vo.*;
    import com.view.*;
    import flash.events.*;
    import flash.text.*;

    public class BoothContainer extends Component
    {
        private var _container:HBox;
        private var _preBoothBtn:BaseButton;
        private var _nextBoothBtn:BaseButton;
        private var _confirmBtn:BaseButton;
        private var _backBtn:BaseButton;
        private var _updateBtn:BaseButton;
        private var _chatBtn:BaseButton;
        private var _resetBtn:BaseButton;
        private var _numBtn:BaseButton;
        private var _playerInfoBtn:BaseButton;
        private var _titleNameTxt:TextField;
        private var _personId:long;
        private var _type:String;
        private var _info:StallsInfo;
        private var _scrollBar:ScrollPanel;
        private var _returnBtn:BaseButton;
        private var _pagecounter:PageCounter;
        private var _curItem:BoothGoodItem;

        public function BoothContainer(param1:String = "boothcontainer")
        {
            super(param1);
            this.initUI();
            this.addListener();
            if (StallsControl.getInstance().otherInfo)
            {
                this.info = StallsControl.getInstance().otherInfo;
                StallsControl.getInstance().otherInfo = null;
            }
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

        public function get info() : StallsInfo
        {
            return this._info;
        }// end function

        public function set info(param1:StallsInfo) : void
        {
            this._info = param1;
            this._personId = param1.playerid;
            this._curItem = null;
            this.update();
            return;
        }// end function

        private function initUI() : void
        {
            this._preBoothBtn = new BaseButton(getDisplayChildByName("btn_pre"));
            this._preBoothBtn.setText(LanguageCfgObj.getInstance().getByIndex("11184"));
            this._nextBoothBtn = new BaseButton(getDisplayChildByName("btn_next"));
            this._nextBoothBtn.setText(LanguageCfgObj.getInstance().getByIndex("11185"));
            this._confirmBtn = new BaseButton(getDisplayChildByName("btn_confirm"));
            this._confirmBtn.setText(LanguageCfgObj.getInstance().getByIndex("11186"));
            this._backBtn = new BaseButton(getDisplayChildByName("btn_back"));
            this._backBtn.setText(LanguageCfgObj.getInstance().getByIndex("11187"));
            this._updateBtn = new BaseButton(getDisplayChildByName("btn_update"));
            this._updateBtn.setText(LanguageCfgObj.getInstance().getByIndex("11188"));
            this._playerInfoBtn = new BaseButton(getDisplayChildByName("btn_info"));
            this._playerInfoBtn.setText(LanguageCfgObj.getInstance().getByIndex("11189"));
            this._chatBtn = new BaseButton(getDisplayChildByName("btn_chat"));
            this._chatBtn.setText(LanguageCfgObj.getInstance().getByIndex("11190"));
            this._resetBtn = new BaseButton(getDisplayChildByName("btn_reset"));
            this._resetBtn.setText(LanguageCfgObj.getInstance().getByIndex("11191"));
            this._numBtn = new BaseButton(getDisplayChildByName("btn_num"));
            this._numBtn.setText(LanguageCfgObj.getInstance().getByIndex("11192"));
            this._titleNameTxt = getDisplayChildByName("txt_titleName");
            this._pagecounter = new PageCounter(getDisplayChildByName("pagecounter"));
            this._returnBtn = new BaseButton(getDisplayChildByName("btn_return"));
            this._container = new HBox();
            this._container.oneRow = 2;
            this._container.intervalX = 2;
            this._container.x = 3;
            this._container.y = 36;
            addChild(this._container);
            return;
        }// end function

        private function addListener() : void
        {
            this._preBoothBtn.addEvtListener(MouseEvent.CLICK, this.__preClick);
            this._nextBoothBtn.addEvtListener(MouseEvent.CLICK, this.__nextClick);
            this._confirmBtn.addEvtListener(MouseEvent.CLICK, this.__confirmClick);
            this._backBtn.addEvtListener(MouseEvent.CLICK, this.__backClick);
            this._updateBtn.addEvtListener(MouseEvent.CLICK, this.__updateClick);
            this._playerInfoBtn.addEvtListener(MouseEvent.CLICK, this.__playerInfoClick);
            this._chatBtn.addEvtListener(MouseEvent.CLICK, this.__chatClick);
            addEvtListener(StallsEvent.BUY, this.__buyClick);
            addEvtListener(StallsEvent.SELECTEDGOOD, this.__selectClick);
            this._pagecounter.addEvtListener(Event.CHANGE, this.__pageChange);
            this._returnBtn.addEvtListener(MouseEvent.CLICK, this.__backClick);
            return;
        }// end function

        private function __selectClick(event:StallsEvent) : void
        {
            if (this._curItem && this._curItem != event.data)
            {
                this._curItem.selected = false;
            }
            this._curItem = event.data;
            this._curItem.selected = true;
            return;
        }// end function

        public function __buyClick(event:StallsEvent) : void
        {
            this._curItem = event.data;
            StallsControl.getInstance().openBuyStallsInfo(this._curItem.info, this._personId, this._info.isNpc);
            return;
        }// end function

        private function __chatClick(event:MouseEvent) : void
        {
            StallsControl.getInstance().chat(this._info.playername);
            return;
        }// end function

        private function __playerInfoClick(event:MouseEvent) : void
        {
            StallsControl.getInstance().playerInfo(this._info.playerid);
            return;
        }// end function

        private function __pageChange(event:Event) : void
        {
            var _loc_2:* = this._pagecounter.curPage;
            if (_loc_2 > StallsControl.getInstance().curIndex)
            {
                StallsControl.getInstance().reqNext();
            }
            else
            {
                StallsControl.getInstance().reqPre();
            }
            return;
        }// end function

        private function update() : void
        {
            var _loc_1:* = 0;
            var _loc_9:* = null;
            if (this._info.stallsname == "")
            {
                this._titleNameTxt.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12205"), [this._info.playername]);
            }
            else
            {
                this._titleNameTxt.text = this._info.stallsname;
            }
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = false;
            var _loc_5:* = false;
            var _loc_6:* = [];
            var _loc_7:* = 0;
            while (_loc_7 < this._info.stallsgoodsinfo.length)
            {
                
                if (this._info.stallsgoodsinfo[_loc_7].prop.itemModelId == -1)
                {
                    _loc_2 = this._info.stallsgoodsinfo[_loc_7];
                    ;
                }
                else if (_loc_2.prop.itemModelId == -2)
                {
                    _loc_3 = this._info.stallsgoodsinfo[_loc_7];
                }
                _loc_6.push(this._info.stallsgoodsinfo[_loc_7]);
                _loc_1++;
                _loc_7++;
            }
            if (_loc_2)
            {
                _loc_6.push(_loc_2);
            }
            if (_loc_3)
            {
                _loc_6.push(_loc_3);
            }
            var _loc_8:* = this._container.length;
            _loc_7 = 0;
            while (_loc_7 < _loc_8)
            {
                
                this._container.removeByIndex(0);
                _loc_7++;
            }
            _loc_7 = 0;
            while (_loc_7 < _loc_6.length)
            {
                
                if (_loc_6[_loc_7].prop.itemModelId == -1)
                {
                    _loc_9 = new BoothCurrencyItem("stallscurrencyitem", 1);
                    (_loc_9 as BoothCurrencyItem).info = _loc_6[_loc_7];
                }
                else if (_loc_6[_loc_7].prop.itemModelId == -2)
                {
                    _loc_9 = new BoothCurrencyItem("stallscurrencyitem", 2);
                    (_loc_9 as BoothCurrencyItem).info = _loc_6[_loc_7];
                }
                else
                {
                    _loc_9 = new BoothGoodItem("stallsSelectItem");
                    (_loc_9 as BoothGoodItem).info = _loc_6[_loc_7];
                }
                this._container.add(_loc_9);
                _loc_7++;
            }
            this._preBoothBtn.enabled = StallsControl.getInstance().isPreAble();
            this._nextBoothBtn.enabled = StallsControl.getInstance().isNextAble();
            _loc_1 = StallsControl.getInstance().curIndex;
            if (StallsControl.getInstance().selfIndex >= 0)
            {
                if (_loc_1 > StallsControl.getInstance().selfIndex)
                {
                    _loc_1 = _loc_1 - 1;
                }
            }
            if (StallsObj.getInstance().self)
            {
                this._pagecounter.setVlaue((_loc_1 + 1), (StallsObj.getInstance().breflist.length - 1));
            }
            else
            {
                this._pagecounter.setVlaue((_loc_1 + 1), StallsObj.getInstance().breflist.length);
            }
            if (this._info.isNpc)
            {
                this._playerInfoBtn.enabled = false;
                this._chatBtn.enabled = false;
            }
            else
            {
                this._playerInfoBtn.enabled = true;
                this._chatBtn.enabled = true;
            }
            return;
        }// end function

        private function __preClick(event:MouseEvent) : void
        {
            StallsControl.getInstance().reqPre();
            return;
        }// end function

        private function __nextClick(event:MouseEvent) : void
        {
            StallsControl.getInstance().reqNext();
            return;
        }// end function

        private function __confirmClick(event:MouseEvent) : void
        {
            if (!this._curItem)
            {
                return;
            }
            StallsControl.getInstance().openBuyStallsInfo(this._curItem.info, this._personId, this._info.isNpc);
            return;
        }// end function

        private function updateInfoBtn() : void
        {
            if (this.info.isNpc || this.info.playerid.equal(UserObj.getInstance().playerInfo.personId))
            {
                this._playerInfoBtn.enabled = false;
                this._chatBtn.enabled = false;
            }
            else
            {
                this._playerInfoBtn.enabled = true;
                this._chatBtn.enabled = true;
            }
            return;
        }// end function

        private function __backClick(event:MouseEvent) : void
        {
            StallsControl.getInstance().openListSearch(this._type);
            StallsControl.getInstance().reqList();
            return;
        }// end function

        private function __updateClick(event:MouseEvent) : void
        {
            if (this._info.isNpc)
            {
                StallsControl.getInstance().refreshNPCData(this._info.isNpc);
            }
            else
            {
                StallsControl.getInstance().refreshStalls(this._info.playerid);
            }
            return;
        }// end function

    }
}
