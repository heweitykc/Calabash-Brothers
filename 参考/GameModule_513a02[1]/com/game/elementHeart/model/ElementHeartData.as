package com.game.elementHeart.model
{
    import __AS3__.vec.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.elementHeart.event.*;
    import com.game.role.util.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;

    public class ElementHeartData extends BaseEventDispatcher
    {
        private var _backpackInfo:Vector.<ElementHeartInfo>;
        private var _houseInfo:Vector.<ElementHeartInfo>;
        private var _onPlayerInfo:Vector.<ElementHeartInfo>;
        private var _cellNum:int = 1;
        private var _value:int = 1;
        private static var _instance:ElementHeartData;
        public static var MAX_LEVEL:int = 20;
        public static var MAX_HOUSE_NUM:int = 126;

        public function ElementHeartData()
        {
            this._backpackInfo = new Vector.<ElementHeartInfo>;
            this._houseInfo = new Vector.<ElementHeartInfo>;
            this._onPlayerInfo = new Vector.<ElementHeartInfo>;
            return;
        }// end function

        public function get value() : int
        {
            return this._value;
        }// end function

        public function get onPlayerInfo() : Vector.<ElementHeartInfo>
        {
            return this._onPlayerInfo;
        }// end function

        public function enable() : Boolean
        {
            return RoleLevelUtil.isMasterLevel(UserObj.getInstance().playerInfo.level);
        }// end function

        public function isFull(param1:int = 0) : Boolean
        {
            return this._houseInfo.length + param1 >= MAX_HOUSE_NUM;
        }// end function

        public function remove(param1:int, param2:int) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            if (param2 == ElementLocateType.BACKPANCK)
            {
                _loc_3 = this.indexOf(this._backpackInfo, param1);
                if (_loc_3 != -1)
                {
                    _loc_4 = this._backpackInfo.splice(_loc_3, 1);
                    dispatchEvt(new EHeartEvent(EHeartEvent.DELETE_BACKPACK, _loc_4[0]));
                }
                else
                {
                    Log.log("格子已经为空，无法移除,[index:" + param1 + ",loc:" + param2 + "]");
                }
            }
            else if (param2 == ElementLocateType.HOUSE)
            {
                _loc_3 = this.indexOf(this._houseInfo, param1);
                if (_loc_3 != -1)
                {
                    _loc_4 = this._houseInfo.splice(_loc_3, 1);
                    dispatchEvt(new EHeartEvent(EHeartEvent.DELETE_HOUSE, _loc_4[0]));
                }
                else
                {
                    Log.log("格子已经为空，无法移除,[index:" + param1 + ",loc:" + param2 + "]");
                }
            }
            else if (param2 == ElementLocateType.ONPLAYER)
            {
                _loc_3 = this.indexOf(this._onPlayerInfo, param1);
                if (_loc_3 != -1)
                {
                    _loc_4 = this._onPlayerInfo.splice(_loc_3, 1);
                    dispatchEvt(new EHeartEvent(EHeartEvent.DELETE_PLAYER, _loc_4[0]));
                }
                else
                {
                    Log.log("格子已经为空，无法移除,[index:" + param1 + ",loc:" + param2 + "]");
                }
            }
            return;
        }// end function

        public function add(param1:ElementHeartInfo, param2:int) : void
        {
            var _loc_3:* = 0;
            if (param2 == ElementLocateType.BACKPANCK)
            {
                _loc_3 = this.indexOf(this._backpackInfo, param1.index);
                if (_loc_3 != -1)
                {
                    this._backpackInfo[_loc_3] = param1;
                }
                else
                {
                    this._backpackInfo.push(param1);
                }
                dispatchEvt(new EHeartEvent(EHeartEvent.ADD_BACKPACK, param1));
            }
            else if (param2 == ElementLocateType.HOUSE)
            {
                _loc_3 = this.indexOf(this._houseInfo, param1.index);
                if (_loc_3 != -1)
                {
                    this._houseInfo[_loc_3] = param1;
                }
                else
                {
                    this._houseInfo.push(param1);
                }
                dispatchEvt(new EHeartEvent(EHeartEvent.ADD_HOUSE, param1));
            }
            else if (param2 == ElementLocateType.ONPLAYER)
            {
                _loc_3 = this.indexOf(this._onPlayerInfo, param1.index);
                if (_loc_3 != -1)
                {
                    this._onPlayerInfo[_loc_3] = param1;
                }
                else
                {
                    this._onPlayerInfo.push(param1);
                }
                dispatchEvt(new EHeartEvent(EHeartEvent.ADD_PLAYER, param1));
            }
            return;
        }// end function

        private function indexOf(param1:Vector.<ElementHeartInfo>, param2:int) : int
        {
            var _loc_3:* = param1.length;
            var _loc_4:* = -1;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_3)
            {
                
                if (param1[_loc_5].index == param2)
                {
                    return _loc_5;
                }
                _loc_5++;
            }
            return _loc_4;
        }// end function

        private function itemOf(param1:Vector.<ElementHeartInfo>, param2:int) : ElementHeartInfo
        {
            var _loc_3:* = param1.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                if (param1[_loc_4].index == param2)
                {
                    return param1[_loc_4];
                }
                _loc_4++;
            }
            return null;
        }// end function

        private function replace(param1:Vector.<ElementHeartInfo>, param2:ElementHeartInfo) : Boolean
        {
            if (!param2)
            {
                return false;
            }
            var _loc_3:* = param1.length;
            var _loc_4:* = param2.index;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_3)
            {
                
                if (param1[_loc_5].index == _loc_4)
                {
                    param1[_loc_5] = param2;
                    return true;
                }
                _loc_5++;
            }
            return false;
        }// end function

        public function updateLock(param1:int, param2:int, param3:int) : void
        {
            var _loc_4:* = null;
            if (param1 == ElementLocateType.BACKPANCK)
            {
                _loc_4 = this.itemOf(this._backpackInfo, param2);
                if (_loc_4 != null)
                {
                    _loc_4.lock = param3;
                    dispatchEvt(new EHeartEvent(EHeartEvent.ADD_BACKPACK, _loc_4));
                }
                else
                {
                    Log.log("格子已经为空，无法更新锁,[index:" + param2 + ",loc:" + param1 + "]");
                }
            }
            else if (param1 == ElementLocateType.HOUSE)
            {
                _loc_4 = this.itemOf(this._houseInfo, param2);
                if (_loc_4 != null)
                {
                    _loc_4.lock = param3;
                    dispatchEvt(new EHeartEvent(EHeartEvent.ADD_HOUSE, _loc_4));
                }
                else
                {
                    Log.log("格子已经为空，无法更新锁,[index:" + param2 + ",loc:" + param1 + "]");
                }
            }
            else if (param1 == ElementLocateType.ONPLAYER)
            {
                _loc_4 = this.itemOf(this._onPlayerInfo, param2);
                if (_loc_4 != null)
                {
                    _loc_4.lock = param3;
                    dispatchEvt(new EHeartEvent(EHeartEvent.ADD_PLAYER, _loc_4));
                }
                else
                {
                    Log.log("格子已经为空，无法更新锁,[index:" + param2 + ",loc:" + param1 + "]");
                }
            }
            return;
        }// end function

        public function updateItem(param1:int, param2:int, param3:int, param4:int) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            if (param1 == ElementLocateType.BACKPANCK)
            {
                _loc_5 = this.itemOf(this._backpackInfo, param2);
                if (!_loc_5)
                {
                    return;
                }
                _loc_6 = _loc_5.lock;
                if (_loc_5.q_id != param4)
                {
                    _loc_5 = QEHeartCfgObj.getInstance().getItem(param4);
                }
                if (_loc_5 != null)
                {
                    _loc_5.exp = param3;
                    _loc_5.index = param2;
                    _loc_5.lock = _loc_6;
                    this.replace(this._backpackInfo, _loc_5);
                    dispatchEvt(new EHeartEvent(EHeartEvent.ADD_BACKPACK, _loc_5));
                }
                else
                {
                    Log.log("格子已经为空，无法更新锁,[index:" + param2 + ",loc:" + param1 + "]");
                }
            }
            else if (param1 == ElementLocateType.HOUSE)
            {
                _loc_5 = this.itemOf(this._houseInfo, param2);
                if (!_loc_5)
                {
                    return;
                }
                _loc_6 = _loc_5.lock;
                if (_loc_5.q_id != param4)
                {
                    _loc_5 = QEHeartCfgObj.getInstance().getItem(param4);
                }
                if (_loc_5 != null)
                {
                    _loc_5.exp = param3;
                    _loc_5.index = param2;
                    _loc_5.lock = _loc_6;
                    this.replace(this._houseInfo, _loc_5);
                    dispatchEvt(new EHeartEvent(EHeartEvent.ADD_HOUSE, _loc_5));
                }
                else
                {
                    Log.log("格子已经为空，无法更新锁,[index:" + param2 + ",loc:" + param1 + "]");
                }
            }
            else if (param1 == ElementLocateType.ONPLAYER)
            {
                _loc_5 = this.itemOf(this._onPlayerInfo, param2);
                if (!_loc_5)
                {
                    return;
                }
                _loc_6 = _loc_5.lock;
                if (_loc_5.q_id != param4)
                {
                    _loc_5 = QEHeartCfgObj.getInstance().getItem(param4);
                }
                if (_loc_5 != null)
                {
                    _loc_5.exp = param3;
                    _loc_5.index = param2;
                    _loc_5.lock = _loc_6;
                    this.replace(this._onPlayerInfo, _loc_5);
                    dispatchEvt(new EHeartEvent(EHeartEvent.ADD_PLAYER, _loc_5));
                }
                else
                {
                    Log.log("格子已经为空，无法更新锁,[index:" + param2 + ",loc:" + param1 + "]");
                }
            }
            return;
        }// end function

        public function updateBackpackInfo(param1:Vector.<ElementHeartInfo>) : void
        {
            this._backpackInfo = param1;
            dispatchEvt(new EHeartEvent(EHeartEvent.FRESH_BACKPACK, param1));
            return;
        }// end function

        public function updateHouseInfo(param1:Vector.<ElementHeartInfo>) : void
        {
            this._houseInfo = param1;
            dispatchEvt(new EHeartEvent(EHeartEvent.FRESH_HOUSE, param1));
            return;
        }// end function

        public function updatePlayerInfo(param1:Vector.<ElementHeartInfo>) : void
        {
            this._onPlayerInfo = param1;
            dispatchEvt(new EHeartEvent(EHeartEvent.FRESH_PlAYER, param1));
            return;
        }// end function

        public function update(param1:Vector.<ElementHeartInfo>, param2:int) : void
        {
            if (param2 == ElementLocateType.BACKPANCK)
            {
                this.updateBackpackInfo(param1);
            }
            else if (param2 == ElementLocateType.HOUSE)
            {
                this.updateHouseInfo(param1);
            }
            else if (param2 == ElementLocateType.ONPLAYER)
            {
                this.updatePlayerInfo(param1);
            }
            return;
        }// end function

        public function updateValue(param1:int) : void
        {
            this._value = param1;
            dispatchEvt(new EHeartEvent(EHeartEvent.CHANGE_VALUE, this._value));
            return;
        }// end function

        public function getSwallower(param1:int) : Array
        {
            var _loc_2:* = null;
            if (param1 == ElementLocateType.HOUSE)
            {
                _loc_2 = this._houseInfo;
            }
            else if (param1 == ElementLocateType.BACKPANCK)
            {
                _loc_2 = this._backpackInfo;
            }
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = _loc_2.length;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            while (_loc_8 < _loc_5)
            {
                
                _loc_6 = _loc_2[_loc_8];
                if (_loc_6.lock != 1)
                {
                    if (_loc_6.q_level == MAX_LEVEL && _loc_6.exp == _loc_6.q_exp_max)
                    {
                    }
                    else if (_loc_6.isExpDan())
                    {
                        _loc_7 = _loc_7 + (_loc_6.exp + _loc_6.q_swallow);
                    }
                    else if (_loc_3)
                    {
                        if (_loc_3.q_quality < _loc_6.q_quality)
                        {
                            _loc_7 = _loc_7 + (_loc_3.exp + _loc_3.q_swallow);
                            _loc_3 = _loc_6;
                        }
                        else if (_loc_3.q_quality == _loc_6.q_quality)
                        {
                            if (_loc_3.q_type_level < _loc_6.q_type_level)
                            {
                                _loc_7 = _loc_7 + (_loc_3.exp + _loc_3.q_swallow);
                                _loc_3 = _loc_6;
                            }
                            else if (_loc_3.q_type_level == _loc_6.q_type_level)
                            {
                                if (_loc_3.exp < _loc_6.exp)
                                {
                                    _loc_7 = _loc_7 + (_loc_3.exp + _loc_3.q_swallow);
                                    _loc_3 = _loc_6;
                                }
                                else if (_loc_3.exp == _loc_6.exp)
                                {
                                    if (_loc_3.index < _loc_6.index)
                                    {
                                        _loc_7 = _loc_7 + (_loc_3.exp + _loc_3.q_swallow);
                                        _loc_3 = _loc_6;
                                    }
                                    else
                                    {
                                        _loc_7 = _loc_7 + (_loc_6.exp + _loc_6.q_swallow);
                                    }
                                }
                                else
                                {
                                    _loc_7 = _loc_7 + (_loc_6.exp + _loc_6.q_swallow);
                                }
                            }
                            else
                            {
                                _loc_7 = _loc_7 + (_loc_6.exp + _loc_6.q_swallow);
                            }
                        }
                        else
                        {
                            _loc_7 = _loc_7 + (_loc_6.exp + _loc_6.q_swallow);
                        }
                    }
                    else
                    {
                        _loc_3 = _loc_6;
                    }
                }
                _loc_8++;
            }
            if (_loc_3)
            {
                _loc_4 = QEHeartCfgObj.getInstance().getNextLevel(_loc_3.q_id, _loc_3.exp + _loc_7);
            }
            return [_loc_3, _loc_7, _loc_4];
        }// end function

        public static function getInstance() : ElementHeartData
        {
            if (!_instance)
            {
                _instance = new ElementHeartData;
            }
            return _instance;
        }// end function

    }
}
