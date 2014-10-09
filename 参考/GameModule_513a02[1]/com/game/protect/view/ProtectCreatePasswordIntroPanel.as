package com.game.protect.view
{
    import com.f1.*;
    import com.f1.ui.btn.*;
    import com.game.protect.control.*;
    import com.game.protect.model.*;
    import com.game.protect.util.*;
    import flash.events.*;

    public class ProtectCreatePasswordIntroPanel extends ProtectBaseBox
    {
        private var btnClose:BaseButton;
        private var btnCreatePassword:BaseButton;
        private var btnCancel:BaseButton;
        private var protectData:ProtectData;

        public function ProtectCreatePasswordIntroPanel()
        {
            this.protectData = ProtectData.getInstance();
            loadDisplay("res/protectPanel.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("protectCreatePasswordIntroPanel");
            this.initUI();
            super.displayReady();
            return;
        }// end function

        public function initUI() : void
        {
            this.btnClose = ProtectUiUtil.createButton(this, "btnClose", this.onClose);
            this.btnCreatePassword = ProtectUiUtil.createButton(this, "btnCreatePassword", this.onCreatePassword);
            this.btnCreatePassword.setText(LanguageCfgObj.getInstance().getByIndex("11095"));
            this.btnCancel = ProtectUiUtil.createButton(this, "btnCancel", this.onClose);
            this.btnCancel.setText(LanguageCfgObj.getInstance().getByIndex("11096"), true);
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
            this.initData();
            return;
        }// end function

        private function onRemovedFromStage(event:Event) : void
        {
            return;
        }// end function

        private function initData() : void
        {
            this.refreshData();
            return;
        }// end function

        private function refreshData(event:Event = null) : void
        {
            return;
        }// end function

        private function onCreatePassword(event:MouseEvent) : void
        {
            close();
            ProtectControl.getInstance().openCreatePasswordPanel();
            return;
        }// end function

        private function onClose(event:MouseEvent) : void
        {
            close();
            return;
        }// end function

    }
}
