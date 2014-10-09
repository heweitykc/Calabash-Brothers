package com.game.facebook.view
{
    import __AS3__.vec.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.game.facebook.control.*;
    import com.game.facebook.locale.*;
    import com.model.vo.*;
    import com.util.*;
    import com.view.icon.*;
    import flash.events.*;
    import flash.text.*;

    public class FacebookInviteAwardRowView extends Component
    {
        private var viewCondition:TextField;
        private var itemViews:Vector.<IconItem>;
        private var btnGain:BaseButton;
        private var activityInfo:NewActivityInfo;
        private var activityItemInfo:NewActivityItemInfo;
        private static var MAX_ITEMS:uint = 5;

        public function FacebookInviteAwardRowView()
        {
            var _loc_2:* = null;
            super("facebookInviteAwardRowView");
            this.viewCondition = getDisplayChildByName("viewCondition");
            this.itemViews = new Vector.<IconItem>(MAX_ITEMS);
            var _loc_1:* = 0;
            while (_loc_1 < MAX_ITEMS)
            {
                
                _loc_2 = new IconItem(getDisplayChildByName("itemView" + _loc_1));
                _loc_2.setImageXY(5, 5);
                _loc_2.setImageSize(56, 56);
                _loc_2.setCountTxtXY(66 - 10, 66 - 22);
                addChild(_loc_2);
                this.itemViews[_loc_1] = _loc_2;
                _loc_1 = _loc_1 + 1;
            }
            this.btnGain = UiUtil.createButton(this, "btnGain", this.onGain);
            this.btnGain.setText("");
            this.viewCondition.text = "";
            return;
        }// end function

        private function getConditionText(param1:NewActivityItemInfo) : String
        {
            var _loc_2:* = param1.getStrCondiction();
            var _loc_3:* = param1.condictionDes;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2.length)
            {
                
                _loc_3 = _loc_3.replace("%", _loc_2[_loc_4]);
                _loc_4 = _loc_4 + 1;
            }
            return _loc_3;
        }// end function

        public function refreshData(param1:NewActivityInfo, param2:NewActivityItemInfo) : void
        {
            var _loc_6:* = null;
            this.activityInfo = param1;
            this.activityItemInfo = param2;
            this.viewCondition.htmlText = this.getConditionText(param2);
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
                FacebookControl.getInstance().gainInviteAward(this.activityInfo, this.activityItemInfo);
            }
            return;
        }// end function

    }
}
