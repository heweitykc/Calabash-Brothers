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

    public class ProtectLockPanel extends ProtectBaseBox
    {
        private var btnClose:BaseButton;
        private var editPassword:TextField;
        private var btnModifyPassword:BaseButton;
        private var btnOk:BaseButton;
        private var btnCancel:BaseButton;
        private var protectData:ProtectData;

        public function ProtectLockPanel()
        {
            this.protectData = ProtectData.getInstance();
            loadDisplay("res/protectPanel.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("protectLockPanel");
            this.initUI();
            super.displayReady();
            return;
        }// end function

        public function initUI() : void
        {
            this.btnClose = ProtectUiUtil.createButton(this, "btnClose", this.onClose);
            this.editPassword = getDisplayChildByName("editPassword");
            this.editPassword.restrict = ProtectConst.passwordRestrict;
            this.btnModifyPassword = ProtectUiUtil.createButton(this, "btnModifyPassword", this.onModifyPassword);
            this.btnOk = ProtectUiUtil.createButton(this, "btnOk", this.onOk);
            this.btnOk.setText(LanguageCfgObj.getInstance().getByIndex("11102"), true);
            this.btnCancel = ProtectUiUtil.createButton(this, "btnCancel", this.onClose);
            this.btnCancel.setText(LanguageCfgObj.getInstance().getByIndex("11103"), true);
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
            this.refreshData();
            return;
        }// end function

        private function refreshData(event:Event = null) : void
        {
            if (this.protectData.locked)
            {
                close();
            }
            return;
        }// end function

        private function onModifyPassword(event:MouseEvent) : void
        {
            close();
            ProtectControl.getInstance().openModifyPasswordPanel();
            return;
        }// end function

        private function onOk(event:MouseEvent) : void
        {
            var _loc_2:* = this.editPassword.text;
            if (_loc_2.length == 0)
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("11104"));
                return;
            }
            ProtectControl.getInstance().lock(_loc_2);
            return;
        }// end function

        private function onClose(event:MouseEvent) : void
        {
            close();
            return;
        }// end function

    }
}
