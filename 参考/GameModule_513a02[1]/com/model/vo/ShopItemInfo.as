package com.model.vo
{
    import com.cfg.obj.*;
    import com.game.shop.bean.*;
    import com.util.*;

    public class ShopItemInfo extends Object
    {
        private var _gold:int;
        private var _bindgold:int;
        private var _coin:int;
        private var _sellId:int;
        private var _originalCoin:int;
        private var _originalGold:int;
        private var _originalBindGold:int;
        private var _moneyType:Array;
        private var _showLevel:int;
        private var _q_souldiamond:int;
        private var _q_show_souldiamond:int;
        private var _q_suitable_level_min:int;
        private var _q_suitable_level_max:int;
        private var _npc:int;
        private var _itemModelId:int;
        private var _intensify:int;
        private var _addAttributLevel:int;
        private var _append:String;
        private var _remark:Array;
        private var _buy_count:int;
        private var _limit_count:int;
        private var _q_index:int;
        private var _prop:PropInfo;

        public function ShopItemInfo()
        {
            return;
        }// end function

        public function get q_index() : int
        {
            return this._q_index;
        }// end function

        public function set q_index(param1:int) : void
        {
            this._q_index = param1;
            return;
        }// end function

        public function get limit_count() : int
        {
            return this._limit_count;
        }// end function

        public function set limit_count(param1:int) : void
        {
            this._limit_count = param1;
            return;
        }// end function

        public function get buy_count() : int
        {
            return this._buy_count;
        }// end function

        public function set buy_count(param1:int) : void
        {
            this._buy_count = param1;
            return;
        }// end function

        public function get itemModelId() : int
        {
            return this._itemModelId;
        }// end function

        public function set itemModelId(param1:int) : void
        {
            this._itemModelId = param1;
            return;
        }// end function

        public function get append() : String
        {
            return this._append;
        }// end function

        public function set append(param1:String) : void
        {
            this._append = param1;
            return;
        }// end function

        public function get prop() : PropInfo
        {
            return this._prop;
        }// end function

        public function set prop(param1:PropInfo) : void
        {
            this._prop = param1;
            return;
        }// end function

        public function get npc() : int
        {
            return this._npc;
        }// end function

        public function set npc(param1:int) : void
        {
            this._npc = param1;
            return;
        }// end function

        public function get q_suitable_level_max() : int
        {
            return this._q_suitable_level_max;
        }// end function

        public function set q_suitable_level_max(param1:int) : void
        {
            this._q_suitable_level_max = param1;
            return;
        }// end function

        public function get q_suitable_level_min() : int
        {
            return this._q_suitable_level_min;
        }// end function

        public function set q_suitable_level_min(param1:int) : void
        {
            this._q_suitable_level_min = param1;
            return;
        }// end function

        public function get q_show_souldiamond() : int
        {
            return this._q_show_souldiamond;
        }// end function

        public function set q_show_souldiamond(param1:int) : void
        {
            this._q_show_souldiamond = param1;
            return;
        }// end function

        public function get q_souldiamond() : int
        {
            return this._q_souldiamond;
        }// end function

        public function set q_souldiamond(param1:int) : void
        {
            this._q_souldiamond = param1;
            return;
        }// end function

        public function get showLevel() : int
        {
            return this._showLevel;
        }// end function

        public function set showLevel(param1:int) : void
        {
            this._showLevel = param1;
            return;
        }// end function

        public function get moneyType() : Array
        {
            return this._moneyType;
        }// end function

        public function set moneyType(param1:Array) : void
        {
            this._moneyType = param1;
            return;
        }// end function

        public function get originalBindGold() : int
        {
            return this._originalBindGold;
        }// end function

        public function set originalBindGold(param1:int) : void
        {
            this._originalBindGold = param1;
            return;
        }// end function

        public function get originalGold() : int
        {
            return this._originalGold;
        }// end function

        public function set originalGold(param1:int) : void
        {
            this._originalGold = param1;
            return;
        }// end function

        public function get originalCoin() : int
        {
            return this._originalCoin;
        }// end function

        public function set originalCoin(param1:int) : void
        {
            this._originalCoin = param1;
            return;
        }// end function

        public function get sellId() : int
        {
            return this._sellId;
        }// end function

        public function set sellId(param1:int) : void
        {
            this._sellId = param1;
            return;
        }// end function

        public function get coin() : int
        {
            return this._coin;
        }// end function

        public function set coin(param1:int) : void
        {
            this._coin = param1;
            return;
        }// end function

        public function get bindgold() : int
        {
            return this._bindgold;
        }// end function

        public function set bindgold(param1:int) : void
        {
            this._bindgold = param1;
            return;
        }// end function

        public function get gold() : int
        {
            return this._gold;
        }// end function

        public function set gold(param1:int) : void
        {
            this._gold = param1;
            return;
        }// end function

        public function set info(param1:int) : void
        {
            var _loc_2:* = ShopCfgObj.getInstance().getShopItem(param1);
            return;
        }// end function

        public function con(param1:CSShopItemInfo) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_2:* = ItemCfgObj.getInstance().getCfgBy(param1.modelId);
            this.coin = param1.coin;
            this.gold = param1.gold;
            this.bindgold = param1.bindgold;
            this._itemModelId = param1.modelId;
            this.sellId = param1.sellId;
            this.originalBindGold = param1.originalBindGold;
            this.originalCoin = param1.originalCoin;
            this.originalGold = param1.originalGold;
            this.showLevel = param1.showLevel;
            this.moneyType = param1.moneyType.split(",");
            this.q_show_souldiamond = param1.q_show_souldiamond;
            this.q_souldiamond = param1.q_souldiamond;
            this._intensify = param1.strengthen;
            this._addAttributLevel = param1.addAttributLevel;
            this._buy_count = param1.buy_count;
            this._limit_count = param1.limit_count;
            this._append = param1.append;
            this._q_index = ShopCfgObj.getInstance().getShopItem(param1.sellId).q_index;
            var _loc_3:* = this._append.split(";");
            if (_loc_3[0].length > 0)
            {
                this._remark = [];
                _loc_4 = 0;
                while (_loc_4 < _loc_3.length)
                {
                    
                    this._remark[_loc_4] = new Object();
                    _loc_5 = (_loc_3[_loc_4] as String).split("|");
                    this._remark[_loc_4].attributeType = _loc_5[0];
                    this._remark[_loc_4].attributeValue = _loc_5[1];
                    _loc_4++;
                }
            }
            this._prop = PropUtil.createItemByCfg(this._itemModelId, this._intensify, this._addAttributLevel, 0, this._remark);
            return;
        }// end function

        public function initByShopConfig(param1:Object) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_2:* = param1.q_sell;
            var _loc_3:* = ItemCfgObj.getInstance().getCfgBy(_loc_2);
            this.coin = param1.q_coin;
            this.gold = param1.q_gold;
            this.bindgold = param1.q_bindgold;
            this._itemModelId = param1.q_sell;
            this.sellId = param1.q_id;
            this.npc = param1.q_model_id;
            this.originalBindGold = param1.q_show_bindgold;
            this.originalCoin = param1.q_show_coin;
            this.originalGold = param1.q_show_gold;
            this.showLevel = param1.q_show_level;
            this.moneyType = param1.q_money_type.split(",");
            this.q_show_souldiamond = param1.q_show_souldiamond;
            this.q_souldiamond = param1.q_souldiamond;
            this._intensify = param1.q_strengthen;
            this._addAttributLevel = param1.q_extra_attribute;
            this._append = param1.q_append;
            this.q_index = param1.q_index;
            if (this._append)
            {
                _loc_4 = this._append.split(";");
                if (_loc_4[0].length > 0)
                {
                    this._remark = [];
                    _loc_5 = 0;
                    while (_loc_5 < _loc_4.length)
                    {
                        
                        this._remark[_loc_5] = new Object();
                        _loc_6 = (_loc_4[_loc_5] as String).split("|");
                        this._remark[_loc_5].attributeType = _loc_6[0];
                        this._remark[_loc_5].attributeValue = _loc_6[1];
                        _loc_5++;
                    }
                }
            }
            this._prop = PropUtil.createItemByCfg(this._itemModelId, this._intensify, this._addAttributLevel, 0, this._remark);
            return;
        }// end function

    }
}
