package com.game.backpack.model
{
    import __AS3__.vec.*;
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.autopk.*;
    import com.game.awardGuide.control.*;
    import com.game.backpack.bean.*;
    import com.game.backpack.events.*;
    import com.game.backpack.util.*;
    import com.game.guide.control.*;
    import com.game.protect.control.*;
    import com.game.utils.*;
    import com.game.vip.model.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;

    public class BackpackObj extends BaseEventDispatcher
    {
        private var _info:BackpackInfo;
        private const FULLCOUNT:int = 2;
        private var _equipType:Array;
        private var _other:Array;
        private const template:Array;
        private const onekeySellKindForbid:Array;
        private var _isFullForCount:Boolean;
        public static const TOTAL:String = "all";
        public static const EQUIP:String = "equip";
        public static const DIAMOND:String = "diamond";
        public static const MEDICINAL:String = "medicinal";
        public static const OTHER:String = "other";
        public static const CAPACITY:int = 70;
        private static var _instance:BackpackObj;

        public function BackpackObj()
        {
            this._equipType = [ItemType.EQUIP, ItemType.PET, ItemType.RIDE_EQUIP, ItemType.RIDE];
            this.template = [310026, 320007, 330013, 310126, 320107, 330113, 311326, 321307, 331313];
            this.onekeySellKindForbid = [Params.WING, Params.PET, Params.RING1, Params.NICKLACE];
            this.setInfo(UserObj.getInstance().backpackInfo);
            return;
        }// end function

        public function get info() : BackpackInfo
        {
            return this._info;
        }// end function

        public function set info(param1:BackpackInfo) : void
        {
            this._info = param1;
            this.checkFullForCount();
            return;
        }// end function

        private function checkFullForCount() : void
        {
            if (this._info.cellNum - this._info.items.length <= this.FULLCOUNT)
            {
                if (!AutoFightManager.getInstance().isAutoFighting())
                {
                    FunGuideControl.getInstance().addGuide(FunGuideControl.getInstance().SELL);
                }
                this.isFullForCount = true;
            }
            else
            {
                this.isFullForCount = false;
            }
            return;
        }// end function

        public function checkEquipForTalentUp() : void
        {
            var _loc_3:* = false;
            var _loc_1:* = this._info.items.length;
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                if (!(this._info.items[_loc_2] is EquipmentInfo))
                {
                    ;
                }
                else
                {
                    _loc_3 = EquipUtil.checkNeedGuide(this._info.items[_loc_2] as EquipmentInfo);
                    if (_loc_3)
                    {
                        if (this._info.items[_loc_2].q_kind != Params.PET)
                        {
                            EquipAwardGuideControl.getInstance().addGuide(this._info.items[_loc_2]);
                        }
                    }
                }
                _loc_2++;
            }
            return;
        }// end function

        public function getGoodsByType(param1:int = 0) : Vector.<PropInfo>
        {
            if (param1 == 0)
            {
                return this._info.items;
            }
            var _loc_2:* = new Vector.<PropInfo>;
            var _loc_3:* = this._info.items.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                if (this._info.items[_loc_4].q_type == param1)
                {
                    _loc_2.push(this._info.items[_loc_4]);
                }
                _loc_4++;
            }
            return _loc_2;
        }// end function

        public function getTabOfItem(param1:PropInfo) : String
        {
            if (PropUtil.isEquip(param1.q_type))
            {
                return EQUIP;
            }
            if (ItemType.MEDICINE == param1.q_type)
            {
                return MEDICINAL;
            }
            if (ItemType.DIAMOND == param1.q_type || ItemType.MATERIAL == param1.q_type)
            {
                return DIAMOND;
            }
            return OTHER;
        }// end function

        public function getGoodsByTab(param1:String = "all") : Vector.<PropInfo>
        {
            var _loc_2:* = null;
            var _loc_6:* = 0;
            if (param1 == TOTAL)
            {
                _loc_2 = this._info.items.sort(this.sortOnGridId);
                return _loc_2;
            }
            var _loc_3:* = new Vector.<PropInfo>;
            var _loc_4:* = this._info.items.length;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_6 = this._info.items[_loc_5].q_type;
                if (param1 == EQUIP)
                {
                    if (PropUtil.isEquip(this._info.items[_loc_5].q_type))
                    {
                        _loc_3.push(this._info.items[_loc_5]);
                    }
                }
                else if (param1 == MEDICINAL)
                {
                    if (_loc_6 == ItemType.MEDICINE)
                    {
                        _loc_3.push(this._info.items[_loc_5]);
                    }
                }
                else if (param1 == DIAMOND)
                {
                    if (_loc_6 == ItemType.DIAMOND || _loc_6 == ItemType.MATERIAL)
                    {
                        _loc_3.push(this._info.items[_loc_5]);
                    }
                }
                else if (param1 == OTHER)
                {
                    if (!PropUtil.isEquip(this._info.items[_loc_5].q_type) && _loc_6 != ItemType.MEDICINE && _loc_6 != ItemType.DIAMOND && _loc_6 != ItemType.MATERIAL)
                    {
                        _loc_3.push(this._info.items[_loc_5]);
                    }
                }
                _loc_5++;
            }
            _loc_2 = _loc_3.sort(this.sortOnGridId);
            return _loc_2;
        }// end function

        private function sortOnGridId(param1:PropInfo, param2:PropInfo) : int
        {
            if (param1 == null)
            {
                return 1;
            }
            if (param2 == null)
            {
                return -1;
            }
            if (param1.gridId < param2.gridId)
            {
                return -1;
            }
            if (param1.gridId > param2.gridId)
            {
                return 1;
            }
            return 0;
        }// end function

        public function setInfo(param1:BackpackInfo) : void
        {
            this._info = param1;
            return;
        }// end function

        public function removeItem(param1:long) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = this.getIndexById(param1);
            if (_loc_2 > -1)
            {
                _loc_3 = this._info.items.splice(_loc_2, 1)[0];
                dispatchEvent(new BackpackEvent(BackpackEvent.BOX_REMOVE, _loc_3));
                dispatchEvent(new BackpackEvent(BackpackEvent.GOODS_CHANGE, _loc_3));
            }
            this.checkFullForCount();
            return;
        }// end function

        public function getIndexById(param1:long) : int
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_2:* = this._info.items.length;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = this._info.items[_loc_3];
                if (_loc_4 && _loc_4.itemId.equal(param1))
                {
                    return _loc_3;
                }
                _loc_3++;
            }
            return -1;
        }// end function

        public function getItemById(param1:long) : PropInfo
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_2:* = this._info.items.length;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = this._info.items[_loc_3];
                if (_loc_4)
                {
                    if (_loc_4.itemId.equal(param1))
                    {
                        return _loc_4;
                    }
                }
                _loc_3++;
            }
            return null;
        }// end function

        public function checkFull() : void
        {
            this.checkFullForCount();
            return;
        }// end function

        public function getItemByGrid(param1:int) : PropInfo
        {
            var _loc_3:* = 0;
            if (param1 == 0)
            {
                return null;
            }
            var _loc_2:* = this._info.items.length;
            while (_loc_3 < _loc_2)
            {
                
                if (this._info.items[_loc_3].gridId == param1)
                {
                    return this._info.items[_loc_3];
                }
                _loc_3++;
            }
            return null;
        }// end function

        public function getItemCount(param1:int) : int
        {
            var _loc_2:* = 0;
            var _loc_3:* = this._info.items.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                if (this._info.items[_loc_4].itemModelId == param1)
                {
                    _loc_2 = _loc_2 + this._info.items[_loc_4].num;
                }
                _loc_4++;
            }
            return _loc_2;
        }// end function

        public function getItemBindCount(param1:int) : int
        {
            var _loc_2:* = 0;
            var _loc_3:* = this._info.items.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                if (this._info.items[_loc_4].itemModelId == param1 && this._info.items[_loc_4].isbind)
                {
                    _loc_2 = _loc_2 + this._info.items[_loc_4].num;
                }
                _loc_4++;
            }
            return _loc_2;
        }// end function

        public function getItemNotBindCount(param1:int) : int
        {
            var _loc_2:* = 0;
            var _loc_3:* = this._info.items.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                if (this._info.items[_loc_4].itemModelId == param1 && !this._info.items[_loc_4].isbind)
                {
                    _loc_2 = _loc_2 + this._info.items[_loc_4].num;
                }
                _loc_4++;
            }
            return _loc_2;
        }// end function

        public function getOneKeyItems() : Array
        {
            var _loc_1:* = this.getOneKeyEquip(10);
            return _loc_1;
        }// end function

        public function getExpiredArr() : Array
        {
            var _loc_3:* = 0;
            var _loc_1:* = [];
            var _loc_2:* = ToolKit.getServerTime();
            _loc_3 = _loc_3;
            while (_loc_3 < this._info.items.length)
            {
                
                if (this._info.items[_loc_3].lostTime != 0 && this._info.items[_loc_3].lostTime <= _loc_2)
                {
                    _loc_1.push(this._info.items[_loc_3]);
                }
                _loc_3++;
            }
            return _loc_1;
        }// end function

        public function getOneKeyEquip(param1:int) : Array
        {
            var _loc_3:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_2:* = [];
            _loc_3 = _loc_3;
            while (_loc_3 < this._info.items.length)
            {
                
                _loc_5 = this._info.items[_loc_3] as EquipmentInfo;
                if (_loc_5)
                {
                    if (this.onekeySellKindForbid.indexOf(_loc_5.q_kind) != -1)
                    {
                    }
                    else if (this.template.indexOf(_loc_5.itemModelId) != -1)
                    {
                    }
                    else
                    {
                        _loc_6 = EquipUtil.compareEquip(_loc_5);
                        if (UserObj.getInstance().playerInfo.level <= 180 && _loc_6 == 1)
                        {
                        }
                        else
                        {
                            _loc_7 = UserObj.getInstance().playerInfo.level <= 180 ? (7) : (12);
                            if (_loc_5.intensify >= _loc_7 || _loc_5.q_remarkable == 1 || _loc_5.suitId != 0)
                            {
                            }
                            else if (_loc_5.q_quality_lv <= 2 && (_loc_5.intensify < 4 || _loc_5.addAttributLevel < 1))
                            {
                                _loc_2.push(_loc_5);
                                ;
                            }
                        }
                    }
                }
                _loc_3++;
            }
            _loc_2.sort(this.jobSort);
            var _loc_4:* = ItemCfgObj.getInstance().getAutoSellItemByLv(UserObj.getInstance().playerInfo.level, VipModel.getInstance().info.level);
            if (ItemCfgObj.getInstance().getAutoSellItemByLv(UserObj.getInstance().playerInfo.level, VipModel.getInstance().info.level))
            {
                _loc_8 = [];
                _loc_3 = 0;
                while (_loc_3 < _loc_4.length)
                {
                    
                    _loc_9 = this.getItemsByItemModelId(_loc_4[_loc_3]);
                    _loc_8 = _loc_8.concat(_loc_9);
                    _loc_3++;
                }
                _loc_2 = _loc_2.concat(_loc_8);
            }
            return _loc_2.slice(0, param1);
        }// end function

        private function jobSort(param1:EquipmentInfo, param2:EquipmentInfo) : int
        {
            var _loc_3:* = UserObj.getInstance().playerInfo.job;
            if (PropUtil.jobAdapt(param1, _loc_3) == PropUtil.jobAdapt(param2, _loc_3))
            {
                return 0;
            }
            if (PropUtil.jobAdapt(param1, _loc_3) && !PropUtil.jobAdapt(param2, _loc_3))
            {
                return -1;
            }
            if (!PropUtil.jobAdapt(param1, _loc_3) && PropUtil.jobAdapt(param2, _loc_3))
            {
                return 1;
            }
            return 0;
        }// end function

        public function updateItemByItemInfo(param1:ItemInfo) : void
        {
            var _loc_2:* = this.getItemById(param1.itemId);
            _loc_2.gridId = param1.gridId;
            var _loc_3:* = new Object();
            _loc_3.info = _loc_2;
            _loc_3.grid = param1.gridId;
            _loc_3.item = param1;
            _loc_3.itemId = param1.itemId;
            _loc_2.conv(param1);
            dispatchEvent(new BackpackEvent(BackpackEvent.BOX_CHANGE, _loc_3, true));
            dispatchEvent(new BackpackEvent(BackpackEvent.GOODS_CHANGE, _loc_2));
            return;
        }// end function

        public function updateItem(param1:PropInfo) : void
        {
            var _loc_2:* = this.getItemById(param1.itemId);
            _loc_2.gridId = param1.gridId;
            var _loc_3:* = new Object();
            _loc_3.info = _loc_2;
            _loc_3.grid = param1.gridId;
            _loc_3.item = param1;
            _loc_3.itemId = param1.itemId;
            _loc_2.num = param1.num;
            dispatchEvent(new BackpackEvent(BackpackEvent.BOX_CHANGE, _loc_3, true));
            dispatchEvent(new BackpackEvent(BackpackEvent.GOODS_CHANGE, _loc_2));
            return;
        }// end function

        public function addItem(param1:PropInfo) : void
        {
            param1.isMine = true;
            this._info.items.push(param1);
            ProtectControl.getInstance().setHighLock(param1);
            dispatchEvent(new BackpackEvent(BackpackEvent.BOX_ADD, param1, true));
            dispatchEvent(new BackpackEvent(BackpackEvent.GOODS_CHANGE, param1));
            this.checkFullForCount();
            return;
        }// end function

        public function getCanShortcutItem() : Vector.<PropInfo>
        {
            var _loc_3:* = 0;
            var _loc_4:* = false;
            var _loc_5:* = 0;
            var _loc_1:* = new Vector.<PropInfo>;
            var _loc_2:* = this._info.items.length;
            while (_loc_3 < _loc_2)
            {
                
                if (this._info.items[_loc_3] && this._info.items[_loc_3].q_shortcut == 1)
                {
                    _loc_4 = false;
                    _loc_5 = 0;
                    while (_loc_5 < _loc_1.length)
                    {
                        
                        if (this._info.items[_loc_3].q_id == _loc_1[_loc_5].q_id)
                        {
                            _loc_4 = true;
                            break;
                        }
                        _loc_5++;
                    }
                    if (!_loc_4)
                    {
                        _loc_1.push(this._info.items[_loc_3]);
                    }
                }
                _loc_3++;
            }
            return _loc_1;
        }// end function

        public function get isFullForCount() : Boolean
        {
            return this._isFullForCount;
        }// end function

        public function set isFullForCount(param1:Boolean) : void
        {
            this._isFullForCount = param1;
            dispatchEvent(new BackpackEvent(BackpackEvent.BOX_FULL, null));
            return;
        }// end function

        public function isFull() : Boolean
        {
            return this.info.cellNum <= this._info.items.length;
        }// end function

        public function isLessThan(param1:int) : Boolean
        {
            return this.info.cellNum - this._info.items.length <= param1;
        }// end function

        public function isFullForItemModelId(param1:int) : Boolean
        {
            if (this.info.cellNum <= this._info.items.length)
            {
                return true;
            }
            var _loc_2:* = this._info.items.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (this.checkModelInfo(this._info.items[_loc_3], param1))
                {
                    return false;
                }
                _loc_3++;
            }
            return true;
        }// end function

        public function getItemsByItemModelId(param1:int) : Array
        {
            var _loc_2:* = [];
            var _loc_3:* = this._info.items.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                if (this._info.items[_loc_4].itemModelId == param1)
                {
                    _loc_2.push(this._info.items[_loc_4]);
                }
                _loc_4++;
            }
            return _loc_2;
        }// end function

        public function getItemByItemModelId(param1:int) : PropInfo
        {
            var _loc_2:* = this._info.items.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (this._info.items[_loc_3].itemModelId == param1)
                {
                    return this._info.items[_loc_3];
                }
                _loc_3++;
            }
            return null;
        }// end function

        public function getJewelryByItemPos(param1:int) : Vector.<EquipmentInfo>
        {
            var _loc_2:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_3:* = this._info.items.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                if (this._info.items[_loc_4] is EquipmentInfo)
                {
                    if (!_loc_2)
                    {
                        _loc_2 = new Vector.<EquipmentInfo>;
                    }
                    _loc_5 = this._info.items[_loc_4] as EquipmentInfo;
                    _loc_6 = GlobalCfgObj.getInstance().getCfgById(213).q_string_value;
                    _loc_6 = _loc_6.slice(1, (_loc_6.length - 1));
                    _loc_7 = 0;
                    _loc_8 = _loc_6.split(",");
                    _loc_9 = 0;
                    while (_loc_9 < _loc_8.length)
                    {
                        
                        _loc_11 = Attributes.getAttrNameByType(_loc_8[_loc_9]);
                        if (_loc_11 && _loc_5[_loc_11])
                        {
                            _loc_7++;
                        }
                        _loc_9++;
                    }
                    _loc_10 = ItemCfgObj.getInstance().getItemCfg(_loc_5.itemModelId);
                    if (_loc_10.q_kind == param1 && _loc_7 == 2)
                    {
                        _loc_2.push(_loc_5);
                    }
                }
                _loc_4++;
            }
            return _loc_2;
        }// end function

        public function getIdle() : int
        {
            return this._info.cellNum - this._info.items.length;
        }// end function

        private function compareTo(param1:PropInfo, param2:PropInfo) : int
        {
            if (param1.q_type != param2.q_type)
            {
                return param1.q_type - param2.q_type;
            }
            if (param1 is EquipmentInfo && param2 is EquipmentInfo)
            {
                if (param1.q_quality_lv != param1.q_quality_lv)
                {
                    return param2.q_quality_lv - param1.q_quality_lv;
                }
            }
            if (param1.num != param2.num)
            {
                return param1.num - param2.num;
            }
            if (param1.isbind != param2.isbind)
            {
                return param1.isbind == true ? (-1) : (1);
            }
            if (param1.lostTime != param2.lostTime)
            {
                return this.int(param1.lostTime - param2.lostTime);
            }
            return 0;
        }// end function

        public function checkNeedArrang() : Boolean
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_1:* = this._info.cellNum;
            var _loc_2:* = 0;
            while (_loc_2 < (_loc_1 - 1))
            {
                
                _loc_3 = this.getItemByGrid((_loc_2 + 1));
                if (_loc_3 == null)
                {
                }
                else
                {
                    _loc_4 = _loc_2 + 1;
                    while (_loc_4 < _loc_1)
                    {
                        
                        _loc_5 = this.getItemByGrid((_loc_4 + 1));
                        if (_loc_3 && _loc_5)
                        {
                            _loc_6 = this.compareTo(_loc_3, _loc_5);
                            if (_loc_6 > 0)
                            {
                                return true;
                            }
                        }
                        _loc_4++;
                    }
                }
                _loc_2++;
            }
            return false;
        }// end function

        public function getIdleCount(param1:PropInfo) : int
        {
            return this.getIdle() * param1.q_max;
        }// end function

        public function checkModelInfo(param1:PropInfo, param2:int) : Boolean
        {
            if (param1.itemModelId != param2)
            {
                return false;
            }
            if (param1.num >= param1.q_max)
            {
                return false;
            }
            return true;
        }// end function

        public static function getInstance() : BackpackObj
        {
            var _loc_1:* = new BackpackObj;
            _instance = new BackpackObj;
            return _instance || _loc_1;
        }// end function

    }
}
