package com.game.artifact.view
{
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.artifact.event.*;
    import com.game.artifact.model.*;
    import com.game.artifact.util.*;
    import com.game.backpack.control.*;
    import com.game.prompt.control.*;
    import com.game.prompt.model.*;
    import com.greensock.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class ArtifactAutoExtractMsgPanel extends BaseBox
    {
        private var btnClose:BaseButton;
        private var viewMsg:TextField;
        private var btnSee:BaseButton;
        private var artifactData:ArtifactData;
        public var autoExtractedEquipCount:int;
        public var autoExtractedMayaCount:int;
        public var autoExtractGainExp:Number;
        private var closeTweenLite:TweenLite;
        private var rollOvering:Boolean = false;
        private var closed:Boolean = true;

        public function ArtifactAutoExtractMsgPanel()
        {
            this.artifactData = ArtifactData.getInstance();
            loadDisplay("res/artifactPanel.swf");
            addEventListener(MouseEvent.ROLL_OVER, this.onRollOver);
            addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("artifactAutoExtractMsgPanel");
            this.initUI();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.btnClose = ArtifactUiUtil.createButton(this, "btnClose", this.onClose);
            this.viewMsg = getDisplayChildByName("viewMsg");
            this.btnSee = ArtifactUiUtil.createButton(this, "btnSee", this.onSee);
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
            this.artifactData.addEventListener(ArtifactEvent.AUTO_EXTRACT_MSG_CHANGE, this.refreshData);
            this.initData();
            return;
        }// end function

        private function onRemovedFromStage(event:Event) : void
        {
            this.artifactData.removeEventListener(ArtifactEvent.AUTO_EXTRACT_MSG_CHANGE, this.refreshData);
            if (!this.closed)
            {
                this.close();
            }
            return;
        }// end function

        private function initData() : void
        {
            var _loc_1:* = 0;
            this.autoExtractedEquipCount = 0;
            this.autoExtractedMayaCount = 0;
            this.autoExtractGainExp = 0;
            _loc_1 = 30;
            y = -68;
            alpha = 1;
            this.closeTweenLite = new TweenLite(this, 1, {delay:10, y:y + _loc_1, alpha:0, onComplete:this.onTweenLiteComplete});
            if (this.rollOvering)
            {
                this.closeTweenLite.pause();
            }
            this.refreshData();
            return;
        }// end function

        private function refreshData(event:Event = null) : void
        {
            this.autoExtractedEquipCount = this.autoExtractedEquipCount + this.artifactData.autoExtractedEquipCount;
            this.autoExtractedMayaCount = this.autoExtractedMayaCount + this.artifactData.autoExtractedMayaCount;
            this.autoExtractGainExp = this.autoExtractGainExp + this.artifactData.autoExtractGainExp;
            this.artifactData.autoExtractedEquipCount = 0;
            this.artifactData.autoExtractedMayaCount = 0;
            this.artifactData.autoExtractGainExp = 0;
            this.artifactData.autoExtractMsgLastShowTime = getTimer();
            var _loc_2:* = "";
            if (this.autoExtractedEquipCount > 0)
            {
                _loc_2 = _loc_2 + ArtifactTextUtil.addColor(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11872"), [this.autoExtractedEquipCount]), 16776960);
            }
            if (this.autoExtractedMayaCount > 0)
            {
                if (_loc_2.length > 0 && _loc_2.charAt((_loc_2.length - 1)) != "、")
                {
                    _loc_2 = _loc_2 + "、";
                }
                _loc_2 = _loc_2 + ArtifactTextUtil.addColor(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11873"), [this.autoExtractedMayaCount]), 16776960);
            }
            this.viewMsg.htmlText = LanguageCfgObj.getInstance().getByIndex("11874") + ArtifactTextUtil.addColor(LanguageCfgObj.getInstance().getByIndex("11875"), 16776960) + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11876"), [_loc_2]) + ArtifactTextUtil.addColor(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11877"), [this.autoExtractGainExp]), 16776960);
            return;
        }// end function

        private function onRollOver(event:MouseEvent) : void
        {
            this.rollOvering = true;
            if (this.closeTweenLite && !this.closeTweenLite.active)
            {
                this.closeTweenLite.pause();
            }
            return;
        }// end function

        private function onRollOut(event:MouseEvent) : void
        {
            this.rollOvering = false;
            if (this.closeTweenLite && this.closeTweenLite.paused)
            {
                this.closeTweenLite.play();
            }
            return;
        }// end function

        private function onTweenLiteComplete() : void
        {
            this.close();
            return;
        }// end function

        private function onClose(event:MouseEvent) : void
        {
            this.closeTweenLite.currentTime = 0;
            if (this.closeTweenLite.paused)
            {
                this.closeTweenLite.play();
            }
            return;
        }// end function

        private function onSee(event:MouseEvent) : void
        {
            PromptControl.getInstance().openMessagesPanel(MessagesModel.ZHUZAO);
            return;
        }// end function

        override public function open() : void
        {
            var _loc_1:* = null;
            if (this.closed)
            {
                this.closed = false;
                super.open();
                _loc_1 = BackPackControl.getInstance().getBackpackView().bagPanel.msgContainer;
                _loc_1.addChild(this);
            }
            return;
        }// end function

        override public function close() : void
        {
            if (!this.closed)
            {
                this.closed = true;
                super.close();
                if (parent)
                {
                    parent.removeChild(this);
                }
                if (this.closeTweenLite)
                {
                    this.closeTweenLite.kill();
                    this.closeTweenLite = null;
                }
            }
            return;
        }// end function

    }
}
