package com.game.newactivity.gift.view
{
    import __AS3__.vec.*;
    import com.events.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.scroller.*;
    import com.f1.utils.*;
    import com.game.newactivity.control.*;
    import com.game.newactivity.model.*;
    import com.model.vo.*;
    import com.util.*;
    import flash.display.*;
    import flash.events.*;

    public class GiftPanel extends BaseBox
    {
        private var btnClose:BaseButton;
        private var btnGotoWebsite:BaseButton;
        private var rowViews:Vector.<GiftRowView>;
        private var leadingRowView:GiftLeadingRowView;
        private var scrollView:ScrollPanel;
        private var scrollViewContent:Sprite;
        private var activityInfo:NewActivityInfo;
        private var gainCd:int;
        private var isPanelJustOpened:Boolean;
        public var activityId:int;
        public var activityGroupId:int;
        public var panelResourceUrl:String;
        public var panelResourceClassName:String;
        public var rowResourceClassName:String;
        public var ruleWebsite:String;
        public var leadingRowResourceClassName:String;
        private static var PAGE_ROW_COUNT:uint = 5;
        private static var GAIN_CD_SECONDS:uint = 3;

        public function GiftPanel()
        {
            return;
        }// end function

        protected function init() : void
        {
            this.activityInfo = NewActivityModel.getInstance().getActivityByActivityId(this.activityId);
            if (!this.activityInfo.isDetailInit)
            {
                NewActivityControl.getInstance().getActivityInfo(this.activityInfo.activityId);
            }
            loadDisplay(this.panelResourceUrl);
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI(this.panelResourceClassName);
            this.initUI();
            super.displayReady();
            return;
        }// end function

        public function initUI() : void
        {
            this.btnClose = UiUtil.createButton(this, "btnClose", this.onClose);
            this.btnGotoWebsite = UiUtil.createButton(this, "btnGotoWebsite", this.onGotoWebsite);
            this.scrollViewContent = new Sprite();
            this.scrollView = new ScrollPanel(530, 423);
            this.scrollView.content = this.scrollViewContent;
            this.scrollView.move(23, 123);
            addChild(this.scrollView);
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
            NewActivityModel.getInstance().addEventListener(NewActivityEvent.ACTIVITY_GROUP_REMOVE, this.onActivityGroupRemove);
            this.activityInfo.addEventListener(NewActivityEvent.ACTIVITY_DETAIL_UPDATE, this.refreshData);
            this.activityInfo.addEventListener(NewActivityEvent.ACTIVITY_INFO_UPDATE, this.refreshData);
            this.initData();
            return;
        }// end function

        private function onRemovedFromStage(event:Event) : void
        {
            NewActivityModel.getInstance().removeEventListener(NewActivityEvent.ACTIVITY_GROUP_REMOVE, this.onActivityGroupRemove);
            this.activityInfo.removeEventListener(NewActivityEvent.ACTIVITY_DETAIL_UPDATE, this.refreshData);
            this.activityInfo.removeEventListener(NewActivityEvent.ACTIVITY_INFO_UPDATE, this.refreshData);
            return;
        }// end function

        private function initData() : void
        {
            this.isPanelJustOpened = true;
            this.refreshData();
            return;
        }// end function

        private function refreshData(event:Event = null) : void
        {
            var _loc_2:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            if (this.activityInfo == null || !this.activityInfo.isDetailInit)
            {
                return;
            }
            var _loc_3:* = this.activityInfo.activityItemLists;
            if (this.leadingRowView == null)
            {
                if (this.leadingRowResourceClassName != null)
                {
                    this.leadingRowView = new GiftLeadingRowView(this);
                    this.scrollViewContent.addChild(this.leadingRowView);
                }
            }
            if (this.rowViews == null)
            {
                this.rowViews = new Vector.<GiftRowView>;
                _loc_4 = 1;
                _loc_5 = this.leadingRowView == null ? (0) : (GiftLeadingRowView.HEIGHT + _loc_4);
                _loc_2 = 0;
                while (_loc_2 < _loc_3.length)
                {
                    
                    _loc_6 = new GiftRowView(this);
                    this.rowViews[_loc_2] = _loc_6;
                    _loc_6.y = _loc_5;
                    this.scrollViewContent.addChild(_loc_6);
                    _loc_5 = _loc_5 + (_loc_6.height + _loc_4);
                    _loc_2 = _loc_2 + 1;
                }
                this.scrollView.updateThumb();
            }
            _loc_2 = 0;
            while (_loc_2 < this.rowViews.length)
            {
                
                this.rowViews[_loc_2].refreshData(this.activityInfo, _loc_3[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            if (this.isPanelJustOpened)
            {
                this.isPanelJustOpened = false;
                if (this.leadingRowView == null && this.rowViews.length > PAGE_ROW_COUNT)
                {
                    _loc_7 = this.rowViews.length - PAGE_ROW_COUNT;
                    _loc_8 = 0;
                    while (_loc_8 < _loc_7 && (_loc_3[_loc_8] as NewActivityItemInfo).canGet == 0)
                    {
                        
                        _loc_8++;
                    }
                    this.scrollView.scrollToByContent(this.rowViews[_loc_8].y);
                }
            }
            return;
        }// end function

        private function onActivityGroupRemove(event:NewActivityEvent) : void
        {
            if (int(event.data) == this.activityGroupId)
            {
                close();
            }
            return;
        }// end function

        private function onGotoWebsite(event:MouseEvent) : void
        {
            JSTools.openWindow(this.ruleWebsite);
            return;
        }// end function

        public function onLeadingRowClick() : void
        {
            return;
        }// end function

        private function onClose(event:MouseEvent) : void
        {
            close();
            return;
        }// end function

        public function onGain() : void
        {
            var _loc_1:* = null;
            this.gainCd = GAIN_CD_SECONDS;
            for each (_loc_1 in this.rowViews)
            {
                
                _loc_1.beginGainCd();
                _loc_1.setGainCd(this.gainCd);
            }
            Ticker.registerTimer(1, this.onGainCdChange, null, this.gainCd);
            return;
        }// end function

        private function onGainCdChange() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = this;
            this.gainCd = (this.gainCd - 1);
            _loc_2.gainCd = this.gainCd - 1;
            if (this.gainCd > 0)
            {
                for each (_loc_1 in this.rowViews)
                {
                    
                    _loc_1.setGainCd(this.gainCd);
                }
            }
            else
            {
                for each (_loc_1 in this.rowViews)
                {
                    
                    _loc_1.endGainCd();
                }
            }
            return;
        }// end function

        public function isGainCding() : Boolean
        {
            return this.gainCd > 0;
        }// end function

    }
}
