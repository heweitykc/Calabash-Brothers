package com.game.newactivity.sevenactivity.view
{
    import com.*;
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.interfaces.ui.list.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.list.*;
    import com.f1.utils.*;
    import com.game.clickstream.*;
    import com.game.country.control.*;
    import com.game.gameStrategy.controll.*;
    import com.game.newactivity.control.*;
    import com.game.newactivity.model.*;
    import com.game.newactivity.singlerecharge.control.*;
    import com.game.primaryrole.control.*;
    import com.game.role.*;
    import com.game.utils.*;
    import com.game.vip.control.*;
    import com.game.zones.control.*;
    import com.greensock.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import com.view.icon.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;
    import interfaces.role.*;

    public class SevenActivityPanel extends BaseBox
    {
        private var actBtnArray:Array;
        private var closeBtn:BaseButton;
        private var helpBtn:BaseButton;
        private var _actTime:TextField;
        private var _restTime:TextField;
        private var txt1:TextField;
        private var txt2:TextField;
        private var _view1:MovieClip;
        private var _view2:MovieClip;
        private var _view3:MovieClip;
        private var _topView:MovieClip;
        private var _list1:List;
        private var _list2:List;
        private var _list3:List;
        private var _list4:List;
        private var _list5:List;
        private var _list6:List;
        private var _list7:List;
        private var _enable:Boolean = false;
        private const STRENG_TYPE:int = 8;
        private var _mc1:MovieClip;
        private var _mc2:MovieClip;
        private var _mc3:MovieClip;
        private var _mc4:MovieClip;
        private var _mc5:MovieClip;
        private var _mc6:MovieClip;
        private var _mc7:MovieClip;
        private var _mc8:MovieClip;
        private var _mc9:MovieClip;
        private var _mc10:MovieClip;
        private var mc_role:MovieClip;
        private var role:IRole;
        private var goodsID:Array;
        private var goodsID1:Array;
        private var goodsID2:Array;
        private var goodsID3:Array;
        private var goodsID4:Array;
        private var armorArray:Array;
        private var weaponArray:Array;
        private var wingArray:Array;
        private var _curEquipIndex:int = 0;
        private var btn_privilege:BaseButton;
        private var intensify:Array;
        private var _infoArr:Array;
        private var _curSelIndex:int;
        private const ACT_BTN_NAME:Array;
        private var ACTIVITY_MAP:Dictionary;

        public function SevenActivityPanel()
        {
            this.goodsID = [];
            this.goodsID1 = [2413005, 2414005, 2416005, 2417005, 2418005];
            this.goodsID2 = [2423003, 2424003, 2426003, 2427003, 2428003];
            this.goodsID3 = [2433004, 2434004, 2436004, 2437004, 2438004];
            this.goodsID4 = [2310036, 2320005, 2330011];
            this.armorArray = [2413005, 2423003, 2433004];
            this.weaponArray = [2310036, 2320005, 2330011];
            this.wingArray = [500011, 500010, 500009];
            this.intensify = [7, 9, 13, 15];
            this.ACT_BTN_NAME = ["act_1", "act_2", "act_3", "act_4", "act_5", "act_6", "act_7", "act_8"];
            this.ACTIVITY_MAP = new Dictionary();
            this.ACTIVITY_MAP[this.ACT_BTN_NAME[0]] = NewActivityConfig.ACTID_SEVEN_ACTIVITY_1;
            this.ACTIVITY_MAP[this.ACT_BTN_NAME[1]] = NewActivityConfig.ACTID_SEVEN_ACTIVITY_2;
            this.ACTIVITY_MAP[this.ACT_BTN_NAME[2]] = NewActivityConfig.ACTID_SEVEN_ACTIVITY_3;
            this.ACTIVITY_MAP[this.ACT_BTN_NAME[3]] = NewActivityConfig.ACTID_SEVEN_ACTIVITY_4;
            this.ACTIVITY_MAP[this.ACT_BTN_NAME[4]] = NewActivityConfig.ACTID_SEVEN_ACTIVITY_5;
            this.ACTIVITY_MAP[this.ACT_BTN_NAME[5]] = NewActivityConfig.ACTID_SEVEN_ACTIVITY_6;
            this.ACTIVITY_MAP[this.ACT_BTN_NAME[6]] = NewActivityConfig.ACTID_SEVEN_ACTIVITY_7;
            setWH(775, 550);
            _combinedBox = ["com.game.gameStrategy.view::GameStrategyBox", "com.game.country.view::CountryBox", "com.game.zones.view.dekaron::ZonesDekaronPanel", "com.game.newactivity.singlerecharge.view::SingleRechargePanel", "com.game.primaryrole.view::PrimaryRoleMainPanel", "com.game.vip.view::VIPPanel"];
            loadDisplay("res/sevenactivity.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("sevenActivityView");
            this.initUI();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_1:* = 0;
            var _loc_2:* = this.ACT_BTN_NAME.length;
            this.actBtnArray = [];
            this._infoArr = [];
            while (_loc_1 < _loc_2)
            {
                
                _loc_3 = new BaseButton(getDisplayChildByName(this.ACT_BTN_NAME[_loc_1]));
                _loc_3.name = this.ACT_BTN_NAME[_loc_1].split("_")[1];
                _loc_3.addEventListener(MouseEvent.CLICK, this.__actBtnClickHandler);
                this.actBtnArray.push(_loc_3);
                if (_loc_1 != (this.STRENG_TYPE - 1))
                {
                    _loc_4 = NewActivityModel.getInstance().getActivityByActivityId(this.ACTIVITY_MAP[this.ACT_BTN_NAME[_loc_1]]);
                    if (!_loc_4.isDetailInit)
                    {
                        NewActivityControl.getInstance().getActivityInfo(_loc_4.activityId);
                    }
                    _loc_4.addEventListener(NewActivityEvent.ACTIVITY_DETAIL_UPDATE, this.updateByActivityInfo);
                    this._infoArr.push(_loc_4);
                }
                _loc_1++;
            }
            this.closeBtn = new BaseButton(getDisplayChildByName("close_btn"));
            this.closeBtn.addEventListener(MouseEvent.CLICK, this.__closeClickHandler);
            this._actTime = getDisplayChildByName("actTime") as TextField;
            this._restTime = getDisplayChildByName("restTime") as TextField;
            this.txt1 = getDisplayChildByName("txt1") as TextField;
            this.txt2 = getDisplayChildByName("txt2") as TextField;
            this._view1 = getDisplayChildByName("view_1") as MovieClip;
            this._view2 = getDisplayChildByName("view_2") as MovieClip;
            this._view3 = getDisplayChildByName("view_3") as MovieClip;
            this._topView = getDisplayChildByName("topView") as MovieClip;
            this.helpBtn = new BaseButton(getDisplayChildByName("helpBtn"));
            this.helpBtn.addEventListener(MouseEvent.CLICK, this.__helpClickHandler);
            this._list1 = new List(522, 245, null, "scrollBar2");
            this._list1.move(0, 28);
            this._list1.cellRenderer = SevenActivityItemOne;
            this._view1.addChild(this._list1);
            _loc_1 = 2;
            while (_loc_1 <= 7)
            {
                
                this["_list" + _loc_1] = new List(522, 245, null, "scrollBar2");
                this["_list" + _loc_1].move(-13, 28);
                this["_list" + _loc_1].cellRenderer = SevenActivityItemTwo;
                _loc_1++;
            }
            _loc_1 = 1;
            while (_loc_1 <= 10)
            {
                
                this["_mc" + _loc_1] = this._view3.getChildByName("mc" + _loc_1);
                this["_mc" + _loc_1].addEventListener(MouseEvent.MOUSE_OVER, this._stopAnimation);
                this["_mc" + _loc_1].addEventListener(MouseEvent.MOUSE_OUT, this._startAnimation);
                _loc_1++;
            }
            this.btn_privilege = new BaseButton(this._view3.getChildByName("btn_privilege"));
            this.btn_privilege.addEventListener(MouseEvent.CLICK, this.__click);
            this.mc_role = this._view3.getChildByName("mc_role") as MovieClip;
            this.curSelIndex = 1;
            NewActivityModel.getInstance().addEventListener(NewActivityEvent.ACTIVITY_GROUP_REMOVE, this._actDelHandler);
            return;
        }// end function

        private function _actDelHandler(event:NewActivityEvent) : void
        {
            if (int(event.data) == NewActivityConfig.GROUP_SEVEN_ACTIVITY)
            {
                NewActivityModel.getInstance().removeEventListener(NewActivityEvent.ACTIVITY_GROUP_REMOVE, this._actDelHandler);
                this.close();
            }
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            this.setAuto(true);
            var _loc_1:* = this.ACT_BTN_NAME.indexOf("act_" + this._curSelIndex);
            if (_loc_1 != -1 && this._infoArr && this._infoArr.length && this._curSelIndex != this.STRENG_TYPE)
            {
                NewActivityControl.getInstance().getActivityInfo(this._infoArr[_loc_1].activityId);
            }
            ClickStream.add(ClickStreamId.OPEN_KaiFuHuoDong);
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            this.setAuto(false);
            this.clearRole();
            TweenLite.killDelayedCallsTo(this.updateEquipIndex);
            return;
        }// end function

        private function clearRole() : void
        {
            if (this.role)
            {
                this.role.finalize();
                this.role = null;
            }
            return;
        }// end function

        private function __actBtnClickHandler(event:MouseEvent) : void
        {
            var _loc_2:* = event.currentTarget.name;
            this.curSelIndex = _loc_2;
            return;
        }// end function

        private function __closeClickHandler(event:MouseEvent) : void
        {
            this.close();
            return;
        }// end function

        private function __helpClickHandler(event:MouseEvent) : void
        {
            var _loc_2:* = this.ACT_BTN_NAME.indexOf("act_" + this._curSelIndex);
            switch(_loc_2)
            {
                case 1:
                {
                    GameStrategyControl.getInstance().openOrCloseStrategyBox();
                    break;
                }
                case 2:
                {
                    CountryControl.getInstance().openCountryBox();
                    break;
                }
                case 3:
                {
                    ZonesControl.getInstance().openZonesDekaron();
                    break;
                }
                case 4:
                {
                    SingleRechargeControl.getInstance().openOrClose();
                    break;
                }
                case 5:
                {
                    PrimaryRoleControl.getInstance().openHorse();
                    break;
                }
                case 6:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function __click(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this.btn_privilege:
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

        private function updateByActivityInfo(event:NewActivityEvent) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_2:* = event.data as NewActivityInfo;
            if (UILoaded && _loc_2 && _loc_2.isDetailInit && _loc_2.activityId == this.ACTIVITY_MAP["act_" + this._curSelIndex])
            {
                _loc_3 = this.ACT_BTN_NAME.indexOf("act_" + this._curSelIndex);
                if (_loc_3 == -1)
                {
                    return;
                }
                _loc_4 = this._infoArr[_loc_3];
                if (!_loc_4 || !_loc_4.isDetailInit)
                {
                    return;
                }
                _loc_5 = this["_list" + this._curSelIndex];
                if (_loc_5.length > 0)
                {
                    _loc_6 = 0;
                    _loc_7 = _loc_4.activityItemLists.length;
                    while (_loc_6 < _loc_7)
                    {
                        
                        _loc_8 = _loc_5.getContent(_loc_6);
                        _loc_8.obj = _loc_4.activityItemLists[_loc_6];
                        _loc_6++;
                    }
                    this._actTime.text = ToolKit.getFormatDate(_loc_4.beginTime * 1000, LanguageCfgObj.getInstance().getByIndex("10020") + LanguageCfgObj.getInstance().getByIndex("10021") + LanguageCfgObj.getInstance().getByIndex("10022")) + "-" + ToolKit.getFormatDate(_loc_4.endTime * 1000, LanguageCfgObj.getInstance().getByIndex("10020") + LanguageCfgObj.getInstance().getByIndex("10021") + LanguageCfgObj.getInstance().getByIndex("10022"));
                    this._timeCountUpdate();
                }
                else
                {
                    this.updateByIndex();
                }
            }
            return;
        }// end function

        private function updateByIndex() : void
        {
            var _loc_3:* = null;
            if (!UILoaded)
            {
                return;
            }
            var _loc_1:* = this.ACT_BTN_NAME.indexOf("act_" + this._curSelIndex);
            if (_loc_1 == -1)
            {
                return;
            }
            var _loc_2:* = this._infoArr[_loc_1];
            if (!_loc_2 || !_loc_2.isDetailInit)
            {
                return;
            }
            _loc_3 = this["_list" + this._curSelIndex];
            if (!_loc_3.length)
            {
                _loc_3.objs = _loc_2.activityItemLists;
            }
            this._actTime.text = ToolKit.getFormatDate(_loc_2.beginTime * 1000, LanguageCfgObj.getInstance().getByIndex("10020") + LanguageCfgObj.getInstance().getByIndex("10021") + LanguageCfgObj.getInstance().getByIndex("10022")) + "-" + ToolKit.getFormatDate(_loc_2.endTime * 1000, LanguageCfgObj.getInstance().getByIndex("10020") + LanguageCfgObj.getInstance().getByIndex("10021") + LanguageCfgObj.getInstance().getByIndex("10022"));
            this._timeCountUpdate();
            return;
        }// end function

        private function _timeCountUpdate() : void
        {
            var _loc_3:* = NaN;
            var _loc_4:* = null;
            if (!UILoaded)
            {
                return;
            }
            var _loc_1:* = this.ACT_BTN_NAME.indexOf("act_" + this._curSelIndex);
            if (_loc_1 == -1)
            {
                return;
            }
            var _loc_2:* = this._infoArr[_loc_1];
            if (UILoaded && _loc_2 && _loc_2.isDetailInit)
            {
                _loc_3 = _loc_2.endTime - ToolKit.getServerTime() * 0.001;
                if (_loc_3 < 0)
                {
                    this._restTime.text = LanguageCfgObj.getInstance().getByIndex("10963");
                    this.setAuto(false);
                }
                else
                {
                    _loc_4 = ToolKit.second2TimeStr(_loc_3, LanguageCfgObj.getInstance().getByIndex("10964"));
                    if (_loc_4 == "")
                    {
                        this._restTime.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11968"), [Math.ceil(_loc_3)]);
                    }
                    else
                    {
                        this._restTime.text = _loc_4;
                    }
                    this.setAuto(true);
                }
            }
            return;
        }// end function

        private function updateStreng() : void
        {
            var _loc_1:* = 0;
            while (_loc_1 < 10)
            {
                
                ToolKit.clearMcChild(this["_mc" + (_loc_1 + 1)]);
                _loc_1++;
            }
            var _loc_2:* = UserObj.getInstance().playerInfo.jobkind;
            var _loc_3:* = new IconItem("");
            _loc_3.setWH(40, 40);
            _loc_3.setImageSize(40, 40);
            var _loc_4:* = PropUtil.createItemByCfg(this["goodsID" + _loc_2][this._curEquipIndex]);
            (PropUtil.createItemByCfg(this["goodsID" + _loc_2][this._curEquipIndex]) as EquipmentInfo).q_reduce_damage = 400;
            (_loc_4 as EquipmentInfo).q_add_hplimit = 400;
            _loc_3.setInfo(_loc_4);
            this._mc1.addChild(_loc_3);
            var _loc_5:* = 1;
            while (_loc_5 < 5)
            {
                
                _loc_3 = new IconItem("");
                _loc_3.setWH(56, 56);
                _loc_3.setImageSize(56, 56);
                _loc_4 = PropUtil.createItemByCfg(this["goodsID" + _loc_2][this._curEquipIndex]);
                _loc_4.intensify = this.intensify[(_loc_5 - 1)];
                (_loc_4 as EquipmentInfo).q_reduce_damage = 400;
                (_loc_4 as EquipmentInfo).q_add_hplimit = 400;
                _loc_3.setInfo(_loc_4);
                this["_mc" + (_loc_5 + 1)].addChild(_loc_3);
                _loc_5++;
            }
            _loc_3 = new IconItem("");
            _loc_3.setWH(40, 40);
            _loc_3.setImageSize(40, 40);
            _loc_4 = PropUtil.createItemByCfg(this.goodsID4[(_loc_2 - 1)]);
            (_loc_4 as EquipmentInfo).q_remarkable_attackSpeed = 7;
            (_loc_4 as EquipmentInfo).q_remarkable_attack = 1000;
            _loc_3.setInfo(_loc_4);
            this._mc6.addChild(_loc_3);
            _loc_5 = 6;
            while (_loc_5 < 10)
            {
                
                _loc_3 = new IconItem("");
                _loc_3.setWH(56, 56);
                _loc_3.setImageSize(56, 56);
                _loc_4 = PropUtil.createItemByCfg(this.goodsID4[(_loc_2 - 1)]);
                _loc_4.intensify = this.intensify[_loc_5 - 6];
                (_loc_4 as EquipmentInfo).q_remarkable_attackSpeed = 7;
                (_loc_4 as EquipmentInfo).q_remarkable_attack = 1000;
                _loc_3.setInfo(_loc_4);
                this["_mc" + (_loc_5 + 1)].addChild(_loc_3);
                _loc_5++;
            }
            return;
        }// end function

        private function updateEquipIndex() : void
        {
            var _loc_1:* = this;
            var _loc_2:* = this._curEquipIndex + 1;
            _loc_1._curEquipIndex = _loc_2;
            if (this._curEquipIndex >= this.goodsID1.length)
            {
                this._curEquipIndex = 0;
            }
            this.equipDisappearAnimation();
            TweenLite.delayedCall(7, this.updateEquipIndex);
            return;
        }// end function

        private function equipDisappearAnimation() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < 10)
            {
                
                this["_mc" + (_loc_1 + 1)].alpha = 1;
                _loc_2 = this["_mc" + (_loc_1 + 1)];
                TweenLite.to(_loc_2, 1, {alpha:0});
                _loc_1++;
            }
            TweenLite.delayedCall(1, this.equipAppearAnimation);
            return;
        }// end function

        private function equipAppearAnimation() : void
        {
            var _loc_2:* = null;
            this.updateStreng();
            var _loc_1:* = 0;
            while (_loc_1 < 10)
            {
                
                _loc_2 = this["_mc" + (_loc_1 + 1)];
                TweenLite.to(_loc_2, 1, {alpha:1});
                _loc_1++;
            }
            return;
        }// end function

        private function showRole() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (!this.role)
            {
                _loc_1 = UserObj.getInstance().playerInfo;
                _loc_2 = new RoleInfo();
                _loc_2.personId = new long(1000);
                _loc_3 = ItemCfgObj.getInstance().getItemCfg(this.armorArray[(_loc_1.jobkind - 1)]);
                _loc_3.streng = 9;
                _loc_2.armor = _loc_3;
                _loc_4 = ItemCfgObj.getInstance().getItemCfg(this.weaponArray[(_loc_1.jobkind - 1)]);
                _loc_4.streng = 9;
                _loc_2.weapon = _loc_4;
                if (_loc_1.jobkind == 2)
                {
                    _loc_6 = ItemCfgObj.getInstance().getItemCfg(2320023);
                    _loc_6.streng = 9;
                    _loc_2.weapon_other = _loc_6;
                }
                else if (_loc_1.jobkind == 3)
                {
                    _loc_6 = ItemCfgObj.getInstance().getItemCfg(2330046);
                    _loc_6.streng = 9;
                    _loc_2.weapon_other = _loc_6;
                }
                _loc_5 = ItemCfgObj.getInstance().getItemCfg(this.wingArray[(_loc_1.jobkind - 1)]);
                _loc_2.wingInfo = _loc_5;
                this.role = Global.roleFactory.creatRole(_loc_2);
                this.role.direct = -FrameworkGlobal.DIRECT_135;
                this.role.updateWeapon();
                this.role.updateWeaponOther();
                this.role.updateWing();
                this.role.auto = true;
                this.role.setAct(Params.ACTION_STAND_ID, true);
                this.mc_role.mouseChildren = false;
                this.mc_role.mouseEnabled = false;
                this.mc_role.parent.mouseEnabled = false;
                this.mc_role.addChild(this.role as Role);
            }
            return;
        }// end function

        private function _startAnimation(event:MouseEvent) : void
        {
            TweenLite.delayedCall(5, this.updateEquipIndex);
            return;
        }// end function

        private function _stopAnimation(event:MouseEvent) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < 10)
            {
                
                _loc_3 = this["_mc" + (_loc_2 + 1)];
                _loc_3.alpha = 1;
                TweenLite.killDelayedCallsTo(this.updateEquipIndex);
                TweenLite.killTweensOf(_loc_3);
                _loc_2++;
            }
            return;
        }// end function

        private function setAuto(param1:Boolean) : void
        {
            if (this._enable == param1)
            {
                return;
            }
            this._enable = param1;
            if (param1)
            {
                Ticker.registerTimer(1, this._timeCountUpdate);
            }
            else
            {
                Ticker.killTimer(this._timeCountUpdate);
            }
            return;
        }// end function

        public function get curSelIndex() : int
        {
            return this._curSelIndex;
        }// end function

        public function set curSelIndex(param1:int) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            _loc_2 = this.ACT_BTN_NAME.indexOf("act_" + this._curSelIndex);
            if (!UILoaded)
            {
                this._curSelIndex = param1;
                return;
            }
            if (_loc_2 != -1)
            {
                _loc_3 = this.actBtnArray[_loc_2];
                _loc_3.selected = false;
                _loc_3.enabled = true;
            }
            if (this._curSelIndex != 0 && this._curSelIndex != this.STRENG_TYPE && this._view2.contains(this["_list" + this._curSelIndex]))
            {
                this._view2.removeChild(this["_list" + this._curSelIndex]);
            }
            this._curSelIndex = param1;
            _loc_2 = this.ACT_BTN_NAME.indexOf("act_" + this._curSelIndex);
            if (_loc_2 != -1)
            {
                this._topView.gotoAndStop((_loc_2 + 1));
                _loc_3 = this.actBtnArray[_loc_2];
                _loc_3.selected = true;
                _loc_3.enabled = false;
            }
            if (this._curSelIndex == 1)
            {
                this._view1.visible = true;
                this._view2.visible = false;
                this._view3.visible = false;
                this.helpBtn.visible = false;
                TweenLite.killDelayedCallsTo(this.updateEquipIndex);
                var _loc_4:* = true;
                this.txt2.visible = true;
                this.txt1.visible = _loc_4;
                this._restTime.visible = _loc_4;
                this._actTime.visible = _loc_4;
            }
            else if (this._curSelIndex == this.STRENG_TYPE)
            {
                this._view1.visible = false;
                this._view2.visible = false;
                this._view3.visible = true;
                this.helpBtn.visible = false;
                this.updateStreng();
                this.showRole();
                TweenLite.delayedCall(5, this.updateEquipIndex);
                var _loc_4:* = false;
                this.txt2.visible = false;
                this.txt1.visible = _loc_4;
                this._restTime.visible = _loc_4;
                this._actTime.visible = _loc_4;
            }
            else
            {
                this._view1.visible = false;
                this._view2.visible = true;
                this._view3.visible = false;
                this._view2.addChild(this["_list" + param1]);
                if (this._curSelIndex == 7)
                {
                    this.helpBtn.visible = false;
                }
                else
                {
                    this.helpBtn.visible = true;
                }
                TweenLite.killDelayedCallsTo(this.updateEquipIndex);
                var _loc_4:* = true;
                this.txt2.visible = true;
                this.txt1.visible = _loc_4;
                this._restTime.visible = _loc_4;
                this._actTime.visible = _loc_4;
            }
            if (this._curSelIndex != this.STRENG_TYPE)
            {
                NewActivityControl.getInstance().getActivityInfo(this._infoArr[_loc_2].activityId);
                this.updateByIndex();
            }
            return;
        }// end function

    }
}
