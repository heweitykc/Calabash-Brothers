package com.game.artifact.model
{
    import com.game.artifact.util.*;
    import com.model.vo.*;
    import flash.utils.*;

    public class ArtifactExtractableItemFilter extends Object
    {
        public var exceptedItemDict:Dictionary;
        public var zhuoyueNum:int = 1;
        public var maxSteplv:int = 0;
        public var allowMaya:Boolean = false;

        public function ArtifactExtractableItemFilter()
        {
            this.exceptedItemDict = new Dictionary();
            return;
        }// end function

        public function addExceptedItem(param1:PropInfo) : void
        {
            this.exceptedItemDict[param1.itemId.toString()] = true;
            return;
        }// end function

        public function clearExceptedItems() : void
        {
            this.exceptedItemDict = new Dictionary();
            return;
        }// end function

        public function hasExceptedItems() : Boolean
        {
            var _loc_1:* = undefined;
            for (_loc_1 in this.exceptedItemDict)
            {
                
                return true;
            }
            return false;
        }// end function

        public function allowItem(param1:PropInfo) : Boolean
        {
            if (this.exceptedItemDict[param1.itemId.toString()] !== undefined)
            {
                return false;
            }
            if (param1.itemModelId == ArtifactConst.tiliandanItemModelId)
            {
                return true;
            }
            if (param1.itemModelId == ArtifactConst.mayaItemModelId)
            {
                return this.allowMaya;
            }
            return this.allowEquip(param1 as EquipmentInfo);
        }// end function

        private function allowEquip(param1:EquipmentInfo) : Boolean
        {
            if (this.zhuoyueNum > 0)
            {
                if (ArtifactEquipUtil.getEquipZhuoyueNum(param1) != this.zhuoyueNum)
                {
                    return false;
                }
            }
            if (this.maxSteplv > 0)
            {
                if (param1.q_equip_steplv > this.maxSteplv)
                {
                    return false;
                }
            }
            return true;
        }// end function

    }
}
