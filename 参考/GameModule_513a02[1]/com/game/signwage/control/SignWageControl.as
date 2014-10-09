package com.game.signwage.control
{
    import __AS3__.vec.*;
    import com.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.game.activitiesoverview.control.*;
    import com.game.map.control.*;
    import com.game.map.view.topbtnspanel.*;
    import com.game.signwage.bean.*;
    import com.game.signwage.event.*;
    import com.game.signwage.model.*;
    import com.game.signwage.protocol.*;
    import com.game.signwage.view.*;
    import com.model.*;

    public class SignWageControl extends BaseEventDispatcher
    {
        private var _protocol:SignUpProtocol;
        private var _signNum:int;
        private var _signWageBox:SignWageBox;
        public var signInfo:SignInfo;
        public var signNum:int;
        public var rewardsType:Vector.<int>;
        public var cmData:CurrentMonthData;
        public var selected:int;
        private static var _instance:SignWageControl;

        public function SignWageControl()
        {
            this.rewardsType = QSignWageCfgObj.getInstance().getType();
            this._protocol = new SignUpProtocol();
            addEvtListener(SignEvent.NUM_CHANGE, this.__updateAcitityIconNum);
            return;
        }// end function

        public function hasCanSign() : int
        {
            var _loc_3:* = 0;
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            while (_loc_2 < this.rewardsType.length)
            {
                
                if (this.rewardsType[_loc_2] <= this.signNum)
                {
                    if (this.signInfo == null || this.signInfo.award == null)
                    {
                        break;
                    }
                    _loc_3 = this.signInfo.award.indexOf(this.rewardsType[_loc_2]);
                    if (_loc_3 == -1)
                    {
                        _loc_1++;
                    }
                }
                _loc_2++;
            }
            if (this.cmData)
            {
                if (!this.cmData.isSigned(this.cmData.date))
                {
                    _loc_1++;
                }
            }
            return _loc_1;
        }// end function

        private function initSignWageBox() : SignWageBox
        {
            if (!this._signWageBox)
            {
                this._signWageBox = new SignWageBox();
                Global.popManager.addPop(this._signWageBox);
            }
            return this._signWageBox;
        }// end function

        private function __updateAcitityIconNum(event:SignEvent) : void
        {
            var _loc_2:* = this.hasCanSign() + ActivitiesOverviewControl.getInstance().hasBoxCanGain();
            if (_loc_2 > 0)
            {
                MapControl.getInstance().showNormalEffect(TopActivateName.TOP_ICON_REWARDS_THOLD, true);
            }
            else
            {
                MapControl.getInstance().showNormalEffect(TopActivateName.TOP_ICON_REWARDS_THOLD, false);
            }
            MapControl.getInstance().topActivateSetCountText(TopActivateName.TOP_ICON_REWARDS_THOLD, _loc_2.toString());
            return;
        }// end function

        public function setSignNumtoClient(param1:uint) : void
        {
            this.signNum = param1;
            if (!this._signWageBox)
            {
                return;
            }
            this._signWageBox.setSignNum();
            return;
        }// end function

        public function setSignInfo(param1:SignInfo) : void
        {
            this.signInfo = param1;
            this.cmData = new CurrentMonthData(param1.year, param1.month, param1.day);
            this.cmData.initData(param1.daylist, param1.freshDate);
            if (!this._signWageBox)
            {
                return;
            }
            this._signWageBox.setSignupViewInfo();
            dispatchEvt(new SignEvent(SignEvent.NUM_CHANGE));
            return;
        }// end function

        public function setReceiveBtnDisable(param1:int) : void
        {
            this.signInfo.award.push(param1);
            dispatchEvt(new SignEvent(SignEvent.NUM_CHANGE));
            if (this._signWageBox)
            {
                this._signWageBox.getRewardSuccess(param1);
            }
            return;
        }// end function

        public function setOffineExpTab() : void
        {
            if (this._signWageBox && this._signWageBox.isOpen && this._signWageBox.UILoaded)
            {
                this._signWageBox.setOffineExp();
            }
            return;
        }// end function

        public function reqClickSignToClient() : void
        {
            this._protocol.reqClickSignToClient();
            return;
        }// end function

        public function reqSignToClient() : void
        {
            this._protocol.reqSignToClient();
            return;
        }// end function

        public function reqReceiveAwardsToClient(param1:int) : void
        {
            this._protocol.reqReceiveAwardsToClient(param1);
            return;
        }// end function

        public function reqFillSign(param1:uint) : void
        {
            this._protocol.reqFillSign(param1);
            return;
        }// end function

        public function openOrcloseSignWageBox(param1:int = 0) : void
        {
            this.selected = param1;
            this.initSignWageBox().openOrClose();
            return;
        }// end function

        public function getCanRewardtype() : int
        {
            var _loc_2:* = 0;
            var _loc_1:* = 0;
            while (_loc_1 < this.rewardsType.length)
            {
                
                if (this.rewardsType[_loc_1] <= this.signNum)
                {
                    _loc_2 = this.signInfo.award.indexOf(this.rewardsType[_loc_1]);
                    if (_loc_2 == -1)
                    {
                        return _loc_1;
                    }
                }
                else
                {
                    return _loc_1;
                }
                _loc_1++;
            }
            return (this.rewardsType.length - 1);
        }// end function

        public function isCanReward(param1:int) : Boolean
        {
            var _loc_2:* = this.signInfo.award.indexOf(param1);
            if (_loc_2 == -1 && param1 <= this.signNum)
            {
                return true;
            }
            return false;
        }// end function

        public function isSignWagePanelOpen() : Boolean
        {
            return this._signWageBox && this._signWageBox.isOpen;
        }// end function

        public function fillSignSuccessdMessage(param1:int) : void
        {
            this._signWageBox.fillSignSuccessd(param1);
            return;
        }// end function

        public function isBeforeCreateTime(param1:int) : Boolean
        {
            var _loc_2:* = new Date(this.signInfo.year, (this.signInfo.month - 1), (param1 + 1)).time;
            var _loc_3:* = UserObj.getInstance().playerInfo.createTime.toNumber();
            var _loc_4:* = new Date(_loc_3);
            if (_loc_3 > _loc_2)
            {
                return true;
            }
            return false;
        }// end function

        public static function getInstance() : SignWageControl
        {
            if (!_instance)
            {
                _instance = new SignWageControl;
            }
            return _instance;
        }// end function

    }
}
