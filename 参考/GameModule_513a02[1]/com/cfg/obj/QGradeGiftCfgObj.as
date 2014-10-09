package com.cfg.obj
{
    import __AS3__.vec.*;
    import com.cfg.vo.*;
    import com.f1.manager.*;
    import com.model.*;
    import com.model.vo.*;
    import com.util.*;

    public class QGradeGiftCfgObj extends Object
    {
        private var _map:Object;
        private var _allInfos:Array;
        private static var _instance:QGradeGiftCfgObj;

        public function QGradeGiftCfgObj()
        {
            this._map = CfgManager.getInstance().getMap("q_grade_gift");
            return;
        }// end function

        public function getAllInfos() : Array
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            if (!this._allInfos)
            {
                this._allInfos = new Array();
                for (_loc_2 in this._map)
                {
                    
                    _loc_1 = int(_loc_2);
                    if (_loc_1 != 0)
                    {
                        this._allInfos.push(this.getItemInfos(_loc_1));
                    }
                }
            }
            return this._allInfos;
        }// end function

        private function getItemInfos(param1:int) : Vector.<PropInfo>
        {
            var _loc_3:* = null;
            var _loc_6:* = null;
            var _loc_8:* = null;
            var _loc_10:* = 0;
            var _loc_2:* = new Vector.<PropInfo>;
            var _loc_4:* = new QGradeGift();
            _loc_4.parse(this._map[param1]);
            var _loc_5:* = _loc_4.q_reward.split(",");
            var _loc_7:* = _loc_5.length;
            var _loc_9:* = 0;
            while (_loc_9 < _loc_7)
            {
                
                _loc_6 = _loc_5[_loc_9].replace("\"", "");
                _loc_6 = (_loc_6 as String).substr(1, _loc_6.length - 2);
                _loc_8 = _loc_6.split("_");
                _loc_3 = PropUtil.createItemByCfg(_loc_8[0]);
                if (!_loc_3.isUseForJobKind(UserObj.getInstance().playerInfo.jobkind))
                {
                }
                else
                {
                    _loc_10 = 0;
                    while (_loc_10 < _loc_8.length)
                    {
                        
                        this.setValue(_loc_3, _loc_10, _loc_8[_loc_10]);
                        _loc_10++;
                    }
                    _loc_2.push(_loc_3);
                }
                _loc_9++;
            }
            return _loc_2;
        }// end function

        public function getIndexByLevel(param1:int) : int
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            for (_loc_3 in this._map)
            {
                
                _loc_2 = int(_loc_5[_loc_3].q_need_grade);
                if (_loc_2 <= 150 || _loc_2 <= param1)
                {
                    return (int(_loc_3) - 1);
                }
            }
            return 0;
        }// end function

        public function getGradeGift(param1:int) : QGradeGift
        {
            var _loc_2:* = new QGradeGift();
            _loc_2.parse(this._map[param1]);
            return _loc_2;
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
                    param1.isbind = param3 == 1 ? (1) : (0);
                    break;
                }
                case 4:
                {
                    param1.intensify = param3;
                    break;
                }
                case 5:
                {
                    param1.addAttributLevel = param3;
                    break;
                }
                case 6:
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
                case 7:
                {
                    (param1 as EquipmentInfo).knowing_attackpercent = param3;
                    break;
                }
                case 8:
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

        public static function getInstance() : QGradeGiftCfgObj
        {
            if (!_instance)
            {
                _instance = new QGradeGiftCfgObj;
            }
            return _instance;
        }// end function

    }
}
