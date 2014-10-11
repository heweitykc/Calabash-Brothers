package com.game.protect.view
{
    import com.*;
    import com.f1.*;
    import com.f1.ui.btn.*;
    import com.game.protect.control.*;
    import com.game.protect.event.*;
    import com.game.protect.model.*;
    import com.game.protect.util.*;
    import flash.events.*;
    import flash.text.*;

    public class ProtectModifyPasswordPanel extends ProtectBaseBox
    {
        private var btnClose:BaseButton;
        private var editOldPassword:TextField;
        private var editPassword:TextField;
        private var editPasswordAgain:TextField;
        private var viewOldPasswordState:ProtectEditFieldStateView;
        private var viewPasswordState:ProtectEditFieldStateView;
        private var viewPasswordAgainState:ProtectEditFieldStateView;
        private var btnOk:BaseButton;
        private var btnCancel:BaseButton;
        private var protectData:ProtectData;
        private var passwordCheckSessionId:int = 0;

        public function ProtectModifyPasswordPanel()
        {
            this.protectData = ProtectData.getInstance();
            loadDisplay("res/protectPanel.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("protectModifyPasswordPanel");
            this.initUI();
            super.displayReady();
            return;
        }// end function

        public function initUI() : void
        {
            this.btnClose = ProtectUiUtil.createButton(this, "btnClose", this.onClose);
            this.editOldPassword = getDisplayChildByName("editOldPassword");
            this.editPassword = getDisplayChildByName("editPassword");
            this.editPasswordAgain = getDisplayChildByName("editPasswordAgain");
            var _loc_1:* = ProtectConst.passwordRestrict;
            this.editPasswordAgain.restrict = ProtectConst.passwordRestrict;
            this.editPassword.restrict = _loc_1;
            this.editOldPassword.restrict = _loc_1;
            this.viewOldPasswordState = new ProtectEditFieldStateView(getDisplayChildByName("viewOldPasswordState"), LanguageCfgObj.getInstance().getByIndex("12359"));
            this.viewPasswordState = new ProtectEditFieldStateView(getDisplayChildByName("viewPasswordState"), LanguageCfgObj.getInstance().getByIndex("12173"));
            this.viewPasswordAgainState = new ProtectEditFieldStateView(getDisplayChildByName("viewPasswordAgainState"), LanguageCfgObj.getInstance().getByIndex("12174"));
            this.btnOk = ProtectUiUtil.createButton(this, "btnOk", this.onOk);
            this.btnOk.setText(LanguageCfgObj.getInstance().getByIndex("11105"), true);
            this.btnCancel = ProtectUiUtil.createButton(this, "btnCancel", this.onClose);
            this.btnCancel.setText(LanguageCfgObj.getInstance().getByIndex("11106"), true);
            this.editOldPassword.addEventListener(FocusEvent.FOCUS_OUT, this.checkOldPassword);
            this.editPassword.addEventListener(FocusEvent.FOCUS_OUT, this.checkPassword);
            this.editPasswordAgain.addEventListener(FocusEvent.FOCUS_OUT, this.checkPasswordAgain);
            this.editOldPassword.tabIndex = 1;
            this.editPassword.tabIndex = 2;
            this.editPasswordAgain.tabIndex = 3;
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
            this.protectData.addEventListener(ProtectEvent.PASSWORD_COMPARE_RESULT, this.refreshOldPasswordState);
            this.protectData.addEventListener(ProtectEvent.MODIFY_PASSWORD_OK, this.onModifyPasswordOk);
            this.initData();
            return;
        }// end function

        private function onRemovedFromStage(event:Event) : void
        {
            this.protectData.removeEventListener(ProtectEvent.PASSWORD_COMPARE_RESULT, this.refreshOldPasswordState);
            this.protectData.removeEventListener(ProtectEvent.MODIFY_PASSWORD_OK, this.onModifyPasswordOk);
            return;
        }// end function

        private function initData() : void
        {
            this.editOldPassword.text = "";
            var _loc_1:* = this;
            var _loc_2:* = this.passwordCheckSessionId + 1;
            _loc_1.passwordCheckSessionId = _loc_2;
            this.editPassword.text = "";
            this.editPasswordAgain.text = "";
            this.viewOldPasswordState.clearState();
            this.viewPasswordState.clearState();
            this.viewPasswordAgainState.clearState();
            this.refreshData();
            return;
        }// end function

        private function refreshData(event:Event = null) : void
        {
            return;
        }// end function

        private function refreshOldPasswordState(event:ProtectEvent) : void
        {
            var _loc_2:* = event.data.sessionId;
            var _loc_3:* = event.data.ok;
            if (_loc_2 == this.passwordCheckSessionId)
            {
                this.viewOldPasswordState.setOk(_loc_3);
            }
            return;
        }// end function

        private function onModifyPasswordOk(event:Event) : void
        {
            close();
            return;
        }// end function

        private function checkOldPassword(event:FocusEvent = null) : void
        {
            var _loc_3:* = this;
            var _loc_4:* = this.passwordCheckSessionId + 1;
            _loc_3.passwordCheckSessionId = _loc_4;
            var _loc_2:* = this.editOldPassword.text;
            if (_loc_2.length == 0)
            {
                this.viewOldPasswordState.setOk(false);
                return;
            }
            ProtectControl.getInstance().checkOldPassword(this.passwordCheckSessionId, _loc_2);
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
            var _loc_4:* = null;
            var _loc_2:* = this.editOldPassword.text;
            if (_loc_2.length == 0)
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("11107"));
                return;
            }
            var _loc_3:* = true;
            _loc_3 = this.checkPassword() && _loc_3;
            _loc_3 = this.checkPasswordAgain() && _loc_3;
            if (_loc_3)
            {
                _loc_4 = this.editPassword.text;
                ProtectControl.getInstance().modifyPassword(_loc_2, _loc_4);
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
