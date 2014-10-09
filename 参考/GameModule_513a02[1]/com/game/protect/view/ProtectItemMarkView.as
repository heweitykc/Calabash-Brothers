package com.game.protect.view
{
    import com.f1.utils.*;
    import com.game.protect.event.*;
    import com.game.protect.model.*;
    import com.model.vo.*;
    import com.view.icon.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class ProtectItemMarkView extends Bitmap
    {
        private var item:PropInfo;
        private static var markBitmapData:BitmapData;
        private static var activeMarkViews:Dictionary;
        private static var protectData:ProtectData;

        public function ProtectItemMarkView()
        {
            super(getBitmapData());
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            return;
        }// end function

        public function setItem(param1:PropInfo) : void
        {
            this.item = param1;
            if (stage)
            {
                this.refreshData();
            }
            return;
        }// end function

        private function onAddedToStage(event:Event) : void
        {
            activeMarkViews[this] = true;
            this.refreshData();
            return;
        }// end function

        private function onRemovedFromStage(event:Event) : void
        {
            delete activeMarkViews[this];
            return;
        }// end function

        public function refreshData() : void
        {
            var _loc_1:* = this.item != null && protectData.isItemLocked(this.item);
            if (this.visible != _loc_1)
            {
                this.visible = _loc_1;
                if (_loc_1)
                {
                    if (parent.getChildIndex(this) != (parent.numChildren - 1))
                    {
                        parent.setChildIndex(this, (parent.numChildren - 1));
                    }
                }
            }
            return;
        }// end function

        private static function getBitmapData() : BitmapData
        {
            if (markBitmapData == null)
            {
                markBitmapData = ToolKit.getNew("protectItemMark");
            }
            return markBitmapData;
        }// end function

        public static function updateItemView(param1:IconItem, param2:PropInfo) : void
        {
            var _loc_3:* = null;
            tryInitClass();
            _loc_3 = param1.protectImg as ProtectItemMarkView;
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
                    _loc_3 = new ProtectItemMarkView;
                    _loc_3.x = param1.image.x + param1.widthImg - _loc_3.width + 1;
                    _loc_3.y = param1.image.y + 1;
                    param1.protectImg = _loc_3;
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
                protectData.addEventListener(ProtectEvent.PROTECT_DATA_CHANGE, onProtectDataChange);
            }
            return;
        }// end function

        private static function onProtectDataChange(event:Event) : void
        {
            var _loc_2:* = undefined;
            var _loc_3:* = null;
            for (_loc_2 in activeMarkViews)
            {
                
                _loc_3 = _loc_2;
                _loc_3.refreshData();
            }
            return;
        }// end function

    }
}
