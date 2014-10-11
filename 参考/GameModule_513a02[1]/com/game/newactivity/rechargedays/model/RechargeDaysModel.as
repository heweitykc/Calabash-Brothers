package com.game.newactivity.rechargedays.model
{
    import com.events.*;
    import com.game.newactivity.model.*;
    import com.game.newactivity.rechargedays.control.*;
    import com.model.vo.*;
    import com.staticdata.*;

    public class RechargeDaysModel extends Object
    {
        private var _info:Object;
        private var _activityInfo:NewActivityInfo;
        private var _acitivityId:int = 30;
        private var _keys:Array;
        private static var _inst:RechargeDaysModel;

        public function RechargeDaysModel()
        {
            this._keys = ["100", "500", "1000"];
            this._activityInfo = NewActivityModel.getInstance().getActivityByActivityId(NewActivityConfig.ACTID_RECHARGE_DAYS);
            if (this._activityInfo)
            {
                this._activityInfo.addEvtListener(NewActivityEvent.ACTIVITY_DETAIL_UPDATE, this.update);
            }
            this._info = new Object();
            return;
        }// end function

        public function get keys() : Array
        {
            return this._keys;
        }// end function

        public function set keys(param1:Array) : void
        {
            this._keys = param1;
            return;
        }// end function

        public function get activityInfo() : NewActivityInfo
        {
            return this._activityInfo;
        }// end function

        public function set activityInfo(param1:NewActivityInfo) : void
        {
            this._activityInfo = param1;
            return;
        }// end function

        public function get acitivityId() : int
        {
            return this._acitivityId;
        }// end function

        private function update(event:NewActivityEvent) : void
        {
            var _loc_2:* = false;
            this.updateInfo();
            RechargetDaysControl.getInstance().initOpenRechargeDays();
            return;
        }// end function

        public function initInfo() : void
        {
            if (!this._activityInfo)
            {
                this._activityInfo = NewActivityModel.getInstance().getActivityByActivityId(NewActivityConfig.ACTID_RECHARGE_DAYS);
                if (this._activityInfo)
                {
                    this._activityInfo.addEvtListener(NewActivityEvent.ACTIVITY_DETAIL_UPDATE, this.update);
                }
            }
            this.updateInfo();
            return;
        }// end function

        public function updateGroupCount(param1:String) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = param1.split("|");
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                if (!this._info[this.keys[_loc_3]])
                {
                    this._info[this.keys[_loc_3]] = new RechargeDaysInfo();
                }
                _loc_4 = this._info[this.keys[_loc_3]];
                if (_loc_4)
                {
                    _loc_4.curGroups = _loc_2[_loc_3];
                    RechargetDaysControl.getInstance().updateGroupAward(this.keys[_loc_3]);
                }
                _loc_3++;
            }
            return;
        }// end function

        private function updateInfo() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (this._activityInfo)
            {
                _loc_1 = this._activityInfo.activityItemLists.length;
                this.keys = [];
                _loc_2 = 0;
                while (_loc_2 < _loc_1)
                {
                    
                    _loc_3 = this._activityInfo.activityItemLists[_loc_2] as NewActivityItemInfo;
                    _loc_4 = this._activityInfo.activityItemLists[(_loc_2 + 1)] as NewActivityItemInfo;
                    this._info.inited = 1;
                    if (!this._info[_loc_3.condiction])
                    {
                        this._info[_loc_3.condiction] = new RechargeDaysInfo();
                    }
                    _loc_5 = this._info[_loc_3.condiction];
                    if (_loc_5)
                    {
                        _loc_5.canGet = _loc_3.canGet;
                        _loc_5.canGetGroup = _loc_4.canGet;
                        _loc_5.props = _loc_3.awardList;
                        _loc_5.index = _loc_3.index;
                        _loc_5.groupIndex = _loc_4.index;
                        _loc_6 = _loc_4.condiction.split("|");
                        _loc_5.key = _loc_6[0].toString();
                        this.keys.push(_loc_6[0].toString());
                        _loc_5.needGroups = _loc_6[1];
                        _loc_5.groupProp = _loc_4.awardList[0];
                    }
                    _loc_2 = _loc_2 + 2;
                }
                RechargetDaysControl.getInstance().updateInfo();
            }
            return;
        }// end function

        public function updateGroup(param1:int, param2:int, param3:String) : void
        {
            if (!this._info[param3])
            {
                this._info[param3] = new RechargeDaysInfo();
            }
            var _loc_4:* = this._info[param3];
            if (this._info[param3])
            {
                _loc_4.curGroups = param1;
                _loc_4.needGroups = param2;
                RechargetDaysControl.getInstance().updateGroupAward(param3);
            }
            return;
        }// end function

        public function getdayInfo(param1:String) : RechargeDaysInfo
        {
            if (!this._info)
            {
                throw new Error("未初始化");
            }
            return this._info[param1];
        }// end function

        public static function get inst() : RechargeDaysModel
        {
            var _loc_1:* = new RechargeDaysModel;
            _inst = new RechargeDaysModel;
            return _inst || _loc_1;
        }// end function

    }
}
