package com.game.primaryrole.model
{
    import __AS3__.vec.*;
    import com.cfg.obj.*;
    import com.model.vo.*;

    public class OtherEquipsData extends Object
    {
        private var _items:Vector.<EquipmentInfo>;
        public var attributeCount:int;
        private static var _instance:OtherEquipsData;

        public function OtherEquipsData()
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

        public function getEquipBy(param1:int) : EquipmentInfo
        {
            return this.items[(param1 - 1)];
        }// end function

        public function set data(param1:Vector.<EquipInfo>) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = param1.length;
            this._items = new Vector.<EquipmentInfo>(_loc_2);
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = ItemCfgObj.getInstance().getCfgBy(param1[_loc_3].itemModelId);
                var _loc_6:* = new EquipmentInfo();
                _loc_5 = new EquipmentInfo();
                this._items[_loc_3] = _loc_6;
                _loc_5.con(param1[_loc_3], _loc_3);
                _loc_5.euipSource = EquipmentInfo.EQUIP_SOURCE_OTHER;
                _loc_3++;
            }
            return;
        }// end function

        public static function getInstance() : OtherEquipsData
        {
            var _loc_1:* = new OtherEquipsData;
            _instance = new OtherEquipsData;
            return _instance || _loc_1;
        }// end function

    }
}
