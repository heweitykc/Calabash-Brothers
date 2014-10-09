package com.game.artifact.view
{
    import __AS3__.vec.*;
    import com.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.game.artifact.util.*;
    import flash.events.*;
    import flash.text.*;

    public class ArtifactExtractConfirmPanel extends BaseBox
    {
        private var btnClose:BaseButton;
        private var viewMsg:TextField;
        private var viewPackItems:ArtifactPackGridView;
        private var btnOk:BaseButton;
        private var btnCancel:BaseButton;
        private var items:Vector.<PropInfo>;
        private var okCallback:Function;
        private var hasAddedToPop:Boolean = false;

        public function ArtifactExtractConfirmPanel()
        {
            loadDisplay("res/artifactPanel.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("artifactExtractConfirmPanel");
            this.initUI();
            super.displayReady();
            return;
        }// end function

        public function initUI() : void
        {
            this.btnClose = ArtifactUiUtil.createButton(this, "btnClose", this.onClose);
            this.viewMsg = getDisplayChildByName("viewMsg");
            this.viewPackItems = new ArtifactPackGridView(279, 108, 5, 2, 3, 0, 7);
            this.viewPackItems.move(23, 95);
            addChild(this.viewPackItems);
            this.btnOk = ArtifactUiUtil.createButton(this, "btnOk", this.onOk);
            this.btnOk.setText(LanguageCfgObj.getInstance().getByIndex("10213"));
            this.btnCancel = ArtifactUiUtil.createButton(this, "btnCancel", this.onClose);
            this.btnCancel.setText(LanguageCfgObj.getInstance().getByIndex("10214"));
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

        public function show(param1:Vector.<PropInfo>, param2:Function) : void
        {
            this.items = param1;
            this.okCallback = param2;
            this.open();
            if (UILoaded)
            {
                this.refreshData();
            }
            return;
        }// end function

        private function initData() : void
        {
            this.refreshData();
            return;
        }// end function

        private function refreshData(event:Event = null) : void
        {
            this.viewPackItems.setData(this.items);
            return;
        }// end function

        private function onClose(event:MouseEvent) : void
        {
            this.close();
            return;
        }// end function

        private function onOk(event:MouseEvent) : void
        {
            var _loc_2:* = this.okCallback;
            this.close();
            this._loc_2();
            return;
        }// end function

        override public function open() : void
        {
            if (!this.hasAddedToPop)
            {
                this.hasAddedToPop = true;
                Global.popManager.addPop(this, true, true, true, true, false, true);
            }
            super.open();
            return;
        }// end function

        override public function close() : void
        {
            this.okCallback = null;
            super.close();
            return;
        }// end function

    }
}
