package com.game.zones.view.belialworld
{
    import __AS3__.vec.*;
    import com.*;
    import com.cfg.obj.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.path.*;
    import com.game.autopk.*;
    import com.game.autopk.controller.*;
    import com.game.autopk.event.*;
    import com.game.guide.*;
    import com.game.guide.control.*;
    import com.game.guide.model.*;
    import com.game.map.model.*;
    import com.game.shop.control.*;
    import com.game.team.model.*;
    import com.game.utils.*;
    import com.game.zones.control.*;
    import com.game.zones.message.*;
    import com.game.zones.model.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class ZonesBeliaworldTraceView extends Component implements IGuide
    {
        private var HIT_QUIT_INSTANCE:String;
        private var TIPS_GLOD_INSPIRE:String;
        private var TIPS_MONEY_INSPIRE:String;
        private var TXT_WORD_INTRODUCE:String;
        private var TXT_WORD_GOLD_GET_GIFT:String;
        private const POINT_MONST:Array;
        private const BUFF_EXP:int = 1128;
        private const BUFF_ATTACK:int = 1101;
        private const BUFF_DEFENSE:int = 1102;
        protected var _btnAwait:BaseButton;
        private var _btnInspire:BaseButton;
        protected var _txtDownTime:TextField;
        private var _txtKillCount:TextField;
        private var hangUpPoint:Array;
        private var _txtIntroduce:TextField;
        private var _isHangUp:Boolean = false;
        protected var _downTime:DownTimer;
        protected var _phase:int = 0;
        private var _zoneInfo:ResZoneTimerMessage;
        protected var _btnGlod:BaseButton;
        protected var _btnMoney:BaseButton;
        private var _txtInspireAttact:TextField;
        private var _txtInspireDefense:TextField;
        private var _txtInspireExp:TextField;
        protected var _txtGoldGetGift:TextField;
        protected var _txtPhase:TextField;
        private var _txtGetExp:TextField;
        protected var _txtAwait:TextField;
        protected var _txtTarget:TextField;
        protected var _txtTitle:TextField;
        protected var _bgView:MovieClip;
        protected var _txtdowntimeTitle:TextField;

        public function ZonesBeliaworldTraceView(param1 = null, param2:String = null)
        {
            this.HIT_QUIT_INSTANCE = LanguageCfgObj.getInstance().getByIndex("11440");
            this.TIPS_GLOD_INSPIRE = LanguageCfgObj.getInstance().getByIndex("11502");
            this.TIPS_MONEY_INSPIRE = LanguageCfgObj.getInstance().getByIndex("12346");
            this.TXT_WORD_INTRODUCE = LanguageCfgObj.getInstance().getByIndex("11446");
            this.TXT_WORD_GOLD_GET_GIFT = LanguageCfgObj.getInstance().getByIndex("11505");
            this.POINT_MONST = [{x:120, y:110}, {x:180, y:80}, {x:120, y:80}, {x:90, y:90}];
            this._downTime = new DownTimer();
            super(param1, param2);
            loadDisplay("res/zonetasktrace.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initComponentUI("zonetasktrace");
            this.initUI();
            this.addEvents();
            super.displayReady();
            this.registerGuide();
            var _loc_1:* = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID);
            if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().FIRST_BEGIN_BELIA_WORLD)) == 0 && _loc_1.zones_type == ZoneType.ZONES_BELIAL_WORLD)
            {
                GuideMultiControl.getInstance().beginGuide(int(GuideConfigObj.getInstance().FIRST_BEGIN_BELIA_WORLD));
                GuideConfigObj.getInstance().saveConfigByTeam(int(GuideConfigObj.getInstance().FIRST_BEGIN_BELIA_WORLD), 1);
            }
            return;
        }// end function

        protected function initUI() : void
        {
            this._btnAwait = new BaseButton(getDisplayChildByName("btnawait"));
            this._btnInspire = new BaseButton(getDisplayChildByName("btninspire"));
            this._txtAwait = TextField(getDisplayChildByName("txt"));
            this._txtTitle = TextField(getDisplayChildByName("txt_title"));
            this._txtdowntimeTitle = getDisplayChildByName("txtdowntime_title");
            this._txtdowntimeTitle.visible = false;
            this._txtTarget = TextField(getDisplayChildByName("txt_target"));
            this._btnGlod = new BaseButton(getDisplayChildByName("btn_inspire_glod"));
            this._btnMoney = new BaseButton(getDisplayChildByName("btn_inspire_money"));
            this._txtInspireAttact = TextField(getDisplayChildByName("txt_inspire_attact"));
            this._txtInspireDefense = TextField(getDisplayChildByName("txt_inspire_defense"));
            this._txtInspireExp = TextField(getDisplayChildByName("txt_inspire_exp"));
            this._txtIntroduce = TextField(getDisplayChildByName("txt_introduce"));
            this._txtDownTime = TextField(getDisplayChildByName("txtdowntime"));
            this._txtDownTime.text = "";
            this._txtKillCount = TextField(getDisplayChildByName("txt_kill_count"));
            this._txtGoldGetGift = TextField(getDisplayChildByName("txt_gold_get_gift"));
            this._txtPhase = TextField(getDisplayChildByName("txt_phase"));
            this._txtGetExp = TextField(getDisplayChildByName("txt_get_exp"));
            this._bgView = getDisplayChildByName("bgView");
            this._btnGlod.setText(LanguageCfgObj.getInstance().getByIndex("11506"));
            this._btnMoney.setText(LanguageCfgObj.getInstance().getByIndex("11507"));
            StringTip.create(this._btnGlod, this.TIPS_GLOD_INSPIRE);
            StringTip.create(this._btnMoney, this.TIPS_MONEY_INSPIRE);
            this._downTime.callBack = this.callDownBack;
            this._txtAwait.text = LanguageCfgObj.getInstance().getByIndex("11508");
            this._txtAwait.mouseEnabled = false;
            this._btnInspire.setText(LanguageCfgObj.getInstance().getByIndex("11509"));
            ButtonFlickerControl.getInstance().addButtonFlicker(this._btnGlod);
            ButtonFlickerControl.getInstance().addButtonFlicker(this._btnMoney);
            this.checkBuff();
            this.setKillMonsterCount();
            this._txtIntroduce.text = "";
            this._txtGoldGetGift.htmlText = "<u>" + this.TXT_WORD_GOLD_GET_GIFT + "</u>";
            return;
        }// end function

        private function callDownBack() : void
        {
            if (UILoaded)
            {
                this._txtDownTime.text = this._downTime.getTimeBySecond();
            }
            return;
        }// end function

        private function addEvents() : void
        {
            this.addEventListener(MouseEvent.CLICK, this.mouseClickHandler);
            this.addEventListener(TextEvent.LINK, this.linkHandler);
            this.addEventListener(MouseEvent.MOUSE_OVER, this.mouseOverHandler);
            this.addEventListener(MouseEvent.MOUSE_OUT, this.mouseOutHandler);
            AutoFightManager.getInstance().fightLogic.addEventListener(AutoFightEvent.END_AUTO, this.onEndFightHung);
            AutoFightManager.getInstance().fightLogic.addEventListener(AutoFightEvent.BEGIN_AUTO, this.onStartFightHung);
            return;
        }// end function

        protected function mouseOutHandler(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._txtGoldGetGift:
                {
                    this._txtGoldGetGift.htmlText = "<u>" + this.TXT_WORD_GOLD_GET_GIFT + "</u>";
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        protected function mouseOverHandler(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._txtGoldGetGift:
                {
                    this._txtGoldGetGift.htmlText = this.TXT_WORD_GOLD_GET_GIFT;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        protected function mouseClickHandler(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            switch(event.target)
            {
                case this._btnAwait:
                {
                    this.autoHangUp();
                    break;
                }
                case this._btnGlod:
                {
                    ZonesControl.getInstance().reqAddInspireBuff(1);
                    break;
                }
                case this._btnMoney:
                {
                    ZonesControl.getInstance().reqAddInspireBuff(0);
                    break;
                }
                case this._txtGoldGetGift:
                {
                    _loc_2 = ShopCfgObj.getInstance().getShopItemInfoFromInside(ItemConst.ONEPOINTFIVE_EXP_MEDICINE);
                    ShopController.getInstance().openBuyItem(_loc_2);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function callClickYes() : void
        {
            ZonesControl.getInstance().reqZoneOut();
            return;
        }// end function

        protected function linkHandler(event:Event) : void
        {
            return;
        }// end function

        private function freshview() : void
        {
            if (this._phase < 1)
            {
                return;
            }
            this._downTime.count = this._zoneInfo.surplustime - 175 * 1000;
            return;
        }// end function

        public function setKillMonsterCount() : void
        {
            if (UILoaded)
            {
                this._txtKillCount.text = ZonesModel.getInstance().killMonsterCount.toString();
                this._txtGetExp.text = ZonesModel.getInstance().killMonsterGetExp.toFixed(0);
            }
            return;
        }// end function

        public function setZoneLife(param1:int, param2:int) : void
        {
            this._phase = param2;
            if (param2 < 1)
            {
                return;
            }
            this._downTime.count = param1 * 1000 - 175 * 1000;
            if (UILoaded)
            {
                this._txtdowntimeTitle.visible = true;
                this._txtPhase.text = "(" + param2 + "/4)";
            }
            return;
        }// end function

        private function cleanInfo() : void
        {
            this._downTime.count = 0;
            if (this.UILoaded)
            {
                this._txtdowntimeTitle.visible = false;
                this._txtKillCount.text = "0";
                this._txtGetExp.text = "0";
                this._txtDownTime.text = "";
            }
            return;
        }// end function

        public function open() : void
        {
            Global.mainUIManager.addUI(this, new LayoutInfo(Layout.RIGHT, 0, 255));
            if (UILoaded)
            {
                ButtonFlickerControl.getInstance().addButtonFlicker(this._btnGlod);
                ButtonFlickerControl.getInstance().addButtonFlicker(this._btnMoney);
                this.checkBuff();
            }
            return;
        }// end function

        public function close() : void
        {
            this.cleanInfo();
            ButtonFlickerControl.getInstance().removeButtonFlicker(this._btnGlod);
            ButtonFlickerControl.getInstance().removeButtonFlicker(this._btnMoney);
            Global.mainUIManager.removeUI(this);
            this.isHangUp = false;
            this.guidePause(GuideConfigObj.getInstance().FIRST_BEGIN_BELIA_WORLD_1);
            return;
        }// end function

        public function get zoneInfo() : ResZoneTimerMessage
        {
            return this._zoneInfo;
        }// end function

        public function set zoneInfo(param1:ResZoneTimerMessage) : void
        {
            this._zoneInfo = param1;
            return;
        }// end function

        public function setInspireBuf(param1:int, param2:int) : void
        {
            return;
        }// end function

        public function checkBuff() : void
        {
            return;
        }// end function

        private function gotoHangUp(param1:int) : void
        {
            var _loc_2:* = this.POINT_MONST[param1];
            this.hangUpPoint = MapUtils.tile2Coo([_loc_2.x, _loc_2.y]);
            RoleList.getInstance().player.addEvtListener(RoleEvent.ARRIVE, this.runToPoint);
            RoleList.getInstance().player.pathByCoo(this.hangUpPoint[0], this.hangUpPoint[1], 0, 0, false, false);
            return;
        }// end function

        private function autoHangUp() : void
        {
            this.isHangUp = !this.isHangUp;
            return;
        }// end function

        public function runToPoint(event:RoleEvent) : void
        {
            RoleList.getInstance().player.removeEvtListener(RoleEvent.ARRIVE, this.runToPoint);
            if (!this.hangUpPoint)
            {
                return;
            }
            if (this.getDistance(this.hangUpPoint[0], this.hangUpPoint[1], RoleList.getInstance().player._x, RoleList.getInstance().player._y) <= 75)
            {
                AutoFightController.getInstance().openAutoFight();
            }
            return;
        }// end function

        private function getDistance(param1:int, param2:int, param3:Number, param4:Number) : int
        {
            return Math.sqrt(Math.pow(param3 - param1, 2) + Math.pow(param4 - param4, 2));
        }// end function

        private function getmyIndexFromTeamList() : int
        {
            var _loc_1:* = TeamModel.getInstance().vecTeamInfo;
            var _loc_2:* = UserObj.getInstance().playerInfo.personId;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_1.length)
            {
                
                if (_loc_1[_loc_3].memberid.equal(_loc_2))
                {
                    return _loc_3;
                }
                _loc_3++;
            }
            return 0;
        }// end function

        public function get isHangUp() : Boolean
        {
            return this._isHangUp;
        }// end function

        public function set isHangUp(param1:Boolean) : void
        {
            this._isHangUp = param1;
            this.setHangUp();
            return;
        }// end function

        private function setHangUp() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            if (this._isHangUp)
            {
                _loc_1 = TeamModel.getInstance().captainId;
                if (_loc_1 && _loc_1.toNumber() > 0)
                {
                    _loc_2 = this.getmyIndexFromTeamList();
                    this.gotoHangUp(_loc_2);
                }
                else
                {
                    AutoFightController.getInstance().openAutoFight();
                }
            }
            else if (UILoaded)
            {
                AutoFightController.getInstance().closeAutoFight();
            }
            return;
        }// end function

        protected function onStartFightHung(event:Event) : void
        {
            this._isHangUp = true;
            this._txtAwait.text = LanguageCfgObj.getInstance().getByIndex("11510");
            return;
        }// end function

        protected function onEndFightHung(event:Event) : void
        {
            this._isHangUp = false;
            this._txtAwait.text = LanguageCfgObj.getInstance().getByIndex("11508");
            return;
        }// end function

        public function registerGuide() : void
        {
            GuideMultiControl.getInstance().registerGuide(this._btnAwait, this, GuideConfigObj.getInstance().FIRST_BEGIN_BELIA_WORLD_1);
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
            return UILoaded;
        }// end function

    }
}
