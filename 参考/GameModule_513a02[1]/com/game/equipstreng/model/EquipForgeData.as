package com.game.equipstreng.model
{
    import __AS3__.vec.*;
    import com.cfg.obj.*;
    import com.game.backpack.model.*;
    import com.game.equip.bean.*;
    import com.game.equipstreng.cfg.*;
    import com.game.player.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;

    public class EquipForgeData extends Object
    {
        private var _equipInfo:EquipInfo;
        private var _fromStrengOrProcess:int;
        private var rank:Array;
        public static const TYPE_WING:int = 1;
        public static const TYPE_TICKET:int = 2;
        public static const TYPE_BLOOD:int = 3;
        public static const TYPE_ANGEL:int = 4;
        public static var saveEquipIdAdd:Array = [];
        private static var _instance:EquipForgeData;

        public function EquipForgeData()
        {
            this.rank = [Params.LEFT_WEAPON, Params.RIGHT_WEAPON, Params.BODY, Params.WING, Params.NICKLACE, Params.RING1, Params.RING2, Params.HEAD, Params.HAND, Params.LEG, Params.SHOE];
            return;
        }// end function

        public function filterComposeAngelEquip(param1:String, param2:Array) : Vector.<EquipmentInfo>
        {
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_3:* = new Vector.<EquipmentInfo>;
            var _loc_4:* = BackpackObj.getInstance().info;
            if (BackpackObj.getInstance().info)
            {
                _loc_5 = _loc_4.items.length;
                _loc_7 = 0;
                while (_loc_7 < _loc_5)
                {
                    
                    if (PropUtil.isEquip(_loc_4.items[_loc_7].q_type))
                    {
                        _loc_6 = _loc_4.items[_loc_7] as EquipmentInfo;
                        if (!_loc_6.isHighLocked && this.checkSignID(_loc_6, param1) && !this.checkHasID(_loc_6, param2))
                        {
                            _loc_3.push(_loc_6);
                        }
                    }
                    _loc_7++;
                }
            }
            return _loc_3;
        }// end function

        public function filterComposeEquipBag(param1:Array, param2:String, param3:Array) : Vector.<EquipmentInfo>
        {
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_4:* = new Vector.<EquipmentInfo>;
            var _loc_5:* = BackpackObj.getInstance().info;
            if (BackpackObj.getInstance().info)
            {
                _loc_6 = _loc_5.items.length;
                _loc_8 = 0;
                while (_loc_8 < _loc_6)
                {
                    
                    if (PropUtil.isEquip(_loc_5.items[_loc_8].q_type))
                    {
                        _loc_7 = _loc_5.items[_loc_8] as EquipmentInfo;
                        if (!_loc_7.isHighLocked && _loc_7.q_remarkable >= param1[1] && _loc_7.intensify >= param1[2] && _loc_7.addAttributLevel >= param1[3] && this.checkSignID(_loc_7, param2) && !this.checkHasID(_loc_7, param3))
                        {
                            _loc_4.push(_loc_7);
                        }
                    }
                    _loc_8++;
                }
            }
            return _loc_4;
        }// end function

        public function filterComposeEquipBagAddRate(param1:Array, param2:Array) : Vector.<EquipmentInfo>
        {
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_3:* = new Vector.<EquipmentInfo>;
            var _loc_4:* = BackpackObj.getInstance().info;
            if (BackpackObj.getInstance().info)
            {
                _loc_5 = _loc_4.items.length;
                _loc_7 = 0;
                while (_loc_7 < _loc_5)
                {
                    
                    if (PropUtil.isEquip(_loc_4.items[_loc_7].q_type))
                    {
                        _loc_6 = _loc_4.items[_loc_7] as EquipmentInfo;
                        if (!_loc_6.isHighLocked && _loc_6.q_remarkable >= param1[1] && _loc_6.intensify >= param1[2] && _loc_6.addAttributLevel >= param1[3] && !this.checkHasID(_loc_6, param2))
                        {
                            _loc_3.push(_loc_6);
                        }
                    }
                    _loc_7++;
                }
            }
            return _loc_3;
        }// end function

        private function checkSignID(param1:EquipmentInfo, param2:String) : Boolean
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            if (param2 != "")
            {
                _loc_3 = param2.split(";");
                _loc_4 = 0;
                while (_loc_4 < _loc_3.length)
                {
                    
                    if (param1.itemModelId == int(_loc_3[_loc_4]))
                    {
                        return true;
                    }
                    _loc_4++;
                }
            }
            else
            {
                return true;
            }
            return false;
        }// end function

        private function checkHasID(param1:EquipmentInfo, param2:Array) : Boolean
        {
            var _loc_3:* = 0;
            while (_loc_3 < param2.length)
            {
                
                if (param1.itemId.equal(param2[_loc_3]))
                {
                    return true;
                }
                _loc_3++;
            }
            return false;
        }// end function

        public function filterEquip(param1:int) : Vector.<EquipmentInfo>
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_2:* = new Vector.<EquipmentInfo>;
            var _loc_3:* = BackpackObj.getInstance().info;
            var _loc_4:* = EquipsObj.getInstance().info;
            if (_loc_3)
            {
                _loc_7 = _loc_3.items.length;
                _loc_8 = 0;
                while (_loc_8 < _loc_7)
                {
                    
                    _loc_9 = ItemCfgObj.getInstance().getCfgBy(_loc_3.items[_loc_8].itemModelId);
                    _loc_10 = EquipProcessCfgObj.getInstance().getEquipProcessinfoByLev(_loc_3.items[_loc_8].itemModelId + "_" + (_loc_3.items[_loc_8].addAttributLevel + 1));
                    _loc_5 = _loc_3.items[_loc_8];
                    if (param1 == EquipOperationTypeCfg.STRENGTHEN_TYPE)
                    {
                        if (PropUtil.isEquip(_loc_5.q_type) && _loc_5.intensify < _loc_9.q_max_strengthen)
                        {
                            _loc_2.push(_loc_5);
                        }
                    }
                    else if (param1 == EquipOperationTypeCfg.ADDITION_TYPE)
                    {
                        if (PropUtil.isEquip(_loc_5.q_type) && _loc_10)
                        {
                            _loc_2.push(_loc_5);
                        }
                    }
                    else if (param1 == EquipOperationTypeCfg.LUCKY_TYPE)
                    {
                        _loc_6 = _loc_5 as EquipmentInfo;
                        if (_loc_5.q_type == ItemType.EQUIP && (_loc_5.q_kind >= 1 && _loc_5.q_kind <= 10) && _loc_6 && _loc_6.knowing_attackpercent == 0)
                        {
                            _loc_2.push(_loc_5);
                        }
                    }
                    else if (param1 == EquipOperationTypeCfg.TRANS_SUIT_TYPE)
                    {
                        _loc_6 = _loc_5 as EquipmentInfo;
                        if (_loc_6 && _loc_5.canTransSuit(_loc_6.suitId))
                        {
                            _loc_2.push(_loc_5);
                        }
                    }
                    else if (param1 == EquipOperationTypeCfg.STRENGTHEN_SUIT_TYPE)
                    {
                        _loc_6 = _loc_5 as EquipmentInfo;
                        if (_loc_6 && _loc_5.suitCanStength(_loc_6.suitId))
                        {
                            _loc_2.push(_loc_5);
                        }
                    }
                    else if (param1 == EquipOperationTypeCfg.TYPE_SUIT_SPLIT)
                    {
                        _loc_6 = _loc_5 as EquipmentInfo;
                        if (_loc_6 && _loc_6.suitId)
                        {
                            _loc_2.push(_loc_5);
                        }
                    }
                    _loc_8++;
                }
            }
            if (_loc_4)
            {
                _loc_7 = _loc_4.items.length;
                _loc_8 = 0;
                while (_loc_8 < _loc_7)
                {
                    
                    _loc_9 = ItemCfgObj.getInstance().getCfgBy(_loc_4.items[_loc_8].itemModelId);
                    _loc_10 = EquipProcessCfgObj.getInstance().getEquipProcessinfoByLev(_loc_4.items[_loc_8].itemModelId + "_" + (_loc_4.items[_loc_8].addAttributLevel + 1));
                    _loc_5 = _loc_4.items[_loc_8];
                    if (param1 == EquipOperationTypeCfg.STRENGTHEN_TYPE)
                    {
                        if (PropUtil.isEquip(_loc_5.q_type) && _loc_5.intensify < _loc_9.q_max_strengthen)
                        {
                            _loc_2.push(_loc_5);
                        }
                    }
                    else if (param1 == EquipOperationTypeCfg.ADDITION_TYPE)
                    {
                        if (PropUtil.isEquip(_loc_5.q_type) && _loc_10)
                        {
                            _loc_2.push(_loc_5);
                        }
                    }
                    else if (param1 == EquipOperationTypeCfg.LUCKY_TYPE)
                    {
                        _loc_6 = _loc_5 as EquipmentInfo;
                        if (_loc_5.q_type == ItemType.EQUIP && (_loc_5.q_kind >= 1 && _loc_5.q_kind <= 10) && _loc_6 && _loc_6.knowing_attackpercent == 0)
                        {
                            _loc_2.push(_loc_5);
                        }
                    }
                    else if (param1 == EquipOperationTypeCfg.TRANS_SUIT_TYPE)
                    {
                        _loc_6 = _loc_5 as EquipmentInfo;
                        if (_loc_6 && _loc_5.canTransSuit(_loc_6.suitId))
                        {
                            _loc_2.push(_loc_5);
                        }
                    }
                    else if (param1 == EquipOperationTypeCfg.STRENGTHEN_SUIT_TYPE)
                    {
                        _loc_6 = _loc_5 as EquipmentInfo;
                        if (_loc_6 && _loc_5.suitCanStength(_loc_6.suitId))
                        {
                            _loc_2.push(_loc_5);
                        }
                    }
                    else if (param1 == EquipOperationTypeCfg.TYPE_SUIT_SPLIT)
                    {
                        _loc_6 = _loc_5 as EquipmentInfo;
                        if (_loc_6 && _loc_6.suitId)
                        {
                            _loc_2.push(_loc_5);
                        }
                    }
                    _loc_8++;
                }
            }
            _loc_2.sort(this.compare);
            return _loc_2;
        }// end function

        private function compare(param1:EquipmentInfo, param2:EquipmentInfo) : int
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            if (param1.pos > 0 && param2.pos > 0 || param1.pos == 0 && param2.pos == 0)
            {
                _loc_3 = this.rank.indexOf(param1.q_kind);
                _loc_4 = this.rank.indexOf(param2.q_kind);
                if (_loc_3 > _loc_4)
                {
                    return 1;
                }
                if (_loc_3 < _loc_4)
                {
                    return -1;
                }
                if (param1.fightNumber < param2.fightNumber)
                {
                    return 1;
                }
                return -1;
            }
            else
            {
                if (param1.pos > param2.pos)
                {
                    return -1;
                }
            }
            return 1;
        }// end function

        public function get equipInfo() : EquipInfo
        {
            return this._equipInfo;
        }// end function

        public function set equipInfo(param1:EquipInfo) : void
        {
            this._equipInfo = param1;
            return;
        }// end function

        public function get fromStrengOrProcess() : int
        {
            return this._fromStrengOrProcess;
        }// end function

        public function set fromStrengOrProcess(param1:int) : void
        {
            this._fromStrengOrProcess = param1;
            return;
        }// end function

        public static function getInstance() : EquipForgeData
        {
            if (_instance == null)
            {
                _instance = new EquipForgeData;
            }
            return _instance;
        }// end function

    }
}
