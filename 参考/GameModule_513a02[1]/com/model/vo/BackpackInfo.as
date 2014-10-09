package com.model.vo
{
    import __AS3__.vec.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.util.*;

    public class BackpackInfo extends BaseEventDispatcher
    {
        private var _items:Vector.<PropInfo>;
        private var _cellNum:int;
        private var _cellTime:int;
        private var _openningGridId:int;

        public function BackpackInfo()
        {
            this._items = new Vector.<PropInfo>;
            return;
        }// end function

        public function get openningGridId() : int
        {
            return this._openningGridId;
        }// end function

        public function set openningGridId(param1:int) : void
        {
            this._openningGridId = param1;
            return;
        }// end function

        public function get cellTime() : int
        {
            return this._cellTime;
        }// end function

        public function set cellTime(param1:int) : void
        {
            this._cellTime = param1;
            return;
        }// end function

        public function get cellNum() : int
        {
            return this._cellNum;
        }// end function

        public function set cellNum(param1:int) : void
        {
            this._cellNum = param1;
            return;
        }// end function

        public function get items() : Vector.<PropInfo>
        {
            return this._items;
        }// end function

        public function set items(param1:Vector.<PropInfo>) : void
        {
            this._items = param1;
            return;
        }// end function

        public function set data(param1:Vector.<ItemInfo>) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = param1.length;
            this._items = new Vector.<PropInfo>;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = ItemCfgObj.getInstance().getCfgBy(param1[_loc_3].itemModelId);
                if (!PropUtil.isEquip(_loc_4.q_type))
                {
                    _loc_5 = new PropInfo();
                }
                else
                {
                    _loc_5 = new EquipmentInfo();
                }
                _loc_5.conv(param1[_loc_3]);
                _loc_5.isMine = true;
                this._items.push(_loc_5);
                _loc_3++;
            }
            return;
        }// end function

    }
}
