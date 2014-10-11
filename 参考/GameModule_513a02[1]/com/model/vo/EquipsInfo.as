package com.model.vo
{
    import __AS3__.vec.*;
    import com.cfg.obj.*;
    import com.f1.*;

    public class EquipsInfo extends BaseEventDispatcher
    {
        private var _items:Vector.<EquipmentInfo>;

        public function EquipsInfo()
        {
            this._items = new Vector.<EquipmentInfo>;
            return;
        }// end function

        public function get items() : Vector.<EquipmentInfo>
        {
            return this._items;
        }// end function

        public function set items(param1:Vector.<EquipmentInfo>) : void
        {
            this._items = param1;
            return;
        }// end function

        public function set data(param1:Vector.<EquipInfo>) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = param1.length;
            this._items = new Vector.<EquipmentInfo>(_loc_2);
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = ItemCfgObj.getInstance().getCfgBy(param1[_loc_3].itemModelId);
                this._items[_loc_3] = new EquipmentInfo();
                this._items[_loc_3].con(param1[_loc_3], _loc_3);
                this._items[_loc_3].isMine = true;
                _loc_3++;
            }
            return;
        }// end function

    }
}
