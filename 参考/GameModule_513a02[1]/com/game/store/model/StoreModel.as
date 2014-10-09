package com.game.store.model
{
    import __AS3__.vec.*;
    import com.cfg.obj.*;
    import com.game.backpack.bean.*;
    import com.game.protect.control.*;
    import com.game.utils.*;
    import com.model.*;
    import com.model.vo.*;
    import com.util.*;

    public class StoreModel extends Object
    {
        private var _cellnum:int = 0;
        private var _vecInfo:Vector.<PropInfo>;
        public static const MAX_GRID_COUNT:int = 56;
        public static const MAX_GRID_ROW:int = 7;
        private static var _instance:StoreModel;

        public function StoreModel()
        {
            this._vecInfo = new Vector.<PropInfo>;
            return;
        }// end function

        public function get cellnum() : int
        {
            return this._cellnum;
        }// end function

        public function set cellnum(param1:int) : void
        {
            this._cellnum = param1;
            return;
        }// end function

        public function setInfo(param1:Vector.<ItemInfo>) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            while (this._vecInfo.length)
            {
                
                this._vecInfo.pop();
            }
            var _loc_2:* = param1.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1[_loc_3];
                _loc_6 = ItemCfgObj.getInstance().getCfgBy(_loc_4.itemModelId);
                if (_loc_6 == null)
                {
                    throw new Error("lose ", _loc_4.itemModelId);
                }
                if (!PropUtil.isEquip(_loc_6.q_type))
                {
                    _loc_5 = new PropInfo();
                }
                else
                {
                    _loc_5 = new EquipmentInfo();
                }
                _loc_5.conv(_loc_4);
                _loc_5.blongToMine = true;
                this._vecInfo.push(_loc_5);
                ProtectControl.getInstance().setHighLock(_loc_5);
                _loc_3++;
            }
            return;
        }// end function

        public function getItemsListByPage(param1:int) : Vector.<PropInfo>
        {
            var _loc_5:* = null;
            var _loc_2:* = new Vector.<PropInfo>;
            if (!this._vecInfo)
            {
                return null;
            }
            var _loc_3:* = this._vecInfo.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = this._vecInfo[_loc_4];
                if (this.getPageFromGridId(_loc_5.gridId) == param1)
                {
                    _loc_2.push(_loc_5);
                }
                _loc_4++;
            }
            return _loc_2;
        }// end function

        public function get count() : int
        {
            return this._vecInfo.length;
        }// end function

        public function getPageFromGridId(param1:int) : int
        {
            return (param1 - 1) / MAX_GRID_COUNT;
        }// end function

        public function getIndexFromGridId(param1:int) : int
        {
            return (param1 - 1) % MAX_GRID_COUNT;
        }// end function

        public function getLockFirstIndexFromPage(param1:int) : int
        {
            var _loc_2:* = this.cellnum - param1 * MAX_GRID_COUNT;
            return _loc_2 > 0 ? (_loc_2) : (0);
        }// end function

        public function getGridIdFromIndexAndPage(param1:int, param2:int) : int
        {
            return param2 * MAX_GRID_COUNT + param1 - 1;
        }// end function

        public function itemUpdate(param1:ItemInfo) : PropInfo
        {
            var _loc_2:* = this.getInfoById(param1.itemId);
            _loc_2.conv(param1);
            return _loc_2;
        }// end function

        public function addItem(param1:ItemInfo) : PropInfo
        {
            var _loc_2:* = null;
            var _loc_3:* = ItemCfgObj.getInstance().getCfgBy(param1.itemModelId);
            if (_loc_3 == null)
            {
                throw new Error("lose ", param1.itemModelId);
            }
            if (!PropUtil.isEquip(_loc_3.q_type))
            {
                _loc_2 = new PropInfo();
            }
            else
            {
                _loc_2 = new EquipmentInfo();
            }
            _loc_2.conv(param1);
            _loc_2.isMine = false;
            _loc_2.blongToMine = true;
            this._vecInfo.push(_loc_2);
            ProtectControl.getInstance().setHighLock(_loc_2);
            return _loc_2;
        }// end function

        public function removeItem(param1:long) : PropInfo
        {
            var _loc_2:* = this.getIndexById(param1);
            if (_loc_2 == -1)
            {
                return null;
            }
            var _loc_3:* = this._vecInfo.splice(_loc_2, 1)[0];
            return _loc_3;
        }// end function

        private function getIndexById(param1:long) : int
        {
            var _loc_2:* = null;
            var _loc_3:* = this._vecInfo.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_2 = this._vecInfo[_loc_4];
                if (_loc_2.itemId.equal(param1))
                {
                    return _loc_4;
                }
                _loc_4++;
            }
            return -1;
        }// end function

        public function getInfoById(param1:long) : PropInfo
        {
            var _loc_2:* = null;
            var _loc_3:* = this._vecInfo.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_2 = this._vecInfo[_loc_4];
                if (_loc_2.itemId.equal(param1))
                {
                    return _loc_2;
                }
                _loc_4++;
            }
            return null;
        }// end function

        public function getOpenCellCost(param1:int) : int
        {
            var _loc_6:* = null;
            var _loc_2:* = StoreModel.getInstance().cellnum + 1;
            var _loc_3:* = param1;
            var _loc_4:* = 0;
            var _loc_5:* = _loc_2;
            while (_loc_5 <= _loc_3)
            {
                
                _loc_6 = BackpackOpenCfgObj.getInstance().getCost("2_" + _loc_5);
                if (_loc_6)
                {
                    _loc_4 = _loc_4 + int(_loc_6.q_cost);
                }
                _loc_5++;
            }
            return _loc_4;
        }// end function

        public function getCanOpenMaXGridCount() : int
        {
            var _loc_7:* = null;
            var _loc_1:* = StoreModel.getInstance().cellnum + 1;
            var _loc_2:* = 200;
            var _loc_3:* = UserObj.getInstance().playerInfo.gold;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = _loc_1;
            while (_loc_6 <= _loc_2)
            {
                
                _loc_7 = BackpackOpenCfgObj.getInstance().getCost("2_" + _loc_6);
                if (_loc_7)
                {
                    if (_loc_3 > _loc_4 + int(_loc_7.q_cost))
                    {
                        _loc_4 = _loc_4 + int(_loc_7.q_cost);
                        _loc_5++;
                    }
                    else
                    {
                        break;
                    }
                }
                _loc_6++;
            }
            return _loc_5;
        }// end function

        public static function getInstance() : StoreModel
        {
            if (!_instance)
            {
                _instance = new StoreModel;
            }
            return _instance;
        }// end function

    }
}
