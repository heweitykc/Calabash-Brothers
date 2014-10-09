package com.game.horse.view
{
    import __AS3__.vec.*;
    import com.*;
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.f1.ui.image.*;
    import com.f1.ui.imagesNumbericStepper.*;
    import com.f1.ui.stripe.*;
    import com.f1.utils.*;
    import com.f1.utils.cue.*;
    import com.f1.vmc.*;
    import com.game.backpack.control.*;
    import com.game.backpack.events.*;
    import com.game.backpack.model.*;
    import com.game.clickstream.*;
    import com.game.guide.*;
    import com.game.guide.consts.*;
    import com.game.guide.control.*;
    import com.game.guide.model.*;
    import com.game.horse.control.*;
    import com.game.mall.control.*;
    import com.game.mall.model.*;
    import com.game.map.control.*;
    import com.game.operationpanel.view.*;
    import com.game.primaryrole.control.*;
    import com.game.protect.control.*;
    import com.greensock.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import com.view.tipcell.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class HorseView extends Component implements IGuide
    {
        private var horsePhoto:VMCView;
        private var horseWingPhoto:VMCView;
        private var horseName:Image;
        private var horseStageImg:Image;
        private var btnLeftRot:BaseButton;
        private var btnRightRot:BaseButton;
        private var btnScanInfo:BaseButton;
        private var btnUpOrDown:BaseButton;
        private var btnCulture:BaseButton;
        private var btnOneKeyCulture:BaseButton;
        private var horseExpBar:Stripe;
        private var fruit:ImgNumber;
        private var horseExpEffect:VMCView;
        private var skillBoxList:HBox;
        private var systemCue:ScrollSystemCue;
        private var vecSkillBox:Vector.<SkillBox>;
        private var effectSuccess:VMCView;
        private var horseDir:int = -3;
        private var horseLevel:int;
        private var horseComb:int = 0;
        private var _horseInfo:HorseInfo;
        private var dic:Dictionary;
        private var autoBeforeStage:int;
        private var _isHitCostGoldForAuto:Boolean = true;
        private var _isAutoCulture:Boolean = false;
        private var _autoCultureType:int = -1;

        public function HorseView()
        {
            this.vecSkillBox = new Vector.<SkillBox>(3, true);
            this.effectSuccess = new VMCView();
            this.dic = new Dictionary();
            loadDisplay("res/horsePanel.swf");
            return;
        }// end function

        private function getTextField(param1:String) : TextField
        {
            var _loc_2:* = null;
            if (!this.dic[param1])
            {
                _loc_2 = getDisplayChildByName(param1);
                _loc_2.selectable = false;
                this.dic[param1] = _loc_2;
            }
            return this.dic[param1];
        }// end function

        override protected function displayReady() : void
        {
            initComponentUI("horsePanel");
            super.displayReady();
            this.initUI();
            this.addEvent();
            HorseControl.getInstance().updatePanel();
            return;
        }// end function

        private function initUI() : void
        {
            this.btnCulture = new BaseButton(getDisplayChildByName("btnCulture"));
            this.btnCulture.setText(LanguageCfgObj.getInstance().getByIndex("10870"));
            this.btnLeftRot = new BaseButton(getDisplayChildByName("btnLeftRot"));
            this.btnRightRot = new BaseButton(getDisplayChildByName("btnRightRot"));
            this.btnScanInfo = new BaseButton(getDisplayChildByName("btnScanInfo"));
            this.btnScanInfo.setText(LanguageCfgObj.getInstance().getByIndex("10871"));
            this.btnUpOrDown = new BaseButton(getDisplayChildByName("btnUpOrDown"));
            this.btnUpOrDown.setText(LanguageCfgObj.getInstance().getByIndex("10872"), true);
            this.btnOneKeyCulture = new BaseButton(getDisplayChildByName("btnOneKeyCulture"));
            this.btnOneKeyCulture.setText(this.getOneKeyText());
            ItemTips.create(this.btnOneKeyCulture, {}, HorseAutoCultureTips);
            this.horseExpBar = new Stripe(getDisplayChildByName("horseExpBar"));
            this.horseExpBar.isOnlyIncrease = true;
            this.horseStageImg = new Image();
            this.horseStageImg.move(39, 70);
            this.addChild(this.horseStageImg);
            this.horseName = new Image();
            this.horseName.move(113.5, 368);
            this.addChild(this.horseName);
            this.horseExpEffect = new VMCView();
            this.horseExpEffect.move(490, 107);
            this.horseExpEffect.loadRes("res/effect/houseExp.png");
            this.horseExpEffect.auto = true;
            this.horseExpEffect.updatePose("90", true);
            this.addChild(this.horseExpEffect);
            this.fruit = new ImgNumber();
            this.fruit.move(450, 100);
            this.addChild(this.fruit);
            this.skillBoxList = new HBox();
            this.skillBoxList.horizontal = true;
            this.addChild(this.skillBoxList);
            var _loc_1:* = 0;
            while (_loc_1 < this.vecSkillBox.length)
            {
                
                this.vecSkillBox[_loc_1] = new SkillBox("horseSkillBoxBack");
                this.vecSkillBox[_loc_1].setImageSize(40, 40);
                _loc_1++;
            }
            this.horsePhoto = new VMCView();
            this.horsePhoto.move(200, 245);
            this.addChild(this.horsePhoto);
            this.horsePhoto.parent.mouseEnabled = false;
            this.systemCue = new ScrollSystemCue(ScrollSystemCue.FIGHT_NOTICE);
            this.systemCue.move(260, 280);
            this.addChild(this.systemCue);
            this.creatToolsTips();
            this.registerGuide();
            return;
        }// end function

        private function addEvent() : void
        {
            this.addEvtListener(MouseEvent.CLICK, this.mouseClick);
            this.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemoveFromStage);
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            BackpackObj.getInstance().addEventListener(BackpackEvent.GOODS_CHANGE, this.onGoodsChange);
            return;
        }// end function

        protected function onAddedToStage(event:Event) : void
        {
            ItemTips.create(this.btnOneKeyCulture, {}, HorseAutoCultureTips);
            this.btnOneKeyCulture.setText(this.getOneKeyText());
            return;
        }// end function

        private function getOneKeyText() : String
        {
            var _loc_1:* = null;
            var _loc_2:* = UserObj.getInstance().playerInfo.vipid;
            if (_loc_2 < 4)
            {
                _loc_1 = LanguageCfgObj.getInstance().getByIndex("10873");
            }
            else if (_loc_2 < 5)
            {
                _loc_1 = LanguageCfgObj.getInstance().getByIndex("10874");
            }
            else
            {
                _loc_1 = LanguageCfgObj.getInstance().getByIndex("10875");
            }
            return _loc_1;
        }// end function

        protected function onRemoveFromStage(event:Event) : void
        {
            this.stopAutoCulture();
            ItemTips.dispose(this.btnOneKeyCulture);
            HorseControl.getInstance().closeHorseUpScan();
            return;
        }// end function

        protected function onGoodsChange(event:BackpackEvent) : void
        {
            var _loc_2:* = event.data as PropInfo;
            if (_loc_2.itemModelId == HorseCfgObj.HORSE_UP_TOOLS_1 || _loc_2.itemModelId == HorseCfgObj.HORSE_UP_TOOLS_2 || _loc_2.itemModelId == HorseCfgObj.HORSE_UP_TOOLS_3)
            {
                this.getTextField(HorseUnit.MAIN_TXT_OWN_TOOL).htmlText = this.getToolsCount(false).toString();
            }
            return;
        }// end function

        private function mouseClick(event:MouseEvent) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            switch(event.target)
            {
                case this.btnCulture:
                {
                    ClickStream.add(ClickStreamId.CLICK_ZuoQi_XunYang);
                    _loc_2 = this.getToolsId();
                    _loc_3 = this.getToolsCount();
                    if (_loc_3 < 1)
                    {
                        if (_loc_2 == ItemConst.HIGH_RIDE_DAN)
                        {
                            FunGuideControl.getInstance().showRemind(FunGuideConst.RIDE);
                            return;
                        }
                        if (_loc_2 == ItemConst.SUPER_RIDE_DAN)
                        {
                            FunGuideControl.getInstance().showRemind(FunGuideConst.SUPER_RIDE);
                            return;
                        }
                        BackPackControl.getInstance().checkItemenough(_loc_2, 1, this.startCulture, [0]);
                    }
                    else
                    {
                        this.startCulture(0);
                    }
                    break;
                }
                case this.btnOneKeyCulture:
                {
                    ClickStream.add(ClickStreamId.CLICK_ZuoQi_ZiDongXunYang);
                    this.clickAutoCulture();
                    break;
                }
                case this.btnLeftRot:
                {
                    this.setNestDirect(1);
                    break;
                }
                case this.btnRightRot:
                {
                    this.setNestDirect(-1);
                    break;
                }
                case this.btnScanInfo:
                {
                    _loc_4 = UserObj.getInstance().playerInfo.horseInfo.horse_level;
                    _loc_5 = HorseCfgObj.getInstance().getNestStepExp(_loc_4, (_loc_4 + 1));
                    if (_loc_5 == 0)
                    {
                        Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10876"));
                    }
                    else
                    {
                        HorseControl.getInstance().openHorseUpScan();
                    }
                    break;
                }
                case this.btnUpOrDown:
                {
                    HorseControl.getInstance().changeRidingState();
                    break;
                }
                case this.dic[HorseUnit.MAIN_TXT_NEED_TOOL]:
                {
                    MallControl.getInstance().openMall(MallModel.kind[1]);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function clickAutoCulture() : void
        {
            var toolID:int;
            var gold:int;
            var item:ItemCfg;
            if (this._isAutoCulture)
            {
                this.stopAutoCulture();
                return;
            }
            var count:int;
            count = this.getToolsCount();
            if (count > 0)
            {
                this._autoCultureType = 0;
                this.startAutoCulture();
            }
            else if (this._isHitCostGoldForAuto)
            {
                toolID = this.getToolsId();
                gold = GlobalCfgObj.getInstance().getHorseToolsCost(toolID);
                item = ItemCfgObj.getInstance().getItemCfg(toolID);
                Global.popManager.cue(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12090"), [item.q_name, gold]), LanguageCfgObj.getInstance().getByIndex("11869"), null, function () : void
            {
                if (UserObj.getInstance().playerInfo.gold < gold)
                {
                    MapControl.getInstance().showRechargeD();
                    return;
                }
                _autoCultureType = 1;
                startAutoCulture();
                return;
            }// end function
            , null, 2, null, false, true, function (param1:Boolean) : void
            {
                _isHitCostGoldForAuto = !param1;
                return;
            }// end function
            );
            }
            else
            {
                this.startAutoCulture();
            }
            return;
        }// end function

        private function setNestDirect(param1:int = 0) : void
        {
            if (!this.horsePhoto)
            {
                return;
            }
            switch(param1)
            {
                case -1:
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this.horseDir - 1;
                    _loc_2.horseDir = _loc_3;
                    this.horseDir = this.horseDir < -3 ? (4) : (this.horseDir);
                    break;
                }
                case 0:
                {
                    break;
                }
                case 1:
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this.horseDir + 1;
                    _loc_2.horseDir = _loc_3;
                    this.horseDir = this.horseDir > 4 ? (-3) : (this.horseDir);
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.loadHorseRes(this.horseDir);
            this.loadHorseWingRes();
            return;
        }// end function

        private function startCulture(param1:int) : void
        {
            if (ProtectControl.getInstance().promptIfLocked())
            {
                this.stopAutoCulture();
                return;
            }
            HorseControl.getInstance().horseCulture(param1);
            return;
        }// end function

        private function startAutoCulture() : void
        {
            this._isAutoCulture = true;
            this.btnOneKeyCulture.setText(LanguageCfgObj.getInstance().getByIndex("10877"));
            this.autoBeforeStage = UserObj.getInstance().playerInfo.horseInfo.horse_step;
            this.onAutoTimer();
            return;
        }// end function

        protected function onAutoTimer() : void
        {
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_1:* = this.getToolsCount();
            var _loc_2:* = this.getToolsId();
            var _loc_3:* = GlobalCfgObj.getInstance().getHorseToolsCost(_loc_2);
            var _loc_4:* = UserObj.getInstance().playerInfo.horseInfo.horse_level;
            var _loc_5:* = HorseCfgObj.getInstance().getInfoFromLevel(_loc_4);
            var _loc_6:* = UserObj.getInstance().playerInfo.vipid;
            if (_loc_5.horse_step > this.autoBeforeStage)
            {
                this.stopAutoCulture();
                return;
            }
            var _loc_7:* = HorseCfgObj.getInstance().getNestStepExp(_loc_4, (_loc_4 + 1));
            if (HorseCfgObj.getInstance().getNestStepExp(_loc_4, (_loc_4 + 1)) == 0)
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10878"));
                this.stopAutoCulture();
                return;
            }
            if (_loc_1 <= 0 && UserObj.getInstance().playerInfo.gold < _loc_3)
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10879"));
                this.stopAutoCulture();
                return;
            }
            if (this._autoCultureType == 0 && _loc_1 <= 0)
            {
                _loc_8 = ItemCfgObj.getInstance().getItemCfg(_loc_2);
                Global.popManager.addedToSystem(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12091"), [_loc_8.q_name]));
                this.stopAutoCulture();
                return;
            }
            if (this._autoCultureType == 1 && _loc_1 <= 0 && UserObj.getInstance().playerInfo.gold < _loc_3)
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10879"));
                this.stopAutoCulture();
                return;
            }
            if (_loc_1 <= 0 && _loc_5.horse_step <= 9 && _loc_5.horse_step >= 7 && _loc_6 < 4)
            {
                _loc_9 = LanguageCfgObj.getInstance().getByIndex("10881");
                Global.popManager.cue(_loc_9);
                this.stopAutoCulture();
                return;
            }
            if (_loc_1 <= 0 && _loc_5.horse_step <= 12 && _loc_5.horse_step >= 10 && _loc_6 < 5)
            {
                _loc_9 = LanguageCfgObj.getInstance().getByIndex("10882");
                Global.popManager.cue(_loc_9);
                this.stopAutoCulture();
                return;
            }
            this.startCulture(1);
            return;
        }// end function

        private function stopAutoCulture() : void
        {
            this._isAutoCulture = false;
            this._autoCultureType = -1;
            this.btnOneKeyCulture.setText(this.getOneKeyText());
            return;
        }// end function

        public function horseCultureBack(param1:int) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_2:* = HorseCfgObj.getInstance().getInfoFromLevel(param1);
            if (_loc_2.horse_step > this.horseLevel)
            {
                this.playEffect();
            }
            if (this._isAutoCulture)
            {
                _loc_3 = ItemCfgObj.getInstance().getCfgBy(this.getToolsId()).q_effict_value;
                if (_loc_3)
                {
                    _loc_4 = int(_loc_3.substr(1, _loc_3.length - 2));
                    _loc_5 = UserObj.getInstance().playerInfo.horseInfo.horse_exp;
                    _loc_6 = int(1000 / int(_loc_5 / (_loc_4 * 0.4)));
                    _loc_6 = _loc_6 < 100 ? (100) : (_loc_6);
                    TweenLite.delayedCall(_loc_6 / 1000, this.onAutoTimer);
                }
                else
                {
                    this.stopAutoCulture();
                }
            }
            return;
        }// end function

        private function playEffect() : void
        {
            var _loc_1:* = new VMCView();
            _loc_1.auto = true;
            _loc_1.move(195, 250);
            _loc_1.loadRes("res/effect/successtips/horseUpStep.png");
            this.addChild(_loc_1);
            _loc_1.updatePose("90", false, false, true, true);
            return;
        }// end function

        public function setRideState(param1:int) : void
        {
            if (UILoaded)
            {
                if (param1 == 0)
                {
                    this.btnUpOrDown.setText(LanguageCfgObj.getInstance().getByIndex("10872"), true);
                }
                else
                {
                    this.btnUpOrDown.setText(LanguageCfgObj.getInstance().getByIndex("10884"), true);
                }
            }
            return;
        }// end function

        public function addedToSystem(param1:String) : void
        {
            this.systemCue.addedScrollInfo(param1);
            return;
        }// end function

        public function updateHorseInfo(param1:HorseInfo) : void
        {
            this._horseInfo = param1;
            this.getTextField(HorseUnit.MAIN_TXT_UP_NEST_LEVEL).text = String(HorseCfgObj.getInstance().getNestGradeInfoFromLevel(param1.horse_level).horse_level - param1.horse_level);
            this.setDetailInfo(param1);
            this.setRideState(param1.horseStat);
            if (this.horseLevel < param1.horse_step)
            {
                this.horseExpBar.setValue(0, param1.horse_exp);
                this.horseExpBar.setValue(param1.currentExp, param1.horse_exp, true);
                this.horsePhoto.auto = true;
                this.horseName.load(Params.ZONES_LEVEL_PATH + param1.horse_id + ".png");
                this.horseStageImg.load("res/image/horse/horsestage" + param1.horse_step + ".png");
                this.setSkillList(param1);
                this.horseLevel = param1.horse_step;
                this.creatToolsTips();
                if (param1.q_horse_wing == 1)
                {
                    if (!this.horseWingPhoto)
                    {
                        this.horseWingPhoto = new VMCView();
                        this.horseWingPhoto.move(200, 245);
                        this.addChild(this.horseWingPhoto);
                    }
                    this.horsePhoto.appendView(this.horseWingPhoto);
                    this.horseWingPhoto.auto = true;
                }
                else if (this.horseWingPhoto)
                {
                    this.horsePhoto.removeAppend(this.horseWingPhoto);
                    if (this.horseWingPhoto.playing)
                    {
                        this.horseWingPhoto.stop();
                    }
                    this.horseWingPhoto.finalize();
                    this.horseWingPhoto = null;
                }
                this.setNestDirect();
            }
            else if (this.horseExpBar.curValue > param1.currentExp)
            {
                this.horseExpBar.setValue(param1.currentExp, param1.horse_exp);
            }
            else
            {
                this.horseExpBar.setValue(param1.currentExp, param1.horse_exp, true);
            }
            PrimaryRoleControl.getInstance().getRoleView().setHorseGateInfo();
            return;
        }// end function

        public function loadHorseRes(param1:int) : void
        {
            var url:String;
            var direct:* = param1;
            if (this._horseInfo)
            {
                if (this.horsePhoto)
                {
                    url = Params.HORSE_PATH + this._horseInfo.horse_id + "/act01/" + Math.abs(direct * 45) + ".png";
                    this.horsePhoto.direct = direct * 45;
                    this.horsePhoto.loadRes(url, null, false, function () : void
            {
                horsePhoto.updatePose(Math.abs(direct * 45).toString(), true);
                return;
            }// end function
            );
                }
            }
            return;
        }// end function

        public function loadHorseWingRes() : void
        {
            var direct:int;
            var url:String;
            direct = this.horsePhoto.direct;
            if (this._horseInfo)
            {
                if (this.horseWingPhoto)
                {
                    url = Params.HORSE_PATH + this._horseInfo.horse_id + "01/act01/" + Math.abs(direct) + ".png";
                    this.horseWingPhoto.direct = direct;
                    this.horseWingPhoto.loadRes(url, null, false, function () : void
            {
                horseWingPhoto.updatePose(Math.abs(direct).toString(), true);
                return;
            }// end function
            );
                }
            }
            return;
        }// end function

        private function creatToolsTips() : void
        {
            ItemTips.dispose(this.getTextField(HorseUnit.MAIN_TXT_NEED_TOOL));
            var _loc_1:* = new PropInfo();
            var _loc_2:* = this.getToolsId();
            _loc_1.convByCfg(_loc_2);
            var _loc_3:* = PropUtil.getPropColor(_loc_1.q_quality_lv);
            this.getTextField(HorseUnit.MAIN_TXT_NEED_TOOL).htmlText = "<font color = \'#" + _loc_3.toString(16) + "\'><u>" + _loc_1.q_name + "x1</u></font>";
            ItemTips.create(this.getTextField(HorseUnit.MAIN_TXT_NEED_TOOL), _loc_1, PropTips);
            return;
        }// end function

        private function setSkillOneInfo(param1:SkillBox, param2:int) : void
        {
            var _loc_3:* = null;
            if (param2)
            {
                _loc_3 = SkillCfgObj.getInstance().getSkillInfoById(param2);
                param1.info = _loc_3;
                this.skillBoxList.add(param1);
            }
            else
            {
                if (this.skillBoxList.contains(param1))
                {
                    this.skillBoxList.remove(param1);
                }
                param1.clean();
            }
            return;
        }// end function

        private function setSkillList(param1:HorseTableVo) : void
        {
            this.setSkillOneInfo(this.vecSkillBox[0], param1.horse_skill_id1);
            this.setSkillOneInfo(this.vecSkillBox[1], param1.horse_skill_id2);
            this.setSkillOneInfo(this.vecSkillBox[2], param1.horse_skill_id3);
            layoutMC(this.skillBoxList, Layout.BOTTOM_CENTER, 197, 24);
            return;
        }// end function

        private function setDetailInfo(param1:HorseTableVo) : void
        {
            var _loc_2:* = 0;
            if (param1)
            {
                _loc_2 = HorseCfgObj.getInstance().getCombatValue(param1);
                if (this.horseComb < _loc_2)
                {
                    this.horseComb = _loc_2;
                    this.fruit.setNumber(_loc_2.toString(), 1, 0, true);
                }
                this.getTextField(HorseUnit.MAIN_TXT_GRADE_LEVEL).htmlText = "lv." + param1.horse_step_level.toString();
                this.getTextField(HorseUnit.MAIN_TXT_ADDED_SPEED_VALUE).htmlText = param1.horse_speed.toString();
                this.getTextField(HorseUnit.MAIN_TXT_BASE_ATTACK_VALUE).htmlText = param1.horse_min_phyatk + " - " + param1.horse_max_phyatk;
                this.getTextField(HorseUnit.MAIN_TXT_DEFENSE_VALUE).htmlText = param1.horse_defense.toString();
                this.getTextField(HorseUnit.MAIN_TXT_LIFT_VALUE).htmlText = param1.horse_hp.toString();
                this.getTextField(HorseUnit.MAIN_TXT_POW_ATTACK_VALUE).htmlText = param1.horse_min_magicatk + " - " + param1.horse_max_magicatk;
                this.getTextField(HorseUnit.MAIN_TXT_POW_VALUE).htmlText = param1.horse_mp.toString();
                this.getTextField(HorseUnit.MAIN_TXT_UNDEFENSE_VALUE).htmlText = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12088"), [param1.horse_ignoredefense / 100]);
                this.getTextField(HorseUnit.MAIN_TXT_UNDEFENSE_VALUE).visible = param1.horse_ignoredefense > 0 ? (true) : (false);
                this.getTextField(HorseUnit.MAIN_TXT_ADDED_HARM_VALUE).htmlText = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12089"), [param1.horse_perfectatk_percent / 100]);
                this.getTextField(HorseUnit.MAIN_TXT_ADDED_HARM_VALUE).visible = param1.horse_perfectatk_percent > 0 ? (true) : (false);
            }
            this.getTextField(HorseUnit.MAIN_TXT_OWN_TOOL).htmlText = this.getToolsCount(false).toString();
            return;
        }// end function

        private function getToolsCount(param1:Boolean = true) : int
        {
            var _loc_2:* = this.getToolsId();
            var _loc_3:* = BackpackObj.getInstance().getItemCount(_loc_2);
            if (param1)
            {
                _loc_3 = _loc_3 + BackpackObj.getInstance().getItemCount(HorseCfgObj.HORSE_UP_TOOLS_NORMAL);
            }
            return _loc_3;
        }// end function

        private function getToolsId() : int
        {
            var _loc_1:* = UserObj.getInstance().playerInfo.horseInfo.horse_item_id;
            return _loc_1;
        }// end function

        public function close() : void
        {
            this.guidePause(GuideConfigObj.getInstance().HORSE_UP_GUIDE_ID_2);
            return;
        }// end function

        public function registerGuide() : void
        {
            GuideControl.getInstance().registerGuide(this.btnCulture, this, GuideConfigObj.getInstance().HORSE_UP_GUIDE_ID_2);
            return;
        }// end function

        public function guideAction(param1:String) : void
        {
            return;
        }// end function

        public function guidePause(param1:String) : void
        {
            GuideControl.getInstance().backGuide(param1, 1);
            return;
        }// end function

        public function guideEnd(param1:String) : void
        {
            return;
        }// end function

        public function isGuideReady() : Boolean
        {
            return UILoaded;
        }// end function

    }
}
