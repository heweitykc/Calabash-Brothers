package com.game.historymsg.view
{
    import __AS3__.vec.*;
    import com.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.scroller.*;
    import com.game.historymsg.bean.*;
    import com.game.historymsg.control.*;
    import com.game.historymsg.event.*;
    import com.game.historymsg.model.*;
    import com.game.historymsg.util.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class HistorymsgListPanel extends BaseBox
    {
        private var btnClose:BaseButton;
        private var rowViews:Vector.<HistorymsgListRowView>;
        private var titleTitle:TextField;
        private var titleOperation:TextField;
        private var scrollView:ScrollPanel;
        private var scrollViewContent:Sprite;
        private var btnClear:BaseButton;
        public var showing:Boolean = false;
        private var historymsgData:HistorymsgData;

        public function HistorymsgListPanel()
        {
            this.rowViews = new Vector.<HistorymsgListRowView>;
            this.historymsgData = HistorymsgData.getInstance();
            _combinedBox = ["com.game.historymsg.view::HistorymsgPanel"];
            loadDisplay("res/historymsgPanel.swf");
            Global.popManager.addPop(this);
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("historymsgListPanel");
            this.initUI();
            super.displayReady();
            return;
        }// end function

        public function initUI() : void
        {
            this.btnClose = HistorymsgUiUtil.createButton(this, "btnClose", this.onClose);
            this.titleTitle = HistorymsgUiUtil.getTitleTextField(this, "titleTitle");
            this.titleTitle.text = LanguageCfgObj.getInstance().getByIndex("10860");
            this.titleOperation = HistorymsgUiUtil.getTitleTextField(this, "titleOperation");
            this.titleOperation.text = LanguageCfgObj.getInstance().getByIndex("10861");
            this.scrollViewContent = new Sprite();
            this.scrollView = new ScrollPanel(291, 167);
            this.scrollView.content = this.scrollViewContent;
            this.scrollView.move(13, 67);
            addChild(this.scrollView);
            this.btnClear = HistorymsgUiUtil.createButton(this, "btnClear", this.onClear);
            this.btnClear.setText(LanguageCfgObj.getInstance().getByIndex("10862"));
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            if (stage)
            {
                this.onAddedToStage();
            }
            return;
        }// end function

        private function onAddedToStage(event:Event = null) : void
        {
            this.showing = true;
            HistorymsgControl.getInstance().judgeMsgIconVisible();
            this.historymsgData.addEventListener(HistorymsgEvent.HISTORYMSG_DATA_CHANGE, this.refreshData);
            this.initData();
            return;
        }// end function

        private function onRemovedFromStage(event:Event) : void
        {
            this.showing = false;
            this.historymsgData.removeEventListener(HistorymsgEvent.HISTORYMSG_DATA_CHANGE, this.refreshData);
            HistorymsgControl.getInstance().judgeMsgIconVisible();
            return;
        }// end function

        private function initData() : void
        {
            this.refreshData();
            return;
        }// end function

        private function refreshData(event:Event = null) : void
        {
            var _loc_5:* = 0;
            var _loc_9:* = null;
            var _loc_11:* = null;
            var _loc_2:* = this.historymsgData.msgs;
            if (_loc_2.length == 0)
            {
                close();
                return;
            }
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_6:* = _loc_3;
            var _loc_7:* = _loc_4;
            var _loc_8:* = 42;
            _loc_5 = 0;
            while (_loc_5 < _loc_2.length)
            {
                
                _loc_11 = _loc_2[_loc_5];
                if (_loc_5 >= this.rowViews.length)
                {
                    _loc_9 = new HistorymsgListRowView();
                    this.rowViews.push(_loc_9);
                    _loc_9.move(_loc_6, _loc_7);
                    this.scrollViewContent.addChild(_loc_9);
                }
                else
                {
                    _loc_9 = this.rowViews[_loc_5];
                }
                _loc_9.setData(_loc_11);
                _loc_7 = _loc_7 + _loc_8;
                _loc_5 = _loc_5 + 1;
            }
            while (_loc_5 < this.rowViews.length)
            {
                
                _loc_9 = this.rowViews[_loc_5];
                this.scrollViewContent.removeChild(_loc_9);
                _loc_5 = _loc_5 + 1;
            }
            this.rowViews.length = _loc_2.length;
            this.scrollView.updateThumb();
            var _loc_10:* = _loc_4 + this.scrollViewContent.height;
            if (_loc_4 + this.scrollViewContent.height <= this.scrollView._h)
            {
                if (this.scrollViewContent.y < 0)
                {
                    this.scrollView.scrollToByContent(0);
                }
            }
            else if (this.scrollViewContent.y < 0)
            {
                if (-this.scrollViewContent.y + this.scrollView._h > _loc_10)
                {
                    this.scrollView.scrollToByContent(_loc_10 - this.scrollView._h);
                }
            }
            return;
        }// end function

        private function onClose(event:MouseEvent) : void
        {
            close();
            return;
        }// end function

        private function onClear(event:MouseEvent) : void
        {
            HistorymsgControl.getInstance().clearMsgs();
            return;
        }// end function

    }
}
