package com.game.country.view
{
    import com.*;
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.game.country.bean.*;
    import com.game.country.control.*;
    import com.game.country.events.*;
    import com.game.country.model.*;
    import com.model.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class CountryCopyState extends Component
    {
        private var mc_state:MovieClip;
        private var mc1:MovieClip;
        private var mc2:MovieClip;
        private var mc3:MovieClip;
        private var mc4:MovieClip;
        private var mc5:MovieClip;
        private var mc6:MovieClip;
        private var mc7:MovieClip;
        private var btn_back:BaseButton;
        private var mc_effect:MovieClip;
        private var txt_state:TextField;
        private var monsterID:Array;
        private var count:int = 0;
        public static var lastStep:int = -1;

        public function CountryCopyState(param1 = null, param2:String = null)
        {
            this.monsterID = [130041003, 130041006, 130041004, 130041007, 130041005, 130041008, 130041009];
            super(param1, param2);
            loadDisplay("res/countryState.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initComponentUI("countryState");
            this.initUI();
            this.addEvents();
            this.mouseEnabled = false;
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.mc_state = getDisplayChildByName("mc_state");
            this.mc_state.mouseEnabled = false;
            this.mc_state.mouseChildren = false;
            var _loc_1:* = 0;
            while (_loc_1 < 7)
            {
                
                this["mc" + (_loc_1 + 1)] = this.mc_state.getChildByName("mc" + (_loc_1 + 1));
                _loc_1++;
            }
            this.btn_back = new BaseButton(getDisplayChildByName("btn_back"));
            this.btn_back.setText(LanguageCfgObj.getInstance().getByIndex("10564"));
            StringTip.create(this.btn_back, LanguageCfgObj.getInstance().getByIndex("10565"));
            this.txt_state = this.mc_state.getChildByName("txt_state") as TextField;
            this.mc_effect = this.mc_state.getChildByName("mc_effect") as MovieClip;
            this.update();
            return;
        }// end function

        private function addEvents() : void
        {
            this.btn_back.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            CountryData.getInstance().addEvtListener(CountryEvent.COUNTRY_WAR_INFO_CHANGE, this.update);
            return;
        }// end function

        public function __click(event:MouseEvent) : void
        {
            var e:* = event;
            switch(e.target)
            {
                case this.btn_back:
                {
                    if (UserObj.getInstance().playerInfo.fightState == 0)
                    {
                        Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10566"));
                    }
                    else
                    {
                        Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("11967"), LanguageCfgObj.getInstance().getByIndex("11635"), null, function () : void
            {
                CountryControl.getInstance().reqSiegeMoveMap();
                startCD();
                return;
            }// end function
            , null, 2);
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

        private function startCD() : void
        {
            this.count = 60;
            this.btn_back.enabled = false;
            this.btn_back.setText(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11968"), [this.count]));
            Ticker.registerTimer(1, this.showTime, this.reset, 60);
            return;
        }// end function

        private function showTime() : void
        {
            var _loc_1:* = this;
            var _loc_2:* = this.count - 1;
            _loc_1.count = _loc_2;
            this.btn_back.setText(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11968"), [this.count]));
            return;
        }// end function

        private function reset() : void
        {
            this.btn_back.enabled = true;
            this.btn_back.setText(LanguageCfgObj.getInstance().getByIndex("10564"));
            return;
        }// end function

        public function update(event:CountryEvent = null) : void
        {
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_2:* = CountryData.getInstance().countrywarinfo;
            if (!_loc_2)
            {
                return;
            }
            var _loc_3:* = _loc_2.process;
            var _loc_4:* = _loc_3.split(",");
            var _loc_5:* = [];
            _loc_5[0] = _loc_4[4];
            _loc_5[1] = _loc_4[0];
            _loc_5[2] = _loc_4[5];
            _loc_5[3] = _loc_4[1];
            _loc_5[4] = _loc_4[6];
            _loc_5[5] = _loc_4[2];
            _loc_5[6] = _loc_4[3];
            var _loc_6:* = 0;
            while (_loc_6 < 7)
            {
                
                if (_loc_5[_loc_6] == 0)
                {
                    this["mc" + (_loc_6 + 1)].gotoAndStop(2);
                    this["mc" + (_loc_6 + 1)].img.gotoAndStop(2);
                    this["mc" + (_loc_6 + 1)].state.gotoAndStop(4);
                    this.__playLightEffect(this["mc" + (_loc_6 + 1)].light, false);
                }
                else
                {
                    this["mc" + (_loc_6 + 1)].gotoAndStop(1);
                    this["mc" + (_loc_6 + 1)].img.gotoAndStop(1);
                    this["mc" + (_loc_6 + 1)].state.gotoAndStop(1);
                    if (_loc_5[_loc_6] == 2)
                    {
                        this.__playLightEffect(this["mc" + (_loc_6 + 1)].light, true);
                    }
                    else if (_loc_5[_loc_6] == 1)
                    {
                        this.__playLightEffect(this["mc" + (_loc_6 + 1)].light, false);
                    }
                    else if (_loc_5[_loc_6] == 3)
                    {
                        this.__playLightEffect(this["mc" + (_loc_6 + 1)].light, false);
                    }
                }
                _loc_6++;
            }
            var _loc_7:* = _loc_2.blood;
            if (_loc_2.blood)
            {
                _loc_8 = _loc_7.split(",");
                _loc_9 = [];
                _loc_9[0] = _loc_8[4];
                _loc_9[1] = _loc_8[0];
                _loc_9[2] = _loc_8[5];
                _loc_9[3] = _loc_8[1];
                _loc_9[4] = _loc_8[6];
                _loc_9[5] = _loc_8[2];
                _loc_9[6] = _loc_8[3];
                _loc_10 = 0;
                while (_loc_10 < _loc_9.length)
                {
                    
                    if (_loc_5[_loc_10] == 0)
                    {
                        this.__playBloodEffect(this["mc" + (_loc_10 + 1)].blood, 0, false);
                    }
                    else if (_loc_5[_loc_10] == 2)
                    {
                        this.__playBloodEffect(this["mc" + (_loc_10 + 1)].blood, 0, false);
                    }
                    else if (_loc_5[_loc_10] == 3)
                    {
                        this.__playBloodEffect(this["mc" + (_loc_10 + 1)].blood, 0, false);
                    }
                    else
                    {
                        this.__playBloodEffect(this["mc" + (_loc_10 + 1)].blood, _loc_9[_loc_10], true);
                        this.txt_state.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11969"), [(_loc_10 + 1), this.getName(_loc_10)]);
                        if (lastStep != _loc_10)
                        {
                            this.playeChangeEffect();
                        }
                        lastStep = _loc_10;
                    }
                    _loc_10++;
                }
            }
            return;
        }// end function

        private function getName(param1:int) : String
        {
            var _loc_2:* = MonsterCfgObj.getInstance().getMonsterCfg(this.monsterID[param1]);
            if (_loc_2)
            {
                return _loc_2.q_name;
            }
            return "";
        }// end function

        public function __playLightEffect(param1:DisplayObjectContainer, param2:Boolean = true) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            ToolKit.clearMcChild(param1, true);
            if (!param2)
            {
                return;
            }
            if (_loc_3 == null)
            {
                _loc_3 = new VMCView();
                _loc_3.auto = true;
            }
            _loc_3.loadRes("res/effect/country/light1.png");
            _loc_3.updatePose("90", true);
            _loc_3.replay();
            if (_loc_4 == null)
            {
                _loc_4 = new VMCView();
                _loc_4.auto = true;
            }
            _loc_4.loadRes("res/effect/country/light2.png");
            _loc_4.updatePose("90", true);
            _loc_4.replay();
            param1.addChild(_loc_3);
            return;
        }// end function

        public function __playBloodEffect(param1:DisplayObjectContainer, param2:int, param3:Boolean = true) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            ToolKit.clearMcChild(param1["mc_blood"], true);
            ToolKit.clearMcChild(param1["effect_blood"], true);
            if (!param3)
            {
                return;
            }
            if (_loc_4 == null)
            {
                _loc_4 = new VMCView();
                _loc_4.auto = true;
            }
            _loc_4.loadRes("res/effect/country/blood1.png");
            _loc_4.updatePose("90", true);
            _loc_4.replay();
            if (_loc_5 == null)
            {
                _loc_5 = new VMCView();
                _loc_5.auto = true;
            }
            _loc_5.loadRes("res/effect/country/blood2.png");
            _loc_5.updatePose("90", true);
            _loc_5.replay();
            param1["mc_blood"].addChild(_loc_4);
            param1["effect_blood"].addChild(_loc_5);
            var _loc_6:* = 18 - param2 / 100 * 36;
            param1["mask"].y = 18 - param2 / 100 * 36;
            param1["effect_blood"].y = _loc_6;
            return;
        }// end function

        private function playeChangeEffect() : void
        {
            var _loc_1:* = null;
            if (_loc_1 == null)
            {
                _loc_1 = new VMCView();
                _loc_1.loadRes("res/effect/country/countryFly.png");
                _loc_1.auto = true;
            }
            if (_loc_1.parent == null)
            {
                this.mc_effect.addChild(_loc_1);
            }
            _loc_1.updatePose("90", false, false, true);
            _loc_1.move(85, 95);
            _loc_1.play();
            return;
        }// end function

        public function open() : void
        {
            Global.mainUIManager.addUI(this, new LayoutInfo(Layout.BOTTOM_CENTER, 0, 30));
            if (this.parent)
            {
                this.parent.addChildAt(this, 0);
            }
            if (UILoaded)
            {
                this.update();
            }
            return;
        }// end function

        public function close() : void
        {
            Global.mainUIManager.removeUI(this);
            return;
        }// end function

    }
}
