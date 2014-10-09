package com.game.artifact.control
{
    import __AS3__.vec.*;
    import com.*;
    import com.cfg.obj.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.artifact.event.*;
    import com.game.artifact.locale.*;
    import com.game.artifact.message.*;
    import com.game.artifact.model.*;
    import com.game.artifact.protocol.*;
    import com.game.artifact.util.*;
    import com.game.artifact.view.*;
    import com.game.autopk.controller.*;
    import com.game.autopk.event.*;
    import com.game.autopk.model.*;
    import com.game.backpack.events.*;
    import com.game.backpack.model.*;
    import com.game.guide.control.*;
    import com.game.guide.event.*;
    import com.game.guide.model.*;
    import com.game.map.control.*;
    import com.game.operationpanel.control.*;
    import com.game.player.events.*;
    import com.game.player.model.*;
    import com.game.primaryrole.control.*;
    import com.game.protect.control.*;
    import com.game.protect.model.*;
    import com.game.utils.*;
    import com.model.*;
    import com.model.vo.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class ArtifactControl extends Object
    {
        private var protocol:ArtifactProtocol;
        private var artifactData:ArtifactData;
        public var artifactView:ArtifactView;
        private var extractPanel:ArtifactExtractPanel;
        private var extractSettingPanel:ArtifactExtractSettingPanel;
        private var extractRemindPanel:ArtifactExtractRemindPanel;
        private var autoExtractMsgPanel:ArtifactAutoExtractMsgPanel;
        private var extractConfirmPanel:ArtifactExtractConfirmPanel;
        private var frameCountBeforeRefreshExtractableItems:int = 0;
        private var goldExtractAutoConfirm:Boolean = false;
        private var extractPreciousItemAutoConfirm:Boolean = false;
        private var doubleExtractAutoConfirm:Boolean = false;
        private static var instance:ArtifactControl;

        public function ArtifactControl()
        {
            this.protocol = new ArtifactProtocol();
            this.artifactData = ArtifactData.getInstance();
            BackpackObj.getInstance().addEventListener(BackpackEvent.GOODS_CHANGE, this.onPackChange);
            EquipsObj.getInstance().addEvtListeners([EquipEvent.TAKE_OFF, EquipEvent.WEAR, EquipEvent.EQUIPSTRENTH], this.onWearingEquipsChange);
            UserObj.getInstance().playerInfo.addEventListener(RoleEvent.UPDATE_VIP_LEVEL, this.onVipLevelChange);
            GuideConfigObj.getInstance().addEventListener(GuideEvent.GUIDE_ACTIVE_CONFIG_COMPLETE, this.onGuideActiveConfigComplete);
            FrameworkGlobal.addMsgListen(AutoFightEvent.AUTO_FIGHT_CONFIG_UPDATE, this.onAutoFightConfigChange);
            this.artifactData.addEventListener(ArtifactEvent.ARTIFACT_DATA_CHANGE, this.onArtifactDataChange);
            this.artifactData.addEventListener(ArtifactEvent.AUTO_EXTRACTABLE_ITEMS_HAS_NEW, this.autoExtractIfAllowed);
            this.artifactData.addEventListener(ArtifactEvent.FILTERED_EXTRACTABLE_ITEMS_HAS_NEW, this.onFilteredExtractableItemsHasNew);
            return;
        }// end function

        private function onPackChange(event:Event = null) : void
        {
            this.refreshExtractableItems();
            return;
        }// end function

        private function onWearingEquipsChange(event:Event = null) : void
        {
            this.refreshExtractableItems();
            return;
        }// end function

        private function refreshExtractableItems() : void
        {
            if (this.frameCountBeforeRefreshExtractableItems <= 0)
            {
                FrameworkGlobal.stage.addEventListener(Event.ENTER_FRAME, this.doRefreshExtractableItems);
            }
            this.frameCountBeforeRefreshExtractableItems = 36;
            return;
        }// end function

        private function doRefreshExtractableItems(event:Event) : void
        {
            var _loc_2:* = this;
            this.frameCountBeforeRefreshExtractableItems = (this.frameCountBeforeRefreshExtractableItems - 1);
            _loc_2.frameCountBeforeRefreshExtractableItems = this.frameCountBeforeRefreshExtractableItems - 1;
            if (this.frameCountBeforeRefreshExtractableItems <= 0)
            {
                FrameworkGlobal.stage.removeEventListener(Event.ENTER_FRAME, this.doRefreshExtractableItems);
                this.artifactData.refreshExtractableItems();
            }
            return;
        }// end function

        private function onVipLevelChange(event:Event) : void
        {
            this.artifactData.refreshVipLevel();
            return;
        }// end function

        private function onGuideActiveConfigComplete(event:Event) : void
        {
            this.checkArtifactEnabled();
            return;
        }// end function

        private function onAutoFightConfigChange(event:Event) : void
        {
            this.artifactData.setAllowAutoExtract(AutoFightModel.autoArtifact);
            return;
        }// end function

        private function checkArtifactEnabled() : void
        {
            if (GuideConfigObj.getInstance().guideConfigInited && this.artifactData.isArtifactEnabled())
            {
                if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().ARTIFACT_ACTIVE_TEAM)) == 0)
                {
                    ActiveGuideControl.getInstance().openByTeamId(GuideConfigObj.getInstance().ARTIFACT_ACTIVE_TEAM);
                }
            }
            return;
        }// end function

        public function initArtifactView() : void
        {
            if (!this.artifactView)
            {
                this.artifactView = new ArtifactView();
            }
            return;
        }// end function

        public function openArtifactPanel() : void
        {
            if (!this.artifactView || this.artifactView.stage == null)
            {
                PrimaryRoleControl.getInstance().openArtifact();
            }
            return;
        }// end function

        public function openOrCloseExtractPanel() : void
        {
            this.getExtractPanel().openOrClose();
            return;
        }// end function

        public function getExtractPanel() : ArtifactExtractPanel
        {
            if (!this.extractPanel)
            {
                this.extractPanel = new ArtifactExtractPanel();
                Global.popManager.addPop(this.extractPanel);
            }
            return this.extractPanel;
        }// end function

        public function closeExtractPanel() : void
        {
            if (this.extractPanel)
            {
                this.extractPanel.close();
            }
            return;
        }// end function

        public function openArtifactAndExtractPanel() : void
        {
            if (this.extractPanel && this.extractPanel.isOpen)
            {
                return;
            }
            PrimaryRoleControl.getInstance().openArtifactExtract();
            return;
        }// end function

        public function openOrCloseExtractSettingPanel() : void
        {
            if (!this.extractSettingPanel)
            {
                this.extractSettingPanel = new ArtifactExtractSettingPanel();
                Global.popManager.addPop(this.extractSettingPanel);
            }
            this.extractSettingPanel.openOrClose();
            return;
        }// end function

        public function openExtractRemindPanel() : void
        {
            if (!this.extractRemindPanel)
            {
                this.extractRemindPanel = new ArtifactExtractRemindPanel();
            }
            this.extractRemindPanel.open();
            return;
        }// end function

        public function openAutoExtractMsgPanelIfNeeded() : void
        {
            var _loc_1:* = 30;
            if (this.artifactData.autoExtractedEquipCount + this.artifactData.autoExtractedMayaCount >= 30 || this.artifactData.autoExtractedEquipCount + this.artifactData.autoExtractedMayaCount > 0 && getTimer() - this.artifactData.autoExtractMsgLastShowTime >= _loc_1 * 60 * 1000)
            {
                this.openAutoExtractMsgPanel();
            }
            return;
        }// end function

        private function openAutoExtractMsgPanel() : void
        {
            if (!this.autoExtractMsgPanel)
            {
                this.autoExtractMsgPanel = new ArtifactAutoExtractMsgPanel();
            }
            this.autoExtractMsgPanel.open();
            return;
        }// end function

        private function getExtractConfirmPanel() : ArtifactExtractConfirmPanel
        {
            if (!this.extractConfirmPanel)
            {
                this.extractConfirmPanel = new ArtifactExtractConfirmPanel();
            }
            return this.extractConfirmPanel;
        }// end function

        private function onArtifactDataChange(event:Event) : void
        {
            this.checkArtifactEnabled();
            OperationPanelControl.getInstance().panel.setGoldExtractRemainingTimes(this.artifactData.getGoldExtractRemainingTimes());
            return;
        }// end function

        private function onFilteredExtractableItemsHasNew(event:Event) : void
        {
            if (this.artifactData.isBest())
            {
                return;
            }
            if (!this.artifactData.extractSetting.allowAutoExtract)
            {
                if (this.artifactData.filteredExtractableItems.length >= 5)
                {
                    if (this.extractPanel == null || !this.extractPanel.dataInited)
                    {
                        if (this.artifactData.extractableItemFilter.hasExceptedItems())
                        {
                            this.artifactData.clearExceptedExtractableItems();
                        }
                    }
                    this.openExtractRemindPanel();
                }
            }
            return;
        }// end function

        public function enableArtifact() : void
        {
            this.protocol.reqOpenArtifact();
            return;
        }// end function

        public function goldExtract() : void
        {
            var maxVipLevel:int;
            var vipLevel:int;
            var times:int;
            var nextVipLevel:int;
            var timesInc:int;
            var vipMsg:String;
            var msg:String;
            var nextTimes:int;
            if (!this.checkArtifactIsUpgradable())
            {
                return;
            }
            if (this.artifactData.getGoldExtractRemainingTimes() <= 0)
            {
                maxVipLevel = VipCfgObj.getInstance().maxLevel;
                vipLevel = UserObj.getInstance().playerInfo.vipid;
                times = ArtifactConst.getGoldExtractMaxTimesByVipLevel(vipLevel);
                timesInc;
                nextVipLevel = (vipLevel + 1);
                while (nextVipLevel <= maxVipLevel)
                {
                    
                    nextTimes = ArtifactConst.getGoldExtractMaxTimesByVipLevel(nextVipLevel);
                    if (nextTimes > times)
                    {
                        timesInc = nextTimes - times;
                        break;
                    }
                    nextVipLevel = (nextVipLevel + 1);
                }
                vipMsg = timesInc == 0 ? ("") : (StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11866"), [nextVipLevel, timesInc]) + LanguageCfgObj.getInstance().getByIndex("10199"));
                msg = "<font color=\'#F0ECE0\'>" + LanguageCfgObj.getInstance().getByIndex("11867") + vipMsg + "</font>";
                Global.popManager.cue(msg, LanguageCfgObj.getInstance().getByIndex("10200"), null, null, null, 1);
                return;
            }
            if (ProtectControl.getInstance().promptIfLocked())
            {
                return;
            }
            if (this.goldExtractAutoConfirm)
            {
                this.onGoldExtractConfirm();
            }
            else
            {
                Global.popManager.cue(ArtifactText.confirmUseGoldOrBindGoldToExtract(this.artifactData.goldExtractCostGold, this.artifactData.goldExtractCostBindGold, this.artifactData.getGoldExtractExp()), LanguageCfgObj.getInstance().getByIndex("11869"), null, this.onGoldExtractConfirm, null, 2, null, false, true, function (param1:Boolean) : void
            {
                goldExtractAutoConfirm = param1;
                return;
            }// end function
            );
            }
            return;
        }// end function

        private function onGoldExtractConfirm() : void
        {
            if (UserObj.getInstance().playerInfo.bindgold < this.artifactData.goldExtractCostBindGold && UserObj.getInstance().playerInfo.gold < this.artifactData.goldExtractCostGold)
            {
                MapControl.getInstance().showRechargeD();
                return;
            }
            this.protocol.reqExtractArtifact(null, true, false);
            return;
        }// end function

        private function autoExtractIfAllowed(event:Event = null) : void
        {
            if (this.artifactData.extractSetting.allowAutoExtract)
            {
                this.doExtract(this.artifactData.autoExtractableItems, true);
            }
            return;
        }// end function

        public function canExtractItemNow(param1:PropInfo) : Boolean
        {
            return this.artifactData.canExtractNow(param1);
        }// end function

        public function extractItem(param1:PropInfo, param2:Point = null, param3:Boolean = false) : void
        {
            var gold:int;
            var item:* = param1;
            var mousePos:* = param2;
            var isDoubleExp:* = param3;
            if (!this.checkArtifactIsUpgradable())
            {
                return;
            }
            gold;
            if (isDoubleExp)
            {
                gold = this.artifactData.computeDoubleExtractCostGold(item);
            }
            var onDoubleExtractConfirm:* = function () : void
            {
                if (UserObj.getInstance().playerInfo.gold < gold)
                {
                    MapControl.getInstance().showRechargeD();
                    return;
                }
                var onExtractPreciousItemConfirm:* = function () : void
                {
                    doExtract(ArtifactUtil.newVector(new Vector.<PropInfo>, item), false, mousePos, isDoubleExp);
                    return;
                }// end function
                ;
                if (!extractPreciousItemAutoConfirm && ProtectData.getInstance().isPreciousItem(item))
                {
                    Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("11870"), LanguageCfgObj.getInstance().getByIndex("11871"), null, onExtractPreciousItemConfirm, null, 2, null, false, true, function (param1:Boolean) : void
                {
                    extractPreciousItemAutoConfirm = param1;
                    return;
                }// end function
                );
                }
                else
                {
                    new activation.onExtractPreciousItemConfirm();
                }
                return;
            }// end function
            ;
            if (!this.doubleExtractAutoConfirm && isDoubleExp)
            {
                Global.popManager.cue(ArtifactText.confirmDoubleExtract(gold), LanguageCfgObj.getInstance().getByIndex("11871"), null, onDoubleExtractConfirm, null, 2, null, false, true, function (param1:Boolean) : void
            {
                doubleExtractAutoConfirm = param1;
                return;
            }// end function
            );
            }
            else
            {
                this.onDoubleExtractConfirm();
            }
            return;
        }// end function

        public function extractItems(param1:Vector.<PropInfo>, param2:Point = null) : void
        {
            var items:* = param1;
            var mousePos:* = param2;
            if (!this.checkArtifactIsUpgradable())
            {
                return;
            }
            var callback:* = function () : void
            {
                doExtract(items, false, mousePos);
                return;
            }// end function
            ;
            var preciousItems:* = ProtectData.getInstance().getPreciousItems(items);
            if (preciousItems.length > 0)
            {
                this.getExtractConfirmPanel().show(preciousItems, callback);
            }
            else
            {
                this.callback();
            }
            return;
        }// end function

        private function doExtract(param1:Vector.<PropInfo>, param2:Boolean = false, param3:Point = null, param4:Boolean = false) : void
        {
            var _loc_6:* = null;
            if (this.artifactData.isBest())
            {
                return;
            }
            if (ProtectData.getInstance().hasPreciousItem(param1) && ProtectControl.getInstance().promptIfLocked())
            {
                return;
            }
            var _loc_5:* = new Vector.<long>;
            for each (_loc_6 in param1)
            {
                
                _loc_5.push(_loc_6.itemId);
                this.artifactData.onExtractBegin(_loc_6, param2, param3);
            }
            this.protocol.reqExtractArtifact(_loc_5, false, param4);
            return;
        }// end function

        private function checkArtifactIsUpgradable() : Boolean
        {
            if (this.artifactData.isBest())
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10201"));
            }
            return !this.artifactData.isBest();
        }// end function

        public function saveExtractSetting() : void
        {
            AutoFightController.getInstance().doSaveAutoFightConfig();
            this.protocol.reqSaveArtifactSetting(this.artifactData.extractSetting.valueToString());
            this.artifactData.refreshExtractableItems();
            return;
        }// end function

        public function resPushArtifactInfo(param1:ResPushArtifactInfoMessage) : void
        {
            this.artifactData.updateData(param1);
            return;
        }// end function

        public function resExtractArtifact(param1:ResExtractArtifactMessage) : void
        {
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            if (param1.result != 0 && !param1.useGold)
            {
                this.artifactData.onExtractOk(param1.itemIds, param1.exps);
                _loc_2 = 0;
                for each (_loc_3 in param1.exps)
                {
                    
                    _loc_2 = _loc_2 + _loc_3;
                }
            }
            return;
        }// end function

        public function resRemoldArtifact(param1:ResRemoldArtifactMessage) : void
        {
            return;
        }// end function

        public static function getInstance() : ArtifactControl
        {
            var _loc_1:* = new ArtifactControl;
            instance = new ArtifactControl;
            return instance || _loc_1;
        }// end function

    }
}
