package com.game.greedisland.view
{
    import com.*;
    import com.f1.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.game.greedisland.control.*;
    import com.game.greedisland.events.*;
    import com.game.greedisland.model.*;
    import com.game.guide.control.*;
    import com.game.primaryrole.control.*;
    import com.game.zones.control.*;
    import com.greensock.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;

    public class IslandCopyInfoView extends Component
    {
        private const HIT_QUIT_INSTANCE:String;
        private var btn_inspire_glod:BaseButton;
        private var btn_box:BaseButton;
        private var btn_look:BaseButton;
        private var btn_box1:BaseButton;
        private var btn_box2:BaseButton;
        private var btn_box3:BaseButton;
        private var btn_box4:BaseButton;
        private var txt_num1:TextField;
        private var txt_num2:TextField;
        private var txt_num3:TextField;
        private var txt_num4:TextField;
        private var txt_exp:TextField;
        private var txtdowntime:TextField;
        private var mc_effect:MovieClip;
        private var curStep:int = 1;
        private var islandData:IslandData;
        private var _downTime:int = 0;
        private var _effect:VMCView;

        public function IslandCopyInfoView(param1 = null, param2:String = null)
        {
            this.HIT_QUIT_INSTANCE = LanguageCfgObj.getInstance().getByIndex("11685");
            this.islandData = IslandData.getInstance();
            super(param1, param2);
            loadDisplay("res/islandcopyinfo.swf");
            return;
        }// end function

        public function get box1point() : Point
        {
            if (!this.btn_box1)
            {
                return new Point(0, 0);
            }
            return localToGlobal(new Point(this.btn_box1.x, this.btn_box1.y));
        }// end function

        public function get box2point() : Point
        {
            if (!this.btn_box2)
            {
                return new Point(0, 0);
            }
            return localToGlobal(new Point(this.btn_box2.x, this.btn_box2.y));
        }// end function

        public function get box3point() : Point
        {
            if (!this.btn_box3)
            {
                return new Point(0, 0);
            }
            return localToGlobal(new Point(this.btn_box3.x, this.btn_box3.y));
        }// end function

        public function get box4point() : Point
        {
            if (!this.btn_box4)
            {
                return new Point(0, 0);
            }
            return localToGlobal(new Point(this.btn_box4.x, this.btn_box4.y));
        }// end function

        override protected function displayReady() : void
        {
            initComponentUI("islandCopyInfo");
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.btn_box1 = new BaseButton(getDisplayChildByName("btn_box1"));
            this.btn_box2 = new BaseButton(getDisplayChildByName("btn_box2"));
            this.btn_box3 = new BaseButton(getDisplayChildByName("btn_box3"));
            this.btn_box4 = new BaseButton(getDisplayChildByName("btn_box4"));
            this.txt_num1 = getDisplayChildByName("txt_num1");
            this.txt_num2 = getDisplayChildByName("txt_num2");
            this.txt_num3 = getDisplayChildByName("txt_num3");
            this.txt_num4 = getDisplayChildByName("txt_num4");
            this.txt_exp = getDisplayChildByName("txt_exp");
            this.txtdowntime = getDisplayChildByName("txtdowntime");
            this.mc_effect = getDisplayChildByName("mc_effect");
            this.mc_effect.mouseChildren = false;
            this.mc_effect.mouseEnabled = false;
            this.btn_inspire_glod = new BaseButton(getDisplayChildByName("btn_inspire_glod"));
            this.btn_box = new BaseButton(getDisplayChildByName("btn_box"));
            this.btn_look = new BaseButton(getDisplayChildByName("btn_look"));
            this.update();
            this.updateDownTime(this._downTime, this.curStep);
            this.setKillMonsterCount(this.curStep);
            return;
        }// end function

        private function addEvents() : void
        {
            this.btn_inspire_glod.addEventListener(MouseEvent.CLICK, this.mouseClickHandler, false, 0, true);
            this.btn_box.addEventListener(MouseEvent.CLICK, this.mouseClickHandler, false, 0, true);
            this.btn_look.addEventListener(MouseEvent.CLICK, this.mouseClickHandler, false, 0, true);
            this.btn_box1.addEventListener(MouseEvent.CLICK, this.mouseClickHandler, false, 0, true);
            this.btn_box2.addEventListener(MouseEvent.CLICK, this.mouseClickHandler, false, 0, true);
            this.btn_box3.addEventListener(MouseEvent.CLICK, this.mouseClickHandler, false, 0, true);
            this.btn_box4.addEventListener(MouseEvent.CLICK, this.mouseClickHandler, false, 0, true);
            IslandData.getInstance().addEvtListener(IslandEvent.ISLAND_ELECMENTS_DATA_CHANGE, this.update);
            return;
        }// end function

        protected function mouseClickHandler(event:MouseEvent) : void
        {
            var needGold:int;
            var level:int;
            var str:String;
            var event:* = event;
            switch(event.target)
            {
                case this.btn_inspire_glod:
                {
                    if (this.curStep < 4)
                    {
                        needGold;
                        level;
                        str = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("10020", "lang_island"), [needGold, level]);
                        Global.popManager.cue(str, LanguageCfgObj.getInstance().getByIndex("10021", "lang_island"), null, function () : void
            {
                IslandControl.getInstance().reqGoldCombo();
                return;
            }// end function
            );
                    }
                    else
                    {
                        Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10019", "lang_island"));
                    }
                    break;
                }
                case this.btn_box:
                {
                    IslandControl.getInstance().openIslandBoxTips();
                    break;
                }
                case this.btn_box1:
                {
                    IslandControl.getInstance().openIslandBag(1);
                    break;
                }
                case this.btn_box2:
                {
                    IslandControl.getInstance().openIslandBag(2);
                    break;
                }
                case this.btn_box3:
                {
                    IslandControl.getInstance().openIslandBag(3);
                    break;
                }
                case this.btn_box4:
                {
                    IslandControl.getInstance().openIslandBag(4);
                    break;
                }
                case this.btn_look:
                {
                    PrimaryRoleControl.getInstance().openElementHeart();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function clickQuit() : void
        {
            var _loc_1:* = this.HIT_QUIT_INSTANCE;
            Global.popManager.cue(_loc_1, "", null, this.callClickYes);
            return;
        }// end function

        private function callClickYes() : void
        {
            ZonesControl.getInstance().reqZoneOut();
            return;
        }// end function

        public function update(event:IslandEvent = null) : void
        {
            if (UILoaded)
            {
                this.txt_num1.text = "×" + this.islandData.electments1.length;
                this.txt_num2.text = "×" + this.islandData.electments2.length;
                this.txt_num3.text = "×" + this.islandData.electments3.length;
                this.txt_num4.text = "×" + this.islandData.electments4.length;
                this.txt_exp.text = "" + this.islandData.totalExp;
            }
            return;
        }// end function

        public function setKillMonsterCount(param1:int) : void
        {
            this.curStep = param1;
            if (UILoaded)
            {
                if (this.curStep < 4 && !this.btn_inspire_glod.filters.length)
                {
                    ButtonFlickerControl.getInstance().addButtonFlicker(this.btn_inspire_glod);
                }
                else if (this.btn_inspire_glod.filters.length)
                {
                    ButtonFlickerControl.getInstance().removeButtonFlicker(this.btn_inspire_glod);
                }
            }
            return;
        }// end function

        public function updateDownTime(param1:int, param2:int) : void
        {
            if (!UILoaded)
            {
                this.curStep = param2;
                this._downTime = param1;
                return;
            }
            this.curStep = param2;
            this._downTime = param1;
            if (this.txtdowntime)
            {
                this.txtdowntime.text = "" + ToolKit.getTimeBySecond(this._downTime);
            }
            Ticker.killTimer(this.timeHandler);
            Ticker.registerTimer(1, this.timeHandler);
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
            if (this.txtdowntime)
            {
                this.txtdowntime.text = "" + ToolKit.getTimeBySecond(this._downTime);
            }
            if (this._downTime == 0)
            {
                Ticker.killTimer(this.timeHandler);
            }
            return;
        }// end function

        public function playEffect(param1:int) : void
        {
            var value:* = param1;
            if (this._effect == null)
            {
                this._effect = new VMCView();
            }
            this._effect.auto = true;
            this._effect.loadRes("res/effect/zones/fight.png");
            this._effect.updatePose("90", true);
            this._effect.replay();
            if (!this._effect.parent)
            {
                if (this.mc_effect)
                {
                    this.mc_effect.addChild(this._effect);
                }
            }
            TweenLite.delayedCall(value, function () : void
            {
                if (_effect)
                {
                    if (_effect.parent)
                    {
                        _effect.parent.removeChild(_effect);
                    }
                    _effect.stop();
                    _effect.finalize();
                    _effect = null;
                }
                return;
            }// end function
            );
            return;
        }// end function

        private function clear() : void
        {
            if (UILoaded)
            {
                this.txt_num1.text = "X0";
                this.txt_num2.text = "X0";
                this.txt_num3.text = "X0";
                this.txt_num4.text = "X0";
                this.txt_exp.text = "0";
            }
            return;
        }// end function

        public function open() : void
        {
            Global.mainUIManager.addUI(this, new LayoutInfo(Layout.RIGHT, 0, 170));
            this.update();
            return;
        }// end function

        public function close() : void
        {
            Global.mainUIManager.removeUI(this);
            Ticker.killTimer(this.timeHandler);
            this.clear();
            return;
        }// end function

    }
}
