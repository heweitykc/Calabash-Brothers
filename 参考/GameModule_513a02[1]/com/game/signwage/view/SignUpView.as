package com.game.signwage.view
{
    import __AS3__.vec.*;
    import com.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.game.activitiesoverview.view.*;
    import com.game.clickstream.*;
    import com.game.guide.*;
    import com.game.guide.control.*;
    import com.game.guide.model.*;
    import com.game.map.control.*;
    import com.game.prompt.utils.*;
    import com.game.signwage.bean.*;
    import com.game.signwage.control.*;
    import com.game.signwage.event.*;
    import com.game.signwage.model.*;
    import com.game.vip.consts.*;
    import com.game.vip.control.*;
    import com.game.vip.model.*;
    import com.model.*;
    import com.view.ui.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class SignUpView extends Component implements IGuide
    {
        private var getAwardsBtn:BaseButton;
        public var signUpBtn:BaseButton;
        private var vipBtn:BaseButton;
        private var tab1Btn:BaseButton;
        private var tab2Btn:BaseButton;
        private var tab3Btn:BaseButton;
        private var tab4Btn:BaseButton;
        private var tab5Btn:BaseButton;
        private var tabConainer:TabContainer;
        private var tab6Btn:BaseButton;
        private var rewardsConainter:HBox;
        private var vipRewarsContainter:HBox;
        private var activitiesOverview:ActivitiesOverview;
        private var _rewardType:uint;
        private var _fillBtn:Dictionary;
        private var todayBtn:Object;
        private var activitedLable:Object;
        private var _signWageControl:SignWageControl;
        private var _dateBtnArr:Array;

        public function SignUpView()
        {
            this._dateBtnArr = [];
            x = 10;
            y = 80;
            this._signWageControl = SignWageControl.getInstance();
            initComponentUI("signupview");
            this.initUI();
            this.addListener();
            return;
        }// end function

        public function fillSignSuccessed(param1:int) : void
        {
            this.fillSign(param1);
            return;
        }// end function

        public function initSignUpView() : void
        {
            var _loc_1:* = null;
            if (UILoaded)
            {
                _loc_1 = this._signWageControl.signInfo;
                this.initCalarderView();
                this.setMonthAndNum(_loc_1.month, _loc_1.daylist.length);
                this.tabConainer.selected = this._signWageControl.getCanRewardtype();
            }
            return;
        }// end function

        private function setMonthAndNum(param1:uint, param2:uint) : void
        {
            (getDisplayChildByName("monthMc") as MovieClip).gotoAndStop(param1);
            this.updateNum();
            return;
        }// end function

        public function updateNum() : void
        {
            var _loc_1:* = this._signWageControl.signNum;
            (getDisplayChildByName("num10Mc") as MovieClip).gotoAndStop((Math.floor(_loc_1 / 10) + 1));
            (getDisplayChildByName("num1Mc") as MovieClip).gotoAndStop(_loc_1 % 10 + 1);
            this.setGetAwardsBtnEnabled(this._signWageControl.isCanReward(this._rewardType));
            return;
        }// end function

        private function initCalarderView() : void
        {
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_10:* = undefined;
            var _loc_1:* = SignWageControl.getInstance().cmData;
            this.reset();
            var _loc_2:* = 238;
            var _loc_3:* = 70;
            var _loc_4:* = 80;
            var _loc_5:* = 27;
            var _loc_8:* = 0;
            while (_loc_8 < this._dateBtnArr.length)
            {
                
                ToolKit.disappear(this._dateBtnArr[_loc_8]);
                _loc_8 = _loc_8 + 1;
            }
            this._fillBtn = new Dictionary();
            var _loc_9:* = _loc_1.daysOfCurrentMonth;
            _loc_8 = 1;
            while (_loc_8 <= _loc_9)
            {
                
                _loc_6 = ToolKit.getNew("signup.dateItem");
                _loc_6.x = int(_loc_8 + _loc_1.firstDayIndex) % 7 * _loc_4 + _loc_2;
                _loc_6.y = Math.floor((_loc_8 + _loc_1.firstDayIndex) / 7) * _loc_5 + _loc_3;
                _loc_6.txt.text = _loc_8;
                addChild(_loc_6);
                this._dateBtnArr.push(_loc_6);
                this._fillBtn[_loc_8] = _loc_6;
                if (_loc_6.obj)
                {
                    _loc_6.removeChild(_loc_6.obj);
                }
                if (_loc_1.beginDate > _loc_8)
                {
                }
                else if (_loc_1.isSigned(_loc_8))
                {
                    _loc_6.obj = ToolKit.getNew("signup_signedIcon");
                    _loc_6.addChild(_loc_6.obj);
                    if (_loc_8 == _loc_1.date)
                    {
                        getDisplayChildByName("signedLabel").visible = true;
                        this.signUpBtn.enabled = false;
                    }
                    else
                    {
                        getDisplayChildByName("signedLabel").visible = false;
                        this.signUpBtn.enabled = true;
                    }
                }
                else if (_loc_8 < _loc_1.date && !this._signWageControl.isBeforeCreateTime(_loc_8))
                {
                    _loc_6.obj = new BaseButton(ToolKit.getNew("signup.fillSignBtn"));
                    if (UserObj.getInstance().playerInfo.vipid > 0)
                    {
                        StringTip.create(_loc_6.obj, LanguageCfgObj.getInstance().getByIndex("11158"));
                    }
                    else
                    {
                        StringTip.create(_loc_6.obj, LanguageCfgObj.getInstance().getByIndex("11159"));
                    }
                    (_loc_6.obj as BaseButton).addEvtListener(MouseEvent.CLICK, this.__fillBtnClick);
                    _loc_6.addChild(_loc_6.obj);
                }
                else if (_loc_8 == _loc_1.date)
                {
                    this.todayBtn = _loc_6;
                    _loc_10 = ToolKit.getNew("signup.todayIcon");
                    _loc_6.addChild(_loc_10);
                    getDisplayChildByName("signedLabel").visible = false;
                    this.signUpBtn.enabled = true;
                }
                _loc_8 = _loc_8 + 1;
            }
            return;
        }// end function

        public function reset() : void
        {
            var _loc_1:* = undefined;
            for each (_loc_1 in this._fillBtn)
            {
                
                if (_loc_1 && _loc_1.parent)
                {
                    _loc_1.parent.removeChild(_loc_1);
                }
            }
            return;
        }// end function

        private function __fillBtnClick(event:Event) : void
        {
            var _loc_2:* = event.target.parent.txt;
            if (_loc_2)
            {
                if (UserObj.getInstance().playerInfo.vipid <= 0 || VipModel.getInstance().info.stageLevel <= VipConst.EXPERIENCE_LEVEL)
                {
                    Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("12196"), LanguageCfgObj.getInstance().getByIndex("11635"), null, null, null, 1);
                }
                else if (UserObj.getInstance().chechGoldEnough(10))
                {
                    this._signWageControl.reqFillSign(_loc_2.text);
                }
                else
                {
                    MapControl.getInstance().showRechargeD(LanguageCfgObj.getInstance().getByIndex("11160"));
                }
            }
            return;
        }// end function

        private function fillSign(param1:int) : void
        {
            var _loc_2:* = this._fillBtn[param1];
            if (!_loc_2)
            {
                return;
            }
            this._fillBtn[param1] = null;
            if (_loc_2.obj.parent)
            {
                _loc_2.obj.parent.removeChild(_loc_2.obj);
                _loc_2.obj = ToolKit.getNew("signup_signedIcon");
                _loc_2.addChild(_loc_2.obj);
                var _loc_3:* = this._signWageControl;
                var _loc_4:* = _loc_3.signNum + 1;
                _loc_3.signNum = _loc_4;
                SignWageControl.getInstance().dispatchEvt(new SignEvent(SignEvent.NUM_CHANGE));
            }
            this.updateNum();
            return;
        }// end function

        private function initUI() : void
        {
            this.getAwardsBtn = new BaseButton(getDisplayChildByName("getAwardsBtn"));
            this.signUpBtn = new BaseButton(getDisplayChildByName("signUpBtn"));
            this.vipBtn = new BaseButton(getDisplayChildByName("vipBtn"));
            this.tab1Btn = new BaseButton(getDisplayChildByName("tab1Btn"), true);
            this.tab2Btn = new BaseButton(getDisplayChildByName("tab2Btn"), true);
            this.tab3Btn = new BaseButton(getDisplayChildByName("tab3Btn"), true);
            this.tab4Btn = new BaseButton(getDisplayChildByName("tab4Btn"), true);
            this.tab5Btn = new BaseButton(getDisplayChildByName("tab5Btn"), true);
            var _loc_1:* = SignWageControl.getInstance().rewardsType;
            this.tab1Btn.setText(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12197"), [_loc_1[0]]));
            this.tab2Btn.setText(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12197"), [_loc_1[1]]));
            this.tab3Btn.setText(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12197"), [_loc_1[2]]));
            this.tab4Btn.setText(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12197"), [_loc_1[3]]));
            this.tab5Btn.setText(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12197"), [_loc_1[4]]));
            this.tabConainer = new TabContainer();
            this.tabConainer.add(this.tab1Btn);
            this.tabConainer.add(this.tab2Btn);
            this.tabConainer.add(this.tab3Btn);
            this.tabConainer.add(this.tab4Btn);
            this.tabConainer.add(this.tab5Btn);
            this.activitedLable = getDisplayChildByName("activitedLable");
            this.rewardsConainter = new HBox();
            this.rewardsConainter.x = 250;
            this.rewardsConainter.y = 277;
            this.rewardsConainter.oneRow = 9;
            this.rewardsConainter.intervalX = 1;
            addChild(this.rewardsConainter);
            this.vipRewarsContainter = new HBox();
            this.vipRewarsContainter.x = 250;
            this.vipRewarsContainter.y = 382;
            this.vipRewarsContainter.oneRow = 9;
            this.vipRewarsContainter.intervalX = 1;
            addChild(this.vipRewarsContainter);
            this.activitiesOverview = new ActivitiesOverview();
            this.addChild(this.activitiesOverview);
            this.registerGuide();
            return;
        }// end function

        private function showReward(param1:uint) : void
        {
            this.rewardsConainter.reset();
            this.vipRewarsContainter.reset();
            var _loc_2:* = QSignWageCfgObj.getInstance().getRewards(param1);
            var _loc_3:* = _loc_2.length;
            var _loc_4:* = [];
            var _loc_5:* = QSignWageCfgObj.getInstance().getProfessionRewards(param1, UserObj.getInstance().playerInfo.jobkind);
            _loc_3 = _loc_5.length;
            var _loc_6:* = 0;
            while (_loc_6 < _loc_3)
            {
                
                this.rewardsConainter.add(new RewardItem(_loc_5[_loc_6]));
                _loc_6++;
            }
            _loc_2 = QSignWageCfgObj.getInstance().getVipRewards(param1);
            _loc_3 = _loc_2.length;
            _loc_6 = 0;
            while (_loc_6 < _loc_3)
            {
                
                this.vipRewarsContainter.add(new RewardItem(_loc_2[_loc_6]));
                _loc_6++;
            }
            this.rewardType = param1;
            return;
        }// end function

        private function addListener() : void
        {
            this.addEvtListener(MouseEvent.CLICK, this.mouseClickHandler);
            addEvtListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            this.tabConainer.addEvtListener(Event.CHANGE, this.__changeTab);
            return;
        }// end function

        private function __changeTab(event:Event) : void
        {
            var _loc_2:* = this._signWageControl.rewardsType[event.target.index];
            this.showReward(_loc_2);
            return;
        }// end function

        private function onAddedToStage(event:Event) : void
        {
            this._signWageControl.reqSignToClient();
            this.activitedLable.visible = UserObj.getInstance().playerInfo.vipid <= 0;
            this.vipBtn.enabled = UserObj.getInstance().playerInfo.vipid <= 0 || VipModel.getInstance().info.stageLevel <= VipConst.EXPERIENCE_LEVEL;
            return;
        }// end function

        private function mouseClickHandler(event:MouseEvent) : void
        {
            var _loc_2:* = undefined;
            switch(event.target)
            {
                case this.getAwardsBtn:
                {
                    this._signWageControl.reqReceiveAwardsToClient(this.rewardType);
                    break;
                }
                case this.signUpBtn:
                {
                    this.signUpBtn.enabled = false;
                    ClickStream.add(ClickStreamId.CLICK_QianDao);
                    this._signWageControl.reqClickSignToClient();
                    _loc_2 = ToolKit.getNew("signup_signedIcon");
                    this.todayBtn.addChild(_loc_2);
                    getDisplayChildByName("signedLabel").visible = true;
                    var _loc_3:* = this._signWageControl;
                    var _loc_4:* = _loc_3.signNum + 1;
                    _loc_3.signNum = _loc_4;
                    this.updateNum();
                    this.rewardType = this.rewardType;
                    SignWageControl.getInstance().dispatchEvt(new SignEvent(SignEvent.NUM_CHANGE));
                    break;
                }
                case this.vipBtn:
                {
                    VIPControl.getInstance().openOrCloseVip();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function set rewardType(param1:uint) : void
        {
            var _loc_2:* = 0;
            this._rewardType = param1;
            if (this._rewardType > this._signWageControl.signNum)
            {
                this.setGetAwardsBtnEnabled(false);
            }
            else
            {
                for each (_loc_2 in this._signWageControl.signInfo.award)
                {
                    
                    if (_loc_2 == this._rewardType)
                    {
                        this.setGetAwardsBtnEnabled(false);
                        return;
                    }
                }
                this.setGetAwardsBtnEnabled(true);
            }
            return;
        }// end function

        public function getRewardSuccess(param1:int) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_2:* = [];
            var _loc_3:* = QSignWageCfgObj.getInstance().getProfessionRewards(param1, UserObj.getInstance().playerInfo.jobkind);
            for each (_loc_4 in _loc_3)
            {
                
                _loc_2.push(_loc_4.split(":")[0]);
            }
            _loc_5 = 0;
            while (_loc_5 < _loc_2.length)
            {
                
                ItemGetAnim.doFlyToBackPack(_loc_2[_loc_5], this.rewardsConainter.getContent(_loc_5).localToGlobal(new Point(0, 0)));
                _loc_5++;
            }
            if (UserObj.getInstance().playerInfo.vipid >= 1 && VipModel.getInstance().info.stageLevel > VipConst.EXPERIENCE_LEVEL)
            {
                _loc_3 = QSignWageCfgObj.getInstance().getVipRewards(param1);
                _loc_2 = [];
                for each (_loc_4 in _loc_3)
                {
                    
                    _loc_2.push(_loc_4.split(":")[0]);
                }
                _loc_5 = 0;
                while (_loc_5 < _loc_2.length)
                {
                    
                    ItemGetAnim.doFlyToBackPack(_loc_2[_loc_5], this.vipRewarsContainter.getContent(_loc_5).localToGlobal(new Point(0, 0)));
                    _loc_5++;
                }
            }
            if (this.rewardType == param1)
            {
                this.setGetAwardsBtnEnabled(false);
            }
            this.tabConainer.selected = this._signWageControl.getCanRewardtype();
            return;
        }// end function

        private function get rewardType() : uint
        {
            return this._rewardType;
        }// end function

        private function setGetAwardsBtnEnabled(param1:Boolean) : void
        {
            if (this.getAwardsBtn)
            {
                this.getAwardsBtn.enabled = param1;
            }
            return;
        }// end function

        public function close() : void
        {
            GuideMultiControl.getInstance().hideGuide(GuideConfigObj.getInstance().SIGN_WAGE_AWARD_SY_GUIDE_ID_1);
            return;
        }// end function

        public function registerGuide() : void
        {
            GuideMultiControl.getInstance().registerGuide(this.getAwardsBtn, this, GuideConfigObj.getInstance().SIGN_WAGE_AWARD_SY_GUIDE_ID_1);
            return;
        }// end function

        public function guideAction(param1:String) : void
        {
            return;
        }// end function

        public function guidePause(param1:String) : void
        {
            return;
        }// end function

        public function guideEnd(param1:String) : void
        {
            return;
        }// end function

        public function isGuideReady() : Boolean
        {
            return true;
        }// end function

    }
}
