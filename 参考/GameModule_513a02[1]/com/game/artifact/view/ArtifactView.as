package com.game.artifact.view
{
    import __AS3__.vec.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.image.*;
    import com.f1.ui.imagesNumbericStepper.*;
    import com.f1.ui.stripe.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.game.artifact.bean.*;
    import com.game.artifact.cfg.*;
    import com.game.artifact.control.*;
    import com.game.artifact.event.*;
    import com.game.artifact.locale.*;
    import com.game.artifact.model.*;
    import com.game.artifact.util.*;
    import com.game.backpack.control.*;
    import com.game.primaryrole.control.*;
    import com.model.vo.*;
    import com.util.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class ArtifactView extends Component
    {
        private var btnHelp:BaseButton;
        private var viewPhoto:ArtifactPhotoView;
        private var viewName:Image;
        private var viewSteplv:Image;
        private var mvUpSteplv:VMCView;
        private var btnPrevSteplv:BaseButton;
        private var btnNextSteplv:BaseButton;
        private var viewLevel:TextField;
        private var viewExp:Stripe;
        private var viewSteplvUpgradeTip:TextField;
        private var btnExtract:BaseButton;
        private var extractButtonXWhenHasGoldExtract:int;
        private var extractButtonXWhenNoGoldExtract:int;
        private var btnGoldExtract:BaseButton;
        private var viewGoldExtractRemainingTimes:TextField;
        private var viewFightPower:ImgNumber;
        private var fightPowerMask:Sprite;
        private var viewFightPowerPreview:ArtifactAttrPreviewView;
        private var viewFightPowerPreviewBg:Sprite;
        private var attrViews:Vector.<TextField>;
        private var attrPreviewViews:Vector.<ArtifactAttrPreviewView>;
        private var attrPreviewViewsBg:Sprite;
        private var remoldInfoViews:Vector.<TextField>;
        private var showingSteplv:int;
        private var showingSteplvFixed:Boolean;
        private var previewNextLevelNeeded:Boolean;
        private var propertyCfg:ArtifactPropertyCfg;
        private var previewingPropertyCfg:ArtifactPropertyCfg;
        private var previewingAttrs:ArtifactAttrs;
        private var artifactData:ArtifactData;
        private var fightPower:int = -1;
        private var level:int = -1;
        private var steplv:int;
        private const TEXT_LINK_EVENT_ITEM:String = "item";

        public function ArtifactView()
        {
            this.artifactData = ArtifactData.getInstance();
            loadDisplay("res/artifactPanel.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initComponentUI("artifactPanel");
            this.initUI();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            this.btnHelp = this.createButton("btnHelp");
            StringTip.create(this.btnHelp, GlobalCfgObj.getInstance().getArtifactHelp());
            this.viewPhoto = new ArtifactPhotoView();
            this.viewPhoto.move(45, -15);
            addChild(this.viewPhoto);
            this.viewName = new Image();
            this.viewName.move(119, 368);
            addChild(this.viewName);
            this.viewSteplv = new Image();
            this.viewSteplv.move(39, 70);
            addChild(this.viewSteplv);
            this.btnPrevSteplv = this.createButton("btnPrevSteplv", this.onPrevSteplv);
            this.btnNextSteplv = this.createButton("btnNextSteplv", this.onNextSteplv);
            this.viewLevel = getDisplayChildByName("viewLevel");
            this.viewExp = new Stripe(getDisplayChildByName("viewExp"));
            this.viewSteplvUpgradeTip = getDisplayChildByName("viewSteplvUpgradeTip");
            this.btnExtract = this.createButton("btnExtract", this.onExtract);
            this.btnExtract.setText("神器提炼");
            this.btnExtract.addEventListener(MouseEvent.ROLL_OVER, this.onExtractButtonMouseOver);
            this.btnExtract.addEventListener(MouseEvent.ROLL_OUT, this.onExtractButtonMouseOut);
            this.btnGoldExtract = this.createButton("btnGoldExtract", this.onGoldExtract);
            this.btnGoldExtract.setText("钻石提炼");
            this.btnGoldExtract.addEventListener(MouseEvent.ROLL_OVER, this.onExtractButtonMouseOver);
            this.btnGoldExtract.addEventListener(MouseEvent.ROLL_OUT, this.onExtractButtonMouseOut);
            this.extractButtonXWhenHasGoldExtract = this.btnExtract.x;
            this.extractButtonXWhenNoGoldExtract = this.btnExtract.x + (this.btnGoldExtract.x + this.btnGoldExtract.width - this.btnExtract.x - this.btnExtract.width) / 2;
            this.viewGoldExtractRemainingTimes = getDisplayChildByName("viewGoldExtractRemainingTimes");
            this.fightPowerMask = getDisplayChildByName("fightPowerMask");
            this.fightPowerMask.visible = false;
            var _loc_1:* = this.fightPowerMask.parent;
            var _loc_2:* = new VMCView();
            _loc_2.move(490, 107);
            _loc_2.loadRes("res/effect/houseExp.png");
            _loc_2.auto = true;
            _loc_2.updatePose("90", true);
            _loc_1.addChildAt(_loc_2, _loc_1.getChildIndex(this.fightPowerMask));
            this.viewFightPower = new ImgNumber();
            this.viewFightPower.move(this.fightPowerMask.x, this.fightPowerMask.y);
            _loc_1.addChildAt(this.viewFightPower, _loc_1.getChildIndex(this.fightPowerMask));
            this.viewFightPower.mask = this.fightPowerMask;
            this.viewFightPowerPreview = new ArtifactAttrPreviewView();
            this.viewFightPowerPreview.move(575, this.fightPowerMask.y + (this.fightPowerMask.height - this.viewFightPowerPreview.height) / 2);
            addChild(this.viewFightPowerPreview);
            this.viewFightPowerPreviewBg = getDisplayChildByName("viewFightPowerPreviewBg");
            this.attrViews = ArtifactUiUtil.getTextFields(this, "attrView", ArtifactAttrCategoryGroup.instances.length);
            this.attrPreviewViews = new Vector.<ArtifactAttrPreviewView>;
            for each (_loc_3 in this.attrViews)
            {
                
                _loc_6 = new ArtifactAttrPreviewView();
                _loc_6.move(575, _loc_3.y + (_loc_3.height - _loc_6.height) / 2);
                addChild(_loc_6);
                this.attrPreviewViews.push(_loc_6);
            }
            this.attrPreviewViewsBg = getDisplayChildByName("attrPreviewViewsBg");
            this.remoldInfoViews = ArtifactUiUtil.getTextFields(this, "remoldInfoView", 6);
            for each (_loc_4 in this.remoldInfoViews)
            {
                
                _loc_4.addEventListener(TextEvent.LINK, this.onRemoldInfoViewTextLink);
            }
            _loc_5 = 0;
            while (_loc_5 < 6)
            {
                
                (getDisplayChildByName("remoldInfoBg" + _loc_5) as MovieClip).gotoAndStop(_loc_5 % 2 + 1);
                _loc_5 = _loc_5 + 1;
            }
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            if (stage)
            {
                this.onAddedToStage();
            }
            return;
        }// end function

        private function createButton(param1:String, param2:Function = null) : BaseButton
        {
            return ArtifactUiUtil.createButton(this, param1, param2);
        }// end function

        private function onAddedToStage(event:Event = null) : void
        {
            this.artifactData.addEventListener(ArtifactEvent.ARTIFACT_DATA_CHANGE, this.refreshData);
            this.initData();
            return;
        }// end function

        private function onRemovedFromStage(event:Event) : void
        {
            this.artifactData.removeEventListener(ArtifactEvent.ARTIFACT_DATA_CHANGE, this.refreshData);
            ArtifactControl.getInstance().closeExtractPanel();
            return;
        }// end function

        private function initData() : void
        {
            this.showingSteplvFixed = false;
            this.previewNextLevelNeeded = false;
            this.steplv = this.artifactData.steplv;
            this.refreshData();
            return;
        }// end function

        private function refreshData(event:Event = null) : void
        {
            this.propertyCfg = this.artifactData.propertyCfg;
            var _loc_2:* = ArtifactPropertyCfgObj.getInstance().getMinLevelCfgBySteplv((this.propertyCfg.q_step + 1));
            this.viewLevel.text = "lv." + this.propertyCfg.q_client_level;
            if (this.propertyCfg.q_client_level != this.level)
            {
                this.level = this.propertyCfg.q_client_level;
                this.viewExp.setValue(0, this.propertyCfg.q_exp);
            }
            this.viewExp.setValue(this.artifactData.exp, this.propertyCfg.q_exp, true);
            this.viewSteplvUpgradeTip.text = _loc_2 == null ? (LanguageCfgObj.getInstance().getByIndex("11883")) : (StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11884"), [_loc_2.q_level - this.propertyCfg.q_level]));
            if (this.steplv < this.artifactData.steplv)
            {
                this.steplv = this.artifactData.steplv;
                this.showSteplvUpgradeEffect();
            }
            var _loc_3:* = ArtifactConst.getGoldExtractMaxTimes() > 0;
            this.btnGoldExtract.visible = _loc_3;
            this.viewGoldExtractRemainingTimes.visible = _loc_3;
            this.btnExtract.x = _loc_3 ? (this.extractButtonXWhenHasGoldExtract) : (this.extractButtonXWhenNoGoldExtract);
            if (_loc_3)
            {
                this.btnGoldExtract.filters = this.artifactData.getGoldExtractRemainingTimes() == 0 ? ([FrameworkGlobal.colorMat]) : (null);
                this.viewGoldExtractRemainingTimes.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11885"), [this.artifactData.getGoldExtractRemainingTimes()]);
                StringTip.create(this.btnGoldExtract, ArtifactText.useGoldOrBindGoldToExtract(this.artifactData.goldExtractCostGold, this.artifactData.goldExtractCostBindGold, this.artifactData.getGoldExtractExp()));
            }
            this.refreshRemoldInfos();
            this.refreshFightPower();
            this.refreshPreview();
            return;
        }// end function

        private function refreshRemoldInfos() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_1:* = this.artifactData.extendedRemoldInfos;
            var _loc_2:* = 0;
            for each (_loc_3 in _loc_1)
            {
                
                _loc_4 = ItemCfgObj.getInstance().getItemName(_loc_3.itemModelId);
                _loc_5 = this.remoldInfoViews[_loc_2++];
                _loc_5.htmlText = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11887"), [ArtifactTextUtil.addNormalLink(_loc_4, this.TEXT_LINK_EVENT_ITEM, 65280) + " " + ArtifactTextUtil.addColor(_loc_3.count.toString(), 65280)]);
                _loc_5.visible = true;
            }
            while (_loc_2 < this.remoldInfoViews.length)
            {
                
                this.remoldInfoViews[_loc_2].visible = false;
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        private function refreshFightPower() : void
        {
            if (this.fightPower != this.artifactData.fightPower)
            {
                this.fightPower = this.artifactData.fightPower;
                this.viewFightPower.setNumberScroll(this.fightPower.toString(), 1, 0, 23, this.fightPowerMask.height, false, true);
            }
            return;
        }// end function

        private function refreshPreview() : void
        {
            if (!this.showingSteplvFixed)
            {
                this.showingSteplv = this.artifactData.steplv;
            }
            var _loc_1:* = ArtifactPropertyCfgObj.getInstance().getMinLevelCfgBySteplv(this.showingSteplv);
            if (this.previewNextLevelNeeded && this.artifactData.level < ArtifactPropertyCfgObj.getInstance().maxLevel)
            {
                this.previewingPropertyCfg = ArtifactPropertyCfgObj.getInstance().getCfg((this.artifactData.level + 1));
            }
            else if (this.showingSteplv > this.artifactData.steplv)
            {
                this.previewingPropertyCfg = _loc_1;
            }
            else
            {
                this.previewingPropertyCfg = this.propertyCfg;
            }
            this.previewingAttrs = this.previewingPropertyCfg.q_level <= this.propertyCfg.q_level ? (null) : (this.artifactData.computeAttrs(this.previewingPropertyCfg));
            this.viewPhoto.setArtifact(_loc_1);
            this.viewName.load(_loc_1.nameUrl);
            this.viewSteplv.load("res/image/horse/horsestage" + _loc_1.q_step + ".png");
            this.btnPrevSteplv.visible = this.showingSteplv > ArtifactPropertyCfgObj.getInstance().minSteplv;
            this.btnNextSteplv.visible = this.showingSteplv < ArtifactPropertyCfgObj.getInstance().maxSteplv;
            this.refreshFightPowerPreview();
            this.refreshAttrs();
            return;
        }// end function

        private function refreshFightPowerPreview() : void
        {
            var _loc_1:* = this.previewingAttrs != null ? (this.previewingAttrs.fightPower - this.artifactData.fightPower) : (0);
            if (_loc_1 <= 0)
            {
                this.viewFightPowerPreview.visible = false;
                this.viewFightPowerPreviewBg.visible = false;
            }
            else
            {
                this.viewFightPowerPreview.visible = true;
                this.viewFightPowerPreviewBg.visible = true;
                this.viewFightPowerPreview.text = "+" + _loc_1;
                this.movieUpArtifactPanel();
            }
            return;
        }// end function

        private function refreshAttrs() : void
        {
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = false;
            var _loc_14:* = 0;
            var _loc_15:* = 0;
            var _loc_16:* = null;
            var _loc_17:* = 0;
            var _loc_18:* = 0;
            var _loc_19:* = 0;
            var _loc_20:* = false;
            var _loc_21:* = 0;
            var _loc_1:* = this.artifactData.attrs;
            var _loc_2:* = 19;
            var _loc_3:* = this.attrViews[0].y;
            var _loc_4:* = this.attrPreviewViews[0].y;
            var _loc_5:* = false;
            var _loc_8:* = 0;
            while (_loc_8 < ArtifactAttrCategoryGroup.instances.length)
            {
                
                _loc_9 = ArtifactAttrCategoryGroup.instances[_loc_8];
                _loc_10 = this.attrViews[_loc_8];
                _loc_11 = this.attrPreviewViews[_loc_8];
                _loc_12 = null;
                _loc_13 = false;
                _loc_14 = 0;
                _loc_15 = 0;
                while (_loc_15 < _loc_9.children.length)
                {
                    
                    _loc_16 = _loc_9.children[_loc_15];
                    _loc_17 = _loc_1.getValue(_loc_16);
                    _loc_18 = this.previewingAttrs == null ? (0) : (this.previewingAttrs.getValue(_loc_16));
                    _loc_19 = _loc_17 != 0 ? (_loc_17) : (_loc_18);
                    if (_loc_19 != 0)
                    {
                        if (_loc_17 == 0)
                        {
                            _loc_13 = true;
                        }
                        else if (_loc_18 != 0 && _loc_18 > _loc_17)
                        {
                            _loc_14 = _loc_18 - _loc_17;
                        }
                        if (_loc_12 == null)
                        {
                            _loc_12 = "";
                        }
                        if (_loc_15 != 0)
                        {
                            _loc_12 = _loc_12 + "-";
                        }
                        if (_loc_9.isPercent)
                        {
                            _loc_12 = _loc_12 + _loc_9.toPercentText(_loc_19);
                        }
                        else
                        {
                            _loc_12 = _loc_12 + _loc_19;
                        }
                    }
                    _loc_15 = _loc_15 + 1;
                }
                if (_loc_12 == null)
                {
                    _loc_10.visible = false;
                    _loc_11.visible = false;
                }
                else
                {
                    _loc_10.visible = true;
                    if (_loc_9.isPercent)
                    {
                        _loc_10.text = _loc_9.name + " " + _loc_12 + "%";
                    }
                    else
                    {
                        _loc_10.text = _loc_9.name + "：" + _loc_12;
                    }
                    _loc_10.y = _loc_3;
                    _loc_20 = true;
                    if (_loc_13)
                    {
                        _loc_11.text = LanguageCfgObj.getInstance().getByIndex("10220");
                    }
                    else if (_loc_14 != 0)
                    {
                        _loc_11.text = "+" + (_loc_9.isPercent ? (_loc_9.toPercentText(_loc_14) + "%") : (_loc_14));
                    }
                    else
                    {
                        _loc_20 = false;
                    }
                    _loc_11.visible = _loc_20;
                    _loc_11.y = _loc_4;
                    if (_loc_20)
                    {
                        if (!_loc_5)
                        {
                            _loc_5 = true;
                            _loc_6 = _loc_4;
                        }
                        _loc_7 = _loc_4;
                    }
                    _loc_3 = _loc_3 + _loc_2;
                    _loc_4 = _loc_4 + _loc_2;
                }
                _loc_8 = _loc_8 + 1;
            }
            this.attrPreviewViewsBg.visible = _loc_5;
            if (_loc_5)
            {
                _loc_21 = 8;
                this.attrPreviewViewsBg.y = _loc_6 - _loc_21;
                this.attrPreviewViewsBg.height = _loc_7 - _loc_6 + this.attrPreviewViews[0].height + _loc_21 * 2;
                this.movieUpArtifactPanel();
            }
            return;
        }// end function

        private function movieUpArtifactPanel() : void
        {
            var _loc_3:* = null;
            var _loc_1:* = PrimaryRoleControl.getInstance().getRoleView();
            var _loc_2:* = ArtifactControl.getInstance().getExtractPanel();
            if (_loc_1.parent && _loc_1.parent == _loc_2.parent)
            {
                _loc_3 = _loc_1.parent;
                if (_loc_3.getChildIndex(_loc_1) < _loc_3.getChildIndex(_loc_2))
                {
                    _loc_3.setChildIndex(_loc_1, _loc_3.getChildIndex(_loc_2));
                }
            }
            return;
        }// end function

        private function showSteplvUpgradeEffect() : void
        {
            if (this.mvUpSteplv == null)
            {
                this.mvUpSteplv = new VMCView();
                this.mvUpSteplv.auto = true;
                this.mvUpSteplv.move(200, 370);
            }
            if (this.mvUpSteplv.parent == null)
            {
                addChild(this.mvUpSteplv);
            }
            this.mvUpSteplv.loadRes("res/effect/successtips/artifactUpStep.png");
            this.mvUpSteplv.updatePose("90", false, false, true);
            this.mvUpSteplv.replay();
            return;
        }// end function

        private function onPrevSteplv(event:MouseEvent = null) : void
        {
            if (this.showingSteplv > ArtifactPropertyCfgObj.getInstance().minSteplv)
            {
                var _loc_2:* = this;
                var _loc_3:* = this.showingSteplv - 1;
                _loc_2.showingSteplv = _loc_3;
                this.onSteplvNavigated();
            }
            return;
        }// end function

        private function onNextSteplv(event:MouseEvent = null) : void
        {
            if (this.showingSteplv < ArtifactPropertyCfgObj.getInstance().maxSteplv)
            {
                var _loc_2:* = this;
                var _loc_3:* = this.showingSteplv + 1;
                _loc_2.showingSteplv = _loc_3;
                this.onSteplvNavigated();
            }
            return;
        }// end function

        private function onSteplvNavigated() : void
        {
            this.showingSteplvFixed = this.showingSteplv != this.artifactData.steplv;
            this.refreshPreview();
            return;
        }// end function

        private function onExtract(event:MouseEvent = null) : void
        {
            ArtifactControl.getInstance().openOrCloseExtractPanel();
            return;
        }// end function

        private function onGoldExtract(event:MouseEvent = null) : void
        {
            ArtifactControl.getInstance().goldExtract();
            return;
        }// end function

        private function onExtractButtonMouseOver(event:MouseEvent) : void
        {
            this.previewNextLevelNeeded = true;
            this.refreshPreview();
            return;
        }// end function

        private function onExtractButtonMouseOut(event:MouseEvent) : void
        {
            this.previewNextLevelNeeded = false;
            this.refreshPreview();
            return;
        }// end function

        private function onRemoldInfoViewTextLink(event:TextEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (event.text == this.TEXT_LINK_EVENT_ITEM)
            {
                _loc_2 = event.target as TextField;
                _loc_3 = this.remoldInfoViews.indexOf(_loc_2);
                if (_loc_3 >= 0 && _loc_3 < this.artifactData.extendedRemoldInfos.length)
                {
                    _loc_4 = this.artifactData.extendedRemoldInfos[_loc_3];
                    _loc_5 = PropUtil.createItemByCfg(_loc_4.itemModelId);
                    EquipCompareControl.createEquipTips(_loc_5, true);
                }
            }
            return;
        }// end function

    }
}
