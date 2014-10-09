package com.game.zones.view.belialworld
{
    import com.*;
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.stripe.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.game.map.model.*;
    import com.game.zones.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class ZonesBeliaWorldEvaluateView extends Component
    {
        private var _stripe:Stripe;
        private var _phase:int = 0;
        private var _rate:int = 0;
        private var _bloodRate:int = 0;
        private var _tips:ZonesBelialWorldEvaluateTips;
        private var _downtime:DownTimer;
        private var _wsDownTime:DownTimer;
        private var _txtDownInfo:TextField;
        private var _txtDownTime:TextField;
        private var txt1:TextField;
        private var txt2:TextField;
        private var mc_level:MovieClip;
        private var mc_step:MovieClip;
        private var mc_effect:MovieClip;
        private var _bloodView:MovieClip;
        private var evaluateArray:Array;
        private var monsterArray:Array;
        private var timeArray:Array;
        private var _effect:VMCView;
        private var lastPhase:int = -1;
        private static const BTNS_LENGTH:int = 6;

        public function ZonesBeliaWorldEvaluateView(param1 = null, param2:String = null)
        {
            this.evaluateArray = [LanguageCfgObj.getInstance().getByIndex("12339"), LanguageCfgObj.getInstance().getByIndex("12340"), LanguageCfgObj.getInstance().getByIndex("12341"), LanguageCfgObj.getInstance().getByIndex("12342"), LanguageCfgObj.getInstance().getByIndex("12343"), LanguageCfgObj.getInstance().getByIndex("12344")];
            this.monsterArray = [50, 100, 200, 300, 500, 800];
            this.timeArray = [50, 100, 200, 300, 500, 800];
            super(param1, param2);
            loadDisplay("res/zonestask.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initComponentUI("zone_evaluate");
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this._txtDownTime = TextField(getDisplayChildByName("txt_down_time"));
            this._tips = new ZonesBelialWorldEvaluateTips();
            this.txt1 = getDisplayChildByName("txt1");
            this.txt2 = getDisplayChildByName("txt2");
            this.mc_level = getDisplayChildByName("mc_level");
            this.mc_step = getDisplayChildByName("mc_step");
            this.mc_effect = getDisplayChildByName("mc_effect");
            this._bloodView = getDisplayChildByName("bloodView");
            var _loc_1:* = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID);
            this.reset();
            if (_loc_1.zones_type == ZoneType.ZONES_BELIAL_WORLD)
            {
                this.updateEM();
            }
            else if (_loc_1.zones_type == ZoneType.ZONES_XS)
            {
                this.updateXS(100);
            }
            else if (_loc_1.zones_type == ZoneType.ZONES_ANGEL)
            {
                this.updateXS(100);
                this.updateBlood(this._bloodRate);
            }
            return;
        }// end function

        private function addEvents() : void
        {
            this.addEventListener(MouseEvent.MOUSE_OVER, this.mouseOverHandler);
            this.addEventListener(MouseEvent.MOUSE_OUT, this.mouseMoveHandler);
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
            if (this.mouseX > 78 || this.mouseY > 78)
            {
                return;
            }
            var _loc_2:* = -1;
            var _loc_3:* = ZonesModel.getInstance().zoneid;
            var _loc_4:* = this._phase;
            var _loc_5:* = this._phase >= _loc_2;
            var _loc_6:* = {zoneID:_loc_3, level:_loc_4, state:_loc_5};
            this._tips.repaint(_loc_6);
            this.addChild(this._tips);
            this._tips.x = 65;
            this._tips.y = -85;
            return;
        }// end function

        protected function mouseMoveHandler(event:MouseEvent) : void
        {
            if (this.mouseX < 75 && this.mouseY < 75)
            {
                return;
            }
            if (this._tips && this._tips.parent)
            {
                this._tips.parent.removeChild(this._tips);
            }
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

        private function freshView(param1:int, param2:int) : void
        {
            if (!UILoaded)
            {
                this._phase = param1;
                this._rate = param2;
                return;
            }
            this._stripe.setValue(param2, 100);
            return;
        }// end function

        private function updateXS(param1:int) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = ZonesModel.getInstance().zoneid;
            var _loc_3:* = ZonesCloneCfg.getInstance().getZonesInfoFromId(_loc_2);
            if (_loc_3)
            {
                _loc_5 = _loc_3.condition_explain;
                if (_loc_5)
                {
                    _loc_4 = _loc_5.split("#");
                    this.txt1.text = _loc_4[this._phase];
                }
            }
            this.txt2.text = this.evaluateArray[5 - this._phase];
            this.mc_level.gotoAndStop((this._phase + 1));
            (this.mc_step.mc_mask as MovieClip).gotoAndStop(param1);
            return;
        }// end function

        public function updateXSView(param1:int) : void
        {
            if (!this._downtime)
            {
                this._downtime = new DownTimer();
                this._downtime.callBack = this.callDownBack;
            }
            this._downtime.count = (param1 - 175) * 1000;
            return;
        }// end function

        private function callDownBack(param1:int) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_2:* = ZonesModel.getInstance().zoneid;
            var _loc_3:* = ZonesCloneCfg.getInstance().getZonesInfoFromId(_loc_2);
            if (_loc_3)
            {
                _loc_5 = _loc_3.time_evaluate;
                if (_loc_5)
                {
                    this.timeArray = _loc_5.split(";");
                }
            }
            var _loc_4:* = this.timeArray.length - 1;
            while (_loc_4 >= 0)
            {
                
                if (param1 >= this.timeArray[_loc_4])
                {
                    this._phase = _loc_4;
                    if (this._phase != this.lastPhase && this._phase != 0)
                    {
                        this.playEffect();
                    }
                    this.lastPhase = this._phase;
                    break;
                }
                _loc_4 = _loc_4 - 1;
            }
            if (UILoaded)
            {
                if (_loc_4 == 5)
                {
                    _loc_8 = _loc_3.q_exist_time - 180 * 1000 - this.timeArray[_loc_4];
                }
                else
                {
                    _loc_8 = this.timeArray[(_loc_4 + 1)] - this.timeArray[_loc_4];
                }
                _loc_6 = param1 - this.timeArray[_loc_4];
                this._txtDownTime.text = ToolKit.getTimeBySecond(_loc_6 / 1000);
                _loc_7 = _loc_6 / _loc_8 * 100;
                this.updateXS(_loc_7);
            }
            return;
        }// end function

        public function updateViewRate(param1:int, param2:int) : void
        {
            var _loc_6:* = null;
            var _loc_3:* = ZonesModel.getInstance().zoneid;
            var _loc_4:* = ZonesCloneCfg.getInstance().getZonesInfoFromId(_loc_3);
            if (ZonesCloneCfg.getInstance().getZonesInfoFromId(_loc_3))
            {
                _loc_6 = _loc_4.time_evaluate;
                if (_loc_6)
                {
                    this.monsterArray = _loc_6.split(";");
                    this.monsterArray.push(100000);
                }
            }
            var _loc_5:* = 0;
            while (_loc_5 < this.monsterArray.length)
            {
                
                if (param1 - this.monsterArray[_loc_5] < 0)
                {
                    this._phase = _loc_5;
                    if (this._phase != this.lastPhase && this._phase != 0)
                    {
                        this.playEffect();
                    }
                    this.lastPhase = this._phase;
                    break;
                }
                _loc_5++;
            }
            if (UILoaded)
            {
                this.updateEM();
            }
            return;
        }// end function

        private function updateEM() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_8:* = 0;
            var _loc_1:* = ZonesModel.getInstance().zoneid;
            var _loc_2:* = ZonesCloneCfg.getInstance().getZonesInfoFromId(_loc_1);
            this.mc_level.gotoAndStop((this._phase + 1));
            var _loc_5:* = this._phase >= 4 ? (4) : (this._phase);
            if (_loc_2)
            {
                _loc_4 = _loc_2.condition_explain;
                if (_loc_4)
                {
                    _loc_3 = _loc_4.split("#");
                    this.txt1.text = _loc_3[_loc_5];
                }
            }
            this.txt2.text = this.evaluateArray[5 - _loc_5 - 1];
            var _loc_6:* = this.monsterArray[_loc_5] - ZonesModel.getInstance().killMonsterCount >= 0 ? (this.monsterArray[_loc_5] - ZonesModel.getInstance().killMonsterCount) : (0);
            if ((this.monsterArray[_loc_5] - ZonesModel.getInstance().killMonsterCount >= 0 ? (this.monsterArray[_loc_5] - ZonesModel.getInstance().killMonsterCount) : (0)) <= 0)
            {
                this._txtDownTime.visible = false;
            }
            else
            {
                this._txtDownTime.visible = true;
                this._txtDownTime.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12345"), [_loc_6]);
            }
            if (_loc_5 == 0)
            {
                _loc_8 = ZonesModel.getInstance().killMonsterCount;
            }
            else
            {
                _loc_8 = this.monsterArray[_loc_5] - this.monsterArray[(_loc_5 - 1)] - _loc_6;
            }
            var _loc_7:* = _loc_8 / (_loc_6 + _loc_8) * 100;
            (this.mc_step.mc_mask as MovieClip).gotoAndStop(_loc_7);
            return;
        }// end function

        public function updateWS(param1:int) : void
        {
            if (!this._wsDownTime)
            {
                this._wsDownTime = new DownTimer();
                this._wsDownTime.callBack = this.wsDownTime;
            }
            this._wsDownTime.count = param1 * 1000;
            return;
        }// end function

        public function updateBlood(param1:int) : void
        {
            this._bloodRate = param1;
            if (this._bloodRate > 100)
            {
                this._bloodRate = 100;
            }
            if (UILoaded)
            {
                this._bloodView.visible = true;
                (this._bloodView.mc_step.mc_mask as MovieClip).gotoAndStop(param1);
            }
            return;
        }// end function

        private function wsDownTime(param1:int) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_2:* = ZonesModel.getInstance().zoneid;
            var _loc_3:* = ZonesCloneCfg.getInstance().getZonesInfoFromId(_loc_2);
            if (_loc_3)
            {
                _loc_5 = _loc_3.time_evaluate;
                if (_loc_5)
                {
                    this.timeArray = _loc_5.split(";");
                }
            }
            var _loc_4:* = this.timeArray.length - 1;
            while (_loc_4 >= 0)
            {
                
                if (param1 >= this.timeArray[_loc_4])
                {
                    this._phase = _loc_4;
                    if (this._phase != this.lastPhase && this._phase != 0)
                    {
                        this.playEffect();
                    }
                    this.lastPhase = this._phase;
                    break;
                }
                _loc_4 = _loc_4 - 1;
            }
            if (UILoaded)
            {
                if (_loc_4 == 5)
                {
                    _loc_8 = _loc_3.q_exist_time - this.timeArray[_loc_4];
                }
                else
                {
                    _loc_8 = this.timeArray[(_loc_4 + 1)] - this.timeArray[_loc_4];
                }
                _loc_6 = param1 - this.timeArray[_loc_4];
                this._txtDownTime.text = ToolKit.getTimeBySecond(_loc_6 / 1000);
                _loc_7 = _loc_6 / _loc_8 * 100;
                this.updateXS(_loc_7);
            }
            return;
        }// end function

        private function playEffect() : void
        {
            var _loc_1:* = null;
            if (_loc_1 == null)
            {
                _loc_1 = new VMCView();
            }
            _loc_1.auto = true;
            _loc_1.loadRes("res/effect/zones/pass.png");
            _loc_1.updatePose("90", false, false, true, true);
            _loc_1.replay();
            if (!_loc_1.parent)
            {
                if (this.mc_effect)
                {
                    this.mc_effect.addChild(_loc_1);
                }
            }
            return;
        }// end function

        private function clean() : void
        {
            if (this._downtime)
            {
                this._downtime.count = 0;
                this._downtime = null;
            }
            if (this._wsDownTime)
            {
                this._wsDownTime.count = 0;
                this._wsDownTime = null;
            }
            if (this._effect)
            {
                this._effect.parent.removeChild(this._effect);
                this._effect.finalize();
                this._effect = null;
            }
            if (this._stripe)
            {
                this._stripe.setValue(0, 100);
            }
            this._phase = 0;
            this._rate = 0;
            this.lastPhase = 0;
            if (UILoaded)
            {
                this.txt1.text = "";
                this.txt2.text = "";
                this._txtDownTime.text = "";
                (this.mc_step.mc_mask as MovieClip).gotoAndStop(1);
                this._txtDownTime.visible = true;
                this.mc_level.gotoAndStop(1);
                this._bloodView.visible = false;
            }
            return;
        }// end function

        private function reset() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (UILoaded)
            {
                _loc_1 = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID);
                this._bloodView.visible = false;
                if (_loc_1.zones_type == ZoneType.ZONES_BELIAL_WORLD)
                {
                    _loc_2 = ZonesModel.getInstance().zoneid;
                    _loc_3 = ZonesCloneCfg.getInstance().getZonesInfoFromId(_loc_2);
                    if (_loc_3)
                    {
                        _loc_5 = _loc_3.condition_explain;
                        if (_loc_5)
                        {
                            _loc_4 = _loc_5.split("#");
                        }
                        _loc_5 = _loc_3.time_evaluate;
                        if (_loc_5)
                        {
                            this.monsterArray = _loc_5.split(";");
                        }
                    }
                    this.txt1.text = "" + _loc_4[0];
                    this.txt2.text = "" + this.evaluateArray[4];
                    this._txtDownTime.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12345"), [this.monsterArray[0]]);
                    (this.mc_step.mc_mask as MovieClip).gotoAndStop(1);
                    this._txtDownTime.visible = true;
                    this.mc_level.gotoAndStop(1);
                }
                else if (_loc_1.zones_type == ZoneType.ZONES_XS)
                {
                    this.txt1.text = "";
                    this.txt2.text = "";
                    this._txtDownTime.text = "";
                    (this.mc_step.mc_mask as MovieClip).gotoAndStop(1);
                    this._txtDownTime.visible = true;
                    this.mc_level.gotoAndStop(1);
                }
                else if (_loc_1.zones_type == ZoneType.ZONES_ANGEL)
                {
                    this._bloodView.visible = true;
                }
            }
            return;
        }// end function

        public function open() : void
        {
            Global.mainUIManager.addUI(this, new LayoutInfo(Layout.BOTTOM_CENTER, 0, 120), 0, true);
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
