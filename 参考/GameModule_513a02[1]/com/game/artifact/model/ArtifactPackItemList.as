package com.game.artifact.model
{
    import __AS3__.vec.*;
    import com.model.vo.*;
    import flash.utils.*;

    public class ArtifactPackItemList extends Object
    {
        public var items:Vector.<PropInfo>;
        public var hasNewItem:Boolean;
        private var oldItemIdSet:Dictionary;

        public function ArtifactPackItemList()
        {
            return;
        }// end function

        public function beginUpdate() : void
        {
            var _loc_1:* = null;
            if (this.items != null)
            {
                this.oldItemIdSet = new Dictionary();
                for each (_loc_1 in this.items)
                {
                    
                    this.oldItemIdSet[_loc_1.itemId.toString()] = true;
                }
            }
            this.items = new Vector.<PropInfo>;
            this.hasNewItem = false;
            return;
        }// end function

        public function addItem(param1:PropInfo) : void
        {
            this.items.push(param1);
            if (!this.hasNewItem)
            {
                if (this.oldItemIdSet == null || this.oldItemIdSet[param1.itemId.toString()] === undefined)
                {
                    this.hasNewItem = true;
                }
            }
            return;
        }// end function

        public function endUpdate() : void
        {
            this.oldItemIdSet = null;
            return;
        }// end function

    }
}
