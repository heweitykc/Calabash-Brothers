package com.game.autopk.controller
{
    import __AS3__.vec.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.f1.utils.path.*;
    import com.game.autopk.event.*;
    import com.game.autopk.model.*;
    import com.game.backpack.model.*;
    import com.game.map.bean.*;
    import com.game.map.control.*;
    import com.game.map.model.*;
    import com.game.map.view.*;
    import com.game.role.*;
    import com.game.utils.*;
    import com.greensock.*;
    import com.model.*;
    import com.staticdata.*;
    import com.util.*;
    import flash.events.*;
    import interfaces.role.*;

    final public class PickLogic extends EventDispatcher
    {
        private var pickType:uint;
        public static const TOTAL_PICK_NUM:int = 8;

        public function PickLogic()
        {
            return;
        }// end function

        public function pick(param1:Boolean = true, param2:DropIcon = null) : void
        {
            var _loc_4:* = false;
            if (!(AutoFightModel.autoPick || AutoFightModel.forcePick))
            {
                return;
            }
            var _loc_3:* = RoleList.getInstance().player as Player;
            if (param1)
            {
                if (_loc_3.cutePet && _loc_3.cutePet.petType == 5)
                {
                    _loc_4 = this.jugeBagIsFull();
                    if (_loc_4 || BackpackObj.getInstance().isLessThan(6))
                    {
                        SellLogic.autoSell();
                    }
                    dispatchEvent(new AutoFightEvent(AutoFightEvent.PICK_COMPLETE));
                }
                else
                {
                    this.getDropList(param2);
                }
            }
            else
            {
                _loc_3.removeEventListener(RoleEvent.ARRIVE, this.onArriveHandle);
                FrameworkGlobal.stage.removeEventListener(MouseEvent.CLICK, this.onClickHandle);
                TweenLite.killDelayedCallsTo(this.getDropList);
            }
            return;
        }// end function

        function getDropList(param1:DropIcon = null) : void
        {
            var _loc_4:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = 0;
            var _loc_17:* = 0;
            var _loc_18:* = 0;
            var _loc_2:* = this.jugeBagIsFull();
            var _loc_3:* = MapControl.getInstance().jugeElementIsPick();
            if (BackpackObj.getInstance().isLessThan(6))
            {
                SellLogic.autoSell();
            }
            if (_loc_2 && !_loc_3)
            {
                _loc_15 = MapControl.getInstance().getCurDropList();
                _loc_16 = _loc_15.length;
                _loc_4 = new Vector.<DropIcon>;
                _loc_17 = 0;
                while (_loc_17 < _loc_16)
                {
                    
                    if (_loc_15[_loc_17].modelInfo && _loc_15[_loc_17].modelInfo.q_type == 0)
                    {
                        _loc_4.push(_loc_15[_loc_17]);
                    }
                    _loc_17++;
                }
            }
            else
            {
                _loc_4 = MapControl.getInstance().getCurDropList();
            }
            if (_loc_4 == null || _loc_4.length == 0)
            {
                dispatchEvent(new AutoFightEvent(AutoFightEvent.PICK_COMPLETE));
                dispatchEvent(new AutoFightEvent(AutoFightEvent.PICK_COMPLETE_ALL));
                return;
            }
            _loc_16 = _loc_4.length;
            var _loc_5:* = RoleList.getInstance().player as Player;
            var _loc_6:* = Params.DROP_PICK_SMALL_RANGE - 25;
            var _loc_7:* = Params.DROP_PICK_BIG_RANGE;
            var _loc_8:* = int.MAX_VALUE;
            var _loc_12:* = false;
            var _loc_13:* = false;
            for each (_loc_14 in _loc_4)
            {
                
                _loc_10 = _loc_14.dropInfo;
                if (!_loc_10)
                {
                    continue;
                }
                if (!MapControl.getInstance().checkEncoughPick(_loc_14))
                {
                    continue;
                }
                _loc_18 = ToolKit.distance(_loc_10.x, _loc_10.y, _loc_5.x, _loc_5.y);
                _loc_12 = false;
                if (PropUtil.isRare(_loc_10.itemModelId) && this.pickCheck(_loc_14, _loc_18))
                {
                    _loc_12 = true;
                }
                if (_loc_18 < _loc_8 || _loc_12)
                {
                    _loc_13 = false;
                    if (_loc_10.ownerId.length == 0 && (_loc_12 || this.pickCheck(_loc_14, _loc_18)))
                    {
                        _loc_13 = true;
                    }
                    else
                    {
                        for each (_loc_11 in _loc_10.ownerId)
                        {
                            
                            if (_loc_11.equal(_loc_5.info.personId))
                            {
                                if (_loc_12 || this.pickCheck(_loc_14, _loc_18))
                                {
                                    _loc_13 = true;
                                }
                                break;
                            }
                        }
                    }
                    if (_loc_13)
                    {
                        _loc_8 = _loc_18;
                        _loc_9 = _loc_14;
                        if (_loc_8 < _loc_6)
                        {
                            break;
                        }
                        if (_loc_12)
                        {
                            break;
                        }
                    }
                }
            }
            if (param1 && param1.dropInfo)
            {
                _loc_9 = param1;
            }
            if (_loc_9)
            {
                if (_loc_8 < _loc_6)
                {
                    MapControl.getInstance().dropTakeUpGoods(_loc_9);
                    dispatchEvent(new AutoFightEvent(AutoFightEvent.PICK_ONE_ITEM));
                    return;
                }
                if (_loc_8 < _loc_7)
                {
                    _loc_10 = _loc_9.dropInfo;
                    if (_loc_10)
                    {
                        _loc_5.addEventListener(RoleEvent.ARRIVE, this.onArriveHandle);
                        FrameworkGlobal.stage.addEventListener(MouseEvent.CLICK, this.onClickHandle);
                        _loc_5.pathByCoo(_loc_10.x, _loc_10.y, 0, 0, false, false);
                        return;
                    }
                }
            }
            dispatchEvent(new AutoFightEvent(AutoFightEvent.PICK_COMPLETE));
            dispatchEvent(new AutoFightEvent(AutoFightEvent.PICK_COMPLETE_ALL));
            return;
        }// end function

        public function pickCheck(param1:DropIcon, param2:int) : Boolean
        {
            var _loc_4:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = false;
            this.pickType = AutoFightModel.pickType;
            if (!param1 || !param1.modelInfo)
            {
                return false;
            }
            var _loc_3:* = RoleList.getInstance().player;
            if (param2 > 0)
            {
                if (!AutoFightModel.forcePick)
                {
                    _loc_4 = MapUtils.findPath(MapObj.getInstance().tilesba, MapUtils.coo2Tile(_loc_3._x), MapUtils.coo2Tile(_loc_3._y), MapUtils.coo2Tile(param1.x), MapUtils.coo2Tile(param1.y), 0, RoleList.FIND_MONSTER_PATH_LIMIT);
                }
                else
                {
                    _loc_4 = MapUtils.findPath(MapObj.getInstance().tilesba, MapUtils.coo2Tile(_loc_3._x), MapUtils.coo2Tile(_loc_3._y), MapUtils.coo2Tile(param1.x), MapUtils.coo2Tile(param1.y), 0);
                }
                if (!_loc_4)
                {
                    return false;
                }
            }
            if (param1.modelInfo.q_type == 11)
            {
                return true;
            }
            var _loc_5:* = TOTAL_PICK_NUM;
            while (_loc_5)
            {
                
                _loc_5 = _loc_5 - 1;
                _loc_6 = 2 << _loc_5;
                if ((this.pickType & _loc_6) == _loc_6)
                {
                    switch(_loc_5)
                    {
                        case 2:
                        {
                            _loc_7 = this.check2(param1);
                            if (_loc_7)
                            {
                                return true;
                            }
                            break;
                        }
                        case 1:
                        {
                            _loc_7 = this.check1(param1);
                            if (_loc_7)
                            {
                                return true;
                            }
                            break;
                        }
                        case 0:
                        {
                            _loc_7 = this.check0(param1);
                            if (_loc_7)
                            {
                                return true;
                            }
                            break;
                        }
                        case 3:
                        {
                            _loc_7 = this.check3(param1);
                            if (_loc_7)
                            {
                                return true;
                            }
                            break;
                        }
                        case 4:
                        {
                            _loc_7 = this.check4(param1);
                            if (_loc_7)
                            {
                                return true;
                            }
                            break;
                        }
                        case 5:
                        {
                            _loc_7 = this.check5(param1);
                            if (_loc_7)
                            {
                                return true;
                            }
                            break;
                        }
                        case 6:
                        {
                            _loc_7 = this.checkOther(param1);
                            if (_loc_7)
                            {
                                return true;
                            }
                            break;
                        }
                        case 7:
                        {
                            _loc_7 = this.check8(param1);
                            if (_loc_7)
                            {
                                return true;
                            }
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                }
            }
            return false;
        }// end function

        private function check0(param1:DropIcon) : Boolean
        {
            var _loc_2:* = false;
            _loc_2 = param1.modelInfo.q_type == 1 && param1.modelInfo.q_remarkable == 1;
            if (_loc_2)
            {
                return true;
            }
            return false;
        }// end function

        private function check1(param1:DropIcon) : Boolean
        {
            var _loc_2:* = false;
            _loc_2 = param1.modelInfo.q_type == 1 && param1.modelInfo.q_remarkable == 0 && param1.modelInfo.q_kind != 5 && param1.modelInfo.q_kind != 9;
            if (_loc_2)
            {
                return true;
            }
            return false;
        }// end function

        private function check2(param1:DropIcon) : Boolean
        {
            var _loc_2:* = false;
            _loc_2 = param1.modelInfo.q_type == 0;
            if (_loc_2)
            {
                return true;
            }
            return false;
        }// end function

        private function check3(param1:DropIcon) : Boolean
        {
            var _loc_2:* = false;
            _loc_2 = param1.modelInfo.q_type == 3 || param1.modelInfo.q_type == 19;
            if (_loc_2)
            {
                return true;
            }
            return false;
        }// end function

        private function check4(param1:DropIcon) : Boolean
        {
            var _loc_2:* = false;
            _loc_2 = param1.modelInfo.q_type == 2;
            if (_loc_2)
            {
                return true;
            }
            return false;
        }// end function

        private function check5(param1:DropIcon) : Boolean
        {
            var _loc_2:* = false;
            _loc_2 = param1.modelInfo.q_type == 11;
            if (_loc_2)
            {
                return true;
            }
            return false;
        }// end function

        private function check8(param1:DropIcon) : Boolean
        {
            var _loc_2:* = false;
            _loc_2 = param1.modelInfo.q_type == 1 && (param1.modelInfo.q_kind == 5 || param1.modelInfo.q_kind == 9);
            if (_loc_2)
            {
                return true;
            }
            return false;
        }// end function

        private function checkOther(param1:DropIcon) : Boolean
        {
            var _loc_2:* = false;
            _loc_2 = this.check0(param1);
            if (_loc_2)
            {
                return false;
            }
            _loc_2 = this.check1(param1);
            if (_loc_2)
            {
                return false;
            }
            _loc_2 = this.check2(param1);
            if (_loc_2)
            {
                return false;
            }
            _loc_2 = this.check3(param1);
            if (_loc_2)
            {
                return false;
            }
            _loc_2 = this.check4(param1);
            if (_loc_2)
            {
                return false;
            }
            _loc_2 = this.check8(param1);
            if (_loc_2)
            {
                return false;
            }
            return true;
        }// end function

        private function onArriveHandle(event:RoleEvent) : void
        {
            var _loc_2:* = RoleList.getInstance().player as Player;
            _loc_2.removeEventListener(RoleEvent.ARRIVE, this.onArriveHandle);
            this.getDropList();
            return;
        }// end function

        private function onClickHandle(event:MouseEvent) : void
        {
            FrameworkGlobal.stage.removeEventListener(MouseEvent.CLICK, this.onClickHandle);
            var _loc_2:* = RoleList.getInstance().player as Player;
            _loc_2.removeEventListener(RoleEvent.ARRIVE, this.onArriveHandle);
            return;
        }// end function

        public function jugeBagIsFull() : Boolean
        {
            return BackpackObj.getInstance().isFull();
        }// end function

    }
}
