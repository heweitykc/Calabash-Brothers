package com.game.newactivity.gift.view
{
    import __AS3__.vec.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.game.newactivity.control.*;
    import com.game.newactivity.gift.locale.*;
    import com.model.vo.*;
    import com.util.*;
    import com.view.icon.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class GiftRowView extends Component
    {
        private var viewLevel:TextField;
        private var viewLevelLeft:TextField;
        private var viewLevelRight:TextField;
        private var viewLevel1:DisplayObject;
        private var viewEndTime:TextField;
        private var itemViews:Vector.<IconItem>;
        private var btnGain:BaseButton;
        private var viewGained:DisplayObject;
        private var panel:GiftPanel;
        private var activityInfo:NewActivityInfo;
        private var activityItemInfo:NewActivityItemInfo;
        private static var MAX_ITEMS:uint = 6;
        private static var DARK_FILTERS:Array = [FrameworkGlobal.colorMat];

        public function GiftRowView(param1:GiftPanel)
        {
            var _loc_3:* = null;
            super(param1.rowResourceClassName);
            this.panel = param1;
            this.viewLevel = getDisplayChildByName("viewLevel");
            this.viewLevelLeft = getDisplayChildByName("viewLevelLeft");
            this.viewLevelRight = getDisplayChildByName("viewLevelRight");
            this.viewLevel1 = getDisplayChildByName("viewLevel1");
            this.viewEndTime = getDisplayChildByName("viewEndTime");
            this.itemViews = new Vector.<IconItem>(MAX_ITEMS);
            var _loc_2:* = 0;
            while (_loc_2 < MAX_ITEMS)
            {
                
                _loc_3 = new IconItem(getDisplayChildByName("itemView" + _loc_2));
                _loc_3.setImageXY(4, 4);
                _loc_3.setWH(48, 48);
                _loc_3.setCountTxtXY(48 - 7, 48 - 18);
                addChild(_loc_3);
                this.itemViews[_loc_2] = _loc_3;
                _loc_2 = _loc_2 + 1;
            }
            this.btnGain = UiUtil.createButton(this, "btnGain", this.onGain);
            this.btnGain.setText(GiftText.btnGain);
            this.viewGained = getDisplayChildByName("viewGained");
            this.btnGain.visible = false;
            this.viewGained.visible = false;
            this.viewLevel.text = "";
            this.viewEndTime.text = "";
            return;
        }// end function

        public function refreshData(param1:NewActivityInfo, param2:NewActivityItemInfo) : void
        {
            var _loc_5:* = false;
            this.activityInfo = param1;
            this.activityItemInfo = param2;
            if (this.viewLevel1)
            {
                _loc_5 = param2.condiction == "1";
                this.viewLevel1.visible = _loc_5;
                this.viewLevelLeft.visible = !_loc_5;
                this.viewLevel.visible = !_loc_5;
                this.viewLevelRight.visible = !_loc_5;
            }
            if (!this.viewLevel1 || param2.condiction != "1")
            {
                this.viewLevel.text = "LV." + param2.condiction;
            }
            this.viewEndTime.text = GiftText.txtEndTime(param1.endTime * 1000);
            var _loc_3:* = 0;
            while (_loc_3 < MAX_ITEMS)
            {
                
                this.itemViews[_loc_3].setInfo(param2.jobAwardList[_loc_3]);
                _loc_3 = _loc_3 + 1;
            }
            var _loc_4:* = param2.canGet == 0;
            this.btnGain.visible = !_loc_4;
            this.viewGained.visible = _loc_4;
            return;
        }// end function

        public function beginGainCd() : void
        {
            this.btnGain.filters = DARK_FILTERS;
            return;
        }// end function

        public function setGainCd(param1:int) : void
        {
            this.btnGain.setText(param1 + GiftText.txtSecond);
            return;
        }// end function

        public function endGainCd() : void
        {
            this.btnGain.filters = null;
            this.btnGain.setText(GiftText.btnGain);
            return;
        }// end function

        private function onGain(event:MouseEvent) : void
        {
            if (this.panel.isGainCding())
            {
                return;
            }
            NewActivityControl.getInstance().getActivityReward(this.panel.activityId, this.activityItemInfo.index);
            this.panel.onGain();
            return;
        }// end function

    }
}
