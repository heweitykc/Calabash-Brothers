package com.game.xscb.view
{
    import com.*;
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.game.autopk.*;
    import com.game.autopk.event.*;
    import com.game.goldRaffle.control.*;
    import com.game.guide.*;
    import com.game.guide.control.*;
    import com.game.guide.model.*;
    import com.game.xscb.control.*;
    import com.game.xscb.model.*;
    import com.game.zones.control.*;
    import com.game.zones.message.*;
    import com.game.zones.model.*;
    import com.greensock.*;
    import com.staticdata.*;
    import com.util.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class ScarletHoldTraceView extends Component implements IGuide
    {
        private const HIT_QUIT_INSTANCE:String;
        private const TIPS_GLOD_INSPIRE:String;
        private const TIPS_MONEY_INSPIRE:String;
        private const BUFF_EXP:int = 1128;
        private const BUFF_ATTACK:int = 1101;
        private const BUFF_DEFENSE:int = 1102;
        private var _btnAwait:BaseButton;
        private var _btnInspire:BaseButton;
        private var _txtDownTime:TextField;
        private var _downTime:DownTimer;
        private var _zoneInfo:ResZoneTimerMessage;
        private var _btnGlod:BaseButton;
        private var _btnMoney:BaseButton;
        private var _txtInspireAttact:TextField;
        private var _txtInspireDefense:TextField;
        private var _txtInspireExp:TextField;
        private var _taskTrace:ScarletHoldTaskComponent;
        private var _timeTxt:TextField;
        private var _txtGoldGetGift:TextField;
        private var _txtIntroduce:TextField;
        private var _txtDownTimeTitle:TextField;
        private const TIPS_INTRODUCE:String;
        private var phaseTxt:TextField;
        private var _orginX:int;
        private var initCompleted:Boolean;
        private var TXT_WORD_INTRODUCE:String;
        private var TXT_WORD_GOLD_GET_GIFT:String;
        private var _totalTime:int;
        private var _kill:int;
        private var _phase:PhaseVo;
        private var _txtAwait:TextField;
        private var _needUpdateBtn:Boolean;
        private var _orginY:int;
        private var _autofightId:int;

        public function ScarletHoldTraceView(param1 = null, param2:String = null)
        {
            this.HIT_QUIT_INSTANCE = LanguageCfgObj.getInstance().getByIndex("11440");
            this.TIPS_GLOD_INSPIRE = LanguageCfgObj.getInstance().getByIndex("11502");
            this.TIPS_MONEY_INSPIRE = LanguageCfgObj.getInstance().getByIndex("12346");
            this._downTime = new DownTimer();
            this.TIPS_INTRODUCE = LanguageCfgObj.getInstance().getByIndex("12323") + "<br>" + LanguageCfgObj.getInstance().getByIndex("12324") + "<br>" + LanguageCfgObj.getInstance().getByIndex("12325") + "<br>" + LanguageCfgObj.getInstance().getByIndex("12326") + "<br>" + LanguageCfgObj.getInstance().getByIndex("12327");
            this.TXT_WORD_INTRODUCE = LanguageCfgObj.getInstance().getByIndex("12329");
            this.TXT_WORD_GOLD_GET_GIFT = LanguageCfgObj.getInstance().getByIndex("12330");
            loadDisplay("res/scarletholdtasktrace.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initComponentUI("scarletholdtasktrace");
            this.initUI();
            this.addEvents();
            this.addAutoEventListener();
            this.checkTimeVisible();
            super.displayReady();
            this.registerGuide();
            if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().FIRST_BEGIN_XS)) == 0)
            {
                GuideMultiControl.getInstance().beginGuide(int(GuideConfigObj.getInstance().FIRST_BEGIN_XS));
                GuideConfigObj.getInstance().saveConfigByTeam(int(GuideConfigObj.getInstance().FIRST_BEGIN_XS), 1);
                this._autofightId = setTimeout(this.firstAutoFight, 15000);
            }
            return;
        }// end function

        private function initUI() : void
        {
            this._btnAwait = new BaseButton(getDisplayChildByName("btnawait"));
            this._txtAwait = TextField(getDisplayChildByName("txt"));
            this._btnInspire = new BaseButton(getDisplayChildByName("btninspire"));
            this._btnGlod = new BaseButton(getDisplayChildByName("btn_inspire_glod"));
            this._btnMoney = new BaseButton(getDisplayChildByName("btn_inspire_money"));
            this._txtInspireAttact = TextField(getDisplayChildByName("txt_inspire_attact"));
            this._txtInspireDefense = TextField(getDisplayChildByName("txt_inspire_defense"));
            this._txtInspireExp = TextField(getDisplayChildByName("txt_inspire_exp"));
            this._txtDownTimeTitle = TextField(getDisplayChildByName("txtdowntime_title"));
            this._txtDownTimeTitle.visible = false;
            this.phaseTxt = getDisplayChildByName("txt_phase");
            this._timeTxt = getDisplayChildByName("txt_time");
            this._txtDownTime = TextField(getDisplayChildByName("txtdowntime"));
            this._downTime.callBack = this.callDownBack;
            this._taskTrace = new ScarletHoldTaskComponent(getDisplayChildByName("task"));
            this._orginX = this._taskTrace.x;
            this._orginY = this._taskTrace.y;
            this._txtIntroduce = TextField(getDisplayChildByName("txt_introduce"));
            this._txtGoldGetGift = TextField(getDisplayChildByName("txt_gold_get_gift"));
            this._txtAwait.text = LanguageCfgObj.getInstance().getByIndex("11444");
            this._txtAwait.mouseEnabled = false;
            this._btnInspire.setText(LanguageCfgObj.getInstance().getByIndex("12328"));
            this._btnInspire.setText(LanguageCfgObj.getInstance().getByIndex("11445"));
            ButtonFlickerControl.getInstance().addButtonFlicker(this._btnGlod);
            ButtonFlickerControl.getInstance().addButtonFlicker(this._btnMoney);
            this._txtGoldGetGift.htmlText = "<u>" + this.TXT_WORD_GOLD_GET_GIFT + "</u>";
            StringTip.create(this._txtIntroduce, this.TIPS_INTRODUCE);
            this.initCompleted = true;
            this.phaseTxt.text = "";
            if (this._phase)
            {
                this.update();
            }
            this.setMonstKill(ZonesModel.getInstance().killMonsterCount);
            return;
        }// end function

        protected function mouseOutHandler(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._txtIntroduce:
                {
                    this._txtIntroduce.htmlText = "<u>" + this.TXT_WORD_INTRODUCE + "</u>";
                    break;
                }
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
                case this._txtIntroduce:
                {
                    this._txtIntroduce.htmlText = this.TXT_WORD_INTRODUCE;
                    break;
                }
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

        private function callDownBack() : void
        {
            var _loc_1:* = null;
            if (UILoaded)
            {
                this._txtDownTime.text = this._downTime.getTimeBySecond();
                if (!this._txtDownTimeTitle.visible)
                {
                    this._txtDownTimeTitle.visible = true;
                }
                _loc_1 = ZonesCloneCfg.getInstance().getZonesInfoFromId(ZonesModel.getInstance().zoneid);
                this._totalTime = _loc_1.q_exist_time;
                this._timeTxt.text = ToolKit.millsecond2TimeStr(this._totalTime - this._downTime.count - 180000);
            }
            return;
        }// end function

        private function addEvents() : void
        {
            this.addEventListener(MouseEvent.CLICK, this.mouseClickHandler);
            this.addEventListener(TextEvent.LINK, this.linkHandler);
            return;
        }// end function

        public function addAutoEventListener() : void
        {
            AutoFightManager.getInstance().fightLogic.addEventListener(AutoFightEvent.END_AUTO, this.onEndFightHung, false, 0, true);
            AutoFightManager.getInstance().fightLogic.addEventListener(AutoFightEvent.BEGIN_AUTO, this.onStartFightHung, false, 0, true);
            return;
        }// end function

        public function removeAutoEventListener() : void
        {
            AutoFightManager.getInstance().fightLogic.removeEventListener(AutoFightEvent.END_AUTO, this.onEndFightHung, false);
            AutoFightManager.getInstance().fightLogic.removeEventListener(AutoFightEvent.BEGIN_AUTO, this.onStartFightHung, false);
            return;
        }// end function

        private function onEndFightHung(event:AutoFightEvent) : void
        {
            if (ScarletHoldControl.getInstance().isHangUp)
            {
                ScarletHoldControl.getInstance().isHangUp = false;
            }
            this.updateBtn();
            return;
        }// end function

        private function onStartFightHung(event:AutoFightEvent) : void
        {
            if (!ScarletHoldControl.getInstance().isHangUp)
            {
                ScarletHoldControl.getInstance().isHangUp = true;
            }
            this.updateBtn();
            return;
        }// end function

        protected function mouseClickHandler(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._btnAwait:
                {
                    this.removeAutoEventListener();
                    if (ScarletHoldControl.getInstance().isHangUp)
                    {
                        ScarletHoldControl.getInstance().isHangUp = false;
                    }
                    else
                    {
                        ScarletHoldControl.getInstance().isHangUp = true;
                    }
                    this.updateBtn();
                    break;
                }
                case this._txtGoldGetGift:
                {
                    GoldRaffleControl.getInstance().openRafflesOrClosePanel();
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
            if (ScarletHoldModel.getInstance().curPhase < 1)
            {
                return;
            }
            var _loc_1:* = this._zoneInfo.surplustime * 1000 - (180 - ZoneType.ZONES_SCARLET_START_GAP) * 1000;
            this._downTime.count = _loc_1 > 0 ? (_loc_1) : (0);
            return;
        }// end function

        public function setZoneLife(param1:int) : void
        {
            if (ScarletHoldModel.getInstance().curPhase < 1)
            {
                return;
            }
            var _loc_2:* = param1 * 1000 - (180 - ZoneType.ZONES_SCARLET_START_GAP) * 1000;
            this._downTime.count = _loc_2 > 0 ? (_loc_2) : (0);
            return;
        }// end function

        private function cleanInfo() : void
        {
            this._downTime.count = 0;
            return;
        }// end function

        public function setPhase(param1:PhaseVo) : void
        {
            if (param1 == null || this._phase == null || param1.phase != this._phase.phase)
            {
                this._phase = param1;
                if (this._kill != 0)
                {
                    this._phase.completed = this._kill;
                }
                if (this._taskTrace == null)
                {
                    return;
                }
                this.update();
            }
            this.checkTimeVisible();
            return;
        }// end function

        private function checkTimeVisible() : void
        {
            if (this.initCompleted)
            {
                if (this._phase == null || this._phase.phase == 0)
                {
                    this._timeTxt.visible = false;
                    this._txtDownTime.visible = false;
                }
                else
                {
                    this._timeTxt.visible = true;
                    this._txtDownTime.visible = true;
                }
            }
            return;
        }// end function

        public function updateBtn() : void
        {
            if (!UILoaded)
            {
                this._needUpdateBtn = true;
                return;
            }
            if (ScarletHoldControl.getInstance().isHangUp)
            {
                this._txtAwait.text = LanguageCfgObj.getInstance().getByIndex("11448");
            }
            else
            {
                this._txtAwait.text = LanguageCfgObj.getInstance().getByIndex("11444");
            }
            return;
        }// end function

        private function update() : void
        {
            if (this.initCompleted)
            {
                this.updateBtn();
                if (this._phase == null)
                {
                    this._taskTrace.phase = null;
                    return;
                }
                this.phaseTxt.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12331"), [ScarletHoldModel.getInstance().curPhase]);
                if (this._phase.phase == 0 || this._taskTrace.phase == null)
                {
                    this._taskTrace.phase = this._phase;
                }
                else
                {
                    TweenLite.killTweensOf(this._taskTrace);
                    this.setTrace(this._phase.target, this._phase.target);
                    TweenLite.to(this._taskTrace, 1, {x:this._orginX - 10, y:this._orginY - 5, scaleX:1.5, scaleY:1.5, alpha:0, onComplete:this.loseComplete});
                }
            }
            return;
        }// end function

        public function setTrace(param1:int, param2:int) : void
        {
            if (this._taskTrace)
            {
                this._taskTrace.setValue(param1, param2);
            }
            return;
        }// end function

        public function setMonstKill(param1:int) : void
        {
            if (this._taskTrace)
            {
                if (this._phase && this._phase.type == PhaseVo.MONSTER)
                {
                    this._phase.completed = param1;
                    this._taskTrace.setValue(this._phase.completed);
                    param1 = 0;
                }
                else
                {
                    this._kill = param1;
                }
            }
            return;
        }// end function

        private function loseComplete() : void
        {
            this._taskTrace.phase = this._phase;
            TweenLite.to(this._taskTrace, 1, {x:this._orginX, y:this._orginY, scaleX:1, scaleY:1, alpha:1});
            return;
        }// end function

        public function setTotalTime() : void
        {
            var _loc_1:* = ZonesCloneCfg.getInstance().getZonesInfoFromId(ZonesModel.getInstance().zoneid);
            this._totalTime = int(_loc_1.q_exist_time);
            return;
        }// end function

        public function open() : void
        {
            if (UILoaded)
            {
                if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().FIRST_BEGIN_XS)) == 0)
                {
                    GuideMultiControl.getInstance().beginGuide(int(GuideConfigObj.getInstance().FIRST_BEGIN_XS));
                    GuideConfigObj.getInstance().saveConfigByTeam(int(GuideConfigObj.getInstance().FIRST_BEGIN_XS), 1);
                    this._autofightId = setTimeout(this.firstAutoFight, 15000);
                }
            }
            if (this._phase)
            {
                this._phase.phase = 0;
            }
            if (this._taskTrace)
            {
                this._taskTrace.clear();
            }
            this.checkTimeVisible();
            Global.mainUIManager.addUI(this, new LayoutInfo(Layout.RIGHT, 0, 255), GroupPanelType.GROUP_LOW);
            var _loc_1:* = ZonesCloneCfg.getInstance().getZonesInfoFromId(ZonesModel.getInstance().zoneid);
            this._totalTime = int(_loc_1.q_exist_time);
            return;
        }// end function

        private function firstAutoFight() : void
        {
            clearTimeout(this._autofightId);
            if (!ScarletHoldControl.getInstance().isHangUp)
            {
                this._btnAwait.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            }
            return;
        }// end function

        public function close() : void
        {
            this.cleanInfo();
            clearTimeout(this._autofightId);
            ButtonFlickerControl.getInstance().removeButtonFlicker(this._btnGlod);
            ButtonFlickerControl.getInstance().removeButtonFlicker(this._btnMoney);
            AutoFightManager.getInstance().fightLogic.removeEventListener(AutoFightEvent.END_AUTO, this.onEndFightHung);
            AutoFightManager.getInstance().fightLogic.removeEventListener(AutoFightEvent.BEGIN_AUTO, this.onStartFightHung);
            Global.mainUIManager.removeUI(this);
            this.guidePause(GuideConfigObj.getInstance().FIRST_BEGIN_XS_1);
            return;
        }// end function

        public function get zoneInfo() : ResZoneTimerMessage
        {
            return this._zoneInfo;
        }// end function

        public function set zoneInfo(param1:ResZoneTimerMessage) : void
        {
            this._zoneInfo = param1;
            this.freshview();
            return;
        }// end function

        public function clear() : void
        {
            if (UILoaded)
            {
                this.phaseTxt.text = "";
                this._txtDownTimeTitle.visible = false;
            }
            return;
        }// end function

        public function setComplete() : void
        {
            this.phaseTxt.text = LanguageCfgObj.getInstance().getByIndex("11452");
            this.setTrace(1, 1);
            return;
        }// end function

        public function registerGuide() : void
        {
            GuideMultiControl.getInstance().registerGuide(this._btnAwait, this, GuideConfigObj.getInstance().FIRST_BEGIN_XS_1);
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
