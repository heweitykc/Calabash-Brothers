package com.game.player.view
{
    import com.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.imagesNumbericStepper.*;
    import com.f1.ui.tips.*;
    import com.f1.vmc.*;
    import com.game.autopk.*;
    import com.game.autopk.controller.*;
    import com.game.autopk.event.*;
    import com.game.fight.control.*;
    import com.game.map.control.*;
    import com.game.map.model.*;
    import com.game.operationpanel.view.*;
    import com.game.player.control.*;
    import com.game.redfortress.model.*;
    import com.game.role.util.*;
    import com.game.toplist.control.*;
    import com.game.vip.control.*;
    import com.game.zones.control.*;
    import com.greensock.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.text.*;

    public class PlayerMainBox extends Component
    {
        private var _stateLevel:String;
        private var _role:RoleInfo;
        private var _goldTxt:CurrencyText;
        private var _dimondTxt:CurrencyText;
        private var _image:PlayerImage;
        private var _placeHold:Sprite;
        private var _upNum:TextField;
        private var _vipBtn:VIPBtn;
        private var _upBtn:BaseButton;
        private var _endAutoFight:BaseButton;
        private var _levelTxt:TextField;
        private var _bindedDimondTxt:CurrencyText;
        private var _nameTxt:TextField;
        private var _rechargeBtn:BaseButton;
        private var _fightNum:ImgNumber;
        private var _fightHolder:Sprite;
        private var _action_mode:BaseButton;
        private var _auto_fight:BaseButton;
        private var _txt:TextField;
        private var mc_pkModel:MovieClip;
        private var close_btn:BaseButton;
        private var btn1:BaseButton;
        private var btn2:BaseButton;
        private var btn3:BaseButton;
        private var txt_model1:TextField;
        private var txt_model2:TextField;
        private var txt_model3:TextField;
        private const SHOW_BUFF_MAX:uint = 50;
        private var _buffContainer:BuffContainer;
        private var _topListMc:BaseButton;
        private var _startAutoFight:BaseButton;
        private const LIMIT_LEVEL:uint = 70;
        private var rateMC:MovieClip;
        private var _professionMc:MovieClip;
        private var _profession:MovieClip;
        private var _autofightview:VMCView;
        private var _info:PlayerInfo;
        private static var STATE_NORMAL:String = "normal";
        private static var STATE_MASTER:String = "master";

        public function PlayerMainBox()
        {
            this._stateLevel = STATE_NORMAL;
            loadDisplay("res/playermainbox.swf");
            return;
        }// end function

        protected function get stateLevel() : String
        {
            return this._stateLevel;
        }// end function

        protected function set stateLevel(param1:String) : void
        {
            if (this._stateLevel != param1)
            {
                this._stateLevel = param1;
                this.resetUI();
            }
            this._stateLevel = param1;
            return;
        }// end function

        override protected function displayReady() : void
        {
            this.resetUI();
            this.addListener();
            super.displayReady();
            return;
        }// end function

        protected function resetUI() : void
        {
            this.removeSomeUI();
            if (RoleLevelUtil.isMasterLevel(UserObj.getInstance().playerInfo.level))
            {
                initComponentUI("playermastermainbox");
                this.initUI();
                this.initMasterUI();
            }
            else
            {
                initComponentUI("playermainbox");
                this.initUI();
                this.initNormalUI();
            }
            this.addUIListener();
            this.setInfo(UserObj.getInstance().playerInfo);
            return;
        }// end function

        private function removeSomeUI() : void
        {
            if (this._action_mode && this._action_mode.parent)
            {
                this._action_mode.parent.removeChild(this._action_mode);
            }
            if (this._startAutoFight && this._startAutoFight.parent)
            {
                this._startAutoFight.parent.removeChild(this._startAutoFight);
            }
            if (this._endAutoFight && this._endAutoFight.parent)
            {
                this._endAutoFight.parent.removeChild(this._endAutoFight);
            }
            if (this._auto_fight && this._auto_fight.parent)
            {
                this._auto_fight.parent.removeChild(this._auto_fight);
            }
            if (this._professionMc && this._professionMc.parent)
            {
                this._professionMc.parent.removeChild(this._professionMc);
            }
            if (this._levelTxt && this._levelTxt.parent)
            {
                this._levelTxt.parent.removeChild(this._levelTxt);
            }
            return;
        }// end function

        private function initUI() : void
        {
            this.rateMC = getDisplayChildByName("rateMc");
            this.rateMC.visible = false;
            this._topListMc = new BaseButton(getDisplayChildByName("mc_toplist"), false);
            this._professionMc = getDisplayChildByName("mc_profession") as MovieClip;
            this._profession = this._professionMc.getChildByName("mc") as MovieClip;
            var _loc_1:* = UserObj.getInstance().playerInfo;
            this.setTopListVisibleByLevel(_loc_1.level);
            this._placeHold = getDisplayChildByName("mc_placeHold");
            if (!this._image)
            {
                this._image = new PlayerImage();
            }
            this._image.x = this._placeHold.x - 28;
            this._image.y = this._placeHold.y - 26;
            addChild(this._image);
            this._role = UserObj.getInstance().playerInfo;
            this._levelTxt = getDisplayChildByName("txt_level");
            addChild(this._levelTxt);
            this._vipBtn = new VIPBtn(getDisplayChildByName("btn_VIP"));
            this._rechargeBtn = new BaseButton(getDisplayChildByName("btn_recharge"));
            this._upBtn = new BaseButton(getDisplayChildByName("btn_Up"));
            if (!this._goldTxt)
            {
                this._goldTxt = new CurrencyText(CostType.COIN);
            }
            addChild(this._goldTxt);
            if (!this._dimondTxt)
            {
                this._dimondTxt = new CurrencyText(CostType.GOLD);
            }
            addChild(this._dimondTxt);
            if (!this._bindedDimondTxt)
            {
                this._bindedDimondTxt = new CurrencyText(CostType.BINDGOLD);
            }
            addChild(this._bindedDimondTxt);
            this._nameTxt = getDisplayChildByName("txt_name");
            this._fightHolder = getDisplayChildByName("mc_fightHold");
            this._fightNum = new ImgNumber();
            this._fightHolder.addChild(this._fightNum);
            this._action_mode = new BaseButton(getDisplayChildByName("mc_actionmode"));
            this._auto_fight = new BaseButton(getDisplayChildByName("mc_autofight"));
            this._startAutoFight = new BaseButton(getDisplayChildByName("mc_startautofight"));
            this._endAutoFight = new BaseButton(getDisplayChildByName("mc_endautofight"));
            addChild(this._action_mode);
            addChild(this._startAutoFight);
            addChild(this._endAutoFight);
            addChild(this._auto_fight);
            addChild(this._professionMc);
            StringTip.create(this._auto_fight, LanguageCfgObj.getInstance().getByIndex("11003"));
            StringTip.create(this._startAutoFight, LanguageCfgObj.getInstance().getByIndex("11004"));
            StringTip.create(this._endAutoFight, LanguageCfgObj.getInstance().getByIndex("11005"));
            this.mc_pkModel = getDisplayChildByName("mc_pkModel");
            this.mc_pkModel.visible = false;
            this.close_btn = new BaseButton(this.mc_pkModel.getChildByName("close_btn"));
            this.txt_model1 = this.mc_pkModel.getChildByName("txt_model1") as TextField;
            this.txt_model2 = this.mc_pkModel.getChildByName("txt_model2") as TextField;
            this.txt_model3 = this.mc_pkModel.getChildByName("txt_model3") as TextField;
            var _loc_2:* = false;
            this.txt_model3.mouseEnabled = false;
            this.txt_model2.mouseEnabled = _loc_2;
            this.txt_model1.mouseEnabled = _loc_2;
            this.btn1 = new BaseButton(this.mc_pkModel.getChildByName("btn1"));
            this.btn2 = new BaseButton(this.mc_pkModel.getChildByName("btn2"));
            this.btn3 = new BaseButton(this.mc_pkModel.getChildByName("btn3"));
            this._vipBtn.viplevel = _loc_1.vipid;
            if (!this._buffContainer)
            {
                this._buffContainer = new BuffContainer();
            }
            addChild(this._buffContainer);
            this.checkAutoFight();
            return;
        }// end function

        private function initMasterUI() : void
        {
            this._goldTxt.x = 129 + 50;
            this._dimondTxt.x = 174 + 50;
            this._bindedDimondTxt.x = 231 + 50;
            var _loc_1:* = 14 + 5;
            this._dimondTxt.y = 14 + 5;
            this._bindedDimondTxt.y = _loc_1;
            this._goldTxt.y = _loc_1;
            this._buffContainer.move(121 + 78, 101 + 10);
            return;
        }// end function

        private function initNormalUI() : void
        {
            this._goldTxt.x = 129;
            this._dimondTxt.x = 174;
            this._bindedDimondTxt.x = 231;
            var _loc_1:* = 14;
            this._dimondTxt.y = 14;
            this._bindedDimondTxt.y = _loc_1;
            this._goldTxt.y = _loc_1;
            this._buffContainer.move(121, 101);
            return;
        }// end function

        private function checkAutoFight(event:AutoFightEvent = null) : void
        {
            var _loc_2:* = AutoFightManager.getInstance().isAutoFighting();
            this._startAutoFight.visible = _loc_2 ? (false) : (true);
            this._endAutoFight.visible = _loc_2 ? (true) : (false);
            return;
        }// end function

        public function updateVIPBuff() : void
        {
            if (this._buffContainer)
            {
                this._buffContainer.updateVipBuff();
            }
            return;
        }// end function

        private function setInfo(param1:PlayerInfo) : void
        {
            this._info = param1;
            this.updateView();
            return;
        }// end function

        private function updateView() : void
        {
            this.setName(this._info.name);
            this.setHeadPic(this._info.headPic);
            this.setLevel(this._info.level);
            this.setProfession(this._info.job);
            this.setGold(UserObj.getInstance().playerInfo.money);
            this.setDiamond(UserObj.getInstance().playerInfo.gold);
            this.setBindedDiamond(UserObj.getInstance().playerInfo.bindgold);
            this.updateCurrency();
            this.setFightNum(this._info.fightPower);
            this.setActionMode(this._info.pkState);
            return;
        }// end function

        private function setProfession(param1:int) : void
        {
            if (this._profession)
            {
                this._profession.gotoAndStop(param1);
            }
            return;
        }// end function

        private function updateCurrency() : void
        {
            this._dimondTxt.x = this._goldTxt.x + this._goldTxt.width + 5;
            this._bindedDimondTxt.x = this._dimondTxt.x + this._dimondTxt.width + 5;
            return;
        }// end function

        private function setActionMode(param1:int) : void
        {
            var _loc_2:* = "";
            switch(param1)
            {
                case 0:
                {
                    _loc_2 = LanguageCfgObj.getInstance().getByIndex("11006");
                    break;
                }
                case 1:
                {
                    _loc_2 = LanguageCfgObj.getInstance().getByIndex("11007");
                    break;
                }
                case 2:
                {
                    _loc_2 = LanguageCfgObj.getInstance().getByIndex("11008");
                    break;
                }
                default:
                {
                    break;
                }
            }
            this._action_mode.setText(_loc_2);
            if (UserObj.getInstance().playerInfo.level < 60)
            {
                this._action_mode.visible = false;
            }
            else
            {
                this._action_mode.visible = true;
            }
            return;
        }// end function

        private function setFightNum(param1:uint) : void
        {
            this._fightNum.setNumber(param1.toString(), 2, -2);
            return;
        }// end function

        private function setFightNumScroll(param1:uint) : void
        {
            this._fightNum.setNumberScroll(param1.toString(), 2, 0, 18, 23, false, true);
            return;
        }// end function

        private function __imageClick(event:MouseEvent) : void
        {
            PlayerControl.getInstance().clickPlayerMainBoxImage();
            return;
        }// end function

        private function addListener() : void
        {
            if (this._info != null)
            {
                this._info.addEvtListener(RoleEvent.UPDATE_JOB, this.__updateJob);
                this._info.addEvtListener(RoleEvent.UPDATE_LEVEL, this.__updateLevel);
                this._info.addEvtListener(RoleEvent.UPDATE_VIP_LEVEL, this.__updateVipLevel);
                this._info.addEvtListener(RoleEvent.UPDATE_HEAD_PIC, this.__updateHeadPic);
                this._info.addEvtListener(RoleEvent.UPDATE_GOLD, this.__updateDiamond);
                this._info.addEvtListener(RoleEvent.UPDATE_MONEY, this.__updateMoneys);
                this._info.addEvtListener(RoleEvent.UPDATE_BINDGOLD, this.__updateBindedDiamond);
                this._info.addEvtListener(RoleEvent.UPDATE_FIGHT_DOWN_NUMBER, this.__updateFightNumber);
                FrameworkGlobal.addMsgListen("fight_up", this.__updateFightNumberScroll);
                FrameworkGlobal.addMsgListen("fadeOut", this.__fadeEffect);
                this._info.addEvtListener(RoleEvent.UPDATE_PK_STATE, this.__updatePkmodel);
                AutoFightManager.getInstance().fightLogic.addEventListener(AutoFightEvent.END_AUTO, this.onEndFightHung, false, 0, true);
                AutoFightManager.getInstance().fightLogic.addEventListener(AutoFightEvent.BEGIN_AUTO, this.onStartFightHung, false, 0, true);
            }
            return;
        }// end function

        protected function addUIListener() : void
        {
            this._vipBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._rechargeBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._action_mode.addEventListener(MouseEvent.CLICK, this.__btnClick);
            this._auto_fight.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._startAutoFight.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._endAutoFight.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._topListMc.addEventListener(MouseEvent.CLICK, this.__btnClick);
            this._image.addEventListener(MouseEvent.ROLL_OVER, this.__roleOver);
            this._image.addEventListener(MouseEvent.CLICK, this.__imageClick);
            this._image.addEventListener(MouseEvent.ROLL_OUT, this.__roleOut);
            this.close_btn.addEventListener(MouseEvent.CLICK, this.__modelClick);
            this.btn1.addEventListener(MouseEvent.CLICK, this.__modelClick);
            this.btn2.addEventListener(MouseEvent.CLICK, this.__modelClick);
            this.btn3.addEventListener(MouseEvent.CLICK, this.__modelClick);
            return;
        }// end function

        private function onStartFightHung(event:AutoFightEvent) : void
        {
            this._startAutoFight.visible = false;
            this._endAutoFight.visible = true;
            if (this._autofightview)
            {
                if (this._autofightview.parent)
                {
                    this._autofightview.parent.removeChild(this._autofightview);
                }
                this._autofightview.finalize();
            }
            this._autofightview = new VMCView();
            this._autofightview.auto = true;
            this._autofightview.loadRes("res/effect/autofight.png");
            this._autofightview.updatePose("90", true);
            this._autofightview.move(this._auto_fight.x + this._auto_fight.width * 0.5, this._auto_fight.y + this._auto_fight.height * 0.5);
            addChild(this._autofightview);
            return;
        }// end function

        private function onEndFightHung(event:AutoFightEvent) : void
        {
            this._startAutoFight.visible = true;
            this._endAutoFight.visible = false;
            if (this._autofightview)
            {
                this._autofightview.finalize();
            }
            return;
        }// end function

        private function __updateFightNumber(event:RoleEvent) : void
        {
            this.setFightNum(this._info.fightPower);
            return;
        }// end function

        private function __updateFightNumberScroll(event:Event) : void
        {
            this.setFightNumScroll(UserObj.getInstance().playerInfo.fightPower);
            return;
        }// end function

        private function __updateVipLevel(event:RoleEvent) : void
        {
            if (this._vipBtn)
            {
                this._vipBtn.viplevel = UserObj.getInstance().playerInfo.vipid;
            }
            return;
        }// end function

        private function __roleOver(event:MouseEvent) : void
        {
            var _loc_2:* = new GlowFilter(16773120, 0.8, 5, 5, 5);
            this._image.filters = [_loc_2];
            return;
        }// end function

        private function __roleOut(event:MouseEvent) : void
        {
            this._image.filters = [];
            return;
        }// end function

        private function __btnClick(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._action_mode:
                {
                    if (MapObj.getInstance().mapID != Params.COUNTRY_MAP_ID && MapObj.getInstance().mapID != ZonesRedfortressModel.ZONES_ID)
                    {
                        this.mc_pkModel.visible = !this.mc_pkModel.visible;
                    }
                    else
                    {
                        Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("11009"));
                    }
                    break;
                }
                case this._auto_fight:
                {
                    AutoFightController.getInstance().openOrCloseFightPanel();
                    break;
                }
                case this._startAutoFight:
                {
                    if (!ZonesControl.getInstance().autoFight())
                    {
                        AutoFightController.getInstance().openOrCloseAutoFight();
                    }
                    break;
                }
                case this._endAutoFight:
                {
                    AutoFightController.getInstance().closeAutoFight();
                    break;
                }
                case this._vipBtn:
                {
                    VIPControl.getInstance().openOrCloseVip();
                    break;
                }
                case this._rechargeBtn:
                {
                    MapControl.getInstance().showRecharge();
                    break;
                }
                case this._topListMc:
                {
                    TopListControl.getInstance().openOrClose();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function __modelClick(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this.btn1:
                {
                    FightControl.getInstance().reqChangePKStateMessage(0);
                    this.mc_pkModel.visible = false;
                    break;
                }
                case this.btn2:
                {
                    FightControl.getInstance().reqChangePKStateMessage(1);
                    this.mc_pkModel.visible = false;
                    break;
                }
                case this.btn3:
                {
                    FightControl.getInstance().reqChangePKStateMessage(2);
                    this.mc_pkModel.visible = false;
                    break;
                }
                case this.close_btn:
                {
                    this.mc_pkModel.visible = false;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function __updateDiamond(event:RoleEvent) : void
        {
            this.setDiamond(UserObj.getInstance().playerInfo.gold, true);
            return;
        }// end function

        private function __updateMoneys(event:RoleEvent) : void
        {
            this.setGold(UserObj.getInstance().playerInfo.money, true);
            return;
        }// end function

        private function __updateBindedDiamond(event:RoleEvent) : void
        {
            this.setBindedDiamond(UserObj.getInstance().playerInfo.bindgold, true);
            return;
        }// end function

        private function setDiamond(param1:uint, param2:Boolean = true) : void
        {
            this._dimondTxt.setText(param1, param2, this.updateCurrency);
            return;
        }// end function

        private function setGold(param1:uint, param2:Boolean = true) : void
        {
            this._goldTxt.setText(param1, param2, this.updateCurrency);
            return;
        }// end function

        private function setBindedDiamond(param1:uint, param2:Boolean = true) : void
        {
            this._bindedDimondTxt.setText(param1, param2, this.updateCurrency);
            return;
        }// end function

        private function __updateJob(event:RoleEvent) : void
        {
            this.setHeadPic(this._info.headPic);
            this.setProfession(this._info.job);
            return;
        }// end function

        private function __updateHeadPic(event:RoleEvent) : void
        {
            this.setHeadPic(this._info.headPic);
            return;
        }// end function

        private function __updateLevel(event:RoleEvent) : void
        {
            var _loc_2:* = event.currentTarget as RoleInfo;
            if (RoleLevelUtil.isMasterLevel(_loc_2.level))
            {
                this.stateLevel = STATE_MASTER;
            }
            else
            {
                this.stateLevel = STATE_NORMAL;
            }
            this.setLevel(_loc_2.level);
            this.addRoleTip();
            this.setActionMode(_loc_2.pkState);
            this.setTopListVisibleByLevel(_loc_2.level);
            return;
        }// end function

        private function __updatePkmodel(event:RoleEvent) : void
        {
            var _loc_2:* = event.currentTarget as RoleInfo;
            this.setActionMode(_loc_2.pkState);
            return;
        }// end function

        public function setHeadPic(param1:String) : void
        {
            if (this._image)
            {
                this._image.setUrl(param1);
            }
            return;
        }// end function

        private function playerImageCom(param1:BitmapData) : void
        {
            return;
        }// end function

        public function setLevel(param1:uint) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = RoleLevelUtil.isMasterLevel(param1) == true ? (param1 - Params.ROLE_MAX_LEVEL) : (param1);
            this._levelTxt.htmlText = _loc_2.toString();
            if (RoleLevelUtil.isMasterLevel(param1))
            {
                _loc_3 = RoleLevelUtil.getMasterLevel(param1) + "";
                StringTip.create(this._levelTxt, _loc_3);
            }
            return;
        }// end function

        public function setName(param1:String) : void
        {
            if (!param1)
            {
                param1 = this._info.name;
            }
            this._nameTxt.htmlText = param1;
            return;
        }// end function

        private function addRoleTip() : void
        {
            return;
        }// end function

        public function setPlayerMainBoxEnable(param1:Boolean) : void
        {
            var _loc_2:* = param1;
            this.mouseChildren = param1;
            this.mouseEnabled = _loc_2;
            return;
        }// end function

        private function __fadeEffect(event:Event) : void
        {
            var _loc_2:* = new ImgNumber();
            _loc_2.setNumber(UserObj.getInstance().playerInfo.fightPower.toString(), 2);
            this._fightHolder.addChild(_loc_2);
            var _loc_3:* = new TimelineLite();
            var _loc_4:* = _loc_2.x;
            var _loc_5:* = _loc_2.y;
            var _loc_6:* = _loc_2.width;
            var _loc_7:* = _loc_2.height;
            _loc_3.append(new TweenLite(_loc_2, 0.1, {scaleX:1.2, scaleY:1.2, x:_loc_4 - _loc_6 * 0.1, y:_loc_5 - _loc_7 * 0.1}));
            _loc_3.append(new TweenLite(_loc_2, 0.1, {scaleX:1, scaleY:1, x:_loc_4, y:_loc_5, onComplete:onComplete, onCompleteParams:[_loc_2, _loc_4, _loc_5]}));
            return;
        }// end function

        private function setTopListVisibleByLevel(param1:uint) : void
        {
            if (this._topListMc)
            {
                if (param1 >= this.LIMIT_LEVEL)
                {
                    this._topListMc.visible = true;
                }
                else
                {
                    this._topListMc.visible = false;
                }
            }
            return;
        }// end function

        public function setRateMcVisible(param1:Boolean) : void
        {
            if (this.rateMC)
            {
                this.rateMC.visible = param1;
            }
            return;
        }// end function

        public function setRateText(param1:String) : void
        {
            if (this.rateMC)
            {
                this.rateMC["rate"].text = param1;
            }
            return;
        }// end function

        private static function onComplete(param1:DisplayObject, param2:Number, param3:Number) : void
        {
            param1.x = param2;
            param1.y = param3;
            if (param1.parent)
            {
                param1.parent.removeChild(param1);
            }
            return;
        }// end function

    }
}
