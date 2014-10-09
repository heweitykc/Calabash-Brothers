package com.game.artifact.model
{
    import __AS3__.vec.*;
    import com.game.artifact.bean.*;
    import com.game.artifact.cfg.*;
    import com.game.artifact.event.*;
    import com.game.artifact.message.*;
    import com.game.artifact.util.*;
    import com.game.backpack.model.*;
    import com.game.utils.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class ArtifactData extends EventDispatcher
    {
        public var level:int;
        public var exp:Number;
        public var goldExtractTimes:int;
        public var remoldInfos:Vector.<ArtifactRemoldInfo>;
        public var extractSetting:ArtifactExtractSetting;
        public var propertyCfg:ArtifactPropertyCfg;
        public var attrs:ArtifactAttrs;
        public var fightPower:int;
        public var extendedRemoldInfos:Vector.<ArtifactRemoldInfo>;
        private var extractableItemList:ArtifactPackItemList;
        public var extractableItemFilter:ArtifactExtractableItemFilter;
        private var filteredExtractableItemList:ArtifactPackItemList;
        private var autoExtractableItemList:ArtifactPackItemList;
        private var autoExtractingItemDict:Dictionary;
        public var autoExtractedEquipCount:int = 0;
        public var autoExtractedMayaCount:int = 0;
        public var autoExtractGainExp:Number = 0;
        public var autoExtractMsgLastShowTime:int;
        private var jewelryKinds:Array;
        private static var instance:ArtifactData;

        public function ArtifactData()
        {
            this.extractSetting = new ArtifactExtractSetting();
            this.extractableItemList = new ArtifactPackItemList();
            this.extractableItemFilter = new ArtifactExtractableItemFilter();
            this.filteredExtractableItemList = new ArtifactPackItemList();
            this.autoExtractableItemList = new ArtifactPackItemList();
            this.autoExtractingItemDict = new Dictionary();
            this.autoExtractMsgLastShowTime = getTimer();
            this.jewelryKinds = [Params.NICKLACE, Params.RING1, Params.RING2];
            ArtifactAttrCategoryGroup.initClass();
            return;
        }// end function

        public function get extractableItems() : Vector.<PropInfo>
        {
            return this.extractableItemList.items;
        }// end function

        public function get filteredExtractableItems() : Vector.<PropInfo>
        {
            return this.filteredExtractableItemList.items;
        }// end function

        public function get autoExtractableItems() : Vector.<PropInfo>
        {
            return this.autoExtractableItemList.items;
        }// end function

        public function isArtifactEnabled() : Boolean
        {
            return this.level > 0;
        }// end function

        public function isBest() : Boolean
        {
            return this.level >= ArtifactPropertyCfgObj.getInstance().maxLevel && this.exp >= ArtifactPropertyCfgObj.getInstance().maxLevelExp;
        }// end function

        public function get steplv() : int
        {
            return this.propertyCfg.q_step;
        }// end function

        public function get stepInnerLv() : int
        {
            return this.propertyCfg.q_client_level;
        }// end function

        public function refreshVipLevel() : void
        {
            dispatchEvent(new ArtifactEvent(ArtifactEvent.ARTIFACT_DATA_CHANGE));
            return;
        }// end function

        public function setAllowAutoExtract(param1:Boolean) : void
        {
            return;
        }// end function

        public function canExtractNow(param1:PropInfo) : Boolean
        {
            return this.isArtifactEnabled() && this.isExtractable(param1);
        }// end function

        private function isJewelry(param1:EquipmentInfo) : Boolean
        {
            return this.jewelryKinds.indexOf(param1.q_kind) >= 0;
        }// end function

        private function isExtractable(param1:PropInfo) : Boolean
        {
            var _loc_2:* = null;
            if (param1.isHighLocked)
            {
                return false;
            }
            if (param1.itemModelId == ArtifactConst.tiliandanItemModelId)
            {
                return true;
            }
            if (param1.itemModelId == ArtifactConst.mayaItemModelId)
            {
                return true;
            }
            if (param1 is EquipmentInfo)
            {
                _loc_2 = param1 as EquipmentInfo;
                if (_loc_2.q_remarkable && !this.isJewelry(_loc_2))
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function isDoubleExtractable(param1:PropInfo) : Boolean
        {
            return param1 is EquipmentInfo;
        }// end function

        public function refreshExtractableItems() : void
        {
            var _loc_2:* = null;
            if (!this.isArtifactEnabled())
            {
                return;
            }
            this.extractableItemList.beginUpdate();
            this.autoExtractableItemList.beginUpdate();
            var _loc_1:* = BackpackObj.getInstance().info.items;
            for each (_loc_2 in _loc_1)
            {
                
                if (this.isExtractable(_loc_2))
                {
                    this.extractableItemList.addItem(_loc_2);
                    if (this.extractSetting.allowItem(_loc_2))
                    {
                        this.autoExtractableItemList.addItem(_loc_2);
                    }
                }
            }
            this.extractableItemList.endUpdate();
            this.autoExtractableItemList.endUpdate();
            this.filterExtractableItems();
            if (this.extractableItemList.hasNewItem)
            {
                dispatchEvent(new ArtifactEvent(ArtifactEvent.EXTRACTABLE_ITEMS_HAS_NEW));
            }
            if (this.autoExtractableItemList.hasNewItem)
            {
                dispatchEvent(new ArtifactEvent(ArtifactEvent.AUTO_EXTRACTABLE_ITEMS_HAS_NEW));
            }
            dispatchEvent(new ArtifactEvent(ArtifactEvent.EXTRACTABLE_ITEMS_CHANGE));
            dispatchEvent(new ArtifactEvent(ArtifactEvent.AUTO_EXTRACTABLE_ITEMS_CHANGE));
            return;
        }// end function

        public function clearExceptedExtractableItems() : void
        {
            if (this.extractableItemFilter.hasExceptedItems())
            {
                this.extractableItemFilter.clearExceptedItems();
                this.filterExtractableItems();
            }
            return;
        }// end function

        public function filterExtractableItems() : void
        {
            var _loc_1:* = null;
            this.filteredExtractableItemList.beginUpdate();
            for each (_loc_1 in this.extractableItems)
            {
                
                if (this.extractableItemFilter.allowItem(_loc_1))
                {
                    this.filteredExtractableItemList.addItem(_loc_1);
                }
            }
            this.filteredExtractableItemList.endUpdate();
            if (this.filteredExtractableItemList.hasNewItem)
            {
                dispatchEvent(new ArtifactEvent(ArtifactEvent.FILTERED_EXTRACTABLE_ITEMS_HAS_NEW));
            }
            dispatchEvent(new ArtifactEvent(ArtifactEvent.FILTERED_EXTRACTABLE_ITEMS_CHANGE));
            return;
        }// end function

        public function onExtractBegin(param1:PropInfo, param2:Boolean = false, param3:Point = null) : void
        {
            var _loc_4:* = param1.itemId;
            if (param2)
            {
                this.autoExtractingItemDict[_loc_4.toString()] = {itemModelId:param1.itemModelId, count:param1.num};
            }
            dispatchEvent(new ArtifactEvent(ArtifactEvent.ITEM_BE_EXTRACT, {item:param1, mousePos:param3}));
            return;
        }// end function

        public function onExtractOk(param1:Vector.<long>, param2:Vector.<Number>) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = NaN;
            var _loc_7:* = undefined;
            var _loc_3:* = false;
            var _loc_4:* = 0;
            while (_loc_4 < param1.length)
            {
                
                _loc_5 = param1[_loc_4];
                _loc_6 = param2[_loc_4];
                _loc_7 = this.autoExtractingItemDict[_loc_5.toString()];
                if (_loc_7 !== undefined)
                {
                    delete this.autoExtractingItemDict[_loc_5.toString()];
                    if (_loc_7.itemModelId != ArtifactConst.tiliandanItemModelId)
                    {
                        _loc_3 = true;
                        if (_loc_7.itemModelId == ArtifactConst.mayaItemModelId)
                        {
                            this.autoExtractedMayaCount = this.autoExtractedMayaCount + _loc_7.count;
                        }
                        else
                        {
                            var _loc_8:* = this;
                            var _loc_9:* = this.autoExtractedEquipCount + 1;
                            _loc_8.autoExtractedEquipCount = _loc_9;
                        }
                        this.autoExtractGainExp = this.autoExtractGainExp + _loc_6;
                    }
                }
                dispatchEvent(new ArtifactEvent(ArtifactEvent.ITEM_BE_EXTRACT_OK, {itemId:_loc_5, exp:_loc_6}));
                _loc_4 = _loc_4 + 1;
            }
            if (_loc_3)
            {
                dispatchEvent(new ArtifactEvent(ArtifactEvent.AUTO_EXTRACT_MSG_CHANGE));
            }
            return;
        }// end function

        public function updateData(param1:ResPushArtifactInfoMessage) : void
        {
            this.level = param1.level;
            this.exp = param1.exp;
            this.goldExtractTimes = param1.extract;
            this.remoldInfos = param1.remold;
            this.extractSetting.updateData(param1.saveSetting);
            if (this.level > 0)
            {
                this.propertyCfg = ArtifactPropertyCfgObj.getInstance().getCfg(this.level);
                this.attrs = this.computeAttrs(this.propertyCfg);
                this.fightPower = this.attrs.fightPower;
                this.extendRemoldInfos();
            }
            this.refreshExtractableItems();
            dispatchEvent(new ArtifactEvent(ArtifactEvent.ARTIFACT_DATA_CHANGE));
            return;
        }// end function

        public function computeAttrs(param1:ArtifactPropertyCfg, param2:Vector.<ArtifactRemoldInfo> = null) : ArtifactAttrs
        {
            var _loc_4:* = undefined;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (param2 == null)
            {
                param2 = this.remoldInfos;
            }
            var _loc_3:* = new Dictionary();
            for (_loc_4 in param1.q_attribute)
            {
                
                _loc_3[_loc_4] = _loc_8[_loc_4];
            }
            for each (_loc_5 in param2)
            {
                
                _loc_6 = ArtifactRemoldCfgObj.getInstance().getCfg(_loc_5.itemModelId);
                for (_loc_4 in _loc_6.q_attribute)
                {
                    
                    _loc_3[_loc_4] = uint(_loc_3[_loc_4]) + _loc_10[_loc_4] * _loc_5.count;
                }
            }
            return new ArtifactAttrs(_loc_3);
        }// end function

        private function extendRemoldInfos() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this.extendedRemoldInfos = new Vector.<ArtifactRemoldInfo>;
            var _loc_1:* = new Dictionary();
            for each (_loc_2 in this.remoldInfos)
            {
                
                this.extendedRemoldInfos.push(_loc_2);
                _loc_1[_loc_2.itemModelId] = _loc_2;
            }
            for each (_loc_3 in ArtifactRemoldCfgObj.getInstance().map)
            {
                
                if (_loc_1[_loc_3.q_id] == null && _loc_3.q_level <= this.level)
                {
                    _loc_2 = new ArtifactRemoldInfo();
                    _loc_2.itemModelId = _loc_3.q_id;
                    _loc_2.count = 0;
                    this.extendedRemoldInfos.push(_loc_2);
                }
            }
            this.extendedRemoldInfos.sort(this.remoldItemArtifactLevelDif);
            return;
        }// end function

        private function remoldItemArtifactLevelDif(param1:ArtifactRemoldInfo, param2:ArtifactRemoldInfo) : Number
        {
            return ArtifactRemoldCfgObj.getInstance().getCfg(param1.itemModelId).q_level - ArtifactRemoldCfgObj.getInstance().getCfg(param2.itemModelId).q_level;
        }// end function

        public function getGoldExtractRemainingTimes() : uint
        {
            var _loc_1:* = ArtifactConst.getGoldExtractMaxTimes();
            var _loc_2:* = this.goldExtractTimes;
            return _loc_2 >= _loc_1 ? (0) : (_loc_1 - _loc_2);
        }// end function

        public function get goldExtractCostGold() : uint
        {
            return ArtifactConst.getGoldExtractCostGold(this.goldExtractTimes);
        }// end function

        public function get goldExtractCostBindGold() : uint
        {
            return ArtifactConst.getGoldExtractCostBindGold(this.goldExtractTimes);
        }// end function

        public function computeExtractExp(param1:Vector.<PropInfo>) : Number
        {
            var _loc_7:* = null;
            var _loc_8:* = NaN;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = undefined;
            var _loc_2:* = 0;
            var _loc_3:* = this.level;
            var _loc_4:* = this.exp;
            var _loc_5:* = ArtifactPropertyCfgObj.getInstance().getCfg(_loc_3);
            var _loc_6:* = ArtifactExtractCfgObj.getInstance().getCfg(_loc_3);
            for each (_loc_7 in param1)
            {
                
                _loc_8 = 0;
                if (_loc_7 is EquipmentInfo)
                {
                    _loc_9 = _loc_7 as EquipmentInfo;
                    _loc_8 = _loc_8 + ArtifactCfgUtil.getExpFromExtractCfg(ArtifactUtil.getInNestedDict(_loc_6.q_zhuoyue_num, _loc_9.q_equip_steplv, ArtifactEquipUtil.getEquipZhuoyueNum(_loc_9)));
                    _loc_10 = _loc_6.q_zhuoyue_attribute[_loc_9.q_equip_steplv];
                    if (_loc_10 != null)
                    {
                        for (_loc_11 in _loc_10)
                        {
                            
                            if (ArtifactEquipUtil.hasEquipAttribute(_loc_9, _loc_11))
                            {
                                _loc_8 = _loc_8 + ArtifactUtil.toNumber(_loc_10[_loc_11]);
                            }
                        }
                    }
                    _loc_8 = _loc_8 + ArtifactCfgUtil.getExpFromExtractCfg(_loc_6.q_steplv_zhuoyue[_loc_9.q_equip_steplv]);
                    _loc_8 = _loc_8 + ArtifactCfgUtil.getExpFromExtractCfg(_loc_6.q_intensify_zhuoyue[_loc_9.intensify]);
                    _loc_8 = _loc_8 + ArtifactCfgUtil.getExpFromExtractCfg(_loc_6.q_append_zhuoyue[_loc_9.addAttributLevel]);
                }
                else if (_loc_7.itemModelId == ArtifactConst.mayaItemModelId)
                {
                    _loc_8 = _loc_8 + _loc_6.q_maya_exp * _loc_7.num;
                }
                else if (_loc_7.itemModelId == ArtifactConst.tiliandanItemModelId)
                {
                    _loc_8 = _loc_8 + _loc_6.q_extract_exp * _loc_7.num;
                }
                _loc_2 = _loc_2 + _loc_8;
                _loc_4 = _loc_4 + _loc_8;
                while (_loc_4 >= _loc_5.q_exp)
                {
                    
                    _loc_4 = _loc_4 - _loc_5.q_exp;
                    _loc_3 = _loc_3 + 1;
                    if (_loc_3 > ArtifactPropertyCfgObj.getInstance().maxLevel)
                    {
                        break;
                    }
                    _loc_5 = ArtifactPropertyCfgObj.getInstance().getCfg(_loc_3);
                    _loc_6 = ArtifactExtractCfgObj.getInstance().getCfg(_loc_3);
                }
            }
            return _loc_2;
        }// end function

        public function computeDoubleExtractCostGold(param1:PropInfo) : int
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = 0;
            if (param1 is EquipmentInfo)
            {
                _loc_3 = param1 as EquipmentInfo;
                _loc_4 = ArtifactExtractCfgObj.getInstance().getCfg(this.level);
                _loc_2 = _loc_2 + ArtifactCfgUtil.getCostGoldFromExtractCfg(ArtifactUtil.getInNestedDict(_loc_4.q_zhuoyue_num, _loc_3.q_equip_steplv, ArtifactEquipUtil.getEquipZhuoyueNum(_loc_3)));
                _loc_2 = _loc_2 + ArtifactCfgUtil.getCostGoldFromExtractCfg(_loc_4.q_steplv_zhuoyue[_loc_3.q_equip_steplv]);
                _loc_2 = _loc_2 + ArtifactCfgUtil.getCostGoldFromExtractCfg(_loc_4.q_intensify_zhuoyue[_loc_3.intensify]);
                _loc_2 = _loc_2 + ArtifactCfgUtil.getCostGoldFromExtractCfg(_loc_4.q_append_zhuoyue[_loc_3.addAttributLevel]);
            }
            return _loc_2;
        }// end function

        public function computeDoubleExtractExp(param1:PropInfo) : Number
        {
            return this.computeExtractExp(ArtifactUtil.newVector(new Vector.<PropInfo>, param1)) * 2;
        }// end function

        public function getGoldExtractExp() : Number
        {
            var _loc_1:* = ArtifactExtractCfgObj.getInstance().getCfg(this.level);
            return _loc_1.q_gold_exp;
        }// end function

        public static function getInstance() : ArtifactData
        {
            var _loc_1:* = new ArtifactData;
            instance = new ArtifactData;
            return instance || _loc_1;
        }// end function

    }
}
