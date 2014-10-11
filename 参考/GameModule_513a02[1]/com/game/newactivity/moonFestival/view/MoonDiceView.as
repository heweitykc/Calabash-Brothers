package com.game.newactivity.moonFestival.view
{
    import __AS3__.vec.*;
    import com.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.game.guide.control.*;
    import com.game.newactivity.control.*;
    import com.game.newactivity.model.*;
    import com.game.newactivity.moonFestival.control.*;
    import com.game.newactivity.moonFestival.model.*;
    import com.game.newactivity.moonFestival.view.*;
    import com.game.newactivity.moonFestival.view.tips.*;
    import com.greensock.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class MoonDiceView extends Component implements IMoonFestivalView
    {
        private var _scroeTxt:TextField;
        private var _scroeRankTxt:TextField;
        private var _changeTimesTxt:TextField;
        private var _lastTimesTxt:TextField;
        private var _moonDiceModel:MoonDiceModel;
        private var _dices:Vector.<DiceItem>;
        private var _scrollDices:Vector.<DiceShowItem>;
        private var _effect:MovieClip;
        private var _helpBtn:BaseButton;
        private var _rankTipsBtn:BaseButton;
        private var _firstTipsString:String = "";
        private var _secondTipsString:String = "";
        private var _thirdTipsString:String = "";
        private var _changeBtn:BaseButton;
        private var _confirmBtn:BaseButton;
        private var _startBtn:BaseButton;
        private var _freeChangeBtn:BaseButton;
        private var _info:NewActivityInfo;
        private var _changeTitleTxt:TextField;
        private var _firstAwardTxt:TextField;
        private var _secondAwardTxt:TextField;
        private var _thirdAwardTxt:TextField;
        private var _fourAwardTxt:TextField;
        private var _answer:MovieClip;
        private var _mooncakeCountTxt:TextField;
        private var _fractionTxt:TextField;
        private var _titleContainer:Sprite;
        private var _starttipsTxt:TextField;
        private var _delegate:MoonFestivalPanel;
        private var _ruleTips:DisplayObjectContainer;
        private var changeTips:String = "";
        private var _tempResult:int;
        private var _inEffect:Boolean;
        private var effectComplete:Boolean = true;
        private var effectCompleteId:int;
        private var updateTime:int;
        private var _scroeTime:int;

        public function MoonDiceView(param1 = null, param2:String = null)
        {
            super(param1, param2);
            this._moonDiceModel = MoonDiceModel.getInstance();
            this._info = NewActivityModel.getInstance().getActivityByActivityId(NewActivityConfig.ACTID_MOONFESTIVAL_1);
            this.initUI();
            this.initDices();
            this.addEvents();
            MoonFestivalControl.getInstance().openDiceReq();
            return;
        }// end function

        private function addEvents() : void
        {
            this._changeBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._confirmBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._startBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._freeChangeBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._helpBtn.addEvtListener(MouseEvent.ROLL_OVER, this.__helpOver);
            this._helpBtn.addEvtListener(MouseEvent.ROLL_OUT, this.__helpOut);
            return;
        }// end function

        private function __helpOver(event:MouseEvent) : void
        {
            this._ruleTips.visible = true;
            this.addChild(this._ruleTips);
            return;
        }// end function

        private function __helpOut(event:MouseEvent) : void
        {
            this._ruleTips.visible = false;
            if (this._ruleTips.parent)
            {
                this._ruleTips.parent.removeChild(this._ruleTips);
            }
            return;
        }// end function

        private function diceReq() : void
        {
            MoonFestivalControl.getInstance().diceReq(MoonDiceModel.CHANGE_OPER);
            return;
        }// end function

        private function __btnClick(event:Event) : void
        {
            var evt:* = event;
            switch(evt.target)
            {
                case this._changeBtn:
                {
                    if (this._inEffect)
                    {
                        return;
                    }
                    if (this._moonDiceModel.lastResult == MoonDiceModel.DICE_COUNT)
                    {
                        Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10008", MoonDiceModel.LANG_VER));
                        return;
                    }
                    if (!this._moonDiceModel.changeConfirm)
                    {
                        Global.popManager.cue(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("10007", MoonDiceModel.LANG_VER), [int(this._changeTimesTxt.text)]), "", null, this.diceReq, null, 2, null, false, true, function (param1:Boolean) : void
            {
                _moonDiceModel.changeConfirm = param1;
                return;
            }// end function
            );
                    }
                    else
                    {
                        this.diceReq();
                    }
                    break;
                }
                case this._confirmBtn:
                {
                    NewActivityControl.getInstance().getActivityReward(this._info.activityId, 0);
                    break;
                }
                case this._freeChangeBtn:
                {
                    if (this._inEffect)
                    {
                        return;
                    }
                    if (this._moonDiceModel.lastResult == MoonDiceModel.DICE_COUNT)
                    {
                        Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10008", MoonDiceModel.LANG_VER));
                        return;
                    }
                    MoonFestivalControl.getInstance().diceReq(MoonDiceModel.CHANGE_OPER);
                    break;
                }
                case this._startBtn:
                {
                    MoonFestivalControl.getInstance().diceReq(MoonDiceModel.START_OPER);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function resetDices() : void
        {
            var _loc_1:* = 0;
            while (_loc_1 < MoonDiceModel.DICE_COUNT)
            {
                
                this._dices[_loc_1].reset();
                this._scrollDices[_loc_1].reset();
                _loc_1++;
            }
            return;
        }// end function

        private function initDices() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            this._dices = new Vector.<DiceItem>;
            var _loc_1:* = 0;
            while (_loc_1 < 6)
            {
                
                _loc_3 = new DiceItem(getDisplayChildByName("item_" + (_loc_1 + 1)));
                _loc_3.visible = false;
                _loc_3.delegate = this;
                this._dices.push(_loc_3);
                _loc_1++;
            }
            var _loc_2:* = getDisplayChildByName("dicecontainer");
            this._scrollDices = new Vector.<DiceShowItem>;
            _loc_1 = 0;
            while (_loc_1 < 6)
            {
                
                _loc_4 = new DiceShowItem(_loc_2.getChildByName("item_" + (_loc_1 + 1)));
                this._scrollDices.push(_loc_4);
                _loc_1++;
            }
            return;
        }// end function

        public function createRankTips() : void
        {
            var _loc_1:* = new Object();
            ItemTips.create(this._rankTipsBtn, _loc_1, DiceLevelTips);
            return;
        }// end function

        public function createDiceItemRankTips() : void
        {
            return;
        }// end function

        private function initUI() : void
        {
            this._scroeRankTxt = getDisplayChildByName("txt_ScroeRank");
            this._scroeTxt = getDisplayChildByName("txt_scroe");
            this._changeTimesTxt = getDisplayChildByName("txt_changeTimes");
            this._changeTitleTxt = getDisplayChildByName("txt_change_tilte");
            this._lastTimesTxt = getDisplayChildByName("txt_lastTimes");
            this._titleContainer = getDisplayChildByName("title");
            this._mooncakeCountTxt = this._titleContainer.getChildByName("txt_mooncake_count") as TextField;
            this._fractionTxt = this._titleContainer.getChildByName("txt_fraction") as TextField;
            this._changeBtn = new BaseButton(getDisplayChildByName("btn_change"));
            this._freeChangeBtn = new BaseButton(getDisplayChildByName("btn_freechange"));
            this._confirmBtn = new BaseButton(getDisplayChildByName("btn_confirm"));
            this._startBtn = new BaseButton(getDisplayChildByName("btn_start"));
            this._rankTipsBtn = new BaseButton(getDisplayChildByName("btn_ranktip"));
            this._helpBtn = new BaseButton(getDisplayChildByName("btn_help"));
            this._starttipsTxt = getDisplayChildByName("txt_starttips");
            this._ruleTips = getDisplayChildByName("rule");
            this._ruleTips.visible = false;
            this._firstAwardTxt = this._ruleTips.getChildByName("txt_first") as TextField;
            this._secondAwardTxt = this._ruleTips.getChildByName("txt_second") as TextField;
            this._answer = getDisplayChildByName("answer") as MovieClip;
            this._answer.gotoAndStop(1);
            this._answer.visible = false;
            this._effect = getDisplayChildByName("effect");
            this._effect.gotoAndStop(1);
            this._effect.visible = false;
            return;
        }// end function

        public function updateByActInfo(param1:NewActivityInfo) : void
        {
            return;
        }// end function

        private function __allShowComplete(event:Event) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_2:* = event.target as MovieClip;
            if (_loc_2.currentFrame == _loc_2.totalFrames)
            {
                _loc_3 = [0, 1, 2, 3, 4, 5];
                _loc_4 = 0;
                while (_loc_4 < this._moonDiceModel.lastResult)
                {
                    
                    _loc_6 = Math.random() * _loc_3.length;
                    this._dices[_loc_3[_loc_6]].showFour();
                    this._scrollDices[_loc_4].stopScroll(6);
                    this._dices[_loc_3[_loc_6]].visible = true;
                    _loc_3.splice(_loc_6, 1);
                    _loc_4++;
                }
                _loc_5 = _loc_4;
                _loc_4 = 0;
                while (_loc_4 < MoonDiceModel.DICE_COUNT - this._moonDiceModel.lastResult)
                {
                    
                    _loc_6 = this._dices[_loc_3[_loc_4]].showNum();
                    this._scrollDices[_loc_5 + _loc_4].stopScroll(_loc_6);
                    this._dices[_loc_3[_loc_4]].visible = true;
                    _loc_4++;
                }
                this._answer.visible = true;
                this._answer.gotoAndStop((this._moonDiceModel.lastResult + 1));
                this._inEffect = false;
                this._effect.removeEventListener(Event.ENTER_FRAME, this.__allShowComplete, false);
                this._effect.visible = false;
                this._effect.gotoAndStop(1);
                this._fractionTxt.text = this._moonDiceModel.addFraction.toString();
                this._mooncakeCountTxt.text = this._moonDiceModel.itemCount.toString();
                this.showScroe();
                ButtonFlickerControl.getInstance().addButtonFlicker(this._confirmBtn);
                if (this._freeChangeBtn.visible)
                {
                    ButtonFlickerControl.getInstance().addButtonFlicker(this._freeChangeBtn);
                }
                else
                {
                    ButtonFlickerControl.getInstance().addButtonFlicker(this._changeBtn);
                }
                this.confirmEffectComplete();
            }
            return;
        }// end function

        public function showResult(param1:int) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            this._tempResult = param1;
            if (this._moonDiceModel.opertype == MoonDiceModel.BO_CAKE)
            {
                _loc_2 = 0;
                while (_loc_2 < MoonDiceModel.DICE_COUNT)
                {
                    
                    this._dices[_loc_2].visible = false;
                    this._scrollDices[_loc_2].startScroll();
                    _loc_2++;
                }
                this._inEffect = true;
                this._effect.addEventListener(Event.ENTER_FRAME, this.__allShowComplete, false, 0, true);
                this._moonDiceModel.lastResult = param1;
                this._moonDiceModel.isDiced = true;
                this._effect.visible = true;
                this._effect.play();
            }
            else if (this._moonDiceModel.opertype == MoonDiceModel.CHANGE_CAKE)
            {
                this._moonDiceModel.isDiced = true;
                ButtonFlickerControl.getInstance().removeButtonFlicker(this._confirmBtn);
                if (this._freeChangeBtn.visible)
                {
                    ButtonFlickerControl.getInstance().removeButtonFlicker(this._freeChangeBtn);
                }
                else
                {
                    ButtonFlickerControl.getInstance().removeButtonFlicker(this._changeBtn);
                }
                _loc_3 = [];
                _loc_2 = 0;
                while (_loc_2 < this._dices.length)
                {
                    
                    if (!this._dices[_loc_2].isFour && !this._dices[_loc_2].tempFour)
                    {
                        _loc_3.push(_loc_2);
                    }
                    this._dices[_loc_2].complete = true;
                    _loc_2++;
                }
                _loc_2 = this._moonDiceModel.lastResult;
                while (_loc_2 < MoonDiceModel.DICE_COUNT)
                {
                    
                    this._scrollDices[_loc_2].startScroll();
                    _loc_2++;
                }
                _loc_2 = 0;
                while (_loc_2 < this._tempResult - this._moonDiceModel.lastResult)
                {
                    
                    if (_loc_3.length > 0)
                    {
                        _loc_5 = Math.random() * _loc_3.length;
                        this._dices[_loc_3[_loc_5]].animationShowNum(this._moonDiceModel.lastResult + _loc_2, true);
                        _loc_3.splice(_loc_5, 1);
                    }
                    this._scrollDices[this._moonDiceModel.lastResult + _loc_2].willBeFour = true;
                    _loc_2++;
                }
                _loc_4 = _loc_2;
                _loc_2 = 0;
                while (_loc_2 < _loc_3.length)
                {
                    
                    this._dices[_loc_3[_loc_2]].animationShowNum(this._tempResult + _loc_2);
                    _loc_2++;
                }
                this._moonDiceModel.lastResult = this._tempResult;
            }
            else if (this._moonDiceModel.opertype == MoonDiceModel.GET_AWARD)
            {
                this._moonDiceModel.isDiced = false;
                if (this._effect)
                {
                    this._effect.visible = false;
                    this._effect.gotoAndStop(1);
                    this._effect.removeEventListener(Event.ENTER_FRAME, this.__allShowComplete, false);
                }
                ButtonFlickerControl.getInstance().removeButtonFlicker(this._confirmBtn);
                if (this._freeChangeBtn.visible)
                {
                    ButtonFlickerControl.getInstance().removeButtonFlicker(this._freeChangeBtn);
                }
                else
                {
                    ButtonFlickerControl.getInstance().removeButtonFlicker(this._changeBtn);
                }
                this.resetDices();
                _loc_2 = 0;
                while (_loc_2 < MoonDiceModel.DICE_COUNT)
                {
                    
                    _loc_5 = this._dices[_loc_2].showNum();
                    this._scrollDices[_loc_2].stopScroll(_loc_5);
                    this._dices[_loc_2].visible = true;
                    _loc_2++;
                }
                this._fractionTxt.text = this._moonDiceModel.addFraction.toString();
                this._mooncakeCountTxt.text = this._moonDiceModel.itemCount.toString();
                this.showScroe();
                this._answer.gotoAndStop((this._moonDiceModel.lastResult + 1));
                this._answer.visible = false;
            }
            return;
        }// end function

        public function updateBtnStatus() : void
        {
            if (this._moonDiceModel.lasttimes <= 0)
            {
                this._startBtn.enabled = false;
            }
            else
            {
                this._startBtn.enabled = true;
            }
            this._freeChangeBtn.visible = this._moonDiceModel.changetimes < MoonDiceModel.FREE_CHANGE_TIMES ? (true) : (false);
            this._changeBtn.visible = !this._freeChangeBtn.visible;
            if (this._moonDiceModel.addFraction == 0)
            {
                this._freeChangeBtn.enabled = false;
                this._changeBtn.enabled = false;
                this._confirmBtn.enabled = false;
                this._freeChangeBtn.filters = [FrameworkGlobal.colorMat];
                this._changeBtn.filters = [FrameworkGlobal.colorMat];
                this._confirmBtn.filters = [FrameworkGlobal.colorMat];
            }
            else
            {
                this._freeChangeBtn.enabled = true;
                this._changeBtn.enabled = true;
                this._confirmBtn.enabled = true;
                this._freeChangeBtn.filters = [];
                this._changeBtn.filters = [];
                this._confirmBtn.filters = [];
            }
            return;
        }// end function

        public function singleEffectComplete(param1:int, param2:int) : void
        {
            this._scrollDices[param2].stopScroll(param1);
            var _loc_3:* = true;
            var _loc_4:* = 0;
            while (_loc_4 < MoonDiceModel.DICE_COUNT)
            {
                
                if (!this._dices[_loc_4].complete)
                {
                    _loc_3 = false;
                    break;
                }
                _loc_4++;
            }
            if (_loc_3)
            {
                _loc_4 = 0;
                while (_loc_4 < MoonDiceModel.DICE_COUNT)
                {
                    
                    this._scrollDices[_loc_4].locked = false;
                    _loc_4++;
                }
                this._fractionTxt.text = this._moonDiceModel.addFraction.toString();
                this._mooncakeCountTxt.text = this._moonDiceModel.itemCount.toString();
                this.showScroe();
                this._answer.gotoAndStop((this._moonDiceModel.lastResult + 1));
                this._answer.visible = true;
            }
            clearTimeout(this.effectCompleteId);
            this.effectCompleteId = setTimeout(this.confirmEffectComplete, 100);
            if (this._tempResult != -1)
            {
                this._tempResult = -1;
            }
            return;
        }// end function

        private function confirmEffectComplete() : void
        {
            if (this._delegate)
            {
                if (this._delegate.isDiceActivate && this._delegate.isOpen)
                {
                    this.effectComplete = true;
                }
                else
                {
                    this.effectComplete = false;
                }
            }
            return;
        }// end function

        private function showScroe() : void
        {
            if (this._moonDiceModel.scroeAdd)
            {
                FrameworkGlobal.stageAddEvtListener(Event.ENTER_FRAME, this.__scroeUpdate);
            }
            else
            {
                this._scroeTxt.text = this._moonDiceModel.scroe.toString();
            }
            return;
        }// end function

        public function getCost(param1:int) : String
        {
            var _loc_2:* = null;
            if (param1 > 40)
            {
                _loc_2 = "55";
            }
            else if (param1 > 35)
            {
                _loc_2 = "45";
            }
            else
            {
                _loc_2 = (int(param1 / 5) * 5 + 5).toString();
            }
            return _loc_2;
        }// end function

        public function showInfo() : void
        {
            if (this._moonDiceModel.changetimes < MoonDiceModel.FREE_CHANGE_TIMES)
            {
                this._changeTimesTxt.text = (MoonDiceModel.FREE_CHANGE_TIMES - this._moonDiceModel.changetimes).toString();
                this._changeTitleTxt.text = LanguageCfgObj.getInstance().getByIndex("10001", MoonDiceModel.LANG_VER);
            }
            else
            {
                this._changeTimesTxt.text = this.getCost(this._moonDiceModel.changetimes);
                this.changeTips = LanguageCfgObj.getInstance().getByIndex("10002", MoonDiceModel.LANG_VER) + this._changeTimesTxt.text;
                this._changeTitleTxt.text = LanguageCfgObj.getInstance().getByIndex("10002", MoonDiceModel.LANG_VER);
                StringTip.create(this._changeBtn, this.changeTips);
            }
            this.showLastTimes();
            if (this._moonDiceModel.rankScroe > 0)
            {
                this._scroeRankTxt.text = this._moonDiceModel.rankScroe.toString();
            }
            else
            {
                this._scroeRankTxt.text = LanguageCfgObj.getInstance().getByIndex("10003", MoonDiceModel.LANG_VER);
            }
            this._lastTimesTxt.text = this._moonDiceModel.lasttimes.toString();
            this._firstTipsString = this.getAwardStr(this._moonDiceModel.firstItems);
            this._firstAwardTxt.text = this._firstTipsString;
            this._secondTipsString = this.getAwardStr(this._moonDiceModel.secondItems);
            this._secondAwardTxt.text = this._secondTipsString;
            this._titleContainer.visible = this._moonDiceModel.addFraction > 0 ? (true) : (false);
            this._starttipsTxt.visible = !this._titleContainer.visible;
            return;
        }// end function

        private function showLastTimes() : void
        {
            if (this._moonDiceModel.lasttimeReduce)
            {
                FrameworkGlobal.stageAddEvtListener(Event.ENTER_FRAME, this.__flashUpdate);
            }
            else
            {
                this._lastTimesTxt.text = this._moonDiceModel.lasttimes.toString();
            }
            return;
        }// end function

        private function __flashUpdate(event:Event) : void
        {
            var txt:TextField;
            var textformat:TextFormat;
            var evt:* = event;
            if (this.updateTime % 2 == 0)
            {
                this._lastTimesTxt.textColor = this._lastTimesTxt.textColor == 16777215 ? (16711680) : (268435455);
            }
            var _loc_3:* = this;
            var _loc_4:* = this.updateTime + 1;
            _loc_3.updateTime = _loc_4;
            if (this.updateTime > FrameworkGlobal.stage.frameRate * 0.2)
            {
                this._lastTimesTxt.text = this._moonDiceModel.lasttimes.toString();
                txt = new TextField();
                txt.text = "-1";
                textformat = txt.defaultTextFormat;
                textformat.size = 14;
                textformat.font = "SimSun";
                txt.textColor = 16719360;
                txt.defaultTextFormat = textformat;
                txt.filters = [FrameworkGlobal.BLACK_FILTER];
                txt.x = this._lastTimesTxt.x + this._lastTimesTxt.width / 2 + 10;
                txt.y = this._lastTimesTxt.y + 10;
                addChild(txt);
                TweenLite.to(txt, 1, {y:txt.y - 30, onComplete:function () : void
            {
                if (txt.parent)
                {
                    txt.parent.removeChild(txt);
                }
                return;
            }// end function
            });
                this.updateTime = 0;
                this._lastTimesTxt.textColor = 52224;
                FrameworkGlobal.stageRemoveEvtListener(Event.ENTER_FRAME, this.__flashUpdate);
            }
            return;
        }// end function

        private function __scroeUpdate(event:Event) : void
        {
            var txt:TextField;
            var textformat:TextFormat;
            var evt:* = event;
            if (this._scroeTime % 2 == 0)
            {
                this._scroeTxt.textColor = this._scroeTxt.textColor == 16777215 ? (16711680) : (268435455);
            }
            var _loc_3:* = this;
            var _loc_4:* = this._scroeTime + 1;
            _loc_3._scroeTime = _loc_4;
            if (this._scroeTime > FrameworkGlobal.stage.frameRate * 0.2)
            {
                this._scroeTxt.text = this._moonDiceModel.scroe.toString();
                txt = new TextField();
                txt.text = "+" + this._moonDiceModel.scroeAdd;
                txt.textColor = 52224;
                txt.filters = [FrameworkGlobal.BLACK_FILTER];
                textformat = txt.defaultTextFormat;
                textformat.size = 14;
                textformat.font = "SimSun";
                txt.textColor = 16719360;
                txt.defaultTextFormat = textformat;
                txt.x = this._scroeTxt.x + this._scroeTxt.width / 2 + 10;
                txt.y = this._scroeTxt.y + 10;
                addChild(txt);
                TweenLite.to(txt, 1, {y:txt.y - 30, onComplete:function () : void
            {
                if (txt.parent)
                {
                    txt.parent.removeChild(txt);
                }
                return;
            }// end function
            });
                this._scroeTime = 0;
                this._scroeTxt.textColor = 52224;
                FrameworkGlobal.stageRemoveEvtListener(Event.ENTER_FRAME, this.__scroeUpdate);
            }
            return;
        }// end function

        override public function set visible(param1:Boolean) : void
        {
            super.visible = param1;
            if (!param1)
            {
                this.clear();
            }
            return;
        }// end function

        public function clear() : void
        {
            FrameworkGlobal.stageRemoveEvtListener(Event.ENTER_FRAME, this.__flashUpdate);
            FrameworkGlobal.stageRemoveEvtListener(Event.ENTER_FRAME, this.__scroeUpdate);
            this._lastTimesTxt.text = this._moonDiceModel.lasttimes.toString();
            this._lastTimesTxt.textColor = 52224;
            this._scroeTxt.text = this._moonDiceModel.scroe.toString();
            this._scroeTxt.textColor = 52224;
            this._inEffect = false;
            if (this._effect)
            {
                this._effect.visible = false;
                this._effect.gotoAndStop(1);
                this._effect.removeEventListener(Event.ENTER_FRAME, this.__allShowComplete, false);
            }
            ButtonFlickerControl.getInstance().removeButtonFlicker(this._confirmBtn);
            if (this._freeChangeBtn.visible)
            {
                ButtonFlickerControl.getInstance().removeButtonFlicker(this._freeChangeBtn);
            }
            else
            {
                ButtonFlickerControl.getInstance().removeButtonFlicker(this._changeBtn);
            }
            return;
        }// end function

        public function getAwardStr(param1:String) : String
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_2:* = param1.split(";");
            var _loc_3:* = "";
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2.length)
            {
                
                _loc_5 = _loc_2[_loc_4] as String;
                if (_loc_5)
                {
                    if (_loc_5.charAt(0) == "!")
                    {
                        _loc_5 = _loc_5.slice(1);
                        _loc_6 = _loc_5.split("_");
                        _loc_7 = PropUtil.createItemByCfg(_loc_6[0]);
                        if (_loc_7)
                        {
                            _loc_3 = _loc_3 + _loc_7.q_name;
                        }
                    }
                }
                _loc_4++;
            }
            _loc_3 = _loc_3 + ("、" + LanguageCfgObj.getInstance().getByIndex("10005", MoonDiceModel.LANG_VER));
            return _loc_3;
        }// end function

        public function clearCurRoundScroe() : void
        {
            this._fractionTxt.text = "";
            this._mooncakeCountTxt.text = "";
            return;
        }// end function

        public function showDice() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            if (!this._moonDiceModel.isDiced || !this.effectComplete || this._moonDiceModel.lasttimes == MoonDiceModel.FULL_TIMES)
            {
                _loc_1 = [0, 1, 2, 3, 4, 5];
                _loc_2 = 0;
                while (_loc_2 < this._moonDiceModel.lastResult)
                {
                    
                    _loc_5 = Math.random() * _loc_1.length;
                    this._dices[_loc_1[_loc_5]].showFour();
                    this._scrollDices[_loc_2].stopScroll(6);
                    this._dices[_loc_1[_loc_5]].visible = true;
                    _loc_1.splice(_loc_5, 1);
                    _loc_2++;
                }
                _loc_3 = _loc_2;
                _loc_4 = this._moonDiceModel.lastResult > 0 ? (this._moonDiceModel.lastResult) : (0);
                _loc_2 = 0;
                while (_loc_2 < 6 - this._moonDiceModel.lastResult)
                {
                    
                    _loc_5 = this._dices[_loc_1[_loc_2]].showNum();
                    this._scrollDices[_loc_2 + _loc_3].stopScroll(_loc_5);
                    this._dices[_loc_1[_loc_2]].visible = true;
                    _loc_2++;
                }
                this._fractionTxt.text = this._moonDiceModel.addFraction.toString();
                this._mooncakeCountTxt.text = this._moonDiceModel.itemCount.toString();
                this._scroeTxt.text = this._moonDiceModel.scroe.toString();
                if (this._moonDiceModel.addFraction > 0)
                {
                    this._answer.gotoAndStop((this._moonDiceModel.lastResult + 1));
                    this._answer.visible = true;
                }
                else
                {
                    this._answer.visible = false;
                }
                this._moonDiceModel.isDiced = true;
                this.effectComplete = true;
            }
            return;
        }// end function

    }
}
