package com.game.greedisland.view
{
    import com.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.game.map.model.*;
    import com.game.zones.message.*;
    import com.game.zones.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class IslandState extends Component
    {
        private var _tips:IslandStateTips;
        private var _downtime:DownTimer;
        private var txt1:TextField;
        private var txt2:TextField;
        private var _txtDownTime:TextField;
        private var txt4:TextField;
        private var mc_level:MovieClip;
        private var mc_step:MovieClip;
        private var mc_effect:MovieClip;
        private var mc_effectFire:MovieClip;
        private var num1:MovieClip;
        private var num2:MovieClip;
        private var num3:MovieClip;
        private var _effect:VMCView;
        private var _effectFire:VMCView;
        private var FIRST_STEP_NUM:int = 32;
        private var leftNum:int;
        private var hasKillNum:int = 0;
        private var curStep:int = 1;
        private var overtime:int = 0;
        private var lastPhase:int = -1;
        private var TWO_STEP_NUM:int = 32;
        private var TWO_STEP_TIME:int = 60000;
        private var numArray:Array;
        private var _zoneInfo:ResZoneTimerMessage;
        private var _downTime:int = 0;

        public function IslandState(param1 = null, param2:String = null)
        {
            this.leftNum = this.FIRST_STEP_NUM;
            this.numArray = [32, 32, 32, 32, 32, 32, 32];
            super(param1, param2);
            loadDisplay("res/islandstate.swf");
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

        override protected function displayReady() : void
        {
            initComponentUI("islandState");
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this._tips = new IslandStateTips();
            this.txt1 = getDisplayChildByName("txt1");
            this.txt2 = getDisplayChildByName("txt2");
            this._txtDownTime = TextField(getDisplayChildByName("txt_down_time"));
            this.txt4 = TextField(getDisplayChildByName("txt4"));
            this.txt4.visible = false;
            this.mc_level = getDisplayChildByName("mc_level");
            this.mc_step = getDisplayChildByName("mc_step");
            this.mc_effect = getDisplayChildByName("mc_effect");
            this.mc_effectFire = getDisplayChildByName("mc_effectFire");
            this.num1 = getDisplayChildByName("num1");
            this.num2 = getDisplayChildByName("num2");
            this.num3 = getDisplayChildByName("num3");
            this.reset();
            if (this.hasKillNum || this.curStep > 1)
            {
                this.setKillMonsterCount(this.curStep, this.overtime, this.hasKillNum);
            }
            return;
        }// end function

        private function addEvents() : void
        {
            this.addEventListener(MouseEvent.MOUSE_OVER, this.mouseOverHandler);
            this.addEventListener(MouseEvent.MOUSE_OUT, this.mouseOutHandler);
            this.addEventListener(Event.ADDED_TO_STAGE, this.addedtoStageHandler);
            return;
        }// end function

        protected function addedtoStageHandler(event:Event) : void
        {
            return;
        }// end function

        protected function mouseOverHandler(event:MouseEvent) : void
        {
            var _loc_2:* = ZonesModel.getInstance().zoneid;
            var _loc_3:* = {zoneID:_loc_2, level:this.curStep};
            this._tips.repaint(_loc_3);
            this.addChild(this._tips);
            this._tips.x = 65;
            this._tips.y = -85;
            return;
        }// end function

        protected function mouseOutHandler(event:MouseEvent) : void
        {
            if (this._tips && this._tips.parent)
            {
                this._tips.parent.removeChild(this._tips);
            }
            return;
        }// end function

        public function setKillMonsterCount(param1:int, param2:uint, param3:int) : void
        {
            var _loc_4:* = NaN;
            this.curStep = param1;
            this.overtime = param2;
            this.hasKillNum = param3;
            this.leftNum = this.numArray[(param1 - 1)] - param3;
            this.leftNum = this.leftNum >= 0 ? (this.leftNum) : (0);
            if (UILoaded)
            {
                if (this.curStep != 1 && this.curStep > this.lastPhase)
                {
                    this.playEffect();
                }
                if (this.curStep == 1)
                {
                    this.updateMonsterNumView();
                    this.clearFire();
                }
                else
                {
                    _loc_4 = ToolKit.getServerTime();
                    this._downTime = param2 - _loc_4;
                    this.updateTimeView(this._downTime);
                    this._downTime = this._downTime / 1000;
                    this.setTimeText();
                    Ticker.killTimer(this.timeHandler);
                    Ticker.registerTimer(1, this.timeHandler);
                }
                this.lastPhase = param1;
            }
            return;
        }// end function

        private function timeHandler() : void
        {
            if (this._downTime > 0)
            {
                var _loc_1:* = this;
                var _loc_2:* = this._downTime - 1;
                _loc_1._downTime = _loc_2;
            }
            this.setTimeText();
            return;
        }// end function

        private function setTimeText() : void
        {
            var _loc_1:* = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("10014", "lang_island"), [this._downTime]);
            this.txt4.htmlText = _loc_1;
            return;
        }// end function

        public function updateTimeView(param1:int) : void
        {
            if (!this._downtime)
            {
                this._downtime = new DownTimer();
                this._downtime.callBack = this.callDownBack;
            }
            this._downtime.count = param1;
            return;
        }// end function

        private function callDownBack(param1:int) : void
        {
            if (UILoaded)
            {
                this.updateStepByTime(param1 * 100 / this.TWO_STEP_TIME);
            }
            return;
        }// end function

        private function updateStepByTime(param1:int) : void
        {
            this.mc_level.gotoAndStop(this.curStep);
            (this.mc_step.mc_mask as MovieClip).gotoAndStop(param1);
            if (this.curStep == 5 || this.curStep == 7)
            {
                this.num1.gotoAndStop(1);
                this.num2.gotoAndStop(1);
                this.num3.gotoAndStop(2);
                this.num3.visible = true;
            }
            else
            {
                this.num1.gotoAndStop((int(this.hasKillNum * 100 / this.TWO_STEP_NUM / 10) + 1));
                this.num2.gotoAndStop((int(this.hasKillNum * 100 / this.TWO_STEP_NUM % 10) + 1));
                this.num3.visible = false;
            }
            this.updateStepViewByTime();
            return;
        }// end function

        private function updateStepViewByTime() : void
        {
            var _loc_4:* = null;
            var _loc_1:* = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("10013", "lang_island"), [this.TWO_STEP_NUM]);
            this.txt1.htmlText = _loc_1;
            var _loc_2:* = (this.curStep + 1) > 7 ? (7) : ((this.curStep + 1));
            if (_loc_2 == 7)
            {
                _loc_4 = LanguageCfgObj.getInstance().getByIndex("10027", "lang_island");
            }
            else
            {
                _loc_4 = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("10011", "lang_island"), [_loc_2]);
            }
            this.txt2.htmlText = _loc_4;
            var _loc_3:* = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("10012", "lang_island"), [this.leftNum]);
            this._txtDownTime.htmlText = _loc_3;
            if (this.curStep < 5 || this.curStep == 6)
            {
                var _loc_5:* = true;
                this._txtDownTime.visible = true;
                this.txt2.visible = _loc_5;
                this.txt1.visible = _loc_5;
                this.txt4.visible = false;
            }
            else
            {
                var _loc_5:* = false;
                this._txtDownTime.visible = false;
                this.txt2.visible = _loc_5;
                this.txt1.visible = _loc_5;
                this.txt4.visible = true;
            }
            return;
        }// end function

        public function updateMonsterNumView() : void
        {
            if (UILoaded)
            {
                this.updateStepByNum();
            }
            return;
        }// end function

        private function updateStepByNum() : void
        {
            var _loc_1:* = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("10010", "lang_island"), [this.FIRST_STEP_NUM]);
            this.txt1.htmlText = _loc_1;
            var _loc_2:* = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("10011", "lang_island"), [2]);
            this.txt2.htmlText = _loc_2;
            var _loc_3:* = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("10012", "lang_island"), [this.leftNum]);
            this._txtDownTime.htmlText = _loc_3;
            var _loc_6:* = true;
            this._txtDownTime.visible = true;
            this.txt2.visible = _loc_6;
            this.txt1.visible = _loc_6;
            this.txt4.visible = false;
            this.mc_level.gotoAndStop(1);
            (this.mc_step.mc_mask as MovieClip).gotoAndStop(100);
            var _loc_4:* = int(this.hasKillNum * 100 / this.FIRST_STEP_NUM / 10);
            var _loc_5:* = int(this.hasKillNum * 100 / this.FIRST_STEP_NUM % 10);
            this.num1.gotoAndStop((_loc_4 + 1));
            this.num2.gotoAndStop((_loc_5 + 1));
            this.num3.visible = false;
            return;
        }// end function

        private function playEffect() : void
        {
            if (this._effect == null)
            {
                this._effect = new VMCView();
            }
            this._effect.auto = true;
            this._effect.loadRes("res/effect/zones/pass.png");
            this._effect.updatePose("90", false, false, true, true);
            this._effect.replay();
            if (!this._effect.parent)
            {
                if (this.mc_effect)
                {
                    this.mc_effect.addChild(this._effect);
                }
            }
            if (this._effectFire == null)
            {
                this._effectFire = new VMCView();
            }
            this._effectFire.auto = true;
            this._effectFire.loadRes("res/effect/zones/fire.png");
            this._effectFire.updatePose("90", true);
            this._effectFire.replay();
            if (!this._effectFire.parent)
            {
                if (this.mc_effectFire)
                {
                    this.mc_effectFire.addChild(this._effectFire);
                }
            }
            return;
        }// end function

        private function clean() : void
        {
            if (this._downtime)
            {
                this._downtime.count = 0;
                this._downtime.callBack = null;
                this._downtime = null;
            }
            Ticker.killTimer(this.timeHandler);
            if (this._effect)
            {
                if (this._effect.parent)
                {
                    this._effect.parent.removeChild(this._effect);
                }
                this._effect.finalize();
                this._effect = null;
            }
            if (this._effectFire)
            {
                if (this._effectFire.parent)
                {
                    this._effectFire.parent.removeChild(this._effectFire);
                }
                this._effectFire.finalize();
                this._effectFire = null;
            }
            this.hasKillNum = 0;
            this.curStep = 1;
            return;
        }// end function

        private function clearFire() : void
        {
            if (this._effectFire)
            {
                if (this._effectFire.parent)
                {
                    this._effectFire.parent.removeChild(this._effectFire);
                }
                this._effectFire.finalize();
                this._effectFire = null;
            }
            return;
        }// end function

        private function reset() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (UILoaded)
            {
                _loc_1 = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID);
                if (_loc_1.zones_type == ZoneType.ZONES_ISLAND)
                {
                    _loc_2 = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("10010", "lang_island"), [this.FIRST_STEP_NUM]);
                    this.txt1.htmlText = _loc_2;
                    _loc_3 = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("10011", "lang_island"), [2]);
                    this.txt2.htmlText = _loc_3;
                    _loc_4 = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("10012", "lang_island"), [this.FIRST_STEP_NUM]);
                    this._txtDownTime.htmlText = _loc_4;
                    var _loc_5:* = true;
                    this._txtDownTime.visible = true;
                    this.txt2.visible = _loc_5;
                    this.txt1.visible = _loc_5;
                    this.txt4.visible = false;
                    (this.mc_step.mc_mask as MovieClip).gotoAndStop(100);
                    this.mc_level.gotoAndStop(1);
                    this.num1.gotoAndStop(1);
                    this.num2.gotoAndStop(1);
                    this.num3.visible = false;
                }
            }
            return;
        }// end function

        public function open() : void
        {
            Global.mainUIManager.addUI(this, new LayoutInfo(Layout.BOTTOM_CENTER, 0, 120), 0, true);
            this.clean();
            this.reset();
            return;
        }// end function

        public function close() : void
        {
            this.clean();
            Global.mainUIManager.removeUI(this);
            return;
        }// end function

    }
}
