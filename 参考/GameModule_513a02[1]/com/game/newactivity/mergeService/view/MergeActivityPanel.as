package com.game.newactivity.mergeService.view
{
    import com.events.*;
    import com.f1.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.newactivity.control.*;
    import com.game.newactivity.mergeService.view.mergeView.*;
    import com.game.newactivity.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class MergeActivityPanel extends Component
    {
        private var _actIds:Array;
        private var _activityId:int;
        private var _activityInfo:NewActivityInfo;
        private var _timeCount:int;
        private var _tabBar:Buttons;
        private var actTimeTitleTxt:TextField;
        private var actTimeTxt:TextField;
        private var actLeftTimeTitleTxt:TextField;
        private var actLeftTimeTxt:TextField;
        private var _siegePanel:SiegePanel;
        private var _giftPanel:GiftPanel;
        private var _doubleExpPanel:DoubleExpPanel;
        private var _bigGiftPanel:BigGiftPanel;
        private var _rechargeRankPanel:RechargeRankPanel;

        public function MergeActivityPanel(param1 = null, param2:String = null)
        {
            var _loc_5:* = null;
            this._actIds = [NewActivityConfig.ACTID_FIVE_LOGIN_MERGE, NewActivityConfig.ACTID_DOUBLE_EXP, NewActivityConfig.ACTID_BIGPACK_TITLE, NewActivityConfig.ACTID_RECHARGE_RANK, NewActivityConfig.ACTID_WAR2_MERGE, NewActivityConfig.ACTID_WAR4_MERGE];
            super(param1, param2);
            var _loc_3:* = this._actIds.length;
            this._tabBar = new Buttons();
            var _loc_4:* = 1;
            while (_loc_4 <= _loc_3)
            {
                
                _loc_5 = new BaseButton(getDisplayChildByName("act_" + _loc_4), true);
                if (_loc_4 == 1)
                {
                    this._tabBar.move(_loc_5._x, _loc_5._y);
                }
                this._tabBar.add(_loc_5);
                _loc_4++;
            }
            this._tabBar.addEvtListener(Event.CHANGE, this.onTabBarChangeHandler);
            addChild(this._tabBar);
            this.actTimeTitleTxt = getDisplayChildByName("actTimeTitleTxt");
            this.actTimeTxt = getDisplayChildByName("actTimeTxt");
            this.actLeftTimeTitleTxt = getDisplayChildByName("actLeftTimeTitleTxt");
            this.actLeftTimeTxt = getDisplayChildByName("actLeftTimeTxt");
            this._giftPanel = new GiftPanel(getDisplayChildByName("giftPanel"));
            this._siegePanel = new SiegePanel(getDisplayChildByName("siegePanel"));
            this._doubleExpPanel = new DoubleExpPanel(getDisplayChildByName("doubleExpPanel"));
            this._bigGiftPanel = new BigGiftPanel(getDisplayChildByName("bigGiftPanel"));
            this._rechargeRankPanel = new RechargeRankPanel(getDisplayChildByName("rechargeRankPanel"));
            return;
        }// end function

        override public function finalize() : void
        {
            this.clearInfo();
            super.finalize();
            return;
        }// end function

        private function updateInfo(event:Event = null) : void
        {
            Ticker.killTimer(this.updateCountTime);
            this._activityInfo = NewActivityModel.getInstance().getActivityByActivityId(this._activityId);
            var _loc_2:* = true;
            switch(this._activityId)
            {
                case NewActivityConfig.ACTID_FIVE_LOGIN_MERGE:
                {
                    this.switchPanel(this._giftPanel);
                    this._giftPanel.setInfo(this._activityInfo);
                    break;
                }
                case NewActivityConfig.ACTID_WAR2_MERGE:
                {
                    this.switchPanel(this._siegePanel);
                    this._siegePanel.setInfo(this._activityId, this._activityInfo);
                    break;
                }
                case NewActivityConfig.ACTID_WAR4_MERGE:
                {
                    this.switchPanel(this._siegePanel);
                    this._siegePanel.setInfo(this._activityId, this._activityInfo);
                    break;
                }
                case NewActivityConfig.ACTID_DOUBLE_EXP:
                {
                    _loc_2 = false;
                    this.switchPanel(this._doubleExpPanel);
                    this._doubleExpPanel.setInfo(this._activityId, this._activityInfo);
                    break;
                }
                case NewActivityConfig.ACTID_BIGPACK_TITLE:
                {
                    _loc_2 = false;
                    this.switchPanel(this._bigGiftPanel);
                    this._bigGiftPanel.setInfo(this._activityId, this._activityInfo);
                    break;
                }
                case NewActivityConfig.ACTID_RECHARGE_RANK:
                {
                    _loc_2 = false;
                    this.switchPanel(this._rechargeRankPanel);
                    this._rechargeRankPanel.setInfo(this._activityId, this._activityInfo);
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (_loc_2)
            {
                this.actTimeTitleTxt.visible = true;
                this.actTimeTxt.visible = true;
                this.actLeftTimeTitleTxt.visible = true;
                this.actLeftTimeTxt.visible = true;
                this.actTimeTxt.text = ToolKit.getFormatDate(this._activityInfo.beginTime * 1000, "YMDhm") + " - " + ToolKit.getFormatDate(this._activityInfo.endTime * 1000, "YMDhm");
                this._timeCount = this._activityInfo.endTime - ToolKit.getServerTime() / 1000;
                this.updateCountText();
                if (this._timeCount > 0)
                {
                    Ticker.registerTimer(1, this.updateCountTime, null, this._timeCount);
                }
            }
            else
            {
                this.actTimeTitleTxt.visible = false;
                this.actTimeTxt.visible = false;
                this.actLeftTimeTitleTxt.visible = false;
                this.actLeftTimeTxt.visible = false;
            }
            return;
        }// end function

        private function switchPanel(param1:DisplayObject) : void
        {
            var _loc_5:* = null;
            var _loc_2:* = [this._giftPanel, this._siegePanel, this._doubleExpPanel, this._bigGiftPanel, this._rechargeRankPanel];
            var _loc_3:* = _loc_2.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = _loc_2[_loc_4];
                _loc_5.visible = _loc_5 == param1;
                _loc_4++;
            }
            return;
        }// end function

        private function updateCountTime() : void
        {
            var _loc_1:* = this;
            var _loc_2:* = this._timeCount - 1;
            _loc_1._timeCount = _loc_2;
            this.updateCountText();
            return;
        }// end function

        private function updateCountText() : void
        {
            if (this._timeCount > 0)
            {
                this.actLeftTimeTxt.text = "" + ToolKit.second2TimeStr(this._timeCount, LanguageCfgObj.getInstance().getByIndex("10964"));
            }
            else
            {
                this.actLeftTimeTxt.text = "" + LanguageCfgObj.getInstance().getByIndex("12429");
            }
            return;
        }// end function

        public function clearInfo() : void
        {
            this._siegePanel.clearInfo();
            this._doubleExpPanel.clearInfo();
            this._bigGiftPanel.clearInfo();
            Ticker.killTimer(this.updateCountTime);
            if (this._activityInfo)
            {
                this._activityInfo.removeEventListener(NewActivityEvent.ACTIVITY_DETAIL_UPDATE, this.updateInfo);
                this._activityInfo.removeEventListener(NewActivityEvent.ACTIVITY_INFO_UPDATE, this.updateInfo);
            }
            this._activityInfo = null;
            return;
        }// end function

        public function loadInfo(param1:int) : void
        {
            if (param1 >= 0)
            {
                this._tabBar.selectIndex = param1;
            }
            this.onTabBarChangeHandler(null);
            return;
        }// end function

        private function onTabBarChangeHandler(event:Event) : void
        {
            this._activityId = this._actIds[this._tabBar.selectIndex];
            this._activityInfo = NewActivityModel.getInstance().getActivityByActivityId(this._activityId);
            if (this._activityInfo)
            {
                this._activityInfo.addEvtListener(NewActivityEvent.ACTIVITY_DETAIL_UPDATE, this.updateInfo);
                this._activityInfo.addEvtListener(NewActivityEvent.ACTIVITY_INFO_UPDATE, this.updateInfo);
                NewActivityControl.getInstance().getActivityInfo(this._activityInfo.activityId);
            }
            if (this._activityInfo)
            {
                this.updateInfo();
            }
            return;
        }// end function

    }
}
