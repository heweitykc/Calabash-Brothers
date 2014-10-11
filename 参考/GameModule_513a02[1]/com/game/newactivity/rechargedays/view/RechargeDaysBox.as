package com.game.newactivity.rechargedays.view
{
    import com.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.newactivity.consts.*;
    import com.game.newactivity.rechargedays.control.*;
    import com.game.newactivity.rechargedays.model.*;
    import com.staticdata.*;
    import com.view.icon.*;
    import com.view.tipcell.*;
    import com.view.ui.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class RechargeDaysBox extends BaseBox
    {
        private var activeid:int = 30;
        private var _groupGetBtn:BaseButton;
        private var _tab:TabContainer;
        private var _lowBtn:BaseButton;
        private var _mediumBtn:BaseButton;
        private var _highBtn:BaseButton;
        private var _awardbtn:BaseButton;
        private var _groupAwardBtn:BaseButton;
        private var _model:RechargeDaysModel;
        private var _groupAward:IconItem;
        private var _awards:Array;
        private const MAX_ICON:int = 5;
        private var _groupNumTxt:TextField;
        private var _info:RechargeDaysInfo;
        private var _chargeBtn:BaseButton;
        private var _closeBtn:BaseButton;
        private var _pics:Array;
        private var _diamond:MovieClip;
        private var _groupBg:Sprite;
        private var _getIcon:Sprite;
        private var lang_ver:String = "lang_rechargedays";
        private var _numCounts:Array;

        public function RechargeDaysBox()
        {
            this._awards = [];
            this._pics = [];
            this._numCounts = [];
            this._model = RechargeDaysModel.inst;
            loadDisplay("res/rechargedays.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            super.initBaseBoxUI("rechargedaypanel");
            _dragBarH = 200;
            this.initUI();
            this.addlisteners();
            this.decideGear();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_3:* = null;
            this._highBtn = new BaseButton(getDisplayChildByName("btn_high"));
            this._mediumBtn = new BaseButton(getDisplayChildByName("btn_medium"));
            this._lowBtn = new BaseButton(getDisplayChildByName("btn_low"));
            this._tab = new TabContainer();
            this._tab.add(this._lowBtn);
            this._tab.add(this._mediumBtn);
            this._tab.add(this._highBtn);
            this._closeBtn = new BaseButton(getDisplayChildByName("close"));
            this._awardbtn = new BaseButton(getDisplayChildByName("btn_award"));
            this._groupAwardBtn = new BaseButton(getDisplayChildByName("btn_groupAward"));
            this._groupNumTxt = getDisplayChildByName("txt_groupNum");
            this._groupNumTxt.mouseEnabled = false;
            this._chargeBtn = new BaseButton(getDisplayChildByName("btn_charge"));
            this._groupAward = new IconItem(getDisplayChildByName("groupaward_item"));
            this._groupBg = getDisplayChildByName("group_bg");
            this._groupAward.setImageXY(18, 18);
            this._groupAward.setImageSize(56, 56);
            this._groupAward.setWH(94, 92);
            this._groupAward.setCountTxtXY(94 - 24, 92 - 35);
            addChild(this._groupAward);
            var _loc_1:* = 0;
            while (_loc_1 < this.MAX_ICON)
            {
                
                _loc_3 = new IconItem(getDisplayChildByName("award_" + _loc_1));
                _loc_3.setImageXY(8, 10);
                _loc_3.setWH(58, 58);
                _loc_3.setCountTxtXY(58 - 12, 58 - 24);
                this._awards.push(_loc_3);
                addChild(_loc_3);
                _loc_1++;
            }
            this._getIcon = getDisplayChildByName("get_icon");
            addChild(this._getIcon);
            this._groupGetBtn = new BaseButton(getDisplayChildByName("btn_groupGet"));
            this._diamond = getDisplayChildByName("diamond") as MovieClip;
            var _loc_2:* = new Object();
            _loc_2.title = LanguageCfgObj.getInstance().getByIndex("10005", this.lang_ver);
            _loc_2.content1 = LanguageCfgObj.getInstance().getByIndex("10006", this.lang_ver);
            _loc_2.content2 = LanguageCfgObj.getInstance().getByIndex("10007", this.lang_ver);
            _loc_2.content3 = LanguageCfgObj.getInstance().getByIndex("10008", this.lang_ver);
            _loc_2.content4 = LanguageCfgObj.getInstance().getByIndex("10009", this.lang_ver);
            ItemTips.create(this._groupBg, _loc_2, RechargeDaysTips);
            return;
        }// end function

        private function decideGear() : void
        {
            var _loc_3:* = null;
            var _loc_1:* = 0;
            var _loc_2:* = RechargeDaysModel.inst.keys.length - 1;
            while (_loc_2 > -1)
            {
                
                _loc_3 = this._model.getdayInfo(RechargeDaysModel.inst.keys[_loc_2]);
                if (_loc_3.canGet == NewActivityConsts.ABLE || _loc_3.canGetGroup == NewActivityConsts.ABLE)
                {
                    _loc_1 = _loc_2;
                }
                _loc_2 = _loc_2 - 1;
            }
            this._tab.selected = _loc_1;
            this._info = this._model.getdayInfo(RechargeDaysModel.inst.keys[_loc_1]);
            this.updateGear(RechargeDaysModel.inst.keys[_loc_1]);
            return;
        }// end function

        private function addlisteners() : void
        {
            this._tab.addEvtListener(Event.CHANGE, this.__tabChange);
            this._awardbtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._groupAwardBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._groupGetBtn.addEventListener(MouseEvent.CLICK, this.__btnClick);
            this._chargeBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._closeBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            return;
        }// end function

        private function __tabChange(event:Event) : void
        {
            this.updateByIndex(this._tab.index);
            return;
        }// end function

        private function __btnClick(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._awardbtn:
                {
                    if (this._info.canGet == NewActivityConsts.ABLE)
                    {
                        RechargetDaysControl.getInstance().getAward(this._info);
                    }
                    else if (this._info.canGet == NewActivityConsts.GETED)
                    {
                        Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10002", this.lang_ver));
                    }
                    break;
                }
                case this._groupAwardBtn:
                {
                    if (this._info.canGetGroup == NewActivityConsts.ABLE)
                    {
                        RechargetDaysControl.getInstance().getGroupAward(this._info);
                    }
                    else if (this._info.canGetGroup == NewActivityConsts.UN_ABLE)
                    {
                        if (this._info.curGroups >= this._info.needGroups)
                        {
                            Global.popManager.addedToMouseCue(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("10003", this.lang_ver), [int(this._info.key)]));
                        }
                        else
                        {
                            Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("100010", this.lang_ver));
                        }
                    }
                    else if (this._info.canGetGroup == NewActivityConsts.GETED)
                    {
                        Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10004", this.lang_ver));
                    }
                    break;
                }
                case this._chargeBtn:
                {
                    JSTools.openWindow(Params.officialRechargeWebSite);
                    break;
                }
                case this._closeBtn:
                {
                    close();
                    break;
                }
                case this._groupGetBtn:
                {
                    if (this._info.canGetGroup == NewActivityConsts.GETED)
                    {
                        Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10004", this.lang_ver));
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function judgeConditionInPage(param1:String) : Boolean
        {
            return param1 == this._info.key;
        }// end function

        public function updateGroupAwardOnCondition(param1:String) : void
        {
            var _loc_2:* = null;
            if (this._info)
            {
                if (this.judgeConditionInPage(param1))
                {
                    _loc_2 = this._model.getdayInfo(param1);
                    this.updateGroupAward(_loc_2);
                }
            }
            return;
        }// end function

        private function updateByIndex(param1:int) : void
        {
            var _loc_2:* = null;
            _loc_2 = RechargeDaysModel.inst.keys[param1];
            this.updateGear(_loc_2);
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            if (UILoaded)
            {
                this.decideGear();
            }
            return;
        }// end function

        private function updateGroupAward(param1:RechargeDaysInfo) : void
        {
            var _loc_2:* = param1.curGroups > this._info.needGroups ? (this._info.needGroups + "↑") : (param1.curGroups.toString());
            this._groupNumTxt.htmlText = _loc_2 + "/" + param1.needGroups + LanguageCfgObj.getInstance().getByIndex("10001", this.lang_ver);
            this._getIcon.visible = false;
            switch(param1.canGetGroup)
            {
                case NewActivityConsts.ABLE:
                {
                    this._groupGetBtn.visible = false;
                    this._groupAwardBtn.visible = true;
                    this._groupAwardBtn.filters = [];
                    break;
                }
                case NewActivityConsts.UN_ABLE:
                {
                    this._groupAwardBtn.visible = true;
                    this._groupAwardBtn.filters = [FrameworkGlobal.colorMat];
                    this._groupGetBtn.visible = false;
                    break;
                }
                case NewActivityConsts.GETED:
                {
                    this._groupGetBtn.visible = true;
                    this._getIcon.visible = true;
                    this._groupAwardBtn.visible = true;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function updateAwards(param1:RechargeDaysInfo) : void
        {
            var _loc_3:* = 0;
            var _loc_2:* = 0;
            while (_loc_2 < param1.props.length)
            {
                
                (this._awards[_loc_2] as IconItem).visible = true;
                (this._awards[_loc_2] as IconItem).setInfo(param1.props[_loc_2]);
                _loc_2++;
            }
            while (_loc_2 < this.MAX_ICON)
            {
                
                (this._awards[_loc_2] as IconItem).visible = false;
                _loc_2++;
            }
            switch(param1.canGet)
            {
                case NewActivityConsts.ABLE:
                {
                    this._chargeBtn.visible = false;
                    this._awardbtn.visible = true;
                    this._awardbtn.filters = [];
                    break;
                }
                case NewActivityConsts.UN_ABLE:
                {
                    this._awardbtn.visible = false;
                    this._chargeBtn.visible = true;
                    break;
                }
                case NewActivityConsts.GETED:
                {
                    this._chargeBtn.visible = false;
                    this._awardbtn.visible = true;
                    this._awardbtn.filters = [FrameworkGlobal.colorMat];
                    break;
                }
                default:
                {
                    break;
                }
            }
            _loc_2 = 0;
            while (_loc_2 < this._numCounts.length)
            {
                
                _loc_3 = 0;
                if (this._model.getdayInfo(RechargeDaysModel.inst.keys[_loc_2]).canGet == NewActivityConsts.ABLE)
                {
                    _loc_3++;
                }
                if (this._model.getdayInfo(RechargeDaysModel.inst.keys[_loc_2]).canGetGroup == NewActivityConsts.ABLE)
                {
                    _loc_3++;
                }
                if (_loc_3 > 0)
                {
                    this._numCounts[_loc_2].visible = true;
                    (this._numCounts[_loc_2] as MovieClip).gotoAndStop(_loc_3);
                }
                else
                {
                    this._numCounts[_loc_2].visible = false;
                }
                _loc_2++;
            }
            return;
        }// end function

        public function updateInfo() : void
        {
            this.updateAwards(this._info);
            this._diamond.gotoAndStop((this._tab.index + 1));
            this._groupAward.setInfo(this._info.groupProp);
            this.updateGroupAward(this._info);
            return;
        }// end function

        private function updateGear(param1:String = "10") : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_2:* = this._model.getdayInfo(param1);
            if (_loc_2)
            {
                this._info = _loc_2;
                this.updateInfo();
            }
            if (this._numCounts.length == 0 && RechargeDaysModel.inst.keys.length != 0)
            {
                _loc_3 = 0;
                while (_loc_3 < RechargeDaysModel.inst.keys.length)
                {
                    
                    _loc_4 = getDisplayChildByName("num_" + (_loc_3 + 1));
                    _loc_4.mouseEnabled = false;
                    _loc_4.mouseChildren = false;
                    this._numCounts.push(_loc_4);
                    addChild(this._numCounts[_loc_3]);
                    _loc_3++;
                }
            }
            return;
        }// end function

    }
}
