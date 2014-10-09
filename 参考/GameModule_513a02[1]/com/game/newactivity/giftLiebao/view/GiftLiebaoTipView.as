package com.game.newactivity.giftLiebao.view
{
    import __AS3__.vec.*;
    import com.events.*;
    import com.f1.utils.*;
    import com.game.newactivity.control.*;
    import com.game.newactivity.gift.locale.*;
    import com.game.newactivity.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class GiftLiebaoTipView extends BaseTips
    {
        private var activityItemInfo:NewActivityItemInfo;
        private var bg:Sprite;
        private var viewTitle:TextField;
        private var viewItems:Sprite;
        private var itemViews:Vector.<GiftLiebaoItemView>;
        private static var activityInfo:NewActivityInfo;

        public function GiftLiebaoTipView()
        {
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            return;
        }// end function

        private function onAddedToStage(event:Event = null) : void
        {
            if (activityInfo == null)
            {
                activityInfo = NewActivityModel.getInstance().getActivityByActivityId(NewActivityConfig.ACTID_GIFT_LIEBAO);
                if (!activityInfo.isDetailInit)
                {
                    NewActivityControl.getInstance().getActivityInfo(activityInfo.activityId);
                }
            }
            activityInfo.addEventListener(NewActivityEvent.ACTIVITY_DETAIL_UPDATE, this.refreshData);
            activityInfo.addEventListener(NewActivityEvent.ACTIVITY_INFO_UPDATE, this.refreshData);
            this.initData();
            return;
        }// end function

        private function onRemovedFromStage(event:Event) : void
        {
            activityInfo.removeEventListener(NewActivityEvent.ACTIVITY_DETAIL_UPDATE, this.refreshData);
            activityInfo.removeEventListener(NewActivityEvent.ACTIVITY_INFO_UPDATE, this.refreshData);
            return;
        }// end function

        private function initData() : void
        {
            this.refreshData();
            return;
        }// end function

        private function refreshData(event:Event = null) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            if (activityInfo == null || !activityInfo.isDetailInit)
            {
                return;
            }
            var _loc_2:* = activityInfo.activityItemLists;
            if (_loc_2.length == 0)
            {
                return;
            }
            this.activityItemInfo = _loc_2[0];
            var _loc_3:* = this.activityItemInfo.jobAwardList;
            if (this.itemViews == null)
            {
                _loc_4 = 25;
                this.bg = ToolKit.getNew("generalHoverWndBg");
                addChild(this.bg);
                this.viewTitle = new TextField();
                this.viewTitle.defaultTextFormat = new TextFormat(GiftText.font, 12, 16774656);
                this.viewTitle.autoSize = TextFieldAutoSize.LEFT;
                this.viewTitle.text = GiftText.clickToGainLiebaoGift;
                this.viewTitle.y = 5;
                addChild(this.viewTitle);
                this.viewItems = new Sprite();
                this.viewItems.y = this.viewTitle.y + this.viewTitle.height + _loc_4;
                addChild(this.viewItems);
                this.itemViews = new Vector.<GiftLiebaoItemView>;
                _loc_5 = 0;
                _loc_6 = 35;
                _loc_7 = 0;
                while (_loc_7 < _loc_3.length)
                {
                    
                    _loc_10 = new GiftLiebaoItemView();
                    _loc_10.setData(_loc_3[_loc_7]);
                    _loc_10.x = _loc_5;
                    this.viewItems.addChild(_loc_10);
                    this.itemViews[_loc_7] = _loc_10;
                    _loc_5 = _loc_5 + (GiftLiebaoItemView.ICON_WIDTH + _loc_6);
                    _loc_7 = _loc_7 + 1;
                }
                _loc_8 = _loc_5 - _loc_6;
                _loc_9 = Math.max(_loc_8, this.viewTitle.width) + _loc_4 * 2;
                this.viewTitle.x = (_loc_9 - this.viewTitle.width) / 2;
                this.viewItems.x = (_loc_9 - _loc_8) / 2;
                this.bg.width = _loc_9;
                this.bg.height = this.viewItems.y + GiftLiebaoItemView.HEIGHT + _loc_4;
            }
            return;
        }// end function

    }
}
