package com.cfg.obj
{
    import __AS3__.vec.*;
    import com.f1.manager.*;
    import com.model.*;
    import com.model.vo.*;
    import com.util.*;

    public class QCastingShowCfgObj extends Object
    {
        private var _map:Object;
        private static var _instance:QCastingShowCfgObj;

        public function QCastingShowCfgObj()
        {
            this._map = CfgManager.getInstance().getMap("q_casting_show");
            return;
        }// end function

        public function getList() : Vector.<PropInfo>
        {
            var _loc_3:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_9:* = 0;
            var _loc_1:* = this.getItemString();
            var _loc_2:* = _loc_1.split(",");
            var _loc_4:* = _loc_2.length;
            var _loc_7:* = new Vector.<PropInfo>;
            if (!_loc_1 || _loc_1 == "")
            {
                return null;
            }
            var _loc_8:* = 0;
            while (_loc_8 < _loc_4)
            {
                
                _loc_3 = _loc_2[_loc_8].replace("\"", "");
                _loc_3 = (_loc_3 as String).substr(1, _loc_3.length - 2);
                _loc_5 = _loc_3.split("_");
                _loc_6 = PropUtil.createItemByCfg(_loc_5[0]);
                _loc_9 = 0;
                while (_loc_9 < _loc_5.length)
                {
                    
                    this.setValue(_loc_6, _loc_9, _loc_5[_loc_9]);
                    _loc_9++;
                }
                _loc_7.push(_loc_6);
                _loc_8++;
            }
            return _loc_7;
        }// end function

        public function getNodes() : Array
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_1:* = new Array();
            for (_loc_3 in this._map)
            {
                
                _loc_2 = int(_loc_3);
                if (_loc_2 > 100)
                {
                    _loc_1.push({level:_loc_5[_loc_3].q_point_level, tips:_loc_5[_loc_3].q_word});
                }
            }
            _loc_1.sortOn("level", Array.NUMERIC);
            return _loc_1;
        }// end function

        private function getItemString() : String
        {
            var _loc_2:* = null;
            var _loc_1:* = UserObj.getInstance().playerInfo;
            for each (_loc_2 in this._map)
            {
                
                if (_loc_2.q_job == _loc_1.jobkind && _loc_2.q_min_level <= _loc_1.level && _loc_2.q_max_level >= _loc_1.level)
                {
                    return _loc_2.q_item_id;
                }
            }
            return "";
        }// end function

        private function setValue(param1:PropInfo, param2:int, param3) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            switch(param2)
            {
                case 1:
                {
                    param1.num = param3;
                    break;
                }
                case 2:
                {
                    param1.q_effective_time = param3;
                    break;
                }
                case 3:
                {
                    param1.intensify = param3;
                    break;
                }
                case 4:
                {
                    param1.addAttributLevel = param3;
                    break;
                }
                case 5:
                {
                    _loc_4 = (param3 as String).split(";");
                    _loc_7 = 0;
                    while (_loc_7 < _loc_4.length)
                    {
                        
                        _loc_6 = _loc_4[_loc_7].split("|");
                        _loc_5 = {attributeType:_loc_6[0], attributeValue:_loc_6[1]};
                        Attributes.setEquipAttr(param1 as EquipmentInfo, _loc_5);
                        _loc_7++;
                    }
                    break;
                }
                case 0.6:
                {
                    (param1 as EquipmentInfo).knowing_attackpercent = param3;
                    break;
                }
                case 7:
                {
                    (param1 as EquipmentInfo).ignore_attack_percent = param3;
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            return;
        }// end function

        public static function getInstance() : QCastingShowCfgObj
        {
            if (!_instance)
            {
                _instance = new QCastingShowCfgObj;
            }
            return _instance;
        }// end function

    }
}
