package com.game.artifact.view
{
    import __AS3__.vec.*;
    import com.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.game.artifact.control.*;
    import com.game.artifact.event.*;
    import com.game.artifact.locale.*;
    import com.game.artifact.model.*;
    import com.game.artifact.util.*;
    import com.game.guide.*;
    import com.game.guide.control.*;
    import com.game.prompt.control.*;
    import com.game.prompt.model.*;
    import com.game.utils.*;
    import com.model.*;
    import com.model.vo.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class ArtifactExtractPanel extends BaseBox implements IGuide
    {
        private var btnClose:BaseButton;
        private var stoveView:ArtifactExtractStoveView;
        private var viewNoItems:DisplayObject;
        private var viewPleaseDragItem:DisplayObject;
        private var viewPackItems:ArtifactPackGridView;
        public var editZhuoyueNum:ArtifactDownListBox;
        public var editMaxSteplv:ArtifactDownListBox;
        public var editAllowMaya:ArtifactDownListBox;
        private var btnExtractAll:BaseButton;
        private var btnDoubleExtract:BaseButton;
        private var packHighlightBorder:ArtifactHighlightBorder;
        private var btnSeeExtractLog:BaseButton;
        private var bombLayer:Sprite;
        private var extractExpView:ArtifactExtractExpView;
        private var stoveSidePos:Point;
        private var stoveCenterPos:Point;
        private var extractExpPos:Point;
        private var artifactData:ArtifactData;
        private var filteredExtractableItems:Vector.<PropInfo>;
        private var extractExpDict:Dictionary;
        private var bombingItemCount:uint = 0;
        private var lastBombingItemId:long = null;
        private var linkedExtractingItemsDict:Dictionary;
        public var dataInited:Boolean = false;
        public static var isDoubleExtractMode:Boolean = false;

        public function ArtifactExtractPanel()
        {
            this.stoveSidePos = new Point(229 + 68, 9 + 148);
            this.stoveCenterPos = new Point(229 + 176, 9 + 161);
            this.extractExpPos = new Point(229 + 267, 9 + 127);
            this.artifactData = ArtifactData.getInstance();
            this.extractExpDict = new Dictionary();
            this.linkedExtractingItemsDict = new Dictionary();
            loadDisplay("res/artifactPanel.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("artifactExtractPanel");
            this.initUI();
            super.displayReady();
            this.registerGuide();
            return;
        }// end function

        private function initUI() : void
        {
            this.btnClose = this.createButton("btnClose", this.onClose);
            this.stoveView = new ArtifactExtractStoveView(getDisplayChildByName("stoveView"));
            this.viewNoItems = getDisplayChildByName("viewNoItems");
            this.viewPleaseDragItem = getDisplayChildByName("viewPleaseDragItem");
            this.viewPackItems = new ArtifactPackGridView(368, 108, 6, 10, 6, 0, 3);
            this.viewPackItems.setCellDragKey(ArtifactPackItemView.DRAG_KEY_EXTRACT);
            this.viewPackItems.setCellRightClickCallback(this.onPackItemRightClick);
            this.viewPackItems.setCellClickCallback(this.onPackItemClick);
            this.viewPackItems.equipTipsClass = ArtifactExtractPanelEquipTips;
            this.viewPackItems.move(254, 361);
            display.addChildAt(this.viewPackItems, display.getChildIndex(this.viewNoItems));
            this.editZhuoyueNum = this.createDownListBox("editZhuoyueNum", [LanguageCfgObj.getInstance().getByIndex("10014", "lang_artifact")].concat(ArtifactStringUtil.range(1, 3, "", LanguageCfgObj.getInstance().getByIndex("10015", "lang_artifact"))), this.onZhuoyueNumChange, this.artifactData.extractableItemFilter.zhuoyueNum);
            this.editMaxSteplv = this.createDownListBox("editMaxSteplv", [LanguageCfgObj.getInstance().getByIndex("10016", "lang_artifact")].concat(ArtifactStringUtil.multiFormat(1, 8, function (param1:uint) : String
            {
                var _loc_2:* = ArtifactStringUtil.getNumberChinese(param1);
                return _loc_2 + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("10017", "lang_artifact"), [_loc_2]);
            }// end function
            )), this.onSteplvChange, this.artifactData.extractableItemFilter.maxSteplv);
            this.editAllowMaya = this.createDownListBox("editAllowMaya", [LanguageCfgObj.getInstance().getByIndex("10018", "lang_artifact"), LanguageCfgObj.getInstance().getByIndex("10019", "lang_artifact")], this.onAllowMayaChange, this.artifactData.extractableItemFilter.allowMaya ? (1) : (0));
            this.btnExtractAll = this.createButton("btnExtractAll", this.onExtractAll);
            this.btnExtractAll.setText(LanguageCfgObj.getInstance().getByIndex("10020", "lang_artifact"));
            StringTip.create(this.btnExtractAll, LanguageCfgObj.getInstance().getByIndex("10021", "lang_artifact"));
            this.btnDoubleExtract = this.createButton("btnDoubleExtract", this.onDoubleExtract);
            this.btnDoubleExtract.setText(ArtifactText.btnDoubleExtract);
            StringTip.create(this.btnDoubleExtract, ArtifactText.tipDoubleExtract);
            this.btnSeeExtractLog = this.createButton("btnSeeExtractLog", this.onSeeExtractLog);
            this.bombLayer = new Sprite();
            addChild(this.bombLayer);
            this.extractExpView = new ArtifactExtractExpView(this.extractExpPos);
            addChild(this.extractExpView);
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

        private function createDownListBox(param1:String, param2:Array, param3:Function = null, param4:uint = 0) : ArtifactDownListBox
        {
            return ArtifactUiUtil.createDownListBox(this, param1, param2, param3, param4);
        }// end function

        private function onAddedToStage(event:Event = null) : void
        {
            this.artifactData.clearExceptedExtractableItems();
            this.artifactData.addEventListener(ArtifactEvent.FILTERED_EXTRACTABLE_ITEMS_CHANGE, this.refreshData);
            this.artifactData.addEventListener(ArtifactEvent.ITEM_BE_EXTRACT, this.onItemBeExtract);
            this.artifactData.addEventListener(ArtifactEvent.ITEM_BE_EXTRACT_OK, this.onItemBeExtractOk);
            this.dataInited = true;
            this.initData();
            return;
        }// end function

        private function onRemovedFromStage(event:Event) : void
        {
            this.turnOffDoubleExtractMode();
            this.artifactData.removeEventListener(ArtifactEvent.FILTERED_EXTRACTABLE_ITEMS_CHANGE, this.refreshData);
            this.artifactData.removeEventListener(ArtifactEvent.ITEM_BE_EXTRACT, this.onItemBeExtract);
            this.artifactData.removeEventListener(ArtifactEvent.ITEM_BE_EXTRACT_OK, this.onItemBeExtractOk);
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
            this.refreshExtractableItems();
            return;
        }// end function

        private function refreshExtractableItems() : void
        {
            var _loc_2:* = false;
            this.filteredExtractableItems = this.artifactData.filteredExtractableItems;
            this.viewPackItems.setData(this.filteredExtractableItems);
            var _loc_1:* = this.artifactData.extractableItems.length > 0;
            _loc_2 = this.filteredExtractableItems.length > 0;
            this.viewPackItems.visible = _loc_2;
            this.viewPleaseDragItem.visible = _loc_2;
            this.btnExtractAll.visible = _loc_1;
            this.btnExtractAll.enabled = _loc_2;
            this.btnDoubleExtract.visible = _loc_1;
            this.viewNoItems.visible = !_loc_2;
            this.editZhuoyueNum.setVisible(_loc_1);
            this.editMaxSteplv.setVisible(_loc_1);
            this.editAllowMaya.setVisible(_loc_1);
            return;
        }// end function

        private function onPackItemRightClick(param1:PropInfo) : void
        {
            this.artifactData.extractableItemFilter.addExceptedItem(param1);
            this.artifactData.filterExtractableItems();
            return;
        }// end function

        private function onPackItemClick(param1:PropInfo) : void
        {
            if (isDoubleExtractMode)
            {
                if (this.artifactData.isDoubleExtractable(param1))
                {
                    ArtifactControl.getInstance().extractItem(param1, null, true);
                }
                else
                {
                    Global.popManager.addedToMouseCue(ArtifactText.errDoubleExtractEquipOnly);
                }
            }
            return;
        }// end function

        private function onItemBeExtract(event:ArtifactEvent) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = event.data.item;
            var _loc_3:* = event.data.mousePos;
            if (_loc_3 != null)
            {
                _loc_4 = this.bombLayer.globalToLocal(_loc_3);
            }
            else
            {
                _loc_5 = this.viewPackItems.getItemViewByItemId(_loc_2.itemId);
                _loc_4 = _loc_5 != null ? (this.bombLayer.globalToLocal(_loc_5.localToGlobal(new Point(0, 0)))) : (this.stoveSidePos);
            }
            this.extractExpDict[_loc_2.itemId.toString()] = 0;
            if (this.bombingItemCount < 10)
            {
                var _loc_6:* = this;
                var _loc_7:* = this.bombingItemCount + 1;
                _loc_6.bombingItemCount = _loc_7;
                this.lastBombingItemId = _loc_2.itemId;
                new ArtifactExtractBombView(this.bombLayer, _loc_4, this.stoveCenterPos, _loc_2, this.onItemBombOk);
            }
            else if (this.linkedExtractingItemsDict[this.lastBombingItemId.toString()] === undefined)
            {
                this.linkedExtractingItemsDict[this.lastBombingItemId.toString()] = [_loc_2.itemId];
            }
            else
            {
                (this.linkedExtractingItemsDict[this.lastBombingItemId.toString()] as Array).push(_loc_2.itemId);
            }
            return;
        }// end function

        private function onItemBombOk(param1:PropInfo) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = NaN;
            var _loc_6:* = this;
            var _loc_7:* = this.bombingItemCount - 1;
            _loc_6.bombingItemCount = _loc_7;
            var _loc_2:* = [param1.itemId];
            if (this.linkedExtractingItemsDict[param1.itemId.toString()] !== undefined)
            {
                _loc_2 = _loc_2.concat(this.linkedExtractingItemsDict[param1.itemId.toString()]);
                delete this.linkedExtractingItemsDict[param1.itemId.toString()];
            }
            for each (_loc_3 in _loc_2)
            {
                
                _loc_4 = _loc_3.toString();
                _loc_5 = this.extractExpDict[_loc_4];
                delete this.extractExpDict[_loc_4];
                if (_loc_5 > 0)
                {
                    this.extractExpView.show(_loc_5);
                }
            }
            return;
        }// end function

        private function onItemBeExtractOk(event:ArtifactEvent) : void
        {
            var _loc_2:* = event.data.itemId;
            var _loc_3:* = event.data.exp;
            if (_loc_2 == null || this.extractExpDict[_loc_2.toString()] === undefined)
            {
                this.extractExpView.show(_loc_3);
            }
            else
            {
                this.extractExpDict[_loc_2.toString()] = _loc_3;
            }
            return;
        }// end function

        private function onClose(event:MouseEvent) : void
        {
            this.close();
            event.stopImmediatePropagation();
            return;
        }// end function

        private function onZhuoyueNumChange(event:Event) : void
        {
            this.artifactData.extractableItemFilter.zhuoyueNum = this.editZhuoyueNum.selectIndex;
            this.artifactData.filterExtractableItems();
            return;
        }// end function

        private function onSteplvChange(event:Event) : void
        {
            this.artifactData.extractableItemFilter.maxSteplv = this.editMaxSteplv.selectIndex;
            this.artifactData.filterExtractableItems();
            return;
        }// end function

        private function onAllowMayaChange(event:Event) : void
        {
            this.artifactData.extractableItemFilter.allowMaya = this.editAllowMaya.selectIndex != 0;
            this.artifactData.filterExtractableItems();
            return;
        }// end function

        private function onExtractAll(event:MouseEvent) : void
        {
            var _loc_2:* = this.filteredExtractableItems;
            if (_loc_2.length == 0)
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10216"));
                return;
            }
            ArtifactControl.getInstance().extractItems(_loc_2);
            return;
        }// end function

        private function onDoubleExtract(event:MouseEvent) : void
        {
            if (isDoubleExtractMode)
            {
                isDoubleExtractMode = false;
                this.btnDoubleExtract.setText(ArtifactText.btnDoubleExtract);
                this.hidePackHighlightBorder();
            }
            else
            {
                if (UserObj.getInstance().playerInfo.vipid < 4)
                {
                    Global.popManager.cue(ArtifactText.nonVip4CannotUseDoubleExtract, null, null, null, null, 1);
                    return;
                }
                isDoubleExtractMode = true;
                this.btnDoubleExtract.setText(ArtifactText.btnCancelDoubleExtract);
                this.showPackHighlightBorder();
            }
            if (event)
            {
                event.stopImmediatePropagation();
            }
            return;
        }// end function

        private function turnOffDoubleExtractMode() : void
        {
            if (isDoubleExtractMode)
            {
                this.onDoubleExtract(null);
            }
            return;
        }// end function

        public function showPackHighlightBorder() : void
        {
            if (this.packHighlightBorder == null)
            {
                this.packHighlightBorder = new ArtifactHighlightBorder(this, this.viewPackItems, 0, 0, this.viewPackItems.visibleWidth, this.viewPackItems.visibleHeight);
                this.packHighlightBorder.panelClickTip = ArtifactText.clickItemToDoubleExtract;
            }
            this.packHighlightBorder.show();
            Global.primaryCursorManager.showExtractIcon();
            return;
        }// end function

        public function hidePackHighlightBorder() : void
        {
            if (this.packHighlightBorder)
            {
                this.packHighlightBorder.hide();
                Global.primaryCursorManager.hide();
            }
            return;
        }// end function

        private function onSeeExtractLog(event:MouseEvent) : void
        {
            PromptControl.getInstance().openMessagesPanel(MessagesModel.ZHUZAO);
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            return;
        }// end function

        public function registerGuide() : void
        {
            return;
        }// end function

        public function guideAction(param1:String) : void
        {
            return;
        }// end function

        public function guidePause(param1:String) : void
        {
            GuideMultiControl.getInstance().backGuide(param1, 1);
            return;
        }// end function

        public function guideEnd(param1:String) : void
        {
            return;
        }// end function

        public function isGuideReady() : Boolean
        {
            return UILoaded;
        }// end function

    }
}
