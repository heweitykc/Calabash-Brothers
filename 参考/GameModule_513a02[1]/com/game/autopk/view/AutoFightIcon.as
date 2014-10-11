package com.game.autopk.view
{
    import com.events.*;
    import com.f1.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.autopk.controller.*;
    import com.game.autopk.event.*;
    import com.game.player.control.*;
    import com.model.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class AutoFightIcon extends Component
    {
        public var closeButton:BaseButton;
        public var panelButton:BaseButton;
        public var expText:TextField;
        public var mcButton:BaseButton;
        public var setBtn:BaseButton;
        public var rateMc:MovieClip;
        private var _componentStr:String;
        private var _expCount:Number;
        private var _totalMin:int;
        private var isTicking:Boolean = false;

        public function AutoFightIcon(param1 = null, param2:String = null, param3:String = null)
        {
            this._componentStr = param3;
            loadDisplay("res/autoFightIcon.swf");
            addEventListener(Event.ADDED_TO_STAGE, this.beginCount);
            return;
        }// end function

        override protected function displayReady() : void
        {
            initComponentUI(this._componentStr);
            this.closeButton = new BaseButton(getDisplayChildByName("close_btn"));
            this.closeButton.addEventListener(MouseEvent.CLICK, this.onCloseHandle);
            if (this._componentStr == "AutoFightIconSkin")
            {
                this.mcButton = new BaseButton(getDisplayChildByName("mc"));
                this.setBtn = new BaseButton(getDisplayChildByName("panel_btn"));
                this.setBtn.addEventListener(MouseEvent.CLICK, this.onSetHandle);
                this.panelButton = new BaseButton(getDisplayChildByName("panel_btn"));
                this.panelButton.addEventListener(MouseEvent.CLICK, this.onSetHandle);
                this.setCountTxt(LanguageCfgObj.getInstance().getByIndex("10308"));
            }
            super.displayReady();
            return;
        }// end function

        private function onSetHandle(event:MouseEvent) : void
        {
            AutoFightController.getInstance().openFightPanel();
            return;
        }// end function

        private function onCloseHandle(event:MouseEvent) : void
        {
            if (this._componentStr == "AutoFindIconSkin")
            {
                this.endCount();
                AutoFightController.getInstance().closeAutoFind(true);
            }
            else
            {
                dispatchEvent(new AutoFightEvent(AutoFightEvent.CLOSE_AUTO_FIGHT_ICON));
            }
            return;
        }// end function

        public function beginCount(event:Event = null) : void
        {
            removeEventListener(Event.ADDED_TO_STAGE, this.beginCount);
            UserObj.getInstance().playerInfo.addEventListener(RoleEvent.UPDATE_EXP, this._expUpdateHandler);
            addEventListener(Event.REMOVED_FROM_STAGE, this.endCount);
            if (!this.isTicking)
            {
                this.isTicking = true;
                this._expCount = 0;
                Ticker.registerTimer(60, this.showCount);
                if (UILoaded && this.rateMc)
                {
                    this.rateMc.visible = false;
                }
            }
            this.setCountTxt(LanguageCfgObj.getInstance().getByIndex("10308"));
            return;
        }// end function

        public function endCount(event:Event = null) : void
        {
            UserObj.getInstance().playerInfo.removeEventListener(RoleEvent.UPDATE_EXP, this._expUpdateHandler);
            removeEventListener(Event.REMOVED_FROM_STAGE, this.endCount);
            Ticker.killTimer(this.showCount);
            this.isTicking = false;
            this._expCount = 0;
            return;
        }// end function

        private function _expUpdateHandler(event:RoleEvent) : void
        {
            this._expCount = this._expCount + Number(event.obj);
            return;
        }// end function

        private function showCount() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = NaN;
            var _loc_3:* = this;
            var _loc_4:* = this._totalMin + 1;
            _loc_3._totalMin = _loc_4;
            if (this._expCount > 100000000)
            {
                _loc_2 = this._expCount / 100000000;
                _loc_1 = String(_loc_2.toFixed(2)) + LanguageCfgObj.getInstance().getByIndex("11783");
            }
            else if (this._expCount > 10000000)
            {
                _loc_2 = this._expCount / 10000000;
                _loc_1 = String(_loc_2.toFixed(2)) + LanguageCfgObj.getInstance().getByIndex("11896");
            }
            else if (this._expCount > 10000)
            {
                _loc_2 = this._expCount * 0.0001;
                _loc_1 = String(_loc_2.toFixed(2)) + LanguageCfgObj.getInstance().getByIndex("11782");
            }
            else
            {
                _loc_1 = int(this._expCount).toString();
            }
            this.setCountTxt(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11897"), [_loc_1]));
            this._expCount = 0;
            if (_loc_1 != "0")
            {
                PlayerControl.getInstance().setRateMcVisible(true);
            }
            else
            {
                PlayerControl.getInstance().setRateMcVisible(false);
            }
            return;
        }// end function

        private function setCountTxt(param1:String) : void
        {
            PlayerControl.getInstance().setRateText(param1);
            return;
        }// end function

    }
}
