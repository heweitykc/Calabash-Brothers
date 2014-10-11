package com.game.operationpanel.view
{
    import __AS3__.vec.*;
    import com.*;
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.events.*;
    import com.events.ui.*;
    import com.f1.*;
    import com.f1.manager.keyboard.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.events.*;
    import com.f1.ui.stripe.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.game.autopk.*;
    import com.game.autopk.controller.*;
    import com.game.backpack.control.*;
    import com.game.backpack.events.*;
    import com.game.backpack.model.*;
    import com.game.backpack.view.itemrenderers.*;
    import com.game.casting.control.*;
    import com.game.country.control.*;
    import com.game.dragonking.control.*;
    import com.game.equipstreng.control.*;
    import com.game.fight.control.*;
    import com.game.goldRaffle.control.*;
    import com.game.grandMasterPanel.control.*;
    import com.game.guide.*;
    import com.game.guide.control.*;
    import com.game.guide.event.*;
    import com.game.guide.model.*;
    import com.game.guild.control.*;
    import com.game.horse.control.*;
    import com.game.magicbook.control.*;
    import com.game.magicbook.model.*;
    import com.game.mall.control.*;
    import com.game.map.control.*;
    import com.game.map.event.*;
    import com.game.map.model.*;
    import com.game.map.view.topbtnspanel.*;
    import com.game.offline.control.*;
    import com.game.operationpanel.control.*;
    import com.game.operationpanel.event.*;
    import com.game.prey.control.*;
    import com.game.primaryrole.control.*;
    import com.game.role.util.*;
    import com.game.shortcut.bean.*;
    import com.game.shortcut.control.*;
    import com.game.shortcut.message.*;
    import com.game.signwage.control.*;
    import com.game.skill.control.*;
    import com.game.task.control.*;
    import com.game.team.control.*;
    import com.game.utils.*;
    import com.game.zones.control.*;
    import com.greensock.*;
    import com.greensock.easing.*;
    import com.manager.cd.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.ui.*;
    import interfaces.*;
    import interfaces.role.*;

    public class OperationBottomBar extends Component implements IGuide
    {
        private const SK_ZONE_UNABLED_KEY:Array;
        private var _barButtonEnable:Boolean = true;
        private var _skillChoosePanel:SkillChoosePanel;
        private var _itemChoosePanel:ItemChoosePanel;
        private var _choosePanel:ShortcutChoosePanel;
        private var addSign:BaseButton;
        private var curSelectBox:ShortcutBox;
        private var curSelectItem:ShortcutBox;
        private var curSelect:ShortcutBox;
        private var overBox:IDragItem;
        private var _masterSkillBtn:BaseButton;
        private var _magicBookBtn:BaseButton;
        private var _roleBtn:BaseButton;
        private var _backpackBtn:BaseButton;
        private var _strengthBtn:BaseButton;
        private var _skillBtn:BaseButton;
        private var _socialityBtn:BaseButton;
        private var _mallBtn:BaseButton;
        private var _teamBtn:BaseButton;
        private var _horseBtn:BaseButton;
        private var _artifactExtractBtn:BaseButton;
        private var _artifactGoldExtractRemainingTimesView:Sprite;
        private var _artifactGoldExtractRemainingTimes:int = 0;
        private var _prayCount:Sprite;
        private var _composeBtn:BaseButton;
        private var _guildBtn:BaseButton;
        private var _autoBtn:BaseButton;
        private var _prayBtn:BaseButton;
        private var _friendBtn:BaseButton;
        private var _goldRaffleBtn:BaseButton;
        private var _zhuzaoBtn:BaseButton;
        private var _skillBoxArr:Array;
        private var _blueBall:EnergyBall;
        private var _info:PlayerInfo;
        private var _redBall:EnergyBall;
        private var _expBar:Stripe;
        private var _expBarMaster:Stripe;
        private var _expBarEffect:VMCView;
        private var defaultEffect:VMCView;
        private var _expTxt:TextField;
        private var _funBtns:Array;
        private var shortBlueItem:ShortcutBox;
        private var shortRedItem:ShortcutBox;
        private var shortEItem:ShortcutBox;
        private var shortRItem:ShortcutBox;
        private var shortRBContainer:BaseSprite;
        private var _fullIcon:DisplayObject;
        private var _stallsBtn:BaseButton;
        private var flagOpenElememt:Boolean = false;
        private var _expEffectMC:VMCView;
        private var effect:VMCView;
        private const SPACE:int = 44;
        private const MAX_RIGHT:int = 805;
        private var _buttonArr:Array;
        private var _effectBtn:BaseButton;
        private var endX:int;
        private var endY:int;
        private var _moveArr:Array;
        private var dirEffectBtnArr:Array;
        private var _offExpBtn:TopActivateIcon;
        private static const SKILL_LENGTH:int = 5;
        private static const SKILL_GRID_BASEX:int = 157;
        private static const SKILL_GRID_BASEY:int = 14;
        private static var saveShortCutVo:Vector.<ShortCutInfo>;

        public function OperationBottomBar()
        {
            this.SK_ZONE_UNABLED_KEY = [Keyboard.C, Keyboard.B, Keyboard.G, Keyboard.T, Keyboard.M];
            this._info = UserObj.getInstance().playerInfo;
            this._funBtns = new Array();
            this.dirEffectBtnArr = [];
            setWH(974, 87.5);
            loadDisplay("res/mainbottombar.swf");
            return;
        }// end function

        public function get prayBtn() : BaseButton
        {
            return this._prayBtn;
        }// end function

        override protected function displayReady() : void
        {
            initComponentUI("mainBottomBar");
            this.initUI();
            this.updateUI();
            this.addListener();
            super.displayReady();
            this.creatChoosePanel();
            this.initBaseData();
            this._buttonArr = [this._horseBtn, this._artifactExtractBtn, this._magicBookBtn, this._composeBtn, this._prayBtn, this._teamBtn, this._masterSkillBtn];
            this.guideConfigComplete();
            this.checkBackpackFull();
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_1:* = null;
            this._masterSkillBtn = new BaseButton(getDisplayChildByName("mc_masterSkill"), true);
            this._masterSkillBtn.visible = this._info && RoleLevelUtil.isMasterLevel(this._info.level);
            this._magicBookBtn = new BaseButton(getDisplayChildByName("mc_magicBook"));
            this._roleBtn = new BaseButton(getDisplayChildByName("mc_role"), true);
            this._backpackBtn = new BaseButton(getDisplayChildByName("mc_backpack"), true);
            this._strengthBtn = new BaseButton(getDisplayChildByName("mc_equipStrength"), true);
            this._skillBtn = new BaseButton(getDisplayChildByName("mc_skill"), true);
            this._socialityBtn = new BaseButton(getDisplayChildByName("mc_sociality"), true);
            this._mallBtn = new BaseButton(getDisplayChildByName("mc_mall"), true);
            this.addSign = new BaseButton(getDisplayChildByName("addedSign"));
            this._teamBtn = new BaseButton(getDisplayChildByName("mc_team"));
            this._horseBtn = new BaseButton(getDisplayChildByName("mc_horse"));
            this._artifactExtractBtn = new BaseButton(getDisplayChildByName("mc_artifactExtract"));
            this._composeBtn = new BaseButton(getDisplayChildByName("mc_compose"));
            this._guildBtn = new BaseButton(getDisplayChildByName("guildBtn"));
            this._guildBtn.visible = false;
            this._friendBtn = new BaseButton(getDisplayChildByName("mc_friend"));
            this._prayBtn = new BaseButton(getDisplayChildByName("mc_pray"));
            this._prayBtn.obj = TopActivateCfgObj.getInstance().getButtonSortId("mc_pray");
            this._goldRaffleBtn = new BaseButton(getDisplayChildByName("goldRaffleBtn"));
            this._zhuzaoBtn = new BaseButton(getDisplayChildByName("zhuzaoBtn"));
            this._funBtns = [this._roleBtn, this._backpackBtn, this._strengthBtn, this._skillBtn, this._socialityBtn, this._mallBtn, this.addSign, this._teamBtn, this._horseBtn, this._artifactExtractBtn, this._magicBookBtn, this._composeBtn, this._autoBtn, this._friendBtn, this._prayBtn, this._goldRaffleBtn, this._zhuzaoBtn];
            this._stallsBtn = new BaseButton(getDisplayChildByName("stallsbtn"));
            this._prayCount = this._prayBtn.getDisplayChildByName("praynum") as Sprite;
            this._prayCount.mouseEnabled = false;
            this._prayCount.visible = false;
            this._artifactGoldExtractRemainingTimesView = this._artifactExtractBtn.getDisplayChildByName("viewGoldExtractRemainingTimes") as Sprite;
            this._artifactGoldExtractRemainingTimesView.mouseEnabled = false;
            this.setGoldExtractRemainingTimes(this._artifactGoldExtractRemainingTimes);
            this._fullIcon = this._backpackBtn.getDisplayChildByName("full_icon");
            this._offExpBtn = new TopActivateIcon(TopActivateName.TOP_ICON_RETURN_EXP);
            PrayControl.getInstance().reqPrayInfo();
            this.addSign.visible = false;
            this._skillBoxArr = [];
            this.addTips();
            this._expBar = new Stripe(getDisplayChildByName("exp_strip_mc"));
            this._expBarMaster = new Stripe(getDisplayChildByName("exp_strip_mc_master"));
            this._expBar.mouseEnabled = true;
            this._expBarMaster.mouseEnabled = true;
            this._expBar.isOnlyIncrease = true;
            this._expBarMaster.isOnlyIncrease = true;
            this._blueBall = new EnergyBall(getDisplayChildByName("blue"));
            this._blueBall.type = 2;
            this._redBall = new EnergyBall(getDisplayChildByName("red"));
            this._redBall.type = 1;
            this.shortRBContainer = new BaseSprite();
            var _loc_2:* = 0;
            while (_loc_2 < SKILL_LENGTH)
            {
                
                _loc_1 = new ShortcutBox("skillBoxBackBmp");
                this.addChild(_loc_1);
                _loc_1.isNum = true;
                _loc_1.setNum(((_loc_2 + 1)).toString());
                _loc_1.gridId = _loc_2 + 1;
                _loc_1.move(SKILL_GRID_BASEX + (_loc_1.width - 3) * _loc_2, SKILL_GRID_BASEY);
                _loc_1.canDrag = true;
                _loc_1.accpetKey = [Params.ITEM_PLACE_BACKPACK, Params.ITEM_PLACE_SHORTCUT_AREA];
                _loc_1.place = Params.ITEM_PLACE_SHORTCUT_AREA;
                this._skillBoxArr.push(_loc_1);
                _loc_2++;
            }
            this.shortRedItem = new ShortcutBox("skillBoxBackSubBmp");
            this.shortBlueItem = new ShortcutBox("skillBoxBackSubBmp");
            this.shortEItem = new ShortcutBox("skillBoxBackSubBmp");
            this.shortRItem = new ShortcutBox("skillBoxBackSubBmp");
            this.shortRBContainer.addChild(this.shortRedItem);
            this.shortRBContainer.addChild(this.shortBlueItem);
            this.shortRBContainer.addChild(this.shortEItem);
            this.shortRBContainer.addChild(this.shortRItem);
            this.shortBlueItem.x = this.shortBlueItem.width + 3;
            this.shortEItem.x = this.shortBlueItem.x + this.shortBlueItem.width + 3;
            this.shortRItem.x = this.shortEItem.x + this.shortEItem.width + 3;
            this.shortRedItem.accpetKey = [Params.ITEM_PLACE_BACKPACK, Params.ITEM_PLACE_SHORTCUT_AREA];
            this.shortBlueItem.accpetKey = [Params.ITEM_PLACE_BACKPACK, Params.ITEM_PLACE_SHORTCUT_AREA];
            this.shortEItem.accpetKey = [Params.ITEM_PLACE_BACKPACK, Params.ITEM_PLACE_SHORTCUT_AREA];
            this.shortRItem.accpetKey = [Params.ITEM_PLACE_BACKPACK, Params.ITEM_PLACE_SHORTCUT_AREA];
            this.shortRedItem.place = Params.ITEM_PLACE_SHORTCUT_AREA;
            this.shortBlueItem.place = Params.ITEM_PLACE_SHORTCUT_AREA;
            this.shortEItem.place = Params.ITEM_PLACE_SHORTCUT_AREA;
            this.shortRItem.place = Params.ITEM_PLACE_SHORTCUT_AREA;
            this.shortRedItem.gridId = 6;
            this.shortBlueItem.gridId = 7;
            this.shortEItem.gridId = 8;
            this.shortRItem.gridId = 9;
            this.shortRedItem.isNum = true;
            this.shortBlueItem.isNum = true;
            this.shortEItem.isNum = true;
            this.shortRItem.isNum = true;
            this.shortRedItem.setNum("Q");
            this.shortBlueItem.setNum("W");
            this.shortEItem.setNum("E");
            this.shortRItem.setNum("R");
            this.shortRedItem.isMenu = false;
            this.shortBlueItem.isMenu = false;
            this.shortEItem.isMenu = false;
            this.shortRItem.isMenu = false;
            var _loc_3:* = true;
            this.shortRItem.canDrag = true;
            this.shortEItem.canDrag = _loc_3;
            this.shortBlueItem.canDrag = _loc_3;
            this.shortRedItem.canDrag = _loc_3;
            this._skillBoxArr.push(this.shortRedItem);
            this._skillBoxArr.push(this.shortBlueItem);
            this._skillBoxArr.push(this.shortEItem);
            this._skillBoxArr.push(this.shortRItem);
            this.shortRBContainer.move(220, -47);
            this.addChild(this.shortRBContainer);
            this.registerGuide();
            return;
        }// end function

        private function initBaseData() : void
        {
            OperationPanelControl.getInstance().freshShortCutView();
            return;
        }// end function

        private function updateUI() : void
        {
            this.setHP(this._info.HP, this._info.HPMax);
            this.setEP(this._info.MP, this._info.MPMax);
            this.__updateExp();
            this.updataMagicBookBtn();
            return;
        }// end function

        private function addTips() : void
        {
            StringTip.create(this._masterSkillBtn, LanguageCfgObj.getInstance().getByIndex("OperationBottomBar_1406087058") + LanguageCfgObj.getInstance().getByIndex("OperationBottomBar_1406087073"));
            StringTip.create(this._roleBtn, LanguageCfgObj.getInstance().getByIndex("12133") + LanguageCfgObj.getInstance().getByIndex("10979"));
            StringTip.create(this._backpackBtn, LanguageCfgObj.getInstance().getByIndex("12134") + LanguageCfgObj.getInstance().getByIndex("10980"));
            StringTip.create(this._strengthBtn, LanguageCfgObj.getInstance().getByIndex("12135") + LanguageCfgObj.getInstance().getByIndex("10981"));
            StringTip.create(this._skillBtn, LanguageCfgObj.getInstance().getByIndex("12136") + LanguageCfgObj.getInstance().getByIndex("10982"));
            StringTip.create(this._socialityBtn, LanguageCfgObj.getInstance().getByIndex("12137") + LanguageCfgObj.getInstance().getByIndex("10983"));
            StringTip.create(this._mallBtn, LanguageCfgObj.getInstance().getByIndex("12138") + LanguageCfgObj.getInstance().getByIndex("12139") + LanguageCfgObj.getInstance().getByIndex("10984"));
            StringTip.create(this.addSign, "");
            StringTip.create(this._stallsBtn, LanguageCfgObj.getInstance().getByIndex("10985"));
            StringTip.create(this._teamBtn, LanguageCfgObj.getInstance().getByIndex("12140") + LanguageCfgObj.getInstance().getByIndex("10986"));
            StringTip.create(this._horseBtn, LanguageCfgObj.getInstance().getByIndex("12141") + LanguageCfgObj.getInstance().getByIndex("10987"));
            StringTip.create(this._artifactExtractBtn, LanguageCfgObj.getInstance().getByIndex("12142") + LanguageCfgObj.getInstance().getByIndex("10988"));
            StringTip.create(this._magicBookBtn, LanguageCfgObj.getInstance().getByIndex("10020", MagicBookControl.MAGICBOOK_LANG));
            StringTip.create(this._composeBtn, LanguageCfgObj.getInstance().getByIndex("12143") + LanguageCfgObj.getInstance().getByIndex("10989"));
            StringTip.create(this._autoBtn, LanguageCfgObj.getInstance().getByIndex("12144") + LanguageCfgObj.getInstance().getByIndex("10990"));
            StringTip.create(this._friendBtn, LanguageCfgObj.getInstance().getByIndex("12145") + LanguageCfgObj.getInstance().getByIndex("10991"));
            StringTip.create(this._prayBtn, LanguageCfgObj.getInstance().getByIndex("12146") + LanguageCfgObj.getInstance().getByIndex("10992"));
            StringTip.create(this._zhuzaoBtn, LanguageCfgObj.getInstance().getByIndex("12147") + LanguageCfgObj.getInstance().getByIndex("10993"));
            StringTip.create(this._goldRaffleBtn, LanguageCfgObj.getInstance().getByIndex("12148") + LanguageCfgObj.getInstance().getByIndex("10994"));
            return;
        }// end function

        private function addListener() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this._masterSkillBtn.addEvtListener(MouseEvent.CLICK, this.__operClick);
            this._roleBtn.addEvtListener(MouseEvent.CLICK, this.__operClick);
            this._backpackBtn.addEvtListener(MouseEvent.CLICK, this.__operClick);
            this._strengthBtn.addEvtListener(MouseEvent.CLICK, this.__operClick);
            this._skillBtn.addEvtListener(MouseEvent.CLICK, this.__operClick);
            this._socialityBtn.addEvtListener(MouseEvent.CLICK, this.__operClick);
            this._teamBtn.addEvtListener(MouseEvent.CLICK, this.__operClick);
            this._mallBtn.addEvtListener(MouseEvent.CLICK, this.__operClick);
            this._prayBtn.addEvtListener(MouseEvent.CLICK, this.__operClick);
            this._friendBtn.addEvtListener(MouseEvent.CLICK, this.__operClick);
            this._horseBtn.addEvtListener(MouseEvent.CLICK, this.__operClick);
            this._artifactExtractBtn.addEvtListener(MouseEvent.CLICK, this.__operClick);
            this._magicBookBtn.addEvtListener(MouseEvent.CLICK, this.__operClick);
            this._composeBtn.addEvtListener(MouseEvent.CLICK, this.__operClick);
            this._guildBtn.addEvtListener(MouseEvent.CLICK, this.__operClick);
            this._zhuzaoBtn.addEvtListener(MouseEvent.CLICK, this.__operClick);
            this._goldRaffleBtn.addEvtListener(MouseEvent.CLICK, this.__operClick);
            this._stallsBtn.addEvtListener(MouseEvent.CLICK, this.__operClick);
            this._info.addEvtListener(RoleEvent.UPDATE_BECOME, this.__become);
            this._offExpBtn.addEvtListener(MouseEvent.CLICK, this.__operClick);
            FrameworkGlobal.stageAddEvtListener(MouseEvent.CLICK, this.mouseClickHandler);
            var _loc_1:* = 0;
            while (_loc_1 < this._skillBoxArr.length)
            {
                
                (this._skillBoxArr[_loc_1] as ShortcutBox).addEvtListener(MouseEvent.CLICK, this.__shortcutClick);
                (this._skillBoxArr[_loc_1] as ShortcutBox).addEvtListener("rightClick", this.__shortcutRightClick);
                (this._skillBoxArr[_loc_1] as ShortcutBox).addEvtListener(MouseEvent.MOUSE_OVER, this.__skillOver);
                (this._skillBoxArr[_loc_1] as ShortcutBox).addEvtListener(MouseEvent.MOUSE_OUT, this.__skillout);
                _loc_1++;
            }
            this._info.addEvtListener(RoleEvent.UPDATE_HPMAX, this.__updateHPMax);
            this._info.addEvtListener(RoleEvent.UPDATE_MPMAX, this.__updateEPMax);
            this._info.addEvtListener(RoleEvent.UPDATE_HP, this.__updateHP);
            this._info.addEvtListener(RoleEvent.UPDATE_MP, this.__updateEP);
            this._info.addEvtListener(RoleEvent.UPDATE_EXP, this.__updateExp);
            this._info.addEvtListener(RoleEvent.UPDATE_LEVEL, this.__updateLevel);
            BackpackObj.getInstance().addEvtListener(BackpackEvent.BOX_FULL, this.checkBackpackFull);
            this.addSign.addEvtListener(MouseEvent.CLICK, this.__addSignClick);
            OperationDispatch.dispatch().addEventListener(OperationEvent.SKILL_BOX_MOVE, this.moveSkillBoxHandler);
            OperationDispatch.dispatch().addEventListener(OperationEvent.SKILL_BOX_REMOVE, this.removeSkillBoxHandler);
            FrameworkGlobal.addMsgListen(GameEvent.CD_CHANGE, this.__cdChange);
            FrameworkGlobal.addMsgListen(WndCloseEvt.CLOSE, this.__wndClose);
            this.listenKeyDown();
            this.listenKeyDown2();
            KeyboardManager.addEventListener(KeyboardEvent.KEY_UP, this.__keyUpHandler);
            BackpackObj.getInstance().addEventListener(BackpackEvent.GOODS_CHANGE, this.onGoodsChange);
            for each (_loc_2 in this._info.buffs)
            {
                
                _loc_3 = new RoleEvent(RoleEvent.UPDATE_BUFF);
                _loc_3.obj = {op:"AU", t:_loc_2.q_buff_id};
                this._info.dispatchEvent(_loc_3);
            }
            UserObj.getInstance().playerInfo.addEvtListener(RoleEvent.UPDATE_OFFLINE_EXP, this.__updateOfflineExp);
            UserObj.getInstance().playerInfo.dispatchEvt(new RoleEvent(RoleEvent.UPDATE_OFFLINE_EXP));
            GuideConfigObj.getInstance().addEventListener(GuideEvent.GUIDE_ACTIVE_CONFIG_COMPLETE, this.guideConfigComplete);
            FrameworkGlobal.addMsgListen(MapEvent.MAP_CHANGE, this.onChangeMapHandler);
            addEvtListener(MouseEvent.CLICK, this.barClickHandler);
            return;
        }// end function

        private function updataMagicBookBtn() : void
        {
            if (MagicBookData.canOpenPanel())
            {
                this._magicBookBtn.visible = true;
            }
            else
            {
                this._magicBookBtn.visible = false;
            }
            return;
        }// end function

        private function barClickHandler(event:Event) : void
        {
            ToolKit.bringToTop(this);
            return;
        }// end function

        private function onChangeMapHandler(event:Event) : void
        {
            var _loc_2:* = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID);
            if (_loc_2.mapZones > 0 && _loc_2.zones_type == ZoneType.ZONES_RED_FORTRESS)
            {
                this.setZonesRedfortressSkill();
            }
            else
            {
                this.reSetZonesRedfortressSkill();
            }
            return;
        }// end function

        private function checkBackpackFull(event:BackpackEvent = null) : void
        {
            this._fullIcon.visible = BackpackObj.getInstance().isFullForCount;
            return;
        }// end function

        protected function onGoodsChange(event:BackpackEvent) : void
        {
            var _loc_4:* = 0;
            var _loc_2:* = event.data as PropInfo;
            var _loc_3:* = this.hasGoodsAll(_loc_2);
            if (_loc_3)
            {
                _loc_3.info = BackpackObj.getInstance().getItemByItemModelId(_loc_2.q_id);
                _loc_3.countSpecific(BackpackObj.getInstance().getItemCount(_loc_2.q_id));
            }
            else
            {
                _loc_4 = this.getGoodsItemEmpty(_loc_2);
                if (_loc_4 > 0)
                {
                    this.setDefaultGoods(_loc_4);
                }
            }
            return;
        }// end function

        private function hasGoods(param1:PropInfo) : ShortcutBox
        {
            if (param1)
            {
                if (this.shortBlueItem && this.shortBlueItem.info && this.shortBlueItem.info is PropInfo)
                {
                    if (PropInfo(this.shortBlueItem.info).itemModelId == param1.itemModelId)
                    {
                        return this.shortBlueItem;
                    }
                }
                if (this.shortRedItem && this.shortRedItem.info && this.shortRedItem.info is PropInfo)
                {
                    if (PropInfo(this.shortRedItem.info).itemModelId == param1.itemModelId)
                    {
                        return this.shortRedItem;
                    }
                }
            }
            return null;
        }// end function

        private function hasGoodsAll(param1:PropInfo) : ShortcutBox
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            if (param1)
            {
                _loc_2 = this._skillBoxArr.length;
                _loc_3 = 0;
                while (_loc_3 < _loc_2)
                {
                    
                    _loc_4 = this._skillBoxArr[_loc_3];
                    if (_loc_4 && _loc_4.info)
                    {
                        if (_loc_4.info is PropInfo)
                        {
                            if (PropInfo(_loc_4.info).itemModelId == param1.itemModelId)
                            {
                                return _loc_4;
                            }
                        }
                    }
                    _loc_3++;
                }
            }
            return null;
        }// end function

        private function getGoodsItemEmpty(param1:PropInfo) : int
        {
            var _loc_2:* = param1.q_effict_type.search("1");
            if (_loc_2 != -1)
            {
                if (this.shortRedItem && !this.shortRedItem.info)
                {
                    return 1;
                }
                return 0;
            }
            _loc_2 = param1.q_effict_type.search("2");
            if (_loc_2 != -1)
            {
                if (this.shortBlueItem && !this.shortBlueItem.info)
                {
                    return 2;
                }
                return 0;
            }
            return 2;
        }// end function

        private function __wndClose(param1:WndCloseEvt) : void
        {
            switch(param1.wnd)
            {
                case "com.game.grandMasterPanel.view::GrandMasterPanel":
                {
                    this._masterSkillBtn.selected = false;
                    break;
                }
                case "com.game.backpack.view::BackPackPanel":
                {
                    this._backpackBtn.selected = false;
                    break;
                }
                case "com.game.primaryrole.view::PrimaryRoleMainPanel":
                {
                    this._roleBtn.selected = false;
                    break;
                }
                case "com.game.equipstreng.view::EquipForgeBox":
                {
                    this._strengthBtn.selected = false;
                    break;
                }
                case "com.game.mall.view::MallPanel":
                {
                    this._mallBtn.selected = false;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function __backpackClose(event:BoxEvent) : void
        {
            if (event.showOrHide == 0)
            {
                this._backpackBtn.selected = false;
            }
            return;
        }// end function

        private function moveSkillBoxHandler(event:OperationEvent) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_2:* = event.data;
            if (_loc_2.item && _loc_2.item.info)
            {
                if (_loc_2.item.info is SkillInfo)
                {
                    _loc_4 = ShortcutBox(_loc_2.item).info.shortcutId;
                    _loc_3 = ShortcutBox(_loc_2.targetItem).gridId;
                    ShortcutControl.getInstance().moveShortCutHandle(_loc_3, _loc_4);
                }
                else
                {
                    _loc_5 = _loc_2.item as Itemrenderer;
                    if (!PropInfo(_loc_5.info).q_shortcut)
                    {
                        return;
                    }
                    _loc_6 = PropInfo(_loc_5.info).itemId;
                    _loc_7 = _loc_2.targetItem as ShortcutBox;
                    _loc_3 = _loc_7.gridId;
                    _loc_8 = new AddShortCutMessage();
                    ShortcutControl.getInstance().addShortCutHandle(_loc_3, _loc_6, PropInfo(_loc_5.info).itemModelId, 1);
                }
            }
            return;
        }// end function

        private function removeSkillBoxHandler(event:OperationEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (event.data is SkillInfo)
            {
                _loc_2 = event.data;
                if (_loc_2 && _loc_2.shortcutId)
                {
                    ShortcutControl.getInstance().removeShortCutHandle(_loc_2.shortcutId);
                }
            }
            else
            {
                _loc_3 = event.data;
                if (_loc_3 && _loc_3.shortcutId)
                {
                    ShortcutControl.getInstance().removeShortCutHandle(_loc_3.shortcutId);
                }
            }
            return;
        }// end function

        private function __cdChange(event:GameEvent) : void
        {
            this.freshCD();
            return;
        }// end function

        private function freshCD() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_1:* = this._skillBoxArr.length;
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = this._skillBoxArr[_loc_2];
                if (_loc_3 && _loc_3.info)
                {
                    if (_loc_3.info is SkillInfo)
                    {
                        _loc_4 = CDManager.getInstance().getCD(CDTypes.SKILL, _loc_3.info.q_skillID, _loc_3.info.q_public_cd_level);
                        _loc_3.setCD(_loc_4[0], _loc_4[1]);
                    }
                    else
                    {
                        _loc_4 = CDManager.getInstance().getCD(CDTypes.DRUG, _loc_3.info.itemModelId, _loc_3.info.q_cooldown_level);
                        _loc_3.setCD(_loc_4[0], _loc_4[1]);
                    }
                }
                _loc_2++;
            }
            return;
        }// end function

        public function getPrayTimes() : int
        {
            if (this._prayCount)
            {
                return int((this._prayCount.getChildByName("txt") as TextField).text);
            }
            return 0;
        }// end function

        private function __updateHPMax(event:RoleEvent) : void
        {
            this.setHP(this._info.HP, this._info.HPMax);
            return;
        }// end function

        private function __updateEPMax(event:RoleEvent) : void
        {
            this.setEP(this._info.MP, this._info.MPMax);
            return;
        }// end function

        private function __updateExp(event:RoleEvent = null) : void
        {
            var _loc_2:* = ExpEffectCfgObj.getInstance().getExpEffectValue(this._info.level);
            if (event && event.obj >= _loc_2)
            {
                this.playExpEffect();
                TweenLite.delayedCall(1, this.updateExp);
            }
            else if (event && event.obj < 0)
            {
                this.updateExpNomorl(true);
            }
            else
            {
                this.updateExpNomorl();
            }
            return;
        }// end function

        private function __updateLevel(event:RoleEvent) : void
        {
            var _loc_2:* = false;
            if (RoleLevelUtil.isMasterLevel(this._info.level))
            {
                this._expBar.visible = false;
                this.setExpBarMasterVisible(true);
                this._masterSkillBtn.visible = true;
                _loc_2 = RoleLevelUtil.isMasterLevel(event.obj.pre);
                if (!_loc_2)
                {
                    this.flagOpenElememt = true;
                    ButtonFlickerControl.getInstance().addButtonFlicker(this._roleBtn);
                    GuideMultiControl.getInstance().beginGuide(int(GuideConfigObj.getInstance().MASTER_SKILL_TEM));
                }
            }
            else
            {
                this._expBar.visible = true;
                this.setExpBarMasterVisible(false);
                this._masterSkillBtn.visible = false;
            }
            this.updataMagicBookBtn();
            return;
        }// end function

        private function setExpBarMasterVisible(param1:Boolean) : void
        {
            if (param1)
            {
                if (!this._expBarEffect)
                {
                    this._expBarEffect = new VMCView();
                    this._expBarEffect.move(490, 80);
                    this._expBarEffect.auto = true;
                    this._expBarEffect.updatePose("90", true);
                    this.addChild(this._expBarEffect);
                }
                this._expBarEffect.loadRes("res/effect/bigmaster/master_exp_bottom.png", null, true);
            }
            this._expBarMaster.visible = param1;
            return;
        }// end function

        private function updateExpNomorl(param1:Boolean = false) : void
        {
            var _loc_4:* = null;
            if (this._info.exp == null)
            {
                return;
            }
            var _loc_2:* = this._info.exp.toNumber();
            if (RoleLevelUtil.isMasterLevel(this._info.level))
            {
                this.setExpBarMasterVisible(true);
                this._expBar.visible = false;
            }
            else
            {
                this.setExpBarMasterVisible(false);
                this._expBar.visible = true;
            }
            var _loc_3:* = LevelExpCfgObj.getInstance().getExpByLevel(UserObj.getInstance().playerInfo.job, this._info.level);
            if (_loc_3 > this._expBar.maxValue)
            {
                this._expBar.setValue(this._expBar.maxValue, this._expBar.maxValue, true, "", true, this.callReachMaxBackNomorl);
                this._expBarMaster.setValue(this._expBarMaster.maxValue, this._expBarMaster.maxValue, true, "", true, this.callReachMaxBackNomorl);
            }
            else
            {
                this._expBar.setValue(_loc_2, _loc_3, true, "", true, null, param1);
                this._expBarMaster.setValue(_loc_2, _loc_3, true, "", true, null, param1);
                StringTip.create(this._expBar, "<font color=\'#ffffff\'>" + LanguageCfgObj.getInstance().getByIndex("11821") + _loc_2 + "/" + _loc_3 + "</font><font color=\'#3cff00\'>（" + (_loc_2 / _loc_3 * 100).toFixed(2) + "%）</font>");
                StringTip.create(this._expBarMaster, "<font color=\'#ffffff\'>" + LanguageCfgObj.getInstance().getByIndex("11821") + _loc_2 + "/" + _loc_3 + "</font><font color=\'#3cff00\'>（" + (_loc_2 / _loc_3 * 100).toFixed(2) + "%）</font>");
            }
            if (_loc_2 >= _loc_3 && UserObj.getInstance().playerInfo.level == Params.MASTER_CHANGE_LEVEL)
            {
                this.playFullExpEffect();
                _loc_4 = "<font color=\'#ffffff\'>" + LanguageCfgObj.getInstance().getByIndex("11821") + _loc_2 + "/" + _loc_3 + "</font><font color=\'#3cff00\'>（" + (_loc_2 / _loc_3 * 100).toFixed(2) + "%）</font>" + LanguageCfgObj.getInstance().getByIndex("10015", "lang_changejob");
                StringTip.create(this._expBar, _loc_4);
                StringTip.create(this._expBarMaster, _loc_4);
            }
            else
            {
                this.removeFullExpEffect();
            }
            return;
        }// end function

        private function updateExp() : void
        {
            var _loc_3:* = null;
            if (this._info.exp == null)
            {
                return;
            }
            var _loc_1:* = this._info.exp.toNumber();
            var _loc_2:* = LevelExpCfgObj.getInstance().getExpByLevel(UserObj.getInstance().playerInfo.job, this._info.level);
            if (_loc_2 > this._expBar.maxValue)
            {
                this._expBar.setValue(this._expBar.maxValue, this._expBar.maxValue, true, "", true, this.callReachMaxBack);
                this._expBarMaster.setValue(this._expBarMaster.maxValue, this._expBarMaster.maxValue, true, "", true, this.callReachMaxBack);
            }
            else
            {
                this._expBar.setValue(_loc_1, _loc_2, true, "", true, this.expFilter);
                this._expBarMaster.setValue(_loc_1, _loc_2, true, "", true, this.expFilter);
                StringTip.create(this._expBar, "<font color=\'#ffffff\'>" + LanguageCfgObj.getInstance().getByIndex("11821") + _loc_1 + "/" + _loc_2 + "</font><font color=\'#3cff00\'>（" + (_loc_1 / _loc_2 * 100).toFixed(2) + "%）</font>");
                StringTip.create(this._expBarMaster, "<font color=\'#ffffff\'>" + LanguageCfgObj.getInstance().getByIndex("11821") + _loc_1 + "/" + _loc_2 + "</font><font color=\'#3cff00\'>（" + (_loc_1 / _loc_2 * 100).toFixed(2) + "%）</font>");
            }
            if (_loc_1 >= _loc_2 && UserObj.getInstance().playerInfo.level == Params.MASTER_CHANGE_LEVEL)
            {
                this.playFullExpEffect();
                _loc_3 = "<font color=\'#ffffff\'>" + LanguageCfgObj.getInstance().getByIndex("11821") + _loc_1 + "/" + _loc_2 + "</font><font color=\'#3cff00\'>（" + (_loc_1 / _loc_2 * 100).toFixed(2) + "%）</font>" + LanguageCfgObj.getInstance().getByIndex("10015", "lang_changejob");
                StringTip.create(this._expBar, _loc_3);
                StringTip.create(this._expBarMaster, _loc_3);
            }
            else
            {
                this.removeFullExpEffect();
            }
            return;
        }// end function

        private function expFilter() : void
        {
            if (RoleLevelUtil.isMasterLevel(this._info.level))
            {
                ButtonFlickerControl.getInstance().addButtonFlicker(this._expBarMaster.stripe);
            }
            else
            {
                ButtonFlickerControl.getInstance().addButtonFlicker(this._expBar.stripe);
            }
            TweenLite.delayedCall(1, this.removeEffect);
            return;
        }// end function

        private function playExpEffect() : void
        {
            if (this._expEffectMC == null)
            {
                this._expEffectMC = new VMCView();
                this._expEffectMC.auto = true;
            }
            this._expEffectMC.loadRes("res/effect/expEffect.png");
            this._expEffectMC.updatePose("90", false, true, true);
            this._expEffectMC.replay();
            this._expEffectMC.move(this._expBar.x + this._expBar.currentStripeWidth + 5, this._expBar.y + 25);
            if (!this._expEffectMC.parent)
            {
                this.addChild(this._expEffectMC);
            }
            return;
        }// end function

        private function removeEffect() : void
        {
            if (RoleLevelUtil.isMasterLevel(this._info.level))
            {
                ButtonFlickerControl.getInstance().removeButtonFlicker(this._expBarMaster.stripe);
            }
            else
            {
                ButtonFlickerControl.getInstance().removeButtonFlicker(this._expBar.stripe);
            }
            return;
        }// end function

        private function callReachMaxBack() : void
        {
            var _loc_3:* = null;
            var _loc_1:* = this._info.exp.toNumber();
            var _loc_2:* = LevelExpCfgObj.getInstance().getExpByLevel(this._info.job, this._info.level);
            this._expBar.setValue(0, _loc_2);
            this._expBarMaster.setValue(0, _loc_2);
            this._expBar.setValue(_loc_1, _loc_2, true, "", true, this.expFilter);
            this._expBarMaster.setValue(_loc_1, _loc_2, true, "", true, this.expFilter);
            if (_loc_1 >= _loc_2 && UserObj.getInstance().playerInfo.level == Params.MASTER_CHANGE_LEVEL)
            {
                _loc_3 = "<font color=\'#ffffff\'>" + LanguageCfgObj.getInstance().getByIndex("11821") + _loc_1 + "/" + _loc_2 + "</font><font color=\'#3cff00\'>（" + (_loc_1 / _loc_2 * 100).toFixed(2) + "%）</font>" + LanguageCfgObj.getInstance().getByIndex("10015", "lang_changejob");
                StringTip.create(this._expBar, _loc_3);
                StringTip.create(this._expBarMaster, _loc_3);
            }
            else
            {
                StringTip.create(this._expBar, "<font color=\'#ffffff\'>" + LanguageCfgObj.getInstance().getByIndex("11821") + _loc_1 + "/" + _loc_2 + "</font><font color=\'#3cff00\'>（" + (_loc_1 / _loc_2 * 100).toFixed(2) + "%）</font>");
                StringTip.create(this._expBarMaster, "<font color=\'#ffffff\'>" + LanguageCfgObj.getInstance().getByIndex("11821") + _loc_1 + "/" + _loc_2 + "</font><font color=\'#3cff00\'>（" + (_loc_1 / _loc_2 * 100).toFixed(2) + "%）</font>");
            }
            return;
        }// end function

        private function callReachMaxBackNomorl() : void
        {
            var _loc_3:* = null;
            var _loc_1:* = this._info.exp.toNumber();
            var _loc_2:* = LevelExpCfgObj.getInstance().getExpByLevel(this._info.job, this._info.level);
            this._expBar.setValue(0, _loc_2);
            this._expBarMaster.setValue(0, _loc_2);
            this._expBar.setValue(_loc_1, _loc_2, true, "", true);
            this._expBarMaster.setValue(_loc_1, _loc_2, true, "", true);
            if (_loc_1 >= _loc_2 && UserObj.getInstance().playerInfo.level == Params.MASTER_CHANGE_LEVEL)
            {
                _loc_3 = "<font color=\'#ffffff\'>" + LanguageCfgObj.getInstance().getByIndex("11821") + _loc_1 + "/" + _loc_2 + "</font><font color=\'#3cff00\'>（" + (_loc_1 / _loc_2 * 100).toFixed(2) + "%）</font>" + LanguageCfgObj.getInstance().getByIndex("10015", "lang_changejob");
                StringTip.create(this._expBar, _loc_3);
                StringTip.create(this._expBarMaster, _loc_3);
            }
            else
            {
                StringTip.create(this._expBar, "<font color=\'#ffffff\'>" + LanguageCfgObj.getInstance().getByIndex("11821") + _loc_1 + "/" + _loc_2 + "</font><font color=\'#3cff00\'>（" + (_loc_1 / _loc_2 * 100).toFixed(2) + "%）</font>");
                StringTip.create(this._expBarMaster, "<font color=\'#ffffff\'>" + LanguageCfgObj.getInstance().getByIndex("11821") + _loc_1 + "/" + _loc_2 + "</font><font color=\'#3cff00\'>（" + (_loc_1 / _loc_2 * 100).toFixed(2) + "%）</font>");
            }
            return;
        }// end function

        private function playFullExpEffect() : void
        {
            if (this.effect == null)
            {
                this.effect = new VMCView();
            }
            this.effect.auto = true;
            this.effect.loadRes("res/effect/changejob/expeffect.png", null, true);
            this.effect.updatePose("90", true);
            this.effect.replay();
            this.effect.move(this._expBar.x + 310, this._expBar.y + 30);
            this.addChild(this.effect);
            return;
        }// end function

        private function removeFullExpEffect() : void
        {
            if (this.effect)
            {
                this.effect.removeFromParent(true);
            }
            return;
        }// end function

        private function __updateHP(event:RoleEvent) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            this.setHP(this._info.HP, this._info.HPMax);
            if (this._info.HP / this._info.HPMax < 0.5)
            {
                _loc_2 = ItemConst.HPMEDICINE.length;
                _loc_4 = 0;
                while (_loc_4 < _loc_2)
                {
                    
                    _loc_3 = _loc_3 + BackpackObj.getInstance().getItemCount(ItemConst.HPMEDICINE[_loc_4]);
                    if (_loc_3 > 0)
                    {
                        return;
                    }
                    _loc_4++;
                }
                if (_loc_3 == 0)
                {
                    FunGuideControl.getInstance().addGuide(FunGuideControl.getInstance().SELF_SHOP);
                }
            }
            return;
        }// end function

        private function __updateEP(event:RoleEvent) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            this.setEP(this._info.MP, this._info.MPMax);
            if (this._info.MP / this._info.MPMax < 0.5)
            {
                _loc_2 = ItemConst.EPMEDICINE.length;
                _loc_4 = 0;
                while (_loc_4 < _loc_2)
                {
                    
                    _loc_3 = _loc_3 + BackpackObj.getInstance().getItemCount(ItemConst.EPMEDICINE[_loc_4]);
                    if (_loc_3 > 0)
                    {
                        return;
                    }
                    _loc_4++;
                }
                if (_loc_3 == 0)
                {
                    FunGuideControl.getInstance().addGuide(FunGuideControl.getInstance().SELF_SHOP);
                }
            }
            return;
        }// end function

        private function setEP(param1:uint, param2:uint) : void
        {
            this._blueBall.setValue(param1, param2);
            return;
        }// end function

        private function setHP(param1:uint, param2:uint) : void
        {
            this._redBall.setValue(param1, param2);
            return;
        }// end function

        private function listenKeyDown2() : void
        {
            KeyboardManager.addEventListener(KeyboardEvent.KEY_DOWN, this.__keyDownHandler2);
            return;
        }// end function

        private function __keyDownHandler2(event:KeyboardEvent) : void
        {
            var _loc_2:* = 0;
            switch(event.keyCode)
            {
                case Keyboard.H:
                {
                    if (event.shiftKey)
                    {
                        _loc_2 = this._info.pkState;
                        _loc_2 = (_loc_2 + 1) > 2 ? (0) : ((_loc_2 + 1));
                        FightControl.getInstance().reqChangePKStateMessage(_loc_2);
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

        private function listenKeyDown() : void
        {
            KeyboardManager.addEventListener(KeyboardEvent.KEY_DOWN, this.__keyDownHandler);
            return;
        }// end function

        private function __keyDownHandler(event:KeyboardEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (!this._barButtonEnable && this.SK_ZONE_UNABLED_KEY.indexOf(event.keyCode) != -1)
            {
                return;
            }
            switch(event.keyCode)
            {
                case Keyboard.NUMBER_1:
                {
                    _loc_2 = this._skillBoxArr[0];
                    break;
                }
                case Keyboard.NUMBER_2:
                {
                    _loc_2 = this._skillBoxArr[1];
                    break;
                }
                case Keyboard.NUMBER_3:
                {
                    _loc_2 = this._skillBoxArr[2];
                    break;
                }
                case Keyboard.NUMBER_4:
                {
                    _loc_2 = this._skillBoxArr[3];
                    break;
                }
                case Keyboard.NUMBER_5:
                {
                    _loc_2 = this._skillBoxArr[4];
                    break;
                }
                case Keyboard.BACKQUOTE:
                {
                    _loc_3 = RoleList.getInstance().selectedRoleRandom();
                    MapControl.getInstance().currentGameScene.showSelectRole(_loc_3);
                    UserObj.getInstance().selectRole = _loc_3;
                    break;
                }
                case Keyboard.Q:
                {
                    _loc_2 = this.shortRedItem;
                    break;
                }
                case Keyboard.W:
                {
                    _loc_2 = this.shortBlueItem;
                    break;
                }
                case Keyboard.E:
                {
                    _loc_2 = this.shortEItem;
                    break;
                }
                case Keyboard.R:
                {
                    _loc_2 = this.shortRItem;
                    break;
                }
                case Keyboard.C:
                {
                    PrimaryRoleControl.getInstance().openPrimayRoleMain();
                    break;
                }
                case Keyboard.I:
                case Keyboard.V:
                case Keyboard.B:
                {
                    BackPackControl.getInstance().openorcloseBackpack();
                    break;
                }
                case Keyboard.D:
                {
                    EquipForgeControl.getInstance().openEquipForgeBox();
                    break;
                }
                case Keyboard.K:
                {
                    SkillControl.getInstance().openSkillPanel();
                    break;
                }
                case Keyboard.F:
                {
                    break;
                }
                case Keyboard.X:
                {
                    MallControl.getInstance().openMall();
                    break;
                }
                case Keyboard.T:
                {
                    TaskControl.getInstance().openOrClose();
                    break;
                }
                case Keyboard.G:
                {
                    if (this._info.guildId != null)
                    {
                        GuildControl.getInstance().openGuildBox();
                    }
                    else
                    {
                        GuildControl.getInstance().openGuildCreatBox();
                    }
                    break;
                }
                case Keyboard.M:
                {
                    MapControl.getInstance().openBigMapPanel();
                    break;
                }
                case Keyboard.SPACE:
                {
                    MapControl.getInstance().dropTakeUpGoodsWithLegalRange(1, true);
                    break;
                }
                case Keyboard.A:
                {
                    if (!ZonesControl.getInstance().autoFight())
                    {
                        AutoFightController.getInstance().openOrCloseAutoFight();
                    }
                    break;
                }
                case Keyboard.Z:
                {
                    break;
                }
                case Keyboard.J:
                {
                    HorseControl.getInstance().changeRidingState();
                    break;
                }
                case Keyboard.P:
                {
                    if (BasicGlobal.gongxi)
                    {
                        DragonKingController.getInstance().moveToTransfer();
                    }
                    if (BasicGlobal.xupeitao)
                    {
                        PrimaryRoleControl.getInstance().openElementHeart();
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (_loc_2 && ShortcutBox(_loc_2).info && ShortcutBox(_loc_2).info is SkillInfo)
            {
                this.setDefaultSkill(_loc_2 as ShortcutBox);
                _loc_4 = ShortcutBox(_loc_2).info;
                if (_loc_4)
                {
                    this.useSkill(_loc_4);
                }
            }
            else
            {
                KeyboardManager.removeEventListener(KeyboardEvent.KEY_DOWN, this.__keyDownHandler);
                if (_loc_2 && ShortcutBox(_loc_2).info)
                {
                    BackPackControl.getInstance().useItem(ShortcutBox(_loc_2).info);
                }
            }
            this.setKeyDown(_loc_2);
            return;
        }// end function

        private function __keyUpHandler(event:KeyboardEvent) : void
        {
            var _loc_2:* = null;
            this.listenKeyDown();
            switch(event.keyCode)
            {
                case Keyboard.NUMBER_1:
                {
                    _loc_2 = this._skillBoxArr[0];
                    break;
                }
                case Keyboard.NUMBER_2:
                {
                    _loc_2 = this._skillBoxArr[1];
                    break;
                }
                case Keyboard.NUMBER_3:
                {
                    _loc_2 = this._skillBoxArr[2];
                    break;
                }
                case Keyboard.NUMBER_4:
                {
                    _loc_2 = this._skillBoxArr[3];
                    break;
                }
                case Keyboard.NUMBER_5:
                {
                    _loc_2 = this._skillBoxArr[4];
                    break;
                }
                case Keyboard.Q:
                {
                    _loc_2 = this.shortRedItem;
                    break;
                }
                case Keyboard.W:
                {
                    _loc_2 = this.shortBlueItem;
                    break;
                }
                case Keyboard.E:
                {
                    _loc_2 = this.shortEItem;
                    break;
                }
                case Keyboard.R:
                {
                    _loc_2 = this.shortRItem;
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.setKeyUp(_loc_2);
            return;
        }// end function

        private function setKeyDown(param1:IDragItem) : void
        {
            if (!param1)
            {
                return;
            }
            if (ShortcutBox(param1).parent == this.shortRBContainer)
            {
                BaseSprite(param1).y = 2;
            }
            else
            {
                BaseSprite(param1).y = SKILL_GRID_BASEY + 2;
            }
            return;
        }// end function

        private function setKeyUp(param1:IDragItem) : void
        {
            if (!param1)
            {
                return;
            }
            if (ShortcutBox(param1).parent == this.shortRBContainer)
            {
                BaseSprite(param1).y = 0;
            }
            else
            {
                BaseSprite(param1).y = SKILL_GRID_BASEY;
            }
            return;
        }// end function

        private function __operClick(event:MouseEvent) : void
        {
            ButtonFlickerControl.getInstance().removeButtonFlicker(event.target as DisplayObject);
            switch(event.target)
            {
                case this._masterSkillBtn:
                {
                    MasterSkillControl.instance.openOrCloseSkillPanel();
                    break;
                }
                case this._roleBtn:
                {
                    if (this.flagOpenElememt)
                    {
                        PrimaryRoleControl.getInstance().openElementHeart();
                        this.flagOpenElememt = false;
                    }
                    else
                    {
                        PrimaryRoleControl.getInstance().openPrimayRoleMain();
                    }
                    break;
                }
                case this._backpackBtn:
                {
                    BackPackControl.getInstance().openorcloseBackpack();
                    break;
                }
                case this._strengthBtn:
                {
                    EquipForgeControl.getInstance().openEquipForgeBox();
                    break;
                }
                case this._skillBtn:
                {
                    SkillControl.getInstance().openToTabSkill(1);
                    break;
                }
                case this._socialityBtn:
                {
                    if (this._info.guildId != null)
                    {
                        GuildControl.getInstance().openGuildBox();
                    }
                    else
                    {
                        GuildControl.getInstance().openGuildCreatBox();
                    }
                    break;
                }
                case this._stallsBtn:
                {
                    if (UserObj.getInstance().playerInfo.level < GlobalCfgObj.getInstance().getStallOpenUpLevel())
                    {
                        Global.popManager.addedToMouseCue(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12149"), [GlobalCfgObj.getInstance().getStallOpenUpLevel()]));
                    }
                    else
                    {
                        BackPackControl.getInstance().openBooth();
                    }
                    break;
                }
                case this._mallBtn:
                {
                    MallControl.getInstance().openMall();
                    break;
                }
                case this._teamBtn:
                {
                    TeamControl.getInstance().openOrCloseTeam();
                    break;
                }
                case this._horseBtn:
                {
                    PrimaryRoleControl.getInstance().openHorse();
                    break;
                }
                case this._artifactExtractBtn:
                {
                    PrimaryRoleControl.getInstance().openArtifactExtract();
                    break;
                }
                case this._magicBookBtn:
                {
                    if (MagicBookData.hasOpenMagicBook())
                    {
                        PrimaryRoleControl.getInstance().openMagicBook();
                    }
                    else
                    {
                        MagicBookControl.getIntance().openOrCloseGainMagicBoookPanel();
                    }
                    break;
                }
                case this._composeBtn:
                {
                    EquipComposeControl.getInstance().openEquipComposeBox();
                    break;
                }
                case this._guildBtn:
                {
                    GuildControl.getInstance().openGuildChatBox();
                    break;
                }
                case this._autoBtn:
                {
                    AutoFightController.getInstance().openOrCloseFightPanel();
                    break;
                }
                case this._prayBtn:
                {
                    PrayControl.getInstance().openOrClosePrayBox();
                    break;
                }
                case this._friendBtn:
                {
                    break;
                }
                case this._goldRaffleBtn:
                {
                    GoldRaffleControl.getInstance().openRafflesOrClosePanel();
                    break;
                }
                case this._zhuzaoBtn:
                {
                    ZhuZaoControl.getInstance().openZhuZaoPanel();
                    break;
                }
                case this._offExpBtn:
                {
                    if (OfflineControl.getInstance().isShowOffineExp())
                    {
                        SignWageControl.getInstance().openOrcloseSignWageBox(1);
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

        private function __skillClick(event:MouseEvent) : void
        {
            return;
        }// end function

        private function __itemClick(event:MouseEvent) : void
        {
            var _loc_2:* = event.target as ItemShortcutBox;
            if (_loc_2 && _loc_2.info)
            {
                this.userItem(_loc_2);
            }
            return;
        }// end function

        private function mouseClickHandler(event:MouseEvent) : void
        {
            if (event.target != this.addSign)
            {
                this.closeChoosePanel();
            }
            return;
        }// end function

        private function setDefaultSkill(param1:ShortcutBox) : void
        {
            var _loc_2:* = 0;
            if (param1 && param1.info)
            {
                if (!param1.info.q_loopmagic)
                {
                    return;
                }
                _loc_2 = param1.info.q_skillID;
                if (this._info.defaultSkillId != _loc_2 && !this._info.isBecome)
                {
                    SkillControl.getInstance().setDefaultSkill(_loc_2);
                    this._info.defaultSkillId = _loc_2;
                }
                if (!this.defaultEffect)
                {
                    this.defaultEffect = new VMCView();
                    this.defaultEffect.loadRes("res/effect/skillbox.png", null, true);
                    this.defaultEffect.updatePose("90", true);
                    this.defaultEffect.auto = true;
                }
                if (!this.defaultEffect.parent)
                {
                    this.addChild(this.defaultEffect);
                }
                if (param1.parent == this.shortRBContainer)
                {
                    this.defaultEffect.move(param1.parent.x + param1.x + 29, param1.parent.y + param1.y + 29);
                }
                else
                {
                    this.defaultEffect.move(param1.x + 29, param1.y + 29);
                }
            }
            return;
        }// end function

        private function __shortcutClick(event:MouseEvent) : void
        {
            var _loc_2:* = event.currentTarget as ShortcutBox;
            if (_loc_2 && _loc_2.info)
            {
                if (_loc_2.info is SkillInfo)
                {
                    this.setDefaultSkill(_loc_2);
                }
                else
                {
                    BackPackControl.getInstance().useItem(_loc_2.info);
                }
            }
            return;
        }// end function

        private function __shortcutRightClick(event:MouseEvent) : void
        {
            var _loc_2:* = event.currentTarget as ShortcutBox;
            if (_loc_2 && _loc_2.info)
            {
                if (_loc_2.info is SkillInfo)
                {
                    this.useSkill(_loc_2.info);
                }
                else
                {
                    BackPackControl.getInstance().useItem(_loc_2.info);
                }
            }
            return;
        }// end function

        private function __skillRightClick(event:MouseEvent) : void
        {
            var _loc_2:* = event.currentTarget as SkillBox;
            if (_loc_2 && _loc_2.info)
            {
                this.useSkill(_loc_2.info);
            }
            return;
        }// end function

        private function __itemRightClick(event:MouseEvent) : void
        {
            var _loc_2:* = event.target as ItemShortcutBox;
            if (_loc_2 && _loc_2.info)
            {
                this.userItem(_loc_2);
            }
            return;
        }// end function

        private function __addSignClick(event:MouseEvent) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            this.curSelect = this.overBox as ShortcutBox;
            var _loc_2:* = this.curSelect.parent == this.shortRBContainer ? (true) : (false);
            if (ShortcutBox(this.overBox).parent && ShortcutBox(this.overBox).parent == this.shortRBContainer)
            {
                this.curSelect = this.overBox as ShortcutBox;
                _loc_3 = this.curSelect;
                this.openChoosePanel(new Point(_loc_3.x + _loc_3.parent.x, _loc_3.y + _loc_3.parent.y + 4), _loc_2);
            }
            else
            {
                this.curSelect = this.overBox as ShortcutBox;
                _loc_4 = this.curSelect;
                this.openChoosePanel(new Point(_loc_4.x, _loc_4.y + 4), _loc_2);
            }
            return;
        }// end function

        private function __skillOver(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (UserObj.getInstance().playerInfo.isBecome)
            {
                return;
            }
            if (event.currentTarget.parent == this.shortRBContainer)
            {
                _loc_2 = event.currentTarget as ShortcutBox;
                this.overBox = _loc_2;
                _loc_2.parent.addChild(this.addSign);
                this.addSign.visible = true;
                this.addSign.x = _loc_2.x + 35;
                this.addSign.y = _loc_2.y + 5;
            }
            else
            {
                _loc_3 = event.currentTarget as ShortcutBox;
                this.overBox = _loc_3;
                _loc_3.parent.addChild(this.addSign);
                this.addSign.visible = true;
                this.addSign.x = _loc_3.x + 35;
                this.addSign.y = _loc_3.y + 5;
            }
            return;
        }// end function

        private function __skillout(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (event.currentTarget.info)
            {
                if (event.currentTarget is SkillInfo)
                {
                    _loc_2 = event.currentTarget as ShortcutBox;
                    if (this.mouseX < _loc_2.x || this.mouseY < _loc_2.y || _loc_2.x + _loc_2.width < this.mouseX || _loc_2.y + _loc_2.height < this.mouseY)
                    {
                        if (this.addSign && this.addSign.parent)
                        {
                            this.addSign.parent.removeChild(this.addSign);
                        }
                    }
                }
                else if (event.currentTarget is ItemShortcutBox)
                {
                    _loc_3 = event.currentTarget as ShortcutBox;
                    if (this.mouseX < _loc_3.x + _loc_3.parent.x || this.mouseY < _loc_3.y + _loc_3.parent.y || _loc_3.x + _loc_3.parent.x + _loc_3.width < this.mouseX || _loc_3.y + _loc_3.parent.y + _loc_3.height < this.mouseY)
                    {
                        if (this.addSign && this.addSign.parent)
                        {
                            this.addSign.parent.removeChild(this.addSign);
                        }
                    }
                }
            }
            return;
        }// end function

        private function creatChoosePanel() : void
        {
            this._choosePanel = new ShortcutChoosePanel();
            this._choosePanel.callSelect = this.callSelect;
            return;
        }// end function

        private function openChoosePanel(param1:Point, param2:Boolean = false) : void
        {
            if (this._choosePanel)
            {
                this.addChild(this._choosePanel);
                this._choosePanel.reset();
                this._choosePanel.x = param1.x;
                this._choosePanel.y = param1.y - this._choosePanel.height - 9;
            }
            this.shortRBContainer.visible = param2;
            if (this.defaultEffect)
            {
                this.defaultEffect.visible = param2;
            }
            return;
        }// end function

        private function closeChoosePanel() : void
        {
            if (this._choosePanel && this._choosePanel.parent)
            {
                this._choosePanel.parent.removeChild(this._choosePanel);
                FrameworkGlobal.stage.focus = FrameworkGlobal.stage;
            }
            this.shortRBContainer.visible = true;
            if (this.defaultEffect)
            {
                this.defaultEffect.visible = true;
            }
            return;
        }// end function

        private function openSkillChoosePanel(param1:Point) : void
        {
            if (this._skillChoosePanel)
            {
                this.addChild(this._skillChoosePanel);
                this._skillChoosePanel.resetSkills();
                this._skillChoosePanel.x = param1.x;
                this._skillChoosePanel.y = param1.y - this._skillChoosePanel.height - 9;
            }
            this.closeItemChoosePanel();
            this.shortRBContainer.visible = false;
            return;
        }// end function

        private function openItemChoosePanel(param1:Point) : void
        {
            if (this._itemChoosePanel)
            {
                this.addChild(this._itemChoosePanel);
                this._itemChoosePanel.resetItems();
                this._itemChoosePanel.x = param1.x;
                this._itemChoosePanel.y = param1.y - this._itemChoosePanel.height;
            }
            this.closeSkillChoosePanel();
            return;
        }// end function

        private function closeSkillChoosePanel() : void
        {
            if (this._skillChoosePanel && this._skillChoosePanel.parent)
            {
                this._skillChoosePanel.parent.removeChild(this._skillChoosePanel);
                FrameworkGlobal.stage.focus = FrameworkGlobal.stage;
            }
            this.shortRBContainer.visible = true;
            return;
        }// end function

        private function closeItemChoosePanel() : void
        {
            if (this._itemChoosePanel && this._itemChoosePanel.parent)
            {
                this._itemChoosePanel.parent.removeChild(this._itemChoosePanel);
                FrameworkGlobal.stage.focus = FrameworkGlobal.stage;
            }
            return;
        }// end function

        private function useSkill(param1:SkillInfo) : void
        {
            if (CountryControl.getInstance().isCountryGather)
            {
                CountryControl.getInstance().stopGather();
                return;
            }
            var _loc_2:* = CDManager.getInstance().getCD(CDTypes.SKILL, param1.q_skillID, param1.q_public_cd_level)[0] / 1000;
            if (_loc_2 <= 0)
            {
                if (this._info.currentSkill && this._info.currentSkill.q_skillID == param1.q_skillID)
                {
                    FightControl.getInstance().checkAndAttack(RoleList.getInstance().player);
                    return;
                }
                FightControl.getInstance().useSkill(param1.q_skillID, UserObj.getInstance().selectRole);
            }
            else if (!AutoFightManager.getInstance().isAutoFighting())
            {
                this._info.currentSkill = param1;
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10995"));
            }
            else if (this._info.currentSkill)
            {
                FightControl.getInstance().useSkill(param1.q_skillID, UserObj.getInstance().selectRole);
            }
            return;
        }// end function

        private function userItem(param1:ItemShortcutBox) : void
        {
            if (param1 && param1.info)
            {
                BackPackControl.getInstance().useItem(param1.info);
            }
            return;
        }// end function

        private function callSelect(param1:ShortcutBox) : void
        {
            if (param1 && param1.info)
            {
                if (param1.info is SkillInfo)
                {
                    this.selectSkill(param1);
                }
                else
                {
                    this.selectItem(param1);
                }
            }
            return;
        }// end function

        private function selectSkill(param1:ShortcutBox) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = param1;
            if (param1 && _loc_2.info)
            {
                _loc_3 = new AddShortCutMessage();
                _loc_4 = _loc_2.info as SkillInfo;
                ShortcutControl.getInstance().addShortCutHandle(this.curSelect.gridId, _loc_4.skillId, _loc_4.q_skillID, 2);
            }
            this.closeChoosePanel();
            return;
        }// end function

        private function selectItem(param1:ShortcutBox) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = param1;
            if (param1 && _loc_2.info)
            {
                _loc_3 = new AddShortCutMessage();
                _loc_4 = _loc_2.info as PropInfo;
                ShortcutControl.getInstance().addShortCutHandle(this.curSelect.gridId, _loc_4.itemId, _loc_4.itemModelId, 1);
            }
            this.closeChoosePanel();
            return;
        }// end function

        public function shortCurAdd(param1:ShortCutInfo) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            param1 = param1;
            if (param1.shortcutType == 2)
            {
                _loc_2 = SkillCfgObj.getInstance().getSkillInfoById(param1.shortcutSourceModel);
                _loc_2.shortcutId = param1.shortcutId;
                _loc_3 = this._skillBoxArr[(param1.shortcutGrid - 1)];
                if (_loc_3.info is SkillInfo)
                {
                    _loc_4 = _loc_3.info;
                }
                _loc_3.clean();
                _loc_3.info = _loc_2;
                if (_loc_3.info && _loc_4.q_skillID == this._info.defaultSkillId)
                {
                    if (this.defaultEffect)
                    {
                        if (this.defaultEffect.parent)
                        {
                            this.defaultEffect.parent.removeChild(this.defaultEffect);
                        }
                    }
                    this.setDefaultSkill(_loc_3);
                }
                if (param1.shortcutSourceModel == SkillGuideControl.getInstance().preSkillId)
                {
                    SkillGuideControl.getInstance().preSkillId = 0;
                    if (this.defaultEffect)
                    {
                        if (this.defaultEffect.parent)
                        {
                            this.defaultEffect.parent.removeChild(this.defaultEffect);
                        }
                    }
                    this.setDefaultSkill(_loc_3);
                }
                _loc_5 = RoleList.getInstance().player;
                if (_loc_5.isZonesMorph && (_loc_2.q_skillID == 10007 || _loc_2.q_skillID == 10016 || _loc_2.q_skillID == 10023))
                {
                    _loc_3.filters = [ColorFilter.getGrayFilter()];
                }
                else
                {
                    _loc_3.filters = [];
                }
            }
            else if (param1.shortcutType == 1)
            {
                _loc_6 = BackpackObj.getInstance().getItemByItemModelId(param1.shortcutSourceModel);
                _loc_7 = this._skillBoxArr[(param1.shortcutGrid - 1)];
                _loc_7.clean();
                if (_loc_6)
                {
                    _loc_6.shortcutId = param1.shortcutId;
                }
                _loc_7.info = _loc_6;
                if (_loc_6)
                {
                    _loc_7.countSpecific(BackpackObj.getInstance().getItemCount(_loc_6.q_id));
                }
            }
            this.freshCD();
            return;
        }// end function

        public function shortCutRemove(param1:int) : void
        {
            var _loc_2:* = this._skillBoxArr[(param1 - 1)] as ShortcutBox;
            if (_loc_2.info is SkillInfo && _loc_2.info.q_skillID == this._info.defaultSkillId)
            {
                if (this.defaultEffect)
                {
                    if (this.defaultEffect.parent)
                    {
                        this.defaultEffect.parent.removeChild(this.defaultEffect);
                    }
                }
            }
            _loc_2.setInfo(null);
            _loc_2.filters = [];
            this.freshCD();
            return;
        }// end function

        private function __become(event:RoleEvent) : void
        {
            if (event.obj)
            {
                this.updateShortCut(null);
            }
            else if (saveShortCutVo)
            {
                this.updateShortCut(saveShortCutVo);
            }
            return;
        }// end function

        public function updateShortCut(param1:Vector.<ShortCutInfo>) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            if (!this.UILoaded)
            {
                return;
            }
            if (UserObj.getInstance().playerInfo.isBecome)
            {
                this.cleanSkills();
                _loc_6 = this._skillBoxArr[0] as ShortcutBox;
                _loc_7 = UserObj.getInstance().playerInfo.getBecomeBuffSkillId();
                _loc_8 = SkillCfgObj.getInstance().getSkillInfoById(_loc_7);
                _loc_6.info = _loc_8;
                _loc_6.info.q_loopmagic = true;
                this.setDefaultSkill(_loc_6);
                return;
            }
            if (param1)
            {
                saveShortCutVo = param1;
            }
            this.cleanSkills();
            var _loc_2:* = param1.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_9 = param1[_loc_3];
                if (_loc_9)
                {
                    if (_loc_9.shortcutType == 2)
                    {
                        _loc_10 = this._skillBoxArr[(_loc_9.shortcutGrid - 1)] as ShortcutBox;
                        _loc_11 = SkillCfgObj.getInstance().getSkillInfoById(_loc_9.shortcutSourceModel);
                        _loc_11.skillId = _loc_9.shortcutSource;
                        _loc_11.shortcutId = _loc_9.shortcutId;
                        _loc_10.info = _loc_11;
                        _loc_12 = RoleList.getInstance().player;
                        if (_loc_12 && _loc_12.isZonesMorph && (_loc_11.q_skillID == 10007 || _loc_11.q_skillID == 10016 || _loc_11.q_skillID == 10023))
                        {
                            _loc_10.filters = [ColorFilter.getGrayFilter()];
                        }
                        else
                        {
                            _loc_10.filters = [];
                        }
                    }
                    else if (_loc_9.shortcutType == 1)
                    {
                        _loc_13 = this._skillBoxArr[(_loc_9.shortcutGrid - 1)] as ShortcutBox;
                        _loc_14 = BackpackObj.getInstance().getItemById(_loc_9.shortcutSource);
                        if (_loc_14)
                        {
                            _loc_14.shortcutId = _loc_9.shortcutId;
                            _loc_13.info = _loc_14;
                            _loc_13.countSpecific(BackpackObj.getInstance().getItemCount(_loc_14.q_id));
                        }
                    }
                }
                _loc_3++;
            }
            var _loc_4:* = this._info.defaultSkillId;
            _loc_11 = SkillCfgObj.getInstance().getSkillInfoById(_loc_4);
            _loc_3 = 0;
            while (_loc_3 < this._skillBoxArr.length)
            {
                
                if (this._skillBoxArr[_loc_3].info && this._skillBoxArr[_loc_3].info is SkillInfo && _loc_11.q_skillID == ShortcutBox(this._skillBoxArr[_loc_3]).info.q_skillID)
                {
                    _loc_5 = this._skillBoxArr[_loc_3];
                    break;
                }
                _loc_3++;
            }
            this.setDefaultSkill(_loc_5);
            this.freshCD();
            return;
        }// end function

        private function setDefaultGoods(param1:int) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_2:* = this.getItemFromItemEffectType(param1);
            if (this.hasGoods(_loc_2))
            {
                return;
            }
            if (_loc_2)
            {
                _loc_4 = BackpackObj.getInstance().getItemCount(_loc_2.q_id);
                switch(param1)
                {
                    case 1:
                    {
                        if (this.shortRedItem.info)
                        {
                            return;
                        }
                        this.shortRedItem.info = _loc_2;
                        this.shortRedItem.countSpecific(_loc_4);
                        _loc_3 = 6;
                        break;
                    }
                    case 2:
                    {
                        if (this.shortBlueItem.info)
                        {
                            return;
                        }
                        this.shortBlueItem.info = _loc_2;
                        this.shortBlueItem.countSpecific(_loc_4);
                        _loc_3 = 7;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                ShortcutControl.getInstance().addShortCutHandle(_loc_3, _loc_2.itemId, _loc_2.itemModelId, 1);
            }
            return;
        }// end function

        private function getItemFromItemEffectType(param1:int) : PropInfo
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = undefined;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_2:* = BackpackObj.getInstance().getCanShortcutItem();
            var _loc_3:* = _loc_2.length;
            switch(param1)
            {
                case 1:
                {
                    _loc_5 = ItemConst.HPMEDICINE;
                    break;
                }
                case 2:
                {
                    _loc_5 = ItemConst.EPMEDICINE;
                    break;
                }
                default:
                {
                    break;
                }
            }
            for each (_loc_7 in _loc_5)
            {
                
                _loc_6 = ItemCfgObj.getInstance().getCfgBy(int(_loc_7));
                if (UserObj.getInstance().playerInfo.level >= _loc_6.q_level)
                {
                    _loc_4 = int(_loc_7);
                    break;
                }
            }
            _loc_8 = 0;
            while (_loc_8 < _loc_3)
            {
                
                _loc_9 = _loc_2[_loc_8];
                if (_loc_9.itemModelId == _loc_4)
                {
                    return _loc_9;
                }
                _loc_8++;
            }
            return null;
        }// end function

        private function reSetZonesRedfortressSkill() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < this._skillBoxArr.length)
            {
                
                _loc_2 = ShortcutBox(this._skillBoxArr[_loc_1]);
                if (_loc_2)
                {
                    _loc_2.filters = [];
                }
                _loc_1++;
            }
            return;
        }// end function

        private function setZonesRedfortressSkill() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < this._skillBoxArr.length)
            {
                
                _loc_2 = ShortcutBox(this._skillBoxArr[_loc_1]);
                if (_loc_2 && _loc_2.info && _loc_2.info is SkillInfo)
                {
                    if (_loc_2.info.q_skillID == 10007 || _loc_2.info.q_skillID == 10016 || _loc_2.info.q_skillID == 10023)
                    {
                        _loc_2.filters = [ColorFilter.getGrayFilter()];
                    }
                }
                _loc_1++;
            }
            return;
        }// end function

        private function cleanSkills() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < this._skillBoxArr.length)
            {
                
                _loc_2 = this._skillBoxArr[_loc_1] as ShortcutBox;
                if (_loc_2 && _loc_2.info && _loc_2.info is SkillInfo)
                {
                    _loc_2.setInfo(null);
                }
                _loc_1++;
            }
            return;
        }// end function

        public function getOperatBtn(param1:String) : BaseButton
        {
            var _loc_2:* = null;
            return this._backpackBtn;
        }// end function

        private function guideConfigComplete(event:GuideEvent = null) : void
        {
            var _loc_3:* = 0;
            var _loc_2:* = false;
            if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().HORSE_ACTIVE_TEAM)) == 0 && this._horseBtn)
            {
                this._horseBtn.visible = false;
                _loc_3 = this._buttonArr.indexOf(this._horseBtn);
                if (_loc_3 != -1)
                {
                    this._buttonArr.splice(_loc_3, 1);
                }
                GuideConfigObj.getInstance().addEventListener(GuideEvent.GUIDE_ACTIVE, this.guideActive);
                _loc_2 = true;
            }
            if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().ARTIFACT_ACTIVE_TEAM)) == 0 && this._artifactExtractBtn)
            {
                this._artifactExtractBtn.visible = false;
                _loc_3 = this._buttonArr.indexOf(this._artifactExtractBtn);
                if (_loc_3 != -1)
                {
                    this._buttonArr.splice(_loc_3, 1);
                }
                GuideConfigObj.getInstance().addEventListener(GuideEvent.GUIDE_ACTIVE, this.guideActive);
                _loc_2 = true;
            }
            if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().PRAY_ACTIVE_TEAM)) == 0 && this._prayBtn)
            {
                this._prayBtn.visible = false;
                _loc_3 = this._buttonArr.indexOf(this._prayBtn);
                if (_loc_3 != -1)
                {
                    this._buttonArr.splice(_loc_3, 1);
                }
                GuideConfigObj.getInstance().addEventListener(GuideEvent.GUIDE_ACTIVE, this.guideActive);
                _loc_2 = true;
            }
            if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().ZHU_ZAO_ACTIVE_TEAM)) == 0 && this._zhuzaoBtn)
            {
                this._zhuzaoBtn.visible = false;
                _loc_3 = this._buttonArr.indexOf(this._zhuzaoBtn);
                if (_loc_3 != -1)
                {
                    this._buttonArr.splice(_loc_3, 1);
                }
                GuideConfigObj.getInstance().addEventListener(GuideEvent.GUIDE_ACTIVE, this.guideActive);
                _loc_2 = true;
            }
            if (!_loc_2)
            {
                GuideConfigObj.getInstance().removeEventListener(GuideEvent.GUIDE_ACTIVE_CONFIG_COMPLETE, this.guideConfigComplete);
            }
            return;
        }// end function

        private function guideActive(event:GuideEvent) : void
        {
            var _loc_2:* = String(event.data);
            if (_loc_2 == GuideConfigObj.getInstance().HORSE_ACTIVE_TEAM)
            {
                this.beginShowMoveEffect(this._horseBtn);
            }
            if (_loc_2 == GuideConfigObj.getInstance().ARTIFACT_ACTIVE_TEAM)
            {
                this.beginShowMoveEffect(this._artifactExtractBtn);
            }
            if (_loc_2 == GuideConfigObj.getInstance().PRAY_ACTIVE_TEAM)
            {
                this.beginShowMoveEffect(this._prayBtn);
            }
            if (_loc_2 == GuideConfigObj.getInstance().ZHU_ZAO_ACTIVE_TEAM)
            {
                this.beginShowMoveEffect(this._zhuzaoBtn);
            }
            if (_loc_2 == GuideConfigObj.getInstance().GOLD_RAFFLE_ACTIVE_TEAM)
            {
                this.beginShowMoveEffect(this._goldRaffleBtn);
            }
            return;
        }// end function

        public function registerGuide() : void
        {
            GuideControl.getInstance().registerGuide(this._horseBtn, this, GuideConfigObj.getInstance().HORSE_UP_GUIDE_ID_1);
            GuideMultiControl.getInstance().registerGuide(this._prayBtn, this, GuideConfigObj.getInstance().PRAY_GUIDE_ID_1);
            GuideMultiControl.getInstance().registerGuide(this._roleBtn, this, GuideConfigObj.getInstance().ROLE_POINT_GUIDE_ID_1);
            GuideMultiControl.getInstance().registerGuide(this._composeBtn, this, GuideConfigObj.getInstance().COMPOSE_TICKET_GUIDE_ID_1);
            GuideMultiControl.getInstance().registerGuide(this._zhuzaoBtn, this, GuideConfigObj.getInstance().ZHU_ZAO_ACTIVE_TEAM_1);
            GuideMultiControl.getInstance().registerGuide(this._artifactExtractBtn, this, GuideConfigObj.getInstance().ARTIFACT_ACTIVE_TEAM_1);
            GuideMultiControl.getInstance().registerGuide(this._masterSkillBtn, this, GuideConfigObj.getInstance().MASTER_SKILL_TEM_1);
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
            return UILoaded;
        }// end function

        public function getSkillGridEmpty(param1:SkillInfo) : ShortcutBox
        {
            var _loc_3:* = null;
            var _loc_2:* = this._skillBoxArr.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_3 = this._skillBoxArr[_loc_4];
                if (_loc_3 && _loc_3.info == param1)
                {
                    return _loc_3;
                }
                _loc_4++;
            }
            return null;
        }// end function

        public function getSkillGrid(param1:int) : ShortcutBox
        {
            var _loc_3:* = null;
            var _loc_2:* = this._skillBoxArr.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_3 = this._skillBoxArr[_loc_4];
                if (_loc_3 && _loc_3.gridId == param1)
                {
                    return _loc_3;
                }
                _loc_4++;
            }
            return null;
        }// end function

        public function getSkillGridBySkillId(param1:int) : ShortcutBox
        {
            var _loc_3:* = null;
            var _loc_5:* = null;
            var _loc_2:* = this._skillBoxArr.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_3 = this._skillBoxArr[_loc_4];
                _loc_5 = _loc_3 ? (_loc_3.info as Skill) : (null);
                if (_loc_5 && _loc_5.q_skillID == param1)
                {
                    return _loc_3;
                }
                _loc_4++;
            }
            return null;
        }// end function

        private function __updateOfflineExp(event:RoleEvent) : void
        {
            this.showOrHideOffExp(OfflineControl.getInstance().isShowOffineExp());
            return;
        }// end function

        public function setPrayCount(param1:int) : void
        {
            if (this._prayCount == null)
            {
                return;
            }
            if (param1 > 0)
            {
                (this._prayCount.getChildByName("txt") as TextField).text = param1.toString();
                this._prayCount.visible = true;
            }
            else
            {
                this._prayCount.visible = false;
            }
            return;
        }// end function

        public function setGoldExtractRemainingTimes(param1:int) : void
        {
            this._artifactGoldExtractRemainingTimes = param1;
            if (this._artifactGoldExtractRemainingTimesView == null)
            {
                return;
            }
            if (param1 > 0)
            {
                this._artifactGoldExtractRemainingTimesView.visible = true;
                (this._artifactGoldExtractRemainingTimesView.getChildByName("txt") as TextField).text = param1.toString();
            }
            else
            {
                this._artifactGoldExtractRemainingTimesView.visible = false;
            }
            return;
        }// end function

        public function setItemCD(param1:PropInfo) : void
        {
            var _loc_2:* = null;
            var _loc_5:* = null;
            if (!UILoaded)
            {
                return;
            }
            var _loc_3:* = 0;
            var _loc_4:* = this._skillBoxArr.length;
            while (_loc_3 < _loc_4)
            {
                
                _loc_5 = this._skillBoxArr[_loc_3];
                if (_loc_5.info && _loc_5.info is PropInfo)
                {
                    _loc_2 = _loc_5.info;
                    if (_loc_2.itemModelId == param1.itemModelId)
                    {
                        CDManager.getInstance().addCD(CDTypes.DRUG, _loc_2.q_cooldown, _loc_2.q_cooldown, _loc_2.itemModelId, _loc_2.q_cooldown_type, _loc_2.q_cooldown_level);
                    }
                    else if (_loc_2.q_effict_type == param1.q_effict_type)
                    {
                        CDManager.getInstance().addCD(CDTypes.DRUG, _loc_2.q_cooldown, _loc_2.q_cooldown_type, _loc_2.itemModelId, _loc_2.q_cooldown_type, _loc_2.q_cooldown_level);
                    }
                }
                _loc_3++;
            }
            return;
        }// end function

        public function get skillBtn() : BaseButton
        {
            return this._skillBtn;
        }// end function

        public function flickerBtn(param1:String) : void
        {
            if (UILoaded)
            {
                switch(param1)
                {
                    case "role":
                    {
                        ButtonFlickerControl.getInstance().addButtonFlicker(this._roleBtn);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        public function setBarEnable(param1:Boolean) : void
        {
            var _loc_3:* = param1;
            this._barButtonEnable = param1;
            UserObj.keyable = _loc_3;
            var _loc_2:* = 0;
            while (_loc_2 < this._funBtns.length)
            {
                
                (this._funBtns[_loc_2] as BaseButton).enabled = param1;
                _loc_2++;
            }
            return;
        }// end function

        private function _layoutTopButton() : void
        {
            var _loc_1:* = null;
            if (this._buttonArr)
            {
                this._buttonArr.sortOn("obj", Array.NUMERIC);
            }
            var _loc_2:* = 0;
            var _loc_3:* = this._buttonArr.length;
            while (_loc_2 < _loc_3)
            {
                
                this._buttonArr[_loc_2].x = this.MAX_RIGHT - (_loc_2 + 1) * this.SPACE + (this.SPACE - this._buttonArr[_loc_2].width >> 1);
                _loc_2++;
            }
            return;
        }// end function

        private function beginShowMoveEffect(param1:BaseButton) : void
        {
            var _loc_3:* = null;
            if (this._effectBtn)
            {
                param1.visible = true;
                _loc_3 = new VMCView();
                _loc_3.move(param1.x + 20, param1.y + 20);
                _loc_3.loadRes("res/effect/functionactive.png", null, true);
                addChild(_loc_3);
                _loc_3.auto = true;
                _loc_3.updatePose("90", false, false, true, true);
                var _loc_4:* = false;
                param1.mouseEnabled = false;
                param1.mouseChildren = _loc_4;
                this.dirEffectBtnArr.push(param1);
                _loc_3.addEventListener(Event.COMPLETE, this.functionEffComplete1);
                return;
            }
            this._effectBtn = param1;
            var _loc_4:* = false;
            this._effectBtn.mouseEnabled = false;
            this._effectBtn.mouseChildren = _loc_4;
            this.endX = param1.x;
            this.endY = param1.y;
            param1.x = FrameworkGlobal.stageW - param1.width >> 1;
            param1.y = (FrameworkGlobal.stageH - param1.height >> 1) - 80;
            param1.visible = true;
            var _loc_2:* = localToGlobal(new Point(this.endX - this.SPACE, this.endY - this.SPACE));
            Global.mainUIManager.addUI(this._effectBtn);
            TweenLite.to(this._effectBtn, 0.8, {x:_loc_2.x, y:_loc_2.y, ease:Expo.easeIn, onComplete:this._moveStep1Complete});
            return;
        }// end function

        private function _moveStep1Complete() : void
        {
            var _loc_1:* = localToGlobal(new Point(this.endX, this.endY));
            TweenLite.to(this._effectBtn, 0.8, {x:_loc_1.x, y:_loc_1.y, onComplete:this._moveStep2Complete});
            return;
        }// end function

        private function _moveStep2Complete() : void
        {
            this._effectBtn.x = this.endX;
            this._effectBtn.y = this.endY;
            addChild(this._effectBtn);
            var _loc_1:* = new VMCView();
            _loc_1.move(this._effectBtn.x + 20, this._effectBtn.y + 20);
            _loc_1.loadRes("res/effect/functionactive.png", null, true);
            addChild(_loc_1);
            _loc_1.auto = true;
            _loc_1.updatePose("90", false, false, true, true);
            _loc_1.addEventListener(Event.COMPLETE, this.functionEffComplete2, false, 0, true);
            return;
        }// end function

        private function showOrHideOffExp(param1:Boolean = true) : void
        {
            TweenLite.killDelayedCallsTo(this.showOrHideTxt);
            if (param1)
            {
                TweenLite.delayedCall(30, this.showOrHideTxt, [false]);
                if (!this._offExpBtn)
                {
                    return;
                }
                this._offExpBtn.move(223, -135);
                addChild(this._offExpBtn);
                this.showOrHideTxt(true);
            }
            else if (this._offExpBtn && this._offExpBtn.parent)
            {
                this._offExpBtn.parent.removeChild(this._offExpBtn);
            }
            return;
        }// end function

        public function showOrHideGuildChatIcon(param1:Boolean) : void
        {
            this._guildBtn.visible = param1;
            return;
        }// end function

        public function filterGuildChatIcon(param1:Boolean) : void
        {
            if (param1)
            {
                ButtonFlickerControl.getInstance().addButtonFlicker(this._guildBtn);
            }
            else
            {
                ButtonFlickerControl.getInstance().removeButtonFlicker(this._guildBtn);
            }
            return;
        }// end function

        private function showOrHideTxt(param1:Boolean) : void
        {
            var _loc_2:* = null;
            if (this._offExpBtn)
            {
                _loc_2 = RoleList.getInstance().player;
                if (_loc_2 && MapObj.getInstance().isSafeByXY(_loc_2._x, _loc_2._y))
                {
                    this._offExpBtn.getDisplayChildByName("mctxt").visible = param1;
                    return;
                }
                this._offExpBtn.getDisplayChildByName("mctxt").visible = false;
            }
            return;
        }// end function

        private function functionEffComplete1(event:Event) : void
        {
            var _loc_2:* = null;
            if (this.dirEffectBtnArr.length)
            {
                _loc_2 = this.dirEffectBtnArr.shift();
                var _loc_3:* = true;
                _loc_2.mouseEnabled = true;
                _loc_2.mouseChildren = _loc_3;
                FrameworkGlobal.sendMsg(new GameEvent(GameEvent.TOP_ACTIVATE_BTN_MOVE_EFFECT_COMPLETE));
            }
            return;
        }// end function

        private function functionEffComplete2(event:Event) : void
        {
            event.currentTarget.removeEventListener(Event.COMPLETE, this.functionEffComplete2);
            var _loc_2:* = true;
            this._effectBtn.mouseEnabled = true;
            this._effectBtn.mouseChildren = _loc_2;
            this._effectBtn = null;
            FrameworkGlobal.sendMsg(new GameEvent(GameEvent.TOP_ACTIVATE_BTN_MOVE_EFFECT_COMPLETE));
            return;
        }// end function

    }
}
