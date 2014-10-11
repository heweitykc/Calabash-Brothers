package com.game.facebook.view
{
    import __AS3__.vec.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.game.facebook.cfg.*;
    import com.game.facebook.control.*;
    import com.game.facebook.locale.*;
    import com.model.vo.*;
    import com.util.*;
    import com.view.icon.*;
    import flash.events.*;
    import flash.text.*;

    public class FacebookShareAwardRowView extends Component
    {
        private var viewCondition:TextField;
        private var itemViews:Vector.<IconItem>;
        private var btnGain:BaseButton;
        private var activityInfo:NewActivityInfo;
        private var activityItemInfo:NewActivityItemInfo;
        private static var MAX_ITEMS:uint = 5;

        public function FacebookShareAwardRowView()
        {
            var _loc_2:* = null;
            super("facebookShareAwardRowView");
            this.viewCondition = getDisplayChildByName("viewCondition");
            this.itemViews = new Vector.<IconItem>(MAX_ITEMS);
            var _loc_1:* = 0;
            while (_loc_1 < MAX_ITEMS)
            {
                
                _loc_2 = new IconItem(getDisplayChildByName("itemView" + _loc_1));
                _loc_2.setImageXY(4, 4);
                _loc_2.setWH(48, 48);
                _loc_2.setCountTxtXY(48 - 7, 48 - 18);
                addChild(_loc_2);
                this.itemViews[_loc_1] = _loc_2;
                _loc_1 = _loc_1 + 1;
            }
            this.btnGain = UiUtil.createButton(this, "btnGain", this.onGain);
            this.btnGain.setText("");
            this.viewCondition.text = "";
            return;
        }// end function

        public function refreshData(param1:NewActivityInfo, param2:NewActivityItemInfo) : void
        {
            var _loc_6:* = null;
            this.activityInfo = param1;
            this.activityItemInfo = param2;
            this.viewCondition.htmlText = FacebookShareCfgObj.getInstance().getCfg(param2.condiction).q_condition_desc;
            var _loc_3:* = 0;
            while (_loc_3 < MAX_ITEMS)
            {
                
                _loc_6 = param2.jobAwardList[_loc_3];
                this.itemViews[_loc_3].setInfo(_loc_6);
                _loc_3 = _loc_3 + 1;
            }
            var _loc_4:* = param2.canGet == FacebookConst.ACTIVITY_AWARD_CAN_GET_GAINABLE;
            this.btnGain.enabled = _loc_4;
            this.btnGain.filters = _loc_4 ? (null) : (UiUtil.DARK_FILTERS);
            var _loc_5:* = "";
            switch(param2.canGet)
            {
                case FacebookConst.ACTIVITY_AWARD_CAN_GET_GAINABLE:
                {
                    _loc_5 = FacebookText.btnGainAward;
                    break;
                }
                case FacebookConst.ACTIVITY_AWARD_CAN_GET_GAINED:
                {
                    _loc_5 = FacebookText.btnGained;
                    break;
                }
                case FacebookConst.ACTIVITY_AWARD_CAN_GET_NOT_GAINABLE:
                {
                    _loc_5 = FacebookText.btnNotGainable;
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.btnGain.setText(_loc_5);
            return;
        }// end function

        private function onGain(event:MouseEvent) : void
        {
            if (this.activityItemInfo && this.activityItemInfo.canGet == FacebookConst.ACTIVITY_AWARD_CAN_GET_GAINABLE)
            {
                FacebookControl.getInstance().gainShareAward(this.activityItemInfo);
            }
            return;
        }// end function

    }
}
