package com.cfg.obj
{
    import com.cfg.info.*;
    import com.f1.manager.*;
    import com.model.vo.*;

    public class EquipComposeAppendCfgObj extends Object
    {
        private var _map:Object;
        private static var instance:EquipComposeAppendCfgObj;

        public function EquipComposeAppendCfgObj()
        {
            this._map = CfgManager.getInstance().getMap("q_equip_compose_append");
            return;
        }// end function

        public function getEquipComposeAppendInfoById(param1:int) : EquipComposeAppendCfg
        {
            var _loc_2:* = undefined;
            var _loc_3:* = null;
            for (_loc_2 in this._map)
            {
                
                if (_loc_5[_loc_2].compose_id == param1)
                {
                    _loc_3 = new EquipComposeAppendCfg();
                    _loc_3.parse(_loc_5[_loc_2]);
                }
            }
            return _loc_3;
        }// end function

        public function get map() : Object
        {
            return this._map;
        }// end function

        public function getSucessRateBySteplv(param1:int, param2:int) : int
        {
            var _loc_3:* = this.getEquipComposeAppendInfoById(param1);
            var _loc_4:* = _loc_3.q_equip_steplv_append;
            _loc_4 = _loc_4.substring(1, (_loc_4.length - 1));
            var _loc_5:* = _loc_4.split("|");
            var _loc_6:* = 0;
            while (_loc_6 < _loc_5.length)
            {
                
                if (_loc_5[_loc_6].split(",")[0] == param2)
                {
                    return _loc_5[_loc_6].split(",")[1];
                }
                _loc_6++;
            }
            return 0;
        }// end function

        public function getSucessRateByStrenglv(param1:int, param2:int) : int
        {
            var _loc_3:* = this.getEquipComposeAppendInfoById(param1);
            var _loc_4:* = _loc_3.q_equip_strenglv;
            _loc_4 = _loc_4.substring(1, (_loc_4.length - 1));
            var _loc_5:* = _loc_4.split("|");
            var _loc_6:* = 0;
            while (_loc_6 < _loc_5.length)
            {
                
                if (_loc_5[_loc_6].split(",")[0] == param2)
                {
                    return _loc_5[_loc_6].split(",")[1];
                }
                _loc_6++;
            }
            return 0;
        }// end function

        public function getSucessRateByAttributelv(param1:int, param2:int) : int
        {
            var _loc_3:* = this.getEquipComposeAppendInfoById(param1);
            var _loc_4:* = _loc_3.q_equip_attributelv;
            _loc_4 = _loc_4.substring(1, (_loc_4.length - 1));
            var _loc_5:* = _loc_4.split("|");
            var _loc_6:* = 0;
            while (_loc_6 < _loc_5.length)
            {
                
                if (_loc_5[_loc_6].split(",")[0] == param2)
                {
                    return _loc_5[_loc_6].split(",")[1];
                }
                _loc_6++;
            }
            return 0;
        }// end function

        public function getSucessRateByRemarkNum(param1:int, param2:EquipmentInfo) : int
        {
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_3:* = this.getEquipComposeAppendInfoById(param1);
            var _loc_4:* = _loc_3.q_equip_remarkablenum;
            _loc_4 = _loc_4.substring(1, (_loc_4.length - 1));
            var _loc_5:* = _loc_4.split(":");
            if (_loc_5.length > 1)
            {
                _loc_6 = 0;
                _loc_7 = _loc_5[0].split(",");
                _loc_8 = 0;
                while (_loc_8 < _loc_7.length)
                {
                    
                    _loc_11 = Attributes.getAttrNameByType(_loc_7[_loc_8]);
                    if (_loc_11 && param2[_loc_11])
                    {
                        _loc_6++;
                    }
                    _loc_8++;
                }
                _loc_9 = _loc_5[1].split("|");
                _loc_10 = 0;
                while (_loc_10 < _loc_9.length)
                {
                    
                    if (_loc_9[_loc_10])
                    {
                        _loc_12 = _loc_9[_loc_10].split(",")[0];
                        _loc_13 = _loc_12.split("-");
                        if (param2.q_equip_steplv == int(_loc_13[0]) && int(_loc_13[1]) == _loc_6)
                        {
                            return _loc_9[_loc_10].split(",")[1];
                        }
                    }
                    _loc_10++;
                }
            }
            return 0;
        }// end function

        public function getSucessRateByIsluck(param1:int, param2:EquipmentInfo) : int
        {
            var _loc_6:* = null;
            var _loc_3:* = this.getEquipComposeAppendInfoById(param1);
            var _loc_4:* = _loc_3.q_equip_isluck;
            _loc_4 = _loc_4.substring(1, (_loc_4.length - 1));
            var _loc_5:* = _loc_4.split(",");
            if (_loc_5.length)
            {
                _loc_6 = Attributes.getAttrNameByType(_loc_5[0]);
                if (_loc_6 && param2[_loc_6])
                {
                    return _loc_5[1];
                }
            }
            return 0;
        }// end function

        public function getSucessRateByIsIGNORE(param1:int, param2:EquipmentInfo) : int
        {
            var _loc_6:* = null;
            var _loc_3:* = this.getEquipComposeAppendInfoById(param1);
            var _loc_4:* = _loc_3.q_equip_IGNORE_ATTACKPERCENT;
            _loc_4 = _loc_4.substring(1, (_loc_4.length - 1));
            var _loc_5:* = _loc_4.split(",");
            if (_loc_5.length)
            {
                _loc_6 = Attributes.getAttrNameByType(_loc_5[0]);
                if (_loc_6 && param2[_loc_6])
                {
                    return _loc_5[1];
                }
            }
            return 0;
        }// end function

        public function getSucessRate(param1:int, param2:EquipmentInfo) : int
        {
            var _loc_3:* = 0;
            _loc_3 = _loc_3 + this.getSucessRateBySteplv(param1, param2.q_equip_steplv);
            _loc_3 = _loc_3 + this.getSucessRateByStrenglv(param1, param2.intensify);
            _loc_3 = _loc_3 + this.getSucessRateByAttributelv(param1, param2.addAttributLevel);
            _loc_3 = _loc_3 + this.getSucessRateByRemarkNum(param1, param2);
            _loc_3 = _loc_3 + this.getSucessRateByIsluck(param1, param2);
            _loc_3 = _loc_3 + this.getSucessRateByIsIGNORE(param1, param2);
            return _loc_3;
        }// end function

        public static function getInstance() : EquipComposeAppendCfgObj
        {
            if (instance == null)
            {
                instance = new EquipComposeAppendCfgObj;
            }
            return instance;
        }// end function

    }
}
