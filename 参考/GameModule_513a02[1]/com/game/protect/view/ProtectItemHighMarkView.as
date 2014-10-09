package com.game.protect.view
{
    import com.events.*;
    import com.f1.utils.*;
    import com.game.protect.model.*;
    import com.model.vo.*;
    import com.view.icon.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class ProtectItemHighMarkView extends Bitmap
    {
        private var item:PropInfo;
        private static var markBitmapData:BitmapData;
        private static var activeMarkViews:Dictionary;
        private static var protectData:ProtectData;

        public function ProtectItemHighMarkView()
        {
            super(getBitmapData());
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            return;
        }// end function

        private function onProtectDataChange(event:GameEvent) : void
        {
            this.refreshData();
            return;
        }// end function

        public function setItem(param1:PropInfo) : void
        {
            if (this.item)
            {
                this.item.removeEvtListener("HIGH_LOCK_UPDE", this.onProtectDataChange);
            }
            this.item = param1;
            if (this.item)
            {
                this.item.addEvtListener("HIGH_LOCK_UPDE", this.onProtectDataChange);
            }
            if (stage)
            {
                this.refreshData();
            }
            return;
        }// end function

        private function onAddedToStage(event:Event) : void
        {
            this.refreshData();
            return;
        }// end function

        public function refreshData() : void
        {
            var _loc_1:* = false;
            var _loc_2:* = false;
            _loc_1 = this.item != null && protectData.isItemHighLocked(this.item);
            this.visible = _loc_1;
            if (_loc_1)
            {
                if (parent.getChildIndex(this) != (parent.numChildren - 1))
                {
                    parent.setChildIndex(this, (parent.numChildren - 1));
                }
                (this.parent as IconItem).protectImg.visible = false;
            }
            else
            {
                _loc_2 = this.item != null && protectData.isItemLocked(this.item);
                (this.parent as IconItem).protectImg.visible = _loc_2;
            }
            return;
        }// end function

        private static function getBitmapData() : BitmapData
        {
            if (markBitmapData == null)
            {
                markBitmapData = ToolKit.getNew("protectHighItemMark");
            }
            return markBitmapData;
        }// end function

        public static function updateItemView(param1:IconItem, param2:PropInfo) : void
        {
            var _loc_3:* = null;
            tryInitClass();
            _loc_3 = param1.highProtectImg as ProtectItemHighMarkView;
            if (param2 == null)
            {
                if (_loc_3 != null)
                {
                    _loc_3.setItem(null);
                }
            }
            else if (param2.blongToMine)
            {
                if (_loc_3 == null)
                {
                    _loc_3 = new ProtectItemHighMarkView;
                    _loc_3.x = param1.image.x + param1.widthImg - _loc_3.width + 6;
                    _loc_3.y = param1.image.y - 2;
                    param1.highProtectImg = _loc_3;
                }
                _loc_3.setItem(param2);
            }
            return;
        }// end function

        private static function tryInitClass() : void
        {
            if (activeMarkViews == null)
            {
                activeMarkViews = new Dictionary();
                protectData = ProtectData.getInstance();
            }
            return;
        }// end function

    }
}
