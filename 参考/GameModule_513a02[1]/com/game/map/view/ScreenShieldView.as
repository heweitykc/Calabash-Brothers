package com.game.map.view
{
    import com.cfg.obj.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.manager.keyboard.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.game.map.event.*;
    import com.game.map.model.*;
    import com.greensock.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class ScreenShieldView extends Component
    {
        private const SHIELD_ZONES_COUNTRY:String;
        private const SHIELD_AWAIT_FUNCTION:String;
        private var _back:Sprite;
        private var _btnAllSelect:BaseButton;
        private var _btnNormalMonster:BaseButton;
        private var _btnOtherRole:BaseButton;
        private var _btnScreenEffect:BaseButton;
        private var _btnOtherShowModel:BaseButton;
        private var _btnCenterBus:BaseButton;
        private var _txtOtherShowModel:TextField;
        private var _cueBox:ScreenShieldCueBox;
        private var _oldState:int = -1;
        private var isShowCountryBox:Boolean = true;
        private var _isAwart:Boolean = true;

        public function ScreenShieldView(param1 = null, param2:String = null)
        {
            this.SHIELD_ZONES_COUNTRY = LanguageCfgObj.getInstance().getByIndex("10952");
            this.SHIELD_AWAIT_FUNCTION = LanguageCfgObj.getInstance().getByIndex("10953");
            initComponentUI("screen_shield_view");
            this.initUI();
            this.move(20, 20);
            this.addEvents();
            this.initSelect();
            this.mouseChildren = true;
            return;
        }// end function

        private function initUI() : void
        {
            this._back = getDisplayChildByName("back") as Sprite;
            this._btnAllSelect = new BaseButton(getDisplayChildByName("btn_check1"), true);
            this._btnNormalMonster = new BaseButton(getDisplayChildByName("btn_check2"), true);
            this._btnOtherRole = new BaseButton(getDisplayChildByName("btn_check3"), true);
            this._btnScreenEffect = new BaseButton(getDisplayChildByName("btn_check4"), true);
            this._btnOtherShowModel = new BaseButton(getDisplayChildByName("btn_check5"), true);
            this._txtOtherShowModel = TextField(getDisplayChildByName("txt_other_show_model"));
            return;
        }// end function

        private function initSelect() : void
        {
            return;
        }// end function

        private function addEvents() : void
        {
            addEvtListener(MouseEvent.CLICK, this.mouseClickHandler);
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            FrameworkGlobal.addMsgListen("showBgEffect", this.ShowScreenEffect);
            FrameworkGlobal.addMsgListen("hideBgEffect", this.HideScreenEffect);
            FrameworkGlobal.addMsgListen(MapEvent.MAP_CHANGE, this.onChangeMapHandler);
            KeyboardManager.addEventListener(KeyboardEvent.KEY_UP, this.cancelAwart);
            FrameworkGlobal.stageAddEvtListener(MouseEvent.MOUSE_MOVE, this.cancelAwart);
            Ticker.registerTimer(600, this.startCheck);
            return;
        }// end function

        private function cancelAwart(event:Event) : void
        {
            this._isAwart = false;
            return;
        }// end function

        private function startCheck() : void
        {
            if (this._isAwart)
            {
                this.setAwaitFunction();
            }
            this._isAwart = true;
            return;
        }// end function

        private function onChangeMapHandler(event:MapEvent) : void
        {
            var _loc_2:* = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID);
            if (_loc_2.zones_type != ZoneType.ZONES_COUNTRY)
            {
                if (this._btnOtherShowModel.selected)
                {
                    this._btnOtherShowModel.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                }
            }
            else if (this.isShowCountryBox)
            {
                TweenLite.delayedCall(5, this.setZonesCountryState);
                this.isShowCountryBox = false;
            }
            return;
        }// end function

        private function HideScreenEffect(event:Event) : void
        {
            this._btnScreenEffect.selected = true;
            this.setCenterBus();
            return;
        }// end function

        private function ShowScreenEffect(event:Event) : void
        {
            this._btnScreenEffect.selected = false;
            this.setCenterBus();
            return;
        }// end function

        protected function onAddedToStage(event:Event) : void
        {
            var _loc_2:* = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID);
            if (_loc_2 && _loc_2.zones_type == ZoneType.ZONES_COUNTRY)
            {
                this._btnOtherShowModel.visible = true;
                this._txtOtherShowModel.visible = true;
                this._back.height = 150;
            }
            else
            {
                this._btnOtherShowModel.visible = false;
                this._txtOtherShowModel.visible = false;
                this._back.height = 120;
            }
            return;
        }// end function

        public function setBtnCenterBus(param1:BaseButton) : void
        {
            this._btnCenterBus = param1;
            this._btnCenterBus.addEventListener(MouseEvent.CLICK, this.clickCenterBus);
            return;
        }// end function

        protected function clickCenterBus(event:MouseEvent) : void
        {
            var _loc_2:* = this._btnCenterBus.selected;
            if (_loc_2)
            {
                this._btnOtherRole.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            }
            else
            {
                this._btnAllSelect.selected = _loc_2;
                this.selectAllBtn(_loc_2);
            }
            return;
        }// end function

        private function mouseClickHandler(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            event.stopImmediatePropagation();
            switch(event.target)
            {
                case this._btnAllSelect:
                {
                    this.selectAllBtn(this._btnAllSelect.selected);
                    break;
                }
                case this._btnScreenEffect:
                {
                    UICfg.SCREEN_EFFECT = this._btnScreenEffect.selected;
                    FrameworkGlobal.isShowGameEffect = !UICfg.SCREEN_EFFECT;
                    if (UICfg.SCREEN_EFFECT)
                    {
                        FrameworkGlobal.sendMsg(new Event("hideBgEffect"));
                    }
                    else
                    {
                        FrameworkGlobal.sendMsg(new Event("showBgEffect"));
                    }
                    break;
                }
                case this._btnNormalMonster:
                {
                    UICfg.NORMAL_MONSTER = this._btnNormalMonster.selected;
                    FrameworkGlobal.sendMsg(new GameEvent(GameEvent.SHOW_OR_HIDE_MONSTER));
                    break;
                }
                case this._btnOtherRole:
                {
                    UICfg.hideOtherPlayer = this._btnOtherRole.selected;
                    _loc_3 = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID);
                    if (_loc_3 && _loc_3.zones_type == ZoneType.ZONES_COUNTRY && this._btnOtherRole.selected && this._btnOtherShowModel.selected)
                    {
                        this._btnOtherShowModel.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                    }
                    FrameworkGlobal.sendMsg(new GameEvent(GameEvent.SHOW_OR_HIDE_PLAYERS));
                    break;
                }
                case this._btnOtherShowModel:
                {
                    UICfg.OTHER_NORMAL_MODEL = this._btnOtherShowModel.selected;
                    if (this._btnOtherRole.selected && this._btnOtherShowModel.selected)
                    {
                        this._btnOtherRole.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                    }
                    FrameworkGlobal.sendMsg(new GameEvent(GameEvent.OTHER_NORMAL_MODEL));
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.setCenterBus();
            return;
        }// end function

        private function selectAllBtn(param1:Boolean) : void
        {
            if (param1 != this._btnOtherRole.selected)
            {
                this._btnOtherRole.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            }
            if (param1 != this._btnScreenEffect.selected)
            {
                this._btnScreenEffect.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            }
            if (param1 != this._btnNormalMonster.selected)
            {
                this._btnNormalMonster.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            }
            return;
        }// end function

        private function setCenterBus() : void
        {
            var _loc_1:* = this._btnScreenEffect.selected || this._btnNormalMonster.selected || this._btnOtherRole.selected || this._btnOtherShowModel.selected;
            this._btnCenterBus.selected = _loc_1;
            var _loc_2:* = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID);
            var _loc_3:* = this._btnScreenEffect.selected && this._btnNormalMonster.selected && this._btnOtherRole.selected;
            this._btnAllSelect.selected = _loc_3;
            return;
        }// end function

        private function setZonesCountryState() : void
        {
            var _loc_1:* = 1;
            var _loc_2:* = this.getBtnStateStr();
            this._oldState = parseInt(_loc_2, 2);
            _loc_1 = _loc_1 | this._oldState;
            this.setBtnState(_loc_1.toString(2));
            this.showPopCueBox(this.SHIELD_ZONES_COUNTRY);
            return;
        }// end function

        public function setAwaitFunction() : void
        {
            if (this._cueBox && this._cueBox.parent)
            {
                return;
            }
            if (this._btnAllSelect.selected)
            {
                return;
            }
            var _loc_1:* = this.getBtnStateStr();
            this._oldState = parseInt(_loc_1, 2);
            this._btnAllSelect.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            this.showPopCueBox(this.SHIELD_AWAIT_FUNCTION);
            return;
        }// end function

        private function getBtnStateStr() : String
        {
            var _loc_1:* = "";
            _loc_1 = _loc_1 + (this._btnNormalMonster.selected ? ("1") : ("0"));
            _loc_1 = _loc_1 + (this._btnOtherRole.selected ? ("1") : ("0"));
            _loc_1 = _loc_1 + (this._btnScreenEffect.selected ? ("1") : ("0"));
            _loc_1 = _loc_1 + (this._btnOtherShowModel.selected ? ("1") : ("0"));
            return _loc_1;
        }// end function

        private function setBtnState(param1:String) : void
        {
            while (param1.length < 4)
            {
                
                param1 = "0" + param1;
            }
            var _loc_2:* = param1.charAt(0);
            var _loc_3:* = _loc_2 != "0";
            if (_loc_3 != this._btnNormalMonster.selected)
            {
                this._btnNormalMonster.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            }
            _loc_2 = param1.charAt(1);
            _loc_3 = _loc_2 != "0";
            if (_loc_3 != this._btnOtherRole.selected)
            {
                this._btnOtherRole.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            }
            _loc_2 = param1.charAt(2);
            _loc_3 = _loc_2 != "0";
            if (_loc_3 != this._btnScreenEffect.selected)
            {
                this._btnScreenEffect.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            }
            _loc_2 = param1.charAt(3);
            _loc_3 = _loc_2 != "0";
            if (_loc_3 != this._btnOtherShowModel.selected)
            {
                this._btnOtherShowModel.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            }
            return;
        }// end function

        public function resetOldState() : void
        {
            if (this._oldState >= 0)
            {
                this.setBtnState(this._oldState.toString(2));
            }
            this.setCenterBus();
            this._oldState = -1;
            return;
        }// end function

        private function showPopCueBox(param1:String) : void
        {
            var word:* = param1;
            if (!this._cueBox)
            {
                this._cueBox = new ScreenShieldCueBox();
            }
            this._cueBox.cue(word, LanguageCfgObj.getInstance().getByIndex("10954"), null, function () : void
            {
                _cueBox.close();
                return;
            }// end function
            , function () : void
            {
                _cueBox.close();
                resetOldState();
                return;
            }// end function
            , 2, [LanguageCfgObj.getInstance().getByIndex("10949"), LanguageCfgObj.getInstance().getByIndex("10950")]);
            this._cueBox.x = FrameworkGlobal.stageW / 2 - this._cueBox.width / 2;
            this._cueBox.y = FrameworkGlobal.stageH / 2 - this._cueBox.height / 2;
            FrameworkGlobal.stage.addChild(this._cueBox);
            return;
        }// end function

        public function getSelectAllState() : Boolean
        {
            if (this._btnAllSelect && this._btnAllSelect.selected == true)
            {
                return true;
            }
            return false;
        }// end function

    }
}
