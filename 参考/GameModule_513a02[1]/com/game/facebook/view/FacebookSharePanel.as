﻿package com.game.facebook.view
{
    import __AS3__.vec.*;
    import com.events.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.scroller.*;
    import com.game.facebook.control.*;
    import com.game.newactivity.control.*;
    import com.game.newactivity.model.*;
    import com.model.vo.*;
    import com.util.*;
    import flash.display.*;
    import flash.events.*;

    public class FacebookSharePanel extends BaseBox
    {
        private var btnClose:BaseButton;
        private var rowViews:Vector.<FacebookShareAwardRowView>;
        private var scrollView:ScrollPanel;
        private var scrollViewContent:Sprite;
        private var activityInfo:NewActivityInfo;
        private var isPanelJustOpened:Boolean;
        public var activityId:int = 32;
        public var activityGroupId:int = 14;
        private static var PAGE_ROW_COUNT:uint = 3;

        public function FacebookSharePanel()
        {
            this.activityInfo = NewActivityModel.getInstance().getActivityByActivityId(this.activityId);
            if (!this.activityInfo.isDetailInit)
            {
                NewActivityControl.getInstance().getActivityInfo(this.activityInfo.activityId);
            }
            loadDisplay("res/facebookSharePanel.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("facebookSharePanel");
            this.initUI();
            super.displayReady();
            return;
        }// end function

        public function initUI() : void
        {
            this.btnClose = UiUtil.createButton(this, "btnClose", this.onClose);
            this.scrollViewContent = new Sprite();
            this.scrollView = new ScrollPanel(493, 320);
            this.scrollView.content = this.scrollViewContent;
            this.scrollView.move(14, 185);
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
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            if (this.activityInfo == null || !this.activityInfo.isDetailInit)
            {
                return;
            }
            var _loc_3:* = this.activityInfo.activityItemLists;
            if (this.rowViews == null)
            {
                this.rowViews = new Vector.<FacebookShareAwardRowView>;
                _loc_4 = 0;
                _loc_2 = 0;
                while (_loc_2 < _loc_3.length)
                {
                    
                    _loc_5 = new FacebookShareAwardRowView();
                    this.rowViews[_loc_2] = _loc_5;
                    _loc_5.y = _loc_4;
                    this.scrollViewContent.addChild(_loc_5);
                    _loc_4 = _loc_4 + (_loc_5.height + 1);
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
                if (this.rowViews.length > PAGE_ROW_COUNT)
                {
                    _loc_6 = this.rowViews.length - PAGE_ROW_COUNT;
                    _loc_7 = 0;
                    while (_loc_7 < _loc_6 && (_loc_3[_loc_7] as NewActivityItemInfo).canGet == FacebookConst.ACTIVITY_AWARD_CAN_GET_GAINED)
                    {
                        
                        _loc_7++;
                    }
                    this.scrollView.scrollToByContent(this.rowViews[_loc_7].y);
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

        private function onClose(event:MouseEvent) : void
        {
            close();
            return;
        }// end function

    }
}
