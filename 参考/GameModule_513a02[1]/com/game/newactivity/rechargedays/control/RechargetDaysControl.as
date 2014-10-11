package com.game.newactivity.rechargedays.control
{
    import com.*;
    import com.game.newactivity.control.*;
    import com.game.newactivity.model.*;
    import com.game.newactivity.rechargedays.model.*;
    import com.game.newactivity.rechargedays.view.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.utils.*;

    public class RechargetDaysControl extends Object
    {
        private var _model:RechargeDaysModel;
        private var _rechargePanel:RechargeDaysBox;
        private var _isOpening:Boolean;
        private var _openTimeid:int;
        private static var _inst:RechargetDaysControl;

        public function RechargetDaysControl()
        {
            this._model = RechargeDaysModel.inst;
            return;
        }// end function

        public function openOrCloseRechargeDays() : void
        {
            var _loc_1:* = null;
            if (this._rechargePanel && this._rechargePanel.isOpen)
            {
                this._rechargePanel.close();
            }
            else
            {
                this._isOpening = true;
                this._openTimeid = setTimeout(this.relaseIsOpening, 1000);
                _loc_1 = NewActivityModel.getInstance().getActivityByActivityId(NewActivityConfig.ACTID_RECHARGE_DAYS);
                NewActivityControl.getInstance().getActivityInfo(_loc_1.activityId);
            }
            return;
        }// end function

        private function relaseIsOpening() : void
        {
            clearTimeout(this._openTimeid);
            this._isOpening = false;
            return;
        }// end function

        public function initOpenRechargeDays() : void
        {
            if (this._isOpening)
            {
                clearTimeout(this._openTimeid);
                this._isOpening = false;
                this.openRechargeDays();
            }
            return;
        }// end function

        public function getAward(param1:RechargeDaysInfo) : void
        {
            NewActivityControl.getInstance().getActivityReward(RechargeDaysModel.inst.acitivityId, param1.index);
            return;
        }// end function

        public function getGroupAward(param1:RechargeDaysInfo) : void
        {
            NewActivityControl.getInstance().getActivityReward(RechargeDaysModel.inst.acitivityId, param1.groupIndex);
            return;
        }// end function

        public function updateGroupCount(param1:String) : void
        {
            RechargeDaysModel.inst.updateGroupCount(param1);
            return;
        }// end function

        public function updateGroupAward(param1:String) : void
        {
            if (this._rechargePanel && this._rechargePanel.isOpen)
            {
                this._rechargePanel.updateGroupAwardOnCondition(param1);
            }
            return;
        }// end function

        public function updateInfo() : void
        {
            if (this._rechargePanel && this._rechargePanel.isOpen)
            {
                this._rechargePanel.updateInfo();
            }
            return;
        }// end function

        public function openRechargeDays() : void
        {
            if (this._rechargePanel == null)
            {
                this._rechargePanel = new RechargeDaysBox();
                Global.popManager.addPop(this._rechargePanel);
            }
            this._rechargePanel.open();
            return;
        }// end function

        public static function getInstance() : RechargetDaysControl
        {
            var _loc_1:* = new RechargetDaysControl;
            _inst = new RechargetDaysControl;
            return _inst || _loc_1;
        }// end function

    }
}
