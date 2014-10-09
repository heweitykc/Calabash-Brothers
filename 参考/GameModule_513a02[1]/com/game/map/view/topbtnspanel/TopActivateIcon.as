package com.game.map.view.topbtnspanel
{
    import com.cfg.obj.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.game.map.control.*;
    import com.util.*;
    import flash.display.*;
    import flash.events.*;

    public class TopActivateIcon extends BaseButton
    {
        private var _countNum:String = "0";
        private var _CD:int;
        private var _topIconCount:BaseButton;
        private var _topIconCount2:BaseButton;
        private var _downTime:DownTimer;
        private var _index:int;
        private var _line:int;
        private var _nameTop:String;
        private var _tips:String;
        private var _isShowFirstClickSign:Boolean = false;
        private var _normalEffect:VMCView;
        private var _gantan:DisplayObject;
        public static const WIDTH:int = 64;
        public static const HEIGHT:int = 72;
        public static const ROW_MAX_COUNT:int = 8;
        public static const EFFECT_NORMAL:int = 0;
        public static const EFFECT_FIRST_CLICK:int = 1;
        public static const EFFECT_FUNC_EFFECT:int = 2;

        public function TopActivateIcon(param1 = null, param2:Boolean = false, param3 = null)
        {
            initBaseButtonUI(param1, param2, param3);
            this.initIcon();
            this._nameTop = param1 as String;
            this._index = TopActivateCfgObj.getInstance().getButtonSortId(param1);
            this._line = Math.floor(this._index / 100);
            return;
        }// end function

        private function initIcon() : void
        {
            this._topIconCount = new BaseButton("top_icon_count");
            this._topIconCount._x = WIDTH - 25;
            this._topIconCount2 = new BaseButton("top_icon_count2");
            this._topIconCount2._x = WIDTH - 25;
            this.addChild(this._topIconCount);
            this.addChild(this._topIconCount2);
            this._topIconCount.visible = false;
            this._topIconCount2.visible = false;
            this._gantan = ToolKit.getNewDO("iconUI_comon");
            this._gantan.x = WIDTH - 17;
            this._gantan.y = 5;
            addChild(this._gantan);
            this._gantan.visible = false;
            return;
        }// end function

        public function setEffect(param1:Boolean, param2:int) : void
        {
            switch(param2)
            {
                case EFFECT_NORMAL:
                {
                    if (param1)
                    {
                        this.showNormalEffect();
                    }
                    else
                    {
                        this.removeNormalEffect();
                    }
                    break;
                }
                case EFFECT_FUNC_EFFECT:
                {
                    this.showFuncEffect();
                    break;
                }
                case EFFECT_FIRST_CLICK:
                {
                    this.showFirstClickEffect(param1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function get countText() : String
        {
            return this._countNum;
        }// end function

        public function set countText(param1:String) : void
        {
            this._countNum = param1;
            this.setCountText();
            return;
        }// end function

        private function setCountText(param1:String = null) : void
        {
            if (!param1)
            {
                param1 = this._countNum;
            }
            if (param1 == "0" && this._isShowFirstClickSign)
            {
                param1 = "!";
            }
            var _loc_2:* = this.getCount(param1);
            if (_loc_2 == -1)
            {
                this._topIconCount.visible = true;
            }
            else
            {
                this._topIconCount.visible = _loc_2 > 0 && _loc_2 < 10;
                this._topIconCount2.visible = _loc_2 >= 10;
            }
            if (param1 == "!")
            {
                this._gantan.visible = true;
                param1 = "";
            }
            else
            {
                this._gantan.visible = false;
            }
            this._topIconCount.setText(param1);
            this._topIconCount2.setText(param1);
            return;
        }// end function

        private function getCount(param1:String = null) : int
        {
            var _loc_2:* = 0;
            if (!param1)
            {
                param1 = this._countNum;
            }
            if (isNaN(Number(param1)))
            {
                _loc_2 = -1;
            }
            else
            {
                _loc_2 = int(param1);
            }
            return _loc_2;
        }// end function

        public function showNormalEffect() : void
        {
            if (this._normalEffect)
            {
                return;
            }
            this._normalEffect = new VMCView();
            var _loc_1:* = "res/effect/top_icon_effect_blue.png";
            this._normalEffect.move(32, 33);
            addChild(this._normalEffect);
            this.setChildIndex(this._normalEffect, 1);
            this._normalEffect.auto = true;
            this._normalEffect.updatePose("90", true);
            this._normalEffect.loadRes(_loc_1, null, true);
            return;
        }// end function

        public function removeNormalEffect() : void
        {
            if (this._normalEffect)
            {
                removeChild(this._normalEffect);
                this._normalEffect.finalize();
                this._normalEffect = null;
            }
            return;
        }// end function

        private function showFuncEffect() : void
        {
            var _loc_3:* = false;
            mouseEnabled = false;
            mouseChildren = _loc_3;
            var _loc_1:* = new VMCView();
            var _loc_2:* = "res/effect/functionactive.png";
            this.addChild(_loc_1);
            _loc_1.move(32, 33);
            _loc_1.auto = true;
            _loc_1.updatePose("90", false, false, true, true);
            _loc_1.loadRes(_loc_2);
            _loc_1.addEventListener(Event.COMPLETE, this.showFunEffectComplete, false, 0, true);
            return;
        }// end function

        private function showFunEffectComplete(event:Event) : void
        {
            var _loc_2:* = true;
            mouseEnabled = true;
            mouseChildren = _loc_2;
            FrameworkGlobal.sendMsg(new GameEvent(GameEvent.TOP_ACTIVATE_BTN_MOVE_EFFECT_COMPLETE));
            return;
        }// end function

        private function showFirstClickEffect(param1:Boolean) : void
        {
            this._isShowFirstClickSign = param1;
            var _loc_2:* = this.getCount();
            if (param1 && _loc_2 <= 0)
            {
                this.setCountText("!");
            }
            else
            {
                this.setCountText();
                this.countText = this._countNum;
            }
            return;
        }// end function

        public function get CD() : int
        {
            return this._CD;
        }// end function

        public function set CD(param1:int) : void
        {
            this._CD = param1;
            this.setCD();
            return;
        }// end function

        private function setCD() : void
        {
            if (this._CD > 0)
            {
                if (!this._downTime)
                {
                    this._downTime = new DownTimer();
                    this._downTime.callBack = this.callCDDownBack;
                }
                this.removeNormalEffect();
            }
            else
            {
                this.setText("");
                this.showNormalEffect();
            }
            if (this._downTime)
            {
                this._downTime.count = this._CD * 1000;
            }
            return;
        }// end function

        private function callCDDownBack(param1:uint, param2:String) : void
        {
            var _loc_3:* = 0;
            if (param1 > 0)
            {
                if (param1 < 86400000)
                {
                    this.setText(param2);
                }
                else
                {
                    _loc_3 = param1 / 86400000;
                    this.setText(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12435"), [_loc_3]));
                }
            }
            else
            {
                this.setText("");
                if (this._nameTop == TopActivateName.RECHARGE_DAYS)
                {
                    MapControl.getInstance().topActivateRemoveBtn(this._nameTop);
                }
                if (this._nameTop == TopActivateName.GIFT_NOTHINK)
                {
                    MapControl.getInstance().topActivateRemoveBtn(this._nameTop);
                }
            }
            return;
        }// end function

        public function get index() : int
        {
            return this._index;
        }// end function

        public function set index(param1:int) : void
        {
            this._index = param1;
            return;
        }// end function

        public function get line() : int
        {
            return this._line;
        }// end function

        public function set line(param1:int) : void
        {
            this._line = param1;
            return;
        }// end function

        public function get nameTop() : String
        {
            return this._nameTop;
        }// end function

        public function set nameTop(param1:String) : void
        {
            this._nameTop = param1;
            return;
        }// end function

        public function get tips() : String
        {
            return this._tips;
        }// end function

        public function set tips(param1:String) : void
        {
            this._tips = param1;
            if (param1 && param1.length > 0)
            {
                StringTip.dispose(this);
                StringTip.create(this, param1);
            }
            return;
        }// end function

    }
}
