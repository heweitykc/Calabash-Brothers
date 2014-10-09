package com.game.protect.view
{
    import com.f1.*;
    import com.f1.ui.btn.*;
    import com.game.protect.control.*;
    import com.game.protect.event.*;
    import com.game.protect.model.*;
    import com.game.protect.util.*;
    import flash.events.*;
    import flash.text.*;

    public class ProtectCreatePasswordPanel extends ProtectBaseBox
    {
        private var btnClose:BaseButton;
        private var editPassword:TextField;
        private var editPasswordAgain:TextField;
        private var viewPasswordState:ProtectEditFieldStateView;
        private var viewPasswordAgainState:ProtectEditFieldStateView;
        private var btnOk:BaseButton;
        private var btnCancel:BaseButton;
        private var protectData:ProtectData;

        public function ProtectCreatePasswordPanel()
        {
            this.protectData = ProtectData.getInstance();
            loadDisplay("res/protectPanel.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("protectCreatePasswordPanel");
            this.initUI();
            super.displayReady();
            return;
        }// end function

        public function initUI() : void
        {
            this.btnClose = ProtectUiUtil.createButton(this, "btnClose", this.onClose);
            this.editPassword = getDisplayChildByName("editPassword");
            this.editPasswordAgain = getDisplayChildByName("editPasswordAgain");
            var _loc_1:* = ProtectConst.passwordRestrict;
            this.editPasswordAgain.restrict = ProtectConst.passwordRestrict;
            this.editPassword.restrict = _loc_1;
            this.viewPasswordState = new ProtectEditFieldStateView(getDisplayChildByName("viewPasswordState"), LanguageCfgObj.getInstance().getByIndex("12173"));
            this.viewPasswordAgainState = new ProtectEditFieldStateView(getDisplayChildByName("viewPasswordAgainState"), LanguageCfgObj.getInstance().getByIndex("12174"));
            this.btnOk = ProtectUiUtil.createButton(this, "btnOk", this.onOk);
            this.btnOk.setText(LanguageCfgObj.getInstance().getByIndex("11097"), true);
            this.btnCancel = ProtectUiUtil.createButton(this, "btnCancel", this.onClose);
            this.btnCancel.setText(LanguageCfgObj.getInstance().getByIndex("11098"), true);
            this.editPassword.addEventListener(FocusEvent.FOCUS_OUT, this.checkPassword);
            this.editPasswordAgain.addEventListener(FocusEvent.FOCUS_OUT, this.checkPasswordAgain);
            this.editPassword.text = "";
            this.editPasswordAgain.text = "";
            this.editPassword.tabIndex = 1;
            this.editPasswordAgain.tabIndex = 2;
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            if (stage)
            {
                this.onAddedToStage();
            }
            return;
        }// end function

        private function onAddedToStage(event:Event = null) : void
        {
            this.protectData.addEventListener(ProtectEvent.PROTECT_DATA_CHANGE, this.refreshData);
            this.initData();
            return;
        }// end function

        private function onRemovedFromStage(event:Event) : void
        {
            this.protectData.removeEventListener(ProtectEvent.PROTECT_DATA_CHANGE, this.refreshData);
            return;
        }// end function

        private function initData() : void
        {
            this.editPassword.text = "";
            this.viewPasswordState.clearState();
            this.editPasswordAgain.text = "";
            this.viewPasswordAgainState.clearState();
            this.refreshData();
            return;
        }// end function

        private function refreshData(event:Event = null) : void
        {
            if (this.protectData.hasPassword)
            {
                close();
            }
            return;
        }// end function

        private function checkPassword(event:FocusEvent = null) : Boolean
        {
            var _loc_2:* = ProtectConst.passwordPattern.test(this.editPassword.text);
            this.viewPasswordState.setOk(_loc_2);
            return _loc_2;
        }// end function

        private function checkPasswordAgain(event:FocusEvent = null) : Boolean
        {
            var _loc_2:* = this.editPasswordAgain.text == this.editPassword.text;
            var _loc_3:* = this.editPasswordAgain.text.length == 0;
            if (_loc_2 && _loc_3)
            {
                this.viewPasswordAgainState.clearState();
            }
            else
            {
                this.viewPasswordAgainState.setOk(_loc_2);
            }
            return _loc_2;
        }// end function

        private function onOk(event:MouseEvent) : void
        {
            var _loc_2:* = true;
            _loc_2 = this.checkPassword() && _loc_2;
            _loc_2 = this.checkPasswordAgain() && _loc_2;
            if (_loc_2)
            {
                ProtectControl.getInstance().createPassword(this.editPassword.text, "1@1.com", "13123456789");
            }
            return;
        }// end function

        private function onClose(event:MouseEvent) : void
        {
            close();
            return;
        }// end function

    }
}
