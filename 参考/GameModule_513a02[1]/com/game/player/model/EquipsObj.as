package com.game.player.model
{
    import __AS3__.vec.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.equip.bean.*;
    import com.game.player.events.*;
    import com.game.protect.control.*;
    import com.game.utils.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import interfaces.role.*;

    public class EquipsObj extends BaseEventDispatcher
    {
        private var _info:EquipsInfo;
        private var _selectedPos:int;
        private static var _instance:EquipsObj;

        public function EquipsObj()
        {
            this._info = UserObj.getInstance().equipsInfo;
            return;
        }// end function

        public function get selectedPos() : int
        {
            return this._selectedPos;
        }// end function

        public function set selectedPos(param1:int) : void
        {
            this._selectedPos = param1;
            return;
        }// end function

        public function get info() : EquipsInfo
        {
            return this._info;
        }// end function

        public function set info(param1:EquipsInfo) : void
        {
            this._info = param1;
            return;
        }// end function

        public function addEquip(param1:EquipmentInfo) : void
        {
            var _loc_2:* = new Object();
            param1.isMine = true;
            _loc_2.equip = param1;
            this._info.items[(param1.pos - 1)] = param1;
            this.updateWeaponStyle(param1.pos, param1);
            ProtectControl.getInstance().setHighLock(param1);
            if (param1 != null)
            {
                param1.addEvtListener(PropEvent.UPDATE_FIGHTNUMBER, this.__updateFightNumber);
            }
            var _loc_3:* = new EquipEvent(EquipEvent.WEAR, _loc_2, true);
            dispatchEvent(_loc_3);
            return;
        }// end function

        private function __updateFightNumber(event:PropEvent) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = event.target as EquipmentInfo;
            if (_loc_2 != null)
            {
                if (_loc_2.pos <= 0)
                {
                    Log.log("updateFightNumber,equip.pos is 0");
                    return;
                }
                _loc_3 = new Object();
                _loc_3.equip = _loc_2;
                _loc_4 = new EquipEvent(EquipEvent.EQUIPSTRENTH, _loc_3, true);
                dispatchEvent(_loc_4);
            }
            else
            {
                Log.log("updateFightNumber,equip is null");
            }
            return;
        }// end function

        public function updateEquip(param1:EquipmentInfo, param2:EquipInfo) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (param1 != null && this._info.items.indexOf(param1) != -1)
            {
                param1.con(param2, (param1.pos - 1));
                _loc_3 = new Object();
                _loc_3.equip = param2;
                _loc_4 = new EquipEvent(EquipEvent.EQUIPSTRENTH, _loc_3, true);
                dispatchEvent(_loc_4);
            }
            return;
        }// end function

        private function updateWeaponStyle(param1:int, param2:EquipmentInfo) : void
        {
            var _loc_3:* = RoleList.getInstance().player;
            if (param1 == Params.LEFT_WEAPON)
            {
                if (!_loc_3.isZonesMorph)
                {
                    UserObj.getInstance().playerInfo.weapon = param2;
                }
            }
            else if (param1 == Params.RIGHT_WEAPON)
            {
                if (!_loc_3.isZonesMorph)
                {
                    UserObj.getInstance().playerInfo.weapon_other = param2;
                }
            }
            return;
        }// end function

        public function removeEquip(param1:long, param2:int) : void
        {
            var _loc_5:* = null;
            var _loc_3:* = this._info.items.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                if (this._info.items[_loc_4].itemId && this._info.items[_loc_4].itemId.equal(param1))
                {
                    this._info.items[_loc_4].removeEvtListener(PropEvent.UPDATE_FIGHTNUMBER, this.__updateFightNumber);
                    this._info.items[_loc_4] = new EquipmentInfo();
                    this._info.items[_loc_4].pos = _loc_4 + 1;
                    _loc_5 = new Object();
                    _loc_5.type = param2;
                    this.updateWeaponStyle(param2, null);
                    dispatchEvent(new EquipEvent(EquipEvent.TAKE_OFF, _loc_5, true));
                    break;
                }
                _loc_4++;
            }
            return;
        }// end function

        public function isInSelf(param1:long) : Boolean
        {
            var _loc_2:* = 0;
            while (_loc_2 < this._info.items.length)
            {
                
                if (this._info.items[_loc_2].itemId)
                {
                    if (this._info.items[_loc_2].itemId.equal(param1))
                    {
                        return true;
                    }
                }
                _loc_2++;
            }
            return false;
        }// end function

        public function getEquipBy(param1:int) : EquipmentInfo
        {
            var _loc_2:* = null;
            if (param1 < -1 || param1 > 12)
            {
                _loc_2 = PropUtil.createItemByCfg(310000);
                _loc_2.q_name = LanguageCfgObj.getInstance().getByIndex("10999");
                return _loc_2 as EquipmentInfo;
            }
            return this._info.items[(param1 - 1)];
        }// end function

        public function getEquipById(param1:long) : EquipmentInfo
        {
            var _loc_3:* = 0;
            var _loc_2:* = this._info.items.length;
            while (_loc_3 < _loc_2)
            {
                
                if (this._info.items[_loc_3] && this._info.items[_loc_3].itemId && this._info.items[_loc_3].itemId.equal(param1))
                {
                    return this._info.items[_loc_3];
                }
                _loc_3++;
            }
            return null;
        }// end function

        public function getSuitCount(param1:int, param2:int, param3:int) : int
        {
            return getSuitCountByItems(this._info.items, param1, param2, param3);
        }// end function

        public static function getInstance() : EquipsObj
        {
            var _loc_1:* = new EquipsObj;
            _instance = new EquipsObj;
            return _instance || _loc_1;
        }// end function

        public static function getSuitCountByItems(param1:Vector.<EquipmentInfo>, param2:int, param3:int, param4:int) : int
        {
            var _loc_9:* = null;
            var _loc_5:* = param1 ? (param1.length) : (0);
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            while (_loc_8 < _loc_5)
            {
                
                _loc_9 = param1[_loc_8];
                if (param3 == Params.RING1)
                {
                    if (_loc_9 && _loc_9.suitId == param2)
                    {
                        if (_loc_9.q_kind == param3)
                        {
                            if (param4 > 0)
                            {
                                if (_loc_9.pos != param4)
                                {
                                    _loc_6++;
                                }
                            }
                            else
                            {
                                _loc_6++;
                                _loc_7++;
                                if (_loc_7 == 2)
                                {
                                    _loc_6 = _loc_6 - 1;
                                }
                            }
                        }
                        else
                        {
                            _loc_6++;
                        }
                    }
                }
                else if (_loc_9 && _loc_9.suitId == param2 && _loc_9.q_kind != param3)
                {
                    _loc_6++;
                }
                _loc_8++;
            }
            return _loc_6;
        }// end function

        public static function countSuitNumber(param1:Vector.<EquipmentInfo>, param2:int) : int
        {
            var _loc_6:* = null;
            var _loc_3:* = param1 ? (param1.length) : (0);
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_6 = param1[_loc_5];
                if (_loc_6 && _loc_6.suitId == param2)
                {
                    _loc_4++;
                }
                _loc_5++;
            }
            return _loc_4;
        }// end function

    }
}
