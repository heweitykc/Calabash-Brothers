package com.game.zones.view.dekaron
{
    import com.*;
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.f1.ui.image.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.game.guide.*;
    import com.game.guide.control.*;
    import com.game.guide.model.*;
    import com.game.map.control.*;
    import com.game.skill.control.*;
    import com.game.zones.control.*;
    import com.game.zones.message.*;
    import com.game.zones.model.*;
    import com.greensock.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class ZonesDekaronPanel extends BaseBox implements IGuide
    {
        private var TIPS_HELP_WORD:String;
        private var _btnClose:BaseButton;
        private var _btnEnter:BaseButton;
        private var _btnDetail:BaseButton;
        private var _btnNestLevel:BaseButton;
        private var _btnGetGift:BaseButton;
        private var _btnHelp:BaseButton;
        private var _btnUseSpirite:BaseButton;
        private var _zonesdetailPanel:ZonesDekaronDetailPanel;
        private var _zonesCycRoll:ZonesCycRotation;
        private var _zonesDekaronInfo:ResTowerIndexMessage;
        private var _ufoContainer:Sprite;
        private var _grayMask:Sprite;
        private var _grayMask1:Sprite;
        private var _grayMask2:Sprite;
        private var _txtSpiritCount:TextField;
        private var _txtMonsterName:TextField;
        private var _txtGiftExp:TextField;
        private var _txtGiftMoney:TextField;
        private var _layerNum1:MovieClip;
        private var _layerNum2:MovieClip;
        private var _hBoxAwards:HBox;
        private var _iconSpirit:Sprite;
        private var _vmcNestRay:VMCView;
        private var _vmcNestSpirit:VMCView;
        private var _vmcGetGift:VMCView;
        private var _imageLevel:Image;
        private var _monsterNameBack:Sprite;
        private var isDelaySpiritEffect:Boolean;
        private var isShowBox:Boolean = true;

        public function ZonesDekaronPanel(param1 = null, param2:uint = 60, param3:String = "", param4:Boolean = true)
        {
            this.TIPS_HELP_WORD = LanguageCfgObj.getInstance().getByIndex("12367");
            super(param1, param2, param3, param4);
            loadDisplay("res/zonesdelaron.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("zonesdelaron");
            this.initUI();
            this.addEvents();
            super.displayReady();
            this.registerGuide();
            return;
        }// end function

        private function initUI() : void
        {
            this._ufoContainer = Sprite(getDisplayChildByName("ufo_container"));
            this._grayMask = Sprite(getDisplayChildByName("gray_mask"));
            this._grayMask1 = Sprite(getDisplayChildByName("gray_mask1"));
            this._grayMask2 = Sprite(getDisplayChildByName("gray_mask2"));
            this._txtMonsterName = TextField(getDisplayChildByName("txt_monster_name"));
            this._monsterNameBack = Sprite(getDisplayChildByName("monster_name_back"));
            this._txtGiftExp = TextField(getDisplayChildByName("txt_gift_exp"));
            this._txtGiftMoney = TextField(getDisplayChildByName("txt_gift_money"));
            this._txtSpiritCount = TextField(getDisplayChildByName("txt_spirit_count"));
            this._layerNum1 = MovieClip(getDisplayChildByName("layer_num1"));
            this._layerNum2 = MovieClip(getDisplayChildByName("layer_num2"));
            this._iconSpirit = Sprite(getDisplayChildByName("icon_spirit"));
            this._grayMask.mouseEnabled = false;
            this._grayMask1.mouseEnabled = false;
            this._grayMask2.mouseEnabled = false;
            this._zonesdetailPanel = new ZonesDekaronDetailPanel();
            Global.popManager.addPop(this._zonesdetailPanel, false, false, true, true, false, true);
            this._btnClose = new BaseButton(getDisplayChildByName("btn_close"));
            this._btnEnter = new BaseButton(getDisplayChildByName("btn_enter_delaron"));
            this._btnHelp = new BaseButton(getDisplayChildByName("btn_help"));
            this._btnDetail = new BaseButton(getDisplayChildByName("btn_detail"));
            this._btnNestLevel = new BaseButton(getDisplayChildByName("btn_nest_level"));
            this._btnGetGift = new BaseButton(getDisplayChildByName("btn_get_gift"));
            this._btnGetGift._labelTxt.multiline = true;
            this._btnGetGift._labelTxt.wordWrap = true;
            this._btnUseSpirite = new BaseButton(getDisplayChildByName("btn_use_spirite"));
            ItemTips.create(this._btnGetGift, {}, ZonesDekaronGiftTips);
            this._btnDetail.setText(LanguageCfgObj.getInstance().getByIndex("11519"));
            this._btnNestLevel.setText(LanguageCfgObj.getInstance().getByIndex("11520"));
            this._btnEnter.setText(LanguageCfgObj.getInstance().getByIndex("11521"));
            StringTip.create(this._btnHelp, this.TIPS_HELP_WORD);
            this._zonesCycRoll = new ZonesCycRotation();
            this._ufoContainer.addChild(this._zonesCycRoll);
            this._zonesCycRoll.move(20, 90);
            this._hBoxAwards = new HBox();
            this._hBoxAwards.horizontal = true;
            this._hBoxAwards.intervalX = 5;
            this._btnEnter.parent.addChild(this._hBoxAwards);
            this._vmcNestRay = new VMCView();
            this._vmcNestRay.move(435, 390);
            this._vmcNestSpirit = new VMCView();
            this.addChild(this._vmcNestSpirit);
            this._vmcNestSpirit.move(440, 390);
            this._imageLevel = new Image();
            this._imageLevel.move(45, 78);
            this.addChild(this._imageLevel);
            return;
        }// end function

        private function addEvents() : void
        {
            this.addEventListener(MouseEvent.CLICK, this.mouseClickHandler);
            this.addEventListener(Event.ADDED_TO_STAGE, this.addedToStageHandler);
            this.addEventListener(Event.REMOVED_FROM_STAGE, this.removeFromStageHandler);
            var _loc_1:* = UserObj.getInstance().playerInfo;
            _loc_1.addEventListener(RoleEvent.UPDATE_SPIRIT, this.onChangeSpirit);
            return;
        }// end function

        protected function onChangeSpirit(event:Event) : void
        {
            this.setSpiritInfo();
            return;
        }// end function

        protected function removeFromStageHandler(event:Event) : void
        {
            this.isDelaySpiritEffect = false;
            return;
        }// end function

        protected function addedToStageHandler(event:Event) : void
        {
            ZonesControl.getInstance().reqTowerIndex();
            this.setGiftInfo();
            this.setSpiritInfo();
            return;
        }// end function

        protected function mouseClickHandler(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._btnClose:
                {
                    this.close();
                    break;
                }
                case this._btnEnter:
                {
                    this.enterDealron();
                    break;
                }
                case this._btnDetail:
                {
                    this.openDetailPanel();
                    break;
                }
                case this._btnNestLevel:
                {
                    this.clickUpNestLevel();
                    break;
                }
                case this._btnGetGift:
                {
                    this.getGift();
                    break;
                }
                case this._btnUseSpirite:
                {
                    SkillControl.getInstance().openToTabSkill(2);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function getGift() : void
        {
            var sendGetReward:Function;
            sendGetReward = function () : void
            {
                isDelaySpiritEffect = true;
                ZonesControl.getInstance().reqTowerReward();
                return;
            }// end function
            ;
            var msg:* = ZonesModel.getInstance().dekaronGiftInfo;
            var cost:* = msg.golds;
            var surplus:* = msg.surplus;
            var gold:* = UserObj.getInstance().playerInfo.gold;
            if (cost > gold && surplus > 0)
            {
                MapControl.getInstance().showRechargeD();
                return;
            }
            if (this.isShowBox && cost > 0)
            {
                if (surplus > 0)
                {
                    Global.popManager.cue(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12368"), [cost]), LanguageCfgObj.getInstance().getByIndex("11635"), null, sendGetReward, null, 2, null, false, true, function () : void
            {
                isShowBox = false;
                return;
            }// end function
            );
                }
            }
            else
            {
                this.sendGetReward();
            }
            return;
        }// end function

        private function clickUpNestLevel() : void
        {
            var msgInfo:* = ZonesModel.getInstance().dekaronGiftInfo;
            if (msgInfo && msgInfo.surplus > 0 && msgInfo.golds == 0)
            {
                Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("12369"), "", null, function () : void
            {
                upNestLevel();
                return;
            }// end function
            );
            }
            else
            {
                this.upNestLevel();
            }
            return;
        }// end function

        private function upNestLevel() : void
        {
            if (!this._vmcNestRay.hasEventListener(Event.COMPLETE))
            {
                this._vmcNestRay.addEventListener(Event.COMPLETE, this.onActComplete);
            }
            this.addChild(this._vmcNestRay);
            this._vmcNestRay.loadRes("res/effect/zones/zonesray.png");
            this._vmcNestRay.auto = true;
            this._vmcNestRay.updatePose("90", false);
            return;
        }// end function

        protected function onActComplete(event:Event) : void
        {
            this._vmcNestRay.removeEventListener(Event.COMPLETE, this.onActComplete);
            this._zonesCycRoll.showOverGateEffect();
            if (this._vmcNestRay && this._vmcNestRay.parent)
            {
                this._vmcNestRay.parent.removeChild(this._vmcNestRay);
            }
            this._vmcNestSpirit.loadRes("res/effect/zones/zonesspirit.png");
            this._vmcNestSpirit.auto = true;
            this._vmcNestSpirit.updatePose("90", false);
            if (this.zonesDekaronInfo)
            {
                if (this.zonesDekaronInfo.level == 0)
                {
                    ZonesControl.getInstance().reqTowerNextLv();
                }
            }
            return;
        }// end function

        private function openDetailPanel() : void
        {
            if (this.zonesDekaronInfo && this.zonesDekaronInfo.level != 0)
            {
                this._zonesdetailPanel.openOrClose();
            }
            return;
        }// end function

        private function enterDealron() : void
        {
            ZonesControl.getInstance().reqZoneInto(-4, 0);
            return;
        }// end function

        private function freshInfo() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (!UILoaded || !this._zonesDekaronInfo)
            {
                return;
            }
            this._zonesCycRoll.currLevel = this._zonesDekaronInfo.level;
            this._zonesCycRoll.currStage = this._zonesDekaronInfo.stage;
            this._zonesCycRoll.adjustPosition();
            this._zonesCycRoll.showAllUfoEffect();
            if (this._zonesDekaronInfo.level == 0)
            {
                this._btnNestLevel.visible = true;
                this._btnEnter.visible = false;
                this._monsterNameBack.visible = false;
                this._btnDetail.visible = false;
                this._txtMonsterName.visible = false;
            }
            else
            {
                this._btnNestLevel.visible = false;
                this._btnEnter.visible = true;
                this._monsterNameBack.visible = true;
                this._btnDetail.visible = true;
                this._txtMonsterName.visible = true;
            }
            this._txtMonsterName.text = "";
            if (this.zonesDekaronInfo.level != 0)
            {
                _loc_1 = ZonesCloneCfg.getInstance().getZonesInfoFromId(this.zonesDekaronInfo.zoneId);
                if (_loc_1)
                {
                    _loc_2 = MonsterCfgObj.getInstance().getMonsterCfg(_loc_1.monster);
                    if (_loc_2)
                    {
                        this._txtMonsterName.text = _loc_2.q_name;
                    }
                }
            }
            this._imageLevel.load(Params.ZONES_LEVEL_PATH + "level_" + this._zonesDekaronInfo.stage + ".png");
            this.setSpiritInfo();
            return;
        }// end function

        public function setSpiritInfo() : void
        {
            var count:int;
            if (!this.isDelaySpiritEffect)
            {
                this._txtSpiritCount.text = LanguageCfgObj.getInstance().getByIndex("12347") + UserObj.getInstance().playerInfo.spirit.toString();
                if (this.parent)
                {
                    count;
                    new TweenLite(this._txtSpiritCount, 0.5, {onUpdate:function () : void
            {
                count = (count + 1);
                _txtSpiritCount.textColor = count % 2 == 0 ? (16711680) : (4567502);
                return;
            }// end function
            , onComplete:function () : void
            {
                _txtSpiritCount.textColor = 4567502;
                return;
            }// end function
            });
                }
            }
            return;
        }// end function

        public function setGiftInfo() : void
        {
            var _loc_5:* = null;
            var _loc_1:* = ZonesModel.getInstance().dekaronGiftInfo;
            if (!UILoaded || !_loc_1)
            {
                return;
            }
            var _loc_2:* = _loc_1.golds;
            var _loc_3:* = _loc_1.surplus;
            var _loc_4:* = _loc_1.money;
            if (_loc_2 == 0 && _loc_4 == 0)
            {
                if (_loc_3 > 0)
                {
                    this._btnGetGift.setText("");
                }
                else
                {
                    this._btnGetGift.setText("");
                }
            }
            else if (_loc_3 > 0)
            {
                _loc_5 = "";
                if (_loc_2 > 0)
                {
                    _loc_5 = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12348"), [_loc_2]);
                }
                if (_loc_4 > 0 && _loc_2 > 0)
                {
                    _loc_5 = _loc_5 + "\n";
                }
                if (_loc_4 > 0)
                {
                    _loc_5 = _loc_5 + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12349"), [int(_loc_4 / 10000)]);
                }
                this._btnGetGift.setText(_loc_5);
            }
            else
            {
                this._btnGetGift.setText(LanguageCfgObj.getInstance().getByIndex("11522"));
            }
            if (_loc_3 > 0)
            {
                if (!this._vmcGetGift)
                {
                    this._vmcGetGift = new VMCView();
                    this.addChild(this._vmcGetGift);
                    this._vmcGetGift.move(754, 430);
                    this._vmcGetGift.loadRes("res/effect/zones/zonesgetgift.png", null, true);
                    this._vmcGetGift.auto = true;
                    this._vmcGetGift.updatePose("90", true);
                }
            }
            else if (this._vmcGetGift)
            {
                this._vmcGetGift.stop();
                if (this._vmcGetGift.parent)
                {
                    this._vmcGetGift.parent.removeChild(this._vmcGetGift);
                }
                this._vmcGetGift = null;
            }
            return;
        }// end function

        public function towerReward() : void
        {
            var eff:* = new VMCView();
            this.addChild(eff);
            eff.addEventListener(VMCEvent.ACT_EFECT, function () : void
            {
                isDelaySpiritEffect = false;
                setSpiritInfo();
                return;
            }// end function
            );
            eff.loadRes("res/effect/zones/zonesgetspirit.png");
            eff.auto = true;
            eff.updatePose("90", false, false, true, true);
            eff.move(426, 437);
            return;
        }// end function

        public function get zonesDekaronInfo() : ResTowerIndexMessage
        {
            return this._zonesDekaronInfo;
        }// end function

        public function set zonesDekaronInfo(param1:ResTowerIndexMessage) : void
        {
            this._zonesDekaronInfo = param1;
            this.freshInfo();
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            if (this._zonesdetailPanel)
            {
                this._zonesdetailPanel.close();
            }
            this.guidePause(GuideConfigObj.getInstance().DEKARON_ZONE_GUIDE_ID_2);
            return;
        }// end function

        public function registerGuide() : void
        {
            GuideMultiControl.getInstance().registerGuide(this._btnEnter, this, GuideConfigObj.getInstance().DEKARON_ZONE_GUIDE_ID_2);
            return;
        }// end function

        public function guideAction(param1:String) : void
        {
            return;
        }// end function

        public function guidePause(param1:String) : void
        {
            GuideMultiControl.getInstance().backGuide(param1, 1);
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

        public function towerNestLv() : void
        {
            return;
        }// end function

    }
}
