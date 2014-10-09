package com.game.shop.model
{
    import __AS3__.vec.*;
    import com.cfg.obj.*;
    import com.model.vo.*;
    import com.util.*;

    public class SupervalueInfo extends Object
    {
        public var goods:Vector.<PropInfo>;
        public var orginalPrice:int;
        public var nowPrice:int;
        private var _itemId:int;

        public function SupervalueInfo()
        {
            return;
        }// end function

        public function get itemId() : int
        {
            return this._itemId;
        }// end function

        public function set itemId(param1:int) : void
        {
            this._itemId = param1;
            var _loc_2:* = SupervalueBuyCfgObj.getInstance().getSupervalueById(this._itemId);
            this.parse(_loc_2);
            return;
        }// end function

        public function parse(param1:Object) : void
        {
            var _loc_3:* = null;
            var _loc_5:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            this.nowPrice = param1.q_pay_gold;
            this.orginalPrice = param1.q_pay_gold_show;
            this.goods = new Vector.<PropInfo>;
            var _loc_2:* = param1.q_itemid_client;
            var _loc_4:* = _loc_2.split(",");
            var _loc_6:* = _loc_4.length;
            var _loc_9:* = [];
            var _loc_10:* = 0;
            while (_loc_10 < _loc_6)
            {
                
                _loc_5 = _loc_4[_loc_10].replace("\"", "");
                _loc_5 = (_loc_5 as String).substr(1, _loc_5.length - 2);
                _loc_7 = _loc_5.split("_");
                if (_loc_7.length >= 6)
                {
                    _loc_8 = _loc_7[5].split(";");
                    _loc_13 = 0;
                    while (_loc_13 < _loc_8.length)
                    {
                        
                        _loc_9[_loc_13] = new Object();
                        _loc_14 = (_loc_8[_loc_13] as String).split("|");
                        _loc_9[_loc_13].attributeType = _loc_14[0];
                        _loc_9[_loc_13].attributeValue = _loc_14[1];
                        _loc_13++;
                    }
                }
                if (_loc_7.length >= 4)
                {
                    _loc_11 = _loc_7[3];
                }
                if (_loc_7.length >= 5)
                {
                    _loc_12 = _loc_7[4];
                }
                _loc_3 = PropUtil.createItemByCfg(_loc_7[0], _loc_11, _loc_12, 0, _loc_9);
                _loc_3.num = _loc_7[1];
                this.goods.push(_loc_3);
                _loc_10++;
            }
            return;
        }// end function

    }
}
