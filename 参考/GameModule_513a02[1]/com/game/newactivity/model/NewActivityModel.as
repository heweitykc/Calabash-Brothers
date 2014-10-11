package com.game.newactivity.model
{
    import com.events.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.map.control.*;
    import com.game.map.view.topbtnspanel.*;
    import com.game.newactivity.bean.*;
    import com.game.newactivity.control.*;
    import com.game.newactivity.message.*;
    import com.greensock.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.utils.*;

    public class NewActivityModel extends BaseEventDispatcher
    {
        public var activityList:Dictionary;
        public var activityGroupDic:Dictionary;
        private static var _instance:NewActivityModel;

        public function NewActivityModel()
        {
            return;
        }// end function

        public function initActivityList(param1:ResNewActivityList) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (!this.activityList)
            {
                this.activityList = new Dictionary();
                this.activityGroupDic = new Dictionary();
                for each (_loc_3 in param1.activities)
                {
                    
                    _loc_2 = new NewActivityInfo();
                    _loc_2.conBySimpleActivityInfo(_loc_3);
                    this.activityList[_loc_2.activityId] = _loc_2;
                    Log.log("收到活动 ID：" + _loc_3.activityId);
                    if (!this.activityGroupDic[_loc_2.q_group])
                    {
                        this.activityGroupDic[_loc_2.q_group] = [];
                    }
                    if (this.activityGroupDic[_loc_2.q_group].indexOf(_loc_2.activityId) == -1)
                    {
                        this.activityGroupDic[_loc_2.q_group].push(_loc_2.activityId);
                    }
                }
                for (_loc_4 in this.activityGroupDic)
                {
                    
                    this.activityAct(int(_loc_4));
                }
            }
            else
            {
                for each (_loc_3 in param1.activities)
                {
                    
                    _loc_2 = this.activityList[_loc_3.activityId] as NewActivityInfo;
                    if (!_loc_2)
                    {
                        _loc_2 = new NewActivityInfo();
                    }
                    _loc_2.conBySimpleActivityInfo(_loc_3);
                    this.activityList[_loc_2.activityId] = _loc_2;
                    if (!this.activityGroupDic[_loc_2.q_group])
                    {
                        this.activityGroupDic[_loc_2.q_group] = [];
                    }
                    if (this.activityGroupDic[_loc_2.q_group].indexOf(_loc_2.activityId) == -1)
                    {
                        this.activityGroupDic[_loc_2.q_group].push(_loc_2.activityId);
                    }
                    this.activityDetailUpdateCountByAct(_loc_2);
                    for (_loc_4 in this.activityGroupDic)
                    {
                        
                        this.activityAct(int(_loc_4));
                    }
                }
            }
            _loc_5 = NewActivityModel.getInstance().getActivityByActivityId(NewActivityConfig.ACTID_GIFT_360HOME);
            if (_loc_5)
            {
                if (MapControl.getInstance().topActivateIconsPanel)
                {
                    _loc_5.addEvtListener(NewActivityEvent.ACTIVITY_DETAIL_UPDATE, MapControl.getInstance().topActivateIconsPanel.update360Tips);
                }
            }
            return;
        }// end function

        public function getActivityByActivityId(param1:int) : NewActivityInfo
        {
            return this.activityList[param1];
        }// end function

        public function activityDetailUpdate(param1:ResGetNewActivityInfo) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            _loc_2 = this.activityList ? (this.activityList[param1.detailInfo.activityId]) : (null);
            if (_loc_2)
            {
                _loc_2.conByDetailActivityInfo(param1.detailInfo);
                this.activityDetailUpdateCountByAct(_loc_2);
                _loc_2.dispatchEvent(new NewActivityEvent(NewActivityEvent.ACTIVITY_DETAIL_UPDATE, _loc_2));
                if (param1.updateAllInfo == 1)
                {
                    _loc_2.dispatchEvent(new NewActivityEvent(NewActivityEvent.ACTIVITY_INFO_UPDATE, _loc_2));
                }
                _loc_3 = [NewActivityConfig.ACTID_RECHARGE_DAYS, NewActivityConfig.ACTID_GIFT_Nothink];
                _loc_4 = [TopActivateName.RECHARGE_DAYS, TopActivateName.GIFT_NOTHINK];
                _loc_5 = _loc_3.indexOf(param1.detailInfo.activityId);
                _loc_6 = _loc_4[_loc_5];
                if (_loc_5 >= 0)
                {
                    _loc_7 = _loc_2.endTime - ToolKit.getServerTime() * 0.001;
                    if (_loc_7 > 0)
                    {
                        MapControl.getInstance().setTopIconCD(_loc_6, _loc_7);
                    }
                }
            }
            return;
        }// end function

        public function addActivity(param1:SimpleActivityInfo) : void
        {
            var _loc_2:* = new NewActivityInfo();
            _loc_2.conBySimpleActivityInfo(param1);
            this.activityList[_loc_2.activityId] = _loc_2;
            if (!this.activityGroupDic[_loc_2.q_group])
            {
                this.activityGroupDic[_loc_2.q_group] = [];
                this.activityAct(int(_loc_2.q_group));
            }
            if (this.activityGroupDic[_loc_2.q_group].indexOf(_loc_2.activityId) == -1)
            {
                this.activityGroupDic[_loc_2.q_group].push(_loc_2.activityId);
            }
            return;
        }// end function

        public function removeActivity(param1:int) : void
        {
            var _loc_3:* = 0;
            var _loc_2:* = this.activityList[param1];
            if (_loc_2)
            {
                _loc_3 = this.activityGroupDic[_loc_2.q_group].indexOf(_loc_2.activityId);
                if (_loc_3 != -1)
                {
                    this.activityGroupDic[_loc_2.q_group].splice(_loc_3, 1);
                }
                if (this.activityGroupDic[_loc_2.q_group].length == 0)
                {
                    this.activityGroupDic[_loc_2.q_group] = null;
                    delete this.activityGroupDic[_loc_2.q_group];
                    this.activityDeAct(int(_loc_2.q_group));
                }
                this.activityList[param1] = null;
                delete this.activityList[param1];
            }
            return;
        }// end function

        private function activityDeAct(param1:int) : void
        {
            switch(param1)
            {
                case NewActivityConfig.GROUP_FIRST_RECHARGE:
                {
                    MapControl.getInstance().topActivateRemoveBtn(TopActivateName.TOP_ICON_FIRST_RECHARGE);
                    break;
                }
                case NewActivityConfig.GROUP_SINGLE_RECHARGE:
                {
                    MapControl.getInstance().topActivateRemoveBtn(TopActivateName.TOP_ICON_SINGLE_RECHARGE);
                    break;
                }
                case NewActivityConfig.GROUP_SEVEN_ACTIVITY:
                {
                    MapControl.getInstance().topActivateRemoveBtn(TopActivateName.TOP_ICON_SEVEN_DAY);
                    break;
                }
                case NewActivityConfig.GROUP_ONLINE_ACTIVITY:
                {
                    MapControl.getInstance().topActivateRemoveBtn(TopActivateName.TOP_ICON_ONLINE);
                    break;
                }
                case NewActivityConfig.GROUP_MAY_ACTIVITY:
                {
                    TweenLite.delayedCall(1800, this.hideMayActivityIcon);
                    break;
                }
                case NewActivityConfig.GROUP_GIFT_360:
                {
                    MapControl.getInstance().topActivateRemoveBtn(TopActivateName.GIFT_360);
                    break;
                }
                case NewActivityConfig.GROUP_GIFT_DUOWAN:
                {
                    MapControl.getInstance().topActivateRemoveBtn(TopActivateName.GIFT_DUOWAN);
                    break;
                }
                case NewActivityConfig.GROUP_GIFT_37:
                {
                    MapControl.getInstance().topActivateRemoveBtn(TopActivateName.GIFT_37);
                    break;
                }
                case NewActivityConfig.GROUP_GIFT_XUNLEI:
                {
                    MapControl.getInstance().topActivateRemoveBtn(TopActivateName.GIFT_XUNLEI);
                    break;
                }
                case NewActivityConfig.GROUP_GIFT_BAIDU:
                {
                    MapControl.getInstance().topActivateRemoveBtn(TopActivateName.GIFT_BAIDU);
                    break;
                }
                case NewActivityConfig.GROUP_GIFT_LIEBAO:
                {
                    MapControl.getInstance().topActivateRemoveBtn(TopActivateName.GIFT_LIEBAO);
                    break;
                }
                case NewActivityConfig.GROUP_GIFT_360HOME:
                {
                    MapControl.getInstance().topActivateRemoveBtn(TopActivateName.GIFT_360HOME);
                    break;
                }
                case NewActivityConfig.GROUP_GIFT_NOTHINK:
                {
                    MapControl.getInstance().topActivateRemoveBtn(TopActivateName.GIFT_NOTHINK);
                    break;
                }
                case NewActivityConfig.GROUP_MERGE_SERVICE:
                {
                    MapControl.getInstance().topActivateRemoveBtn(TopActivateName.MERGE_SERVICE);
                    break;
                }
                case NewActivityConfig.GROUP_PREV_MERGE:
                {
                    MapControl.getInstance().topActivateRemoveBtn(TopActivateName.PREV_MERGE);
                    break;
                }
                case NewActivityConfig.GROUP_SUPERVIP:
                {
                    MapControl.getInstance().topActivateRemoveBtn(TopActivateName.SUPERVIP);
                    break;
                }
                case NewActivityConfig.GROUP_FACEBOOK_INVITE:
                {
                    MapControl.getInstance().topActivateRemoveBtn(TopActivateName.FACEBOOK_INVITE);
                    break;
                }
                case NewActivityConfig.GROUP_FACEBOOK_SHARE:
                {
                    MapControl.getInstance().topActivateRemoveBtn(TopActivateName.FACEBOOK_SHARE);
                    break;
                }
                case NewActivityConfig.GROUP_VALENTINE_DAYS:
                {
                    MapControl.getInstance().topActivateRemoveBtn(TopActivateName.TOP_ICON_ACTIVE_VALENT);
                    break;
                }
                case NewActivityConfig.GROUP_RECHARGE_DAYS:
                {
                    MapControl.getInstance().topActivateRemoveBtn(TopActivateName.RECHARGE_DAYS);
                    break;
                }
                case NewActivityConfig.GROUP_MID_AUTUMN:
                {
                    MapControl.getInstance().topActivateRemoveBtn(TopActivateName.TOP_ICON_MID_AUTUMN);
                    break;
                }
                case NewActivityConfig.GROUP_MOONFESTIVAL_ACT:
                {
                    MapControl.getInstance().topActivateRemoveBtn(TopActivateName.TOP_ICON_MOOD_FEASTIVAL);
                    break;
                }
                case NewActivityConfig.GROUP_POPULAR_PAY:
                {
                    MapControl.getInstance().topActivateRemoveBtn(TopActivateName.TOP_ICON_POPULAR);
                    break;
                }
                default:
                {
                    break;
                }
            }
            dispatchEvent(new NewActivityEvent(NewActivityEvent.ACTIVITY_GROUP_REMOVE, param1));
            return;
        }// end function

        private function hideMayActivityIcon() : void
        {
            MapControl.getInstance().topActivateRemoveBtn(TopActivateName.TOP_ICON_MAY_ACTIVITY);
            MapControl.getInstance().showNormalEffect(TopActivateName.TOP_ICON_MAY_ACTIVITY, false);
            return;
        }// end function

        private function activityAct(param1:int) : void
        {
            var _loc_2:* = null;
            switch(param1)
            {
                case NewActivityConfig.GROUP_FIRST_RECHARGE:
                {
                    MapControl.getInstance().topActivateAddedBtn(TopActivateName.TOP_ICON_FIRST_RECHARGE);
                    break;
                }
                case NewActivityConfig.GROUP_SINGLE_RECHARGE:
                {
                    MapControl.getInstance().topActivateAddedBtn(TopActivateName.TOP_ICON_SINGLE_RECHARGE);
                    break;
                }
                case NewActivityConfig.GROUP_SEVEN_ACTIVITY:
                {
                    MapControl.getInstance().topActivateAddedBtn(TopActivateName.TOP_ICON_SEVEN_DAY);
                    break;
                }
                case NewActivityConfig.GROUP_ONLINE_ACTIVITY:
                {
                    MapControl.getInstance().topActivateAddedBtn(TopActivateName.TOP_ICON_ONLINE);
                    break;
                }
                case NewActivityConfig.GROUP_MAY_ACTIVITY:
                {
                    MapControl.getInstance().topActivateAddedBtn(TopActivateName.TOP_ICON_MAY_ACTIVITY);
                    MapControl.getInstance().showNormalEffect(TopActivateName.TOP_ICON_MAY_ACTIVITY, true);
                    break;
                }
                case NewActivityConfig.GROUP_GIFT_360:
                {
                    MapControl.getInstance().topActivateAddedBtn(TopActivateName.GIFT_360);
                    break;
                }
                case NewActivityConfig.GROUP_GIFT_DUOWAN:
                {
                    MapControl.getInstance().topActivateAddedBtn(TopActivateName.GIFT_DUOWAN);
                    break;
                }
                case NewActivityConfig.GROUP_GIFT_37:
                {
                    MapControl.getInstance().topActivateAddedBtn(TopActivateName.GIFT_37);
                    break;
                }
                case NewActivityConfig.GROUP_GIFT_XUNLEI:
                {
                    MapControl.getInstance().topActivateAddedBtn(TopActivateName.GIFT_XUNLEI);
                    break;
                }
                case NewActivityConfig.GROUP_GIFT_BAIDU:
                {
                    MapControl.getInstance().topActivateAddedBtn(TopActivateName.GIFT_BAIDU);
                    break;
                }
                case NewActivityConfig.GROUP_GIFT_LIEBAO:
                {
                    MapControl.getInstance().topActivateAddedBtn(TopActivateName.GIFT_LIEBAO);
                    break;
                }
                case NewActivityConfig.GROUP_GIFT_360HOME:
                {
                    MapControl.getInstance().topActivateAddedBtn(TopActivateName.GIFT_360HOME);
                    break;
                }
                case NewActivityConfig.GROUP_GIFT_NOTHINK:
                {
                    MapControl.getInstance().topActivateAddedBtn(TopActivateName.GIFT_NOTHINK);
                    break;
                }
                case NewActivityConfig.GROUP_RECHARGE_DAYS:
                {
                    MapControl.getInstance().topActivateAddedBtn(TopActivateName.RECHARGE_DAYS);
                    _loc_2 = NewActivityModel.getInstance().getActivityByActivityId(NewActivityConfig.ACTID_RECHARGE_DAYS);
                    NewActivityControl.getInstance().getActivityInfo(_loc_2.activityId);
                    break;
                }
                case NewActivityConfig.GROUP_MERGE_SERVICE:
                {
                    MapControl.getInstance().topActivateAddedBtn(TopActivateName.MERGE_SERVICE);
                    break;
                }
                case NewActivityConfig.GROUP_PREV_MERGE:
                {
                    MapControl.getInstance().topActivateAddedBtn(TopActivateName.PREV_MERGE);
                    break;
                }
                case NewActivityConfig.GROUP_SUPERVIP:
                {
                    MapControl.getInstance().topActivateAddedBtn(TopActivateName.SUPERVIP);
                    break;
                }
                case NewActivityConfig.GROUP_FACEBOOK_INVITE:
                {
                    MapControl.getInstance().topActivateAddedBtn(TopActivateName.FACEBOOK_INVITE);
                    break;
                }
                case NewActivityConfig.GROUP_FACEBOOK_SHARE:
                {
                    MapControl.getInstance().topActivateAddedBtn(TopActivateName.FACEBOOK_SHARE);
                    break;
                }
                case NewActivityConfig.GROUP_VALENTINE_DAYS:
                {
                    MapControl.getInstance().topActivateAddedBtn(TopActivateName.TOP_ICON_ACTIVE_VALENT);
                    break;
                }
                case NewActivityConfig.GROUP_MID_AUTUMN:
                {
                    MapControl.getInstance().topActivateAddedBtn(TopActivateName.TOP_ICON_MID_AUTUMN);
                    break;
                }
                case NewActivityConfig.GROUP_MOONFESTIVAL_ACT:
                {
                    MapControl.getInstance().topActivateAddedBtn(TopActivateName.TOP_ICON_MOOD_FEASTIVAL);
                    break;
                }
                case NewActivityConfig.GROUP_POPULAR_PAY:
                {
                    MapControl.getInstance().topActivateAddedBtn(TopActivateName.TOP_ICON_POPULAR);
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.activityDetailUpdateCountByGroup(param1);
            dispatchEvent(new NewActivityEvent(NewActivityEvent.ACTIVITY_GROUP_ADD, param1));
            return;
        }// end function

        private function activityDetailUpdateCountByAct(param1:NewActivityInfo) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = 0;
            for each (_loc_4 in this.activityGroupDic[param1.q_group])
            {
                
                _loc_3 = this.activityList[_loc_4];
                _loc_2 = _loc_2 + _loc_3.rewardNum;
            }
            this.updateCount(int(param1.q_group), _loc_2);
            return;
        }// end function

        private function activityDetailUpdateCountByGroup(param1:int) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = 0;
            for each (_loc_4 in this.activityGroupDic[param1])
            {
                
                _loc_3 = this.activityList[_loc_4];
                _loc_2 = _loc_2 + _loc_3.rewardNum;
            }
            this.updateCount(param1, _loc_2);
            return;
        }// end function

        private function updateCount(param1:int, param2:int) : void
        {
            switch(param1)
            {
                case NewActivityConfig.GROUP_FIRST_RECHARGE:
                {
                    MapControl.getInstance().topActivateSetCountText(TopActivateName.TOP_ICON_FIRST_RECHARGE, param2.toString());
                    break;
                }
                case NewActivityConfig.GROUP_SINGLE_RECHARGE:
                {
                    MapControl.getInstance().topActivateSetCountText(TopActivateName.TOP_ICON_SINGLE_RECHARGE, param2.toString());
                    break;
                }
                case NewActivityConfig.GROUP_SEVEN_ACTIVITY:
                {
                    MapControl.getInstance().topActivateSetCountText(TopActivateName.TOP_ICON_SEVEN_DAY, param2.toString());
                    break;
                }
                case NewActivityConfig.GROUP_ONLINE_ACTIVITY:
                {
                    MapControl.getInstance().topActivateSetCountText(TopActivateName.TOP_ICON_ONLINE, param2.toString());
                    break;
                }
                case NewActivityConfig.GROUP_RECHARGE_DAYS:
                {
                    MapControl.getInstance().topActivateSetCountText(TopActivateName.RECHARGE_DAYS, param2.toString());
                    break;
                }
                case NewActivityConfig.GROUP_MERGE_SERVICE:
                {
                    MapControl.getInstance().topActivateSetCountText(TopActivateName.MERGE_SERVICE, param2.toString());
                    break;
                }
                case NewActivityConfig.GROUP_PREV_MERGE:
                {
                    MapControl.getInstance().topActivateSetCountText(TopActivateName.PREV_MERGE, param2.toString());
                    break;
                }
                case NewActivityConfig.GROUP_FACEBOOK_INVITE:
                {
                    MapControl.getInstance().topActivateSetCountText(TopActivateName.FACEBOOK_INVITE, param2.toString());
                    break;
                }
                case NewActivityConfig.GROUP_FACEBOOK_SHARE:
                {
                    MapControl.getInstance().topActivateSetCountText(TopActivateName.FACEBOOK_SHARE, param2.toString());
                    break;
                }
                case NewActivityConfig.GROUP_FACEBOOK_SHARE:
                {
                    MapControl.getInstance().topActivateSetCountText(TopActivateName.TOP_ICON_MID_AUTUMN, param2.toString());
                    break;
                }
                case NewActivityConfig.GROUP_POPULAR_PAY:
                {
                    MapControl.getInstance().topActivateSetCountText(TopActivateName.TOP_ICON_POPULAR, param2.toString());
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function getActivityByGroup(param1:int) : Object
        {
            if (this.activityGroupDic[param1])
            {
                return this.activityGroupDic[param1];
            }
            return null;
        }// end function

        public static function getInstance() : NewActivityModel
        {
            var _loc_1:* = new NewActivityModel;
            _instance = new NewActivityModel;
            return _instance || _loc_1;
        }// end function

    }
}
