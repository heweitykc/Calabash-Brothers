package com.game.artifact.view
{
    import __AS3__.vec.*;
    import com.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.artifact.control.*;
    import com.game.artifact.event.*;
    import com.game.artifact.model.*;
    import com.game.artifact.util.*;
    import flash.events.*;
    import flash.text.*;

    public class ArtifactExtractRemindPanel extends BaseBox
    {
        private var btnClose:BaseButton;
        private var viewMsg:TextField;
        private var viewPackItems:ArtifactPackGridView;
        private var btnNowExtract:BaseButton;
        private var btnSeeExtract:BaseButton;
        private var artifactData:ArtifactData;
        public var dataInited:Boolean = false;
        private var layoutInfo:LayoutInfo;

        public function ArtifactExtractRemindPanel()
        {
            this.artifactData = ArtifactData.getInstance();
            loadDisplay("res/artifactPanel.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("artifactExtractRemindPanel");
            this.initUI();
            super.displayReady();
            return;
        }// end function

        public function initUI() : void
        {
            this.btnClose = this.createButton("btnClose", this.onClose);
            this.viewMsg = getDisplayChildByName("viewMsg");
            this.viewPackItems = new ArtifactPackGridView(279, 108, 5, 2, 3, 0, 7);
            this.viewPackItems.move(23, 95);
            addChild(this.viewPackItems);
            this.btnNowExtract = this.createButton("btnNowExtract", this.onNowExtract);
            this.btnNowExtract.setText(LanguageCfgObj.getInstance().getByIndex("10217"));
            this.btnSeeExtract = this.createButton("btnSeeExtract", this.onSeeExtract);
            this.btnSeeExtract.setText(LanguageCfgObj.getInstance().getByIndex("10218"));
            this.btnNowExtract.visible = false;
            this.btnSeeExtract.x = this.btnNowExtract.x + (this.btnSeeExtract.x + this.btnSeeExtract.width - this.btnNowExtract.x - this.btnNowExtract.width) / 2;
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            if (stage)
            {
                this.onAddedToStage();
            }
            return;
        }// end function

        private function createButton(param1:String, param2:Function) : BaseButton
        {
            return ArtifactUiUtil.createButton(this, param1, param2);
        }// end function

        private function onAddedToStage(event:Event = null) : void
        {
            this.artifactData.addEventListener(ArtifactEvent.FILTERED_EXTRACTABLE_ITEMS_CHANGE, this.refreshData);
            this.artifactData.addEventListener(ArtifactEvent.ARTIFACT_DATA_CHANGE, this.refreshData);
            this.dataInited = true;
            this.initData();
            return;
        }// end function

        private function onRemovedFromStage(event:Event) : void
        {
            this.artifactData.removeEventListener(ArtifactEvent.FILTERED_EXTRACTABLE_ITEMS_CHANGE, this.refreshData);
            this.artifactData.removeEventListener(ArtifactEvent.ARTIFACT_DATA_CHANGE, this.refreshData);
            this.dataInited = false;
            return;
        }// end function

        private function initData() : void
        {
            this.refreshData();
            return;
        }// end function

        private function refreshData(event:Event = null) : void
        {
            var _loc_2:* = this.artifactData.filteredExtractableItems;
            if (this.artifactData.extractSetting.allowAutoExtract || _loc_2.length == 0 || this.artifactData.isBest())
            {
                this.close();
                return;
            }
            var _loc_3:* = this.artifactData.computeExtractExp(_loc_2);
            this.viewMsg.htmlText = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11878"), [_loc_2.length, _loc_3]);
            this.viewPackItems.setData(_loc_2);
            return;
        }// end function

        private function onClose(event:MouseEvent) : void
        {
            this.close();
            return;
        }// end function

        private function onNowExtract(event:MouseEvent) : void
        {
            this.close();
            ArtifactControl.getInstance().extractItems(this.artifactData.filteredExtractableItems);
            return;
        }// end function

        private function onSeeExtract(event:MouseEvent) : void
        {
            ArtifactControl.getInstance().openArtifactAndExtractPanel();
            this.close();
            return;
        }// end function

        override public function open() : void
        {
            if (isOpen)
            {
                return;
            }
            super.open();
            if (!this.layoutInfo)
            {
                this.layoutInfo = new LayoutInfo(Layout.BOTTOM_RIGHT, 0, 105);
            }
            Global.popManager.addUI(this, this.layoutInfo);
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            Global.popManager.removeUI(this);
            return;
        }// end function

    }
}
