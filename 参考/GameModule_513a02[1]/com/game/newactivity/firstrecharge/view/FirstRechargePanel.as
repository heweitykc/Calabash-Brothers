package com.game.newactivity.firstrecharge.view
{
    import com.events.*;
    import com.f1.manager.resource.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.clickstream.*;
    import com.game.map.control.*;
    import com.game.newactivity.control.*;
    import com.game.newactivity.model.*;
    import com.greensock.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.view.icon.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.events.*;

    public class FirstRechargePanel extends BaseBox
    {
        private var _awardBtn:BaseButton;
        private var _awardView:MovieClip;
        private var _rechargeBtn:BaseButton;
        private var _closeBtn:BaseButton;
        private var _awardArr:Array;
        private var _wea1:MovieClip;
        private var _wea2:MovieClip;
        private var _wea3:MovieClip;
        private var _curWea:MovieClip;
        private var _info:NewActivityInfo;
        private const POINT_ARR_1:Array;
        private const POINT_ARR_2:Array;
        private const POINT_ARR_3:Array;
        private const POINT_ARR:Array;
        private var pointIndex:int;

        public function FirstRechargePanel()
        {
            this.POINT_ARR_1 = [[233 + 35, 171 + 60], [372 + 35, 87 + 95], [609 + 34, 171 + 65]];
            this.POINT_ARR_2 = [[242 + 25, 181 + 48], [368 + 35, 105 + 75], [598 + 35, 181 + 30]];
            this.POINT_ARR_3 = [[255 + 35, 184 + 40], [383 + 31, 99 + 78], [615 + 35, 184 + 45]];
            this.POINT_ARR = [-10, 10];
            super(null, 100);
            setWH(714, 550);
            this._info = NewActivityModel.getInstance().getActivityByActivityId(NewActivityConfig.ACTID_FIRST_RECHARGE);
            if (this._info && !this._info.isDetailInit)
            {
                NewActivityControl.getInstance().getActivityInfo(this._info.activityId);
            }
            this._info.addEventListener(NewActivityEvent.ACTIVITY_DETAIL_UPDATE, this.updateByActivityInfo);
            loadDisplay("res/firstrecharge.swf");
            VResManager.load("res/firstrechargeeffect1.swf", this._loadEffect1Complete);
            VResManager.load("res/firstrechargeeffect2.swf", this._loadEffect2Complete);
            VResManager.load("res/firstrechargeeffect3.swf", this._loadEffect3Complete);
            return;
        }// end function

        private function _loadEffect1Complete(param1 = null) : void
        {
            this._wea1 = ToolKit.getNew("firstrecharge_wea_1") as MovieClip;
            this.updateByActivityInfo();
            return;
        }// end function

        private function _loadEffect2Complete(param1 = null) : void
        {
            this._wea2 = ToolKit.getNew("firstrecharge_wea_2") as MovieClip;
            this.updateByActivityInfo();
            return;
        }// end function

        private function _loadEffect3Complete(param1 = null) : void
        {
            this._wea3 = ToolKit.getNew("firstrecharge_wea_3") as MovieClip;
            this.updateByActivityInfo();
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            if (this._curWea)
            {
                this.setCurWeaAuto(true);
            }
            return;
        }// end function

        private function setCurWeaAuto(param1:Boolean) : void
        {
            if (this._curWea)
            {
                if (param1)
                {
                    this._curWea.play();
                    this.tweenEffect();
                }
                else
                {
                    this._curWea.stop();
                    TweenLite.killTweensOf(this._curWea, true);
                }
            }
            return;
        }// end function

        private function tweenEffect() : void
        {
            if (this._curWea)
            {
                TweenLite.to(this._curWea, 1.5, {y:this._curWea.y + this.POINT_ARR[this.pointIndex], onComplete:this.moveComplete});
                var _loc_1:* = this;
                var _loc_2:* = this.pointIndex + 1;
                _loc_1.pointIndex = _loc_2;
                if (this.pointIndex >= this.POINT_ARR.length)
                {
                    this.pointIndex = 0;
                }
            }
            return;
        }// end function

        private function moveComplete() : void
        {
            if (this._curWea.isPlaying)
            {
                this.tweenEffect();
            }
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            if (this._curWea)
            {
                this.setCurWeaAuto(false);
            }
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("firstRechargeView", 100);
            this.initUI();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this._awardBtn = new BaseButton(getDisplayChildByName("getAwardBtn"));
            this._rechargeBtn = new BaseButton(getDisplayChildByName("rechargeBtn"));
            this._closeBtn = new BaseButton(getDisplayChildByName("btn_close"));
            this._awardView = getDisplayChildByName("getAwardTxt") as MovieClip;
            var _loc_1:* = false;
            this._awardView.mouseEnabled = false;
            this._awardView.mouseChildren = _loc_1;
            this.addListener();
            this.updateByActivityInfo();
            return;
        }// end function

        private function addListener() : void
        {
            this._awardBtn.addEventListener(MouseEvent.CLICK, this._getAwardHandler);
            this._rechargeBtn.addEventListener(MouseEvent.CLICK, this._rechargeHandler);
            this._closeBtn.addEventListener(MouseEvent.CLICK, this._closeHandler);
            NewActivityModel.getInstance().addEventListener(NewActivityEvent.ACTIVITY_GROUP_REMOVE, this._actDelHandler);
            return;
        }// end function

        private function removeListener() : void
        {
            this._awardBtn.removeEventListener(MouseEvent.CLICK, this._getAwardHandler);
            this._rechargeBtn.removeEventListener(MouseEvent.CLICK, this._rechargeHandler);
            this._closeBtn.removeEventListener(MouseEvent.CLICK, this._closeHandler);
            NewActivityModel.getInstance().removeEventListener(NewActivityEvent.ACTIVITY_GROUP_REMOVE, this._actDelHandler);
            return;
        }// end function

        private function _actDelHandler(event:NewActivityEvent) : void
        {
            if (int(event.data) == NewActivityConfig.GROUP_FIRST_RECHARGE)
            {
                this.removeListener();
                this.close();
            }
            return;
        }// end function

        private function _getAwardHandler(event:MouseEvent) : void
        {
            NewActivityControl.getInstance().getActivityReward(this._info.activityId, this._info.activityItemLists[0].index);
            return;
        }// end function

        private function _rechargeHandler(event:MouseEvent) : void
        {
            MapControl.getInstance().showRecharge();
            ClickStream.add(ClickStreamId.CLICK_ShouCiChongZhi_ChongDianXiaoQian);
            return;
        }// end function

        private function _closeHandler(event:MouseEvent) : void
        {
            this.close();
            return;
        }// end function

        private function updateByActivityInfo(event:NewActivityEvent = null) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            if (UILoaded && this._info && this._info.isDetailInit && this._wea1 && this._wea2 && this._wea3)
            {
                if (this._info.activityItemLists[0].canGet == 1)
                {
                    this._awardBtn.visible = true;
                    this._awardView.visible = true;
                    this._rechargeBtn.visible = false;
                }
                else
                {
                    this._awardBtn.visible = false;
                    this._awardView.visible = false;
                    this._rechargeBtn.visible = true;
                }
                _loc_2 = UserObj.getInstance().playerInfo.job;
                _loc_2 = (_loc_2 - 1) % 3 + 1;
                if (this._wea1)
                {
                    ItemTips.create(this._wea1, this._info.activityItemLists[0].awardList[0], EquipTips);
                    this._wea1.stop();
                }
                if (this._wea2)
                {
                    ItemTips.create(this._wea2, this._info.activityItemLists[0].awardList[1], EquipTips);
                    this._wea2.stop();
                }
                if (this._wea3)
                {
                    ItemTips.create(this._wea3, this._info.activityItemLists[0].awardList[2], EquipTips);
                    this._wea3.stop();
                }
                if (_loc_2 == 1)
                {
                    if (this._wea1)
                    {
                        this._wea1.x = this.POINT_ARR_1[1][0] - 155;
                        this._wea1.y = this.POINT_ARR_1[1][1] - 34;
                        this._curWea = this._wea1;
                        this._wea1.play();
                        addChild(this._wea1);
                    }
                    if (this._wea2)
                    {
                        var _loc_8:* = 0.55;
                        this._wea2.scaleY = 0.55;
                        this._wea2.scaleX = _loc_8;
                        this._wea2.x = this.POINT_ARR_2[0][0] - 155;
                        this._wea2.y = this.POINT_ARR_2[0][1] - 34;
                        addChild(this._wea2);
                    }
                    if (this._wea3)
                    {
                        var _loc_8:* = 0.65;
                        this._wea3.scaleY = 0.65;
                        this._wea3.scaleX = _loc_8;
                        this._wea3.x = this.POINT_ARR_3[2][0] - 155;
                        this._wea3.y = this.POINT_ARR_3[2][1] - 34;
                        addChild(this._wea3);
                    }
                }
                else if (_loc_2 == 2)
                {
                    if (this._wea2)
                    {
                        this._wea2.x = this.POINT_ARR_2[1][0] - 155;
                        this._wea2.y = this.POINT_ARR_2[1][1] - 34;
                        this._curWea = this._wea2;
                        this._wea2.play();
                        addChild(this._wea2);
                    }
                    if (this._wea1)
                    {
                        var _loc_8:* = 0.55;
                        this._wea1.scaleY = 0.55;
                        this._wea1.scaleX = _loc_8;
                        this._wea1.x = this.POINT_ARR_1[0][0] - 155;
                        this._wea1.y = this.POINT_ARR_1[0][1] - 34;
                        addChild(this._wea1);
                    }
                    if (this._wea3)
                    {
                        var _loc_8:* = 0.65;
                        this._wea3.scaleY = 0.65;
                        this._wea3.scaleX = _loc_8;
                        this._wea3.x = this.POINT_ARR_3[2][0] - 155;
                        this._wea3.y = this.POINT_ARR_3[2][1] - 34;
                        addChild(this._wea3);
                    }
                }
                else
                {
                    if (this._wea3)
                    {
                        this._wea3.x = this.POINT_ARR_3[1][0] - 155;
                        this._wea3.y = this.POINT_ARR_3[1][1] - 34;
                        this._curWea = this._wea3;
                        this._wea3.play();
                        addChild(this._wea3);
                    }
                    if (this._wea2)
                    {
                        var _loc_8:* = 0.55;
                        this._wea2.scaleY = 0.55;
                        this._wea2.scaleX = _loc_8;
                        this._wea2.x = this.POINT_ARR_2[0][0] - 155;
                        this._wea2.y = this.POINT_ARR_2[0][1] - 34;
                        addChild(this._wea2);
                    }
                    if (this._wea1)
                    {
                        var _loc_8:* = 0.55;
                        this._wea1.scaleY = 0.55;
                        this._wea1.scaleX = _loc_8;
                        this._wea1.x = this.POINT_ARR_1[2][0] - 155;
                        this._wea1.y = this.POINT_ARR_1[2][1] - 34;
                        addChild(this._wea1);
                    }
                }
                if (!this._awardArr)
                {
                    this._awardArr = [];
                    _loc_5 = 0;
                    _loc_6 = this._info.activityItemLists[0].jobAwardList.length;
                    _loc_7 = 714 - 67 * (_loc_6 - 2) - 48 >> 1;
                    _loc_5 = 1;
                    while (_loc_5 < _loc_6)
                    {
                        
                        _loc_4 = this._info.activityItemLists[0].jobAwardList[_loc_5];
                        _loc_3 = new IconItem("commonRewardBox2_40");
                        _loc_3.setImageXY(4, 4);
                        _loc_3.setWH(48, 48);
                        _loc_3.setCountTxtXY(48 - 7, 48 - 18);
                        _loc_3.x = _loc_7 + (_loc_5 - 1) * 67;
                        _loc_3.y = 398;
                        _loc_3.setInfo(_loc_4);
                        addChild(_loc_3);
                        _loc_5++;
                    }
                }
                this._curWea.y = this._curWea.y - 5;
                this.setCurWeaAuto(true);
            }
            return;
        }// end function

    }
}
