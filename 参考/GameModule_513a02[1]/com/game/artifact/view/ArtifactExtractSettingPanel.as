package com.game.artifact.view
{
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.game.artifact.control.*;
    import com.game.artifact.model.*;
    import com.game.artifact.util.*;
    import flash.events.*;

    public class ArtifactExtractSettingPanel extends BaseBox
    {
        private var btnClose:BaseButton;
        private var radioAllJob:CheckBox;
        private var radioOtherJob:CheckBox;
        private var radioMyJob:CheckBox;
        public var editAppend:ArtifactDownListBox;
        public var editIntensify:ArtifactDownListBox;
        public var editSteplv:ArtifactDownListBox;
        public var editZhuoyueNum:ArtifactDownListBox;
        private var checkScoreHigher:CheckBox;
        private var checkMaya:CheckBox;
        private var btnSave:BaseButton;
        private var setting:ArtifactExtractSetting;

        public function ArtifactExtractSettingPanel()
        {
            this.setting = ArtifactData.getInstance().extractSetting;
            loadDisplay("res/artifactPanel.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("artifactExtractSettingPanel");
            this.initUI();
            super.displayReady();
            return;
        }// end function

        public function initUI() : void
        {
            this.btnClose = this.createButton("btnClose", this.onClose);
            this.radioAllJob = this.createCheckBox("radioAllJob");
            this.radioOtherJob = this.createCheckBox("radioOtherJob");
            this.radioMyJob = this.createCheckBox("radioMyJob");
            CheckBox.group(this.radioAllJob, this.radioOtherJob, this.radioMyJob);
            this.editAppend = this.createDownListBox("editAppend", [LanguageCfgObj.getInstance().getByIndex("11879")].concat(ArtifactStringUtil.range(1, 5, "", LanguageCfgObj.getInstance().getByIndex("11880"))));
            this.editIntensify = this.createDownListBox("editIntensify", [LanguageCfgObj.getInstance().getByIndex("11879")].concat(ArtifactStringUtil.range(1, 15, "+", "")));
            this.editSteplv = this.createDownListBox("editSteplv", [LanguageCfgObj.getInstance().getByIndex("11879")].concat(ArtifactStringUtil.range(1, 8, "", LanguageCfgObj.getInstance().getByIndex("11881"), ArtifactStringUtil.getNumberChinese)));
            this.editZhuoyueNum = this.createDownListBox("editZhuoyueNum", [LanguageCfgObj.getInstance().getByIndex("11879")].concat(ArtifactStringUtil.range(1, 3, "", LanguageCfgObj.getInstance().getByIndex("11882"))));
            this.checkScoreHigher = this.createCheckBox("checkScoreHigher");
            this.checkMaya = this.createCheckBox("checkMaya");
            this.btnSave = this.createButton("btnSave", this.onSave);
            this.btnSave.setText(LanguageCfgObj.getInstance().getByIndex("10219"));
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

        private function createCheckBox(param1:String) : CheckBox
        {
            var _loc_2:* = new CheckBox(getDisplayChildByName(param1));
            _loc_2.bindTextField(getDisplayChildByName(param1 + "_label"));
            return _loc_2;
        }// end function

        private function createDownListBox(param1:String, param2:Array) : ArtifactDownListBox
        {
            return ArtifactUiUtil.createDownListBox(this, param1, param2);
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
            this.radioAllJob.selected = this.setting.jobType == ArtifactExtractSetting.JOB_TYPE_ALL;
            this.radioOtherJob.selected = this.setting.jobType == ArtifactExtractSetting.JOB_TYPE_OTHER;
            this.radioMyJob.selected = this.setting.jobType == ArtifactExtractSetting.JOB_TYPE_MY;
            this.editAppend.selectIndex = this.setting.maxAppend;
            this.editIntensify.selectIndex = this.setting.maxIntensify;
            this.editSteplv.selectIndex = this.setting.maxSteplv;
            this.editZhuoyueNum.selectIndex = this.setting.maxZhuoyueNum;
            this.checkScoreHigher.selected = this.setting.allowScoreHigher;
            this.checkMaya.selected = this.setting.allowMaya;
            return;
        }// end function

        private function onClose(event:MouseEvent) : void
        {
            close();
            return;
        }// end function

        private function onSave(event:MouseEvent) : void
        {
            this.setting.jobType = this.radioAllJob.selected ? (ArtifactExtractSetting.JOB_TYPE_ALL) : (this.radioOtherJob.selected ? (ArtifactExtractSetting.JOB_TYPE_OTHER) : (this.radioMyJob.selected ? (ArtifactExtractSetting.JOB_TYPE_MY) : (ArtifactExtractSetting.JOB_TYPE_ALL)));
            this.setting.maxAppend = this.editAppend.selectIndex;
            this.setting.maxIntensify = this.editIntensify.selectIndex;
            this.setting.maxSteplv = this.editSteplv.selectIndex;
            this.setting.maxZhuoyueNum = this.editZhuoyueNum.selectIndex;
            this.setting.allowScoreHigher = this.checkScoreHigher.selected;
            this.setting.allowMaya = this.checkMaya.selected;
            ArtifactControl.getInstance().saveExtractSetting();
            close();
            return;
        }// end function

    }
}
