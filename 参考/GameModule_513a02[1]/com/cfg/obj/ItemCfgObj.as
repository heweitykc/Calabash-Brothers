package com.cfg.obj
{
    import com.cfg.info.*;
    import com.f1.manager.*;
    import flash.utils.*;

    public class ItemCfgObj extends Object
    {
        private var _map:Object;
        private var _sellMap:Object;
        private var _autoSellDic:Dictionary;
        private static var instance:ItemCfgObj;

        public function ItemCfgObj()
        {
            this._map = CfgManager.getInstance().getMap("item");
            this._sellMap = CfgManager.getInstance().getMap("q_autosell");
            this.initAutoSellCfg();
            return;
        }// end function

        private function initAutoSellCfg() : void
        {
            var _loc_1:* = undefined;
            var _loc_2:* = null;
            if (!this._sellMap)
            {
                return;
            }
            this._autoSellDic = new Dictionary();
            for (_loc_1 in this._sellMap)
            {
                
                _loc_2 = _loc_4[_loc_1]["item_id"].split(";");
                this._autoSellDic[_loc_1] = {list:_loc_2, key:_loc_1, level:_loc_4[_loc_1]["level"], vip:_loc_4[_loc_1]["vip_level"], type:_loc_4[_loc_1]["type"]};
            }
            return;
        }// end function

        public function getCfg() : Object
        {
            return this._map;
        }// end function

        public function getItemCfg(param1:uint) : ItemCfg
        {
            var _loc_2:* = null;
            if (this._map[param1])
            {
                _loc_2 = new ItemCfg();
                _loc_2.parse(this._map[param1]);
                return _loc_2;
            }
            return null;
        }// end function

        public function getCfgBy(param1:uint) : Object
        {
            if (this._map[param1])
            {
                return this._map[param1];
            }
            if (this._map[param1] == null)
            {
                return this._map[900001];
            }
            return null;
        }// end function

        public function getItemName(param1:uint) : String
        {
            var _loc_2:* = undefined;
            if (this._map[param1])
            {
                _loc_2 = this._map[param1];
                return String(_loc_2["q_name"]);
            }
            return "";
        }// end function

        public function getColor(param1:uint) : uint
        {
            var _loc_2:* = undefined;
            if (this._map[param1])
            {
                _loc_2 = this._map[param1];
                return uint(_loc_2["ItemColor"]);
            }
            return 1;
        }// end function

        public function getIconUrl(param1:uint) : String
        {
            if (this._map[param1])
            {
                return "art/res/item/" + this._map[param1].q_item_icon + ".png";
            }
            return "";
        }// end function

        public function isUsable(param1:uint) : Boolean
        {
            if (this._map[param1])
            {
                return this._map[param1].Usable == "1";
            }
            return false;
        }// end function

        public function getLimitPlayLv(param1:uint) : int
        {
            if (this._map[param1])
            {
                return this._map[param1].PlayerLv;
            }
            return 0;
        }// end function

        public function getAutoSellItemByLv(param1:int, param2:int, param3:int = 0) : Array
        {
            var _loc_5:* = undefined;
            var _loc_6:* = null;
            var _loc_4:* = [];
            if (!this._autoSellDic)
            {
                return _loc_4;
            }
            for (_loc_5 in this._autoSellDic)
            {
                
                _loc_6 = _loc_8[_loc_5];
                if (param1 >= _loc_6.level && param2 >= _loc_6.vip && (param3 == 0 || param3 == _loc_6.type))
                {
                    _loc_4 = _loc_4.concat(_loc_6.list);
                }
            }
            return _loc_4;
        }// end function

        public static function getInstance() : ItemCfgObj
        {
            if (instance == null)
            {
                instance = new ItemCfgObj;
            }
            return instance;
        }// end function

    }
}
