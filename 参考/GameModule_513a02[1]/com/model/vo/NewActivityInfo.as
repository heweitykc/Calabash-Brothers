package com.model.vo
{
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.game.newactivity.bean.*;

    public class NewActivityInfo extends NewActivityCfg
    {
        public var rewardNum:int;
        public var activityId:int;
        public var notice:String;
        public var beginTime:int;
        public var endTime:int;
        public var condDesc:String = "";
        public var otherInfo:String;
        public var activityItemLists:Array;
        private var _isDetailInit:Boolean = false;

        public function NewActivityInfo()
        {
            return;
        }// end function

        public function get isDetailInit() : Boolean
        {
            return this._isDetailInit;
        }// end function

        public function conByDetailActivityInfo(param1:DetailActivityInfo) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            parse(NewActivityCfgObj.getInstance().getActivityCfgByActivityId(this.activityId));
            this.activityId = param1.activityId;
            this.beginTime = param1.beginTime;
            this.endTime = param1.endTime;
            this.condDesc = param1.condDesc;
            this.otherInfo = param1.otherInfo;
            this.activityItemLists = [];
            var _loc_4:* = 0;
            for each (_loc_2 in param1.items)
            {
                
                _loc_3 = new NewActivityItemInfo();
                if (condictionArr && _loc_4 < condictionArr.length)
                {
                    _loc_3.conByActivityItemInfo(_loc_2, _loc_4, this.activityId, condictionArr[_loc_4]);
                }
                else
                {
                    _loc_3.conByActivityItemInfo(_loc_2, _loc_4, this.activityId, "");
                }
                this.activityItemLists.push(_loc_3);
                _loc_4++;
            }
            this._isDetailInit = true;
            return;
        }// end function

        public function conBySimpleActivityInfo(param1:SimpleActivityInfo) : void
        {
            this.activityId = param1.activityId;
            this.rewardNum = param1.rewardNum;
            parse(NewActivityCfgObj.getInstance().getActivityCfgByActivityId(this.activityId));
            return;
        }// end function

    }
}
