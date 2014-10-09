package com.game.redfortress.view
{
    import __AS3__.vec.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.game.redfortress.message.*;
    import com.game.redfortress.model.*;
    import com.model.vo.*;
    import com.util.*;
    import com.view.icon.*;
    import flash.events.*;

    public class ZonesRedFortressTopListPanel extends BaseBox
    {
        private var _btnGetGift:BaseButton;
        private var _hBox:HBox;
        private var _rankList:BaseSprite;
        private var _vecItems:Vector.<ZonesRedFortressTopItem>;
        private var _selfItem:ZonesRedFortressTopItem;
        private var _topListInfo:ResCsysEndMessage;
        private static var RANK_LIST_LENGTH:int = 5;

        public function ZonesRedFortressTopListPanel(param1 = null, param2:uint = 60, param3:String = "", param4:Boolean = true)
        {
            super(param1, param2, param3, param4);
            loadDisplay("res/redfortressrank.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("redfortress_rank_view");
            this.initUI();
            this.addEvents();
            super.displayReady();
            this.freshPanel();
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_2:* = null;
            this._btnGetGift = new BaseButton(getDisplayChildByName("btn_get_gift"));
            this._btnGetGift.setText(LanguageCfgObj.getInstance().getByIndex("11113"));
            this._vecItems = new Vector.<ZonesRedFortressTopItem>;
            this._rankList = new BaseSprite();
            this._rankList.move(25, 138);
            this.addChild(this._rankList);
            var _loc_1:* = 0;
            while (_loc_1 < RANK_LIST_LENGTH)
            {
                
                _loc_2 = new ZonesRedFortressTopItem(ZonesRedFortressTopItem.RANK_PANEL_ITEM);
                this._vecItems[_loc_1] = _loc_2;
                this._rankList.addChild(_loc_2);
                _loc_2.move(0, _loc_1 * _loc_2.height);
                _loc_1++;
            }
            this._selfItem = new ZonesRedFortressTopItem(ZonesRedFortressTopItem.RANK_PANEL_ITEM);
            this._selfItem.move(25, 326);
            this.addChild(this._selfItem);
            this._hBox = new HBox();
            this._hBox.oneRow = 5;
            this._hBox.intervalX = 11;
            this.addChild(this._hBox);
            return;
        }// end function

        private function addEvents() : void
        {
            this.addEventListener(MouseEvent.CLICK, this.mouseClickHandler);
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            return;
        }// end function

        protected function mouseClickHandler(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._btnGetGift:
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

        protected function onAddedToStage(event:Event) : void
        {
            this.freshPanel();
            return;
        }// end function

        private function freshPanel() : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (!UILoaded)
            {
                return;
            }
            if (!this._topListInfo)
            {
                return;
            }
            this._hBox.reset();
            ZonesRedfortressModel.getInstance().zonesRankList = this._topListInfo.infos;
            var _loc_1:* = this._topListInfo.infos;
            if (_loc_1)
            {
                _loc_3 = _loc_1.length;
                _loc_4 = 0;
                while (_loc_4 < RANK_LIST_LENGTH)
                {
                    
                    if (_loc_4 < _loc_3)
                    {
                        this._vecItems[_loc_4].info = _loc_1[_loc_4];
                    }
                    else
                    {
                        this._vecItems[_loc_4].info = null;
                    }
                    _loc_4++;
                }
            }
            this._selfItem.info = ZonesRedfortressModel.getInstance().zonesSelfRank;
            var _loc_2:* = this._topListInfo.itemlist;
            _loc_4 = 0;
            while (_loc_4 < _loc_2.length)
            {
                
                _loc_5 = new IconItem("commonRewardBox2_40");
                _loc_5.setWH(40, 40);
                _loc_5.image.move(3, 3);
                _loc_6 = PropUtil.createItemByItemInfo(_loc_2[_loc_4]);
                _loc_5.setInfo(_loc_6);
                this._hBox.add(_loc_5);
                _loc_4++;
            }
            layoutMC(this._hBox, Layout.BOTTOM_CENTER, 0, 75);
            return;
        }// end function

        public function get topListInfo() : ResCsysEndMessage
        {
            return this._topListInfo;
        }// end function

        public function set topListInfo(param1:ResCsysEndMessage) : void
        {
            this._topListInfo = param1;
            this.freshPanel();
            return;
        }// end function

    }
}
