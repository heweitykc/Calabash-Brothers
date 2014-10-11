package com.game.common
{
    import __AS3__.vec.*;
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.f1.utils.*;
    import com.f1.utils.path.*;
    import com.game.autopk.*;
    import com.game.autopk.controller.*;
    import com.game.role.control.*;
    import com.game.role.model.*;
    import com.game.sound.control.*;
    import com.game.task.*;
    import com.game.task.model.*;
    import com.model.*;
    import interfaces.role.*;

    public class PlayerArriveHandler extends Object
    {

        public function PlayerArriveHandler()
        {
            return;
        }// end function

        public static function handle() : void
        {
            var _loc_1:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = false;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_2:* = RoleList.getInstance().player;
            if (!_loc_2)
            {
                return;
            }
            AutoFightController.getInstance().closeAutoFind();
            var _loc_3:* = NpcData.getInstance().selectNpc;
            if (!_loc_3 && NpcData.getInstance().arriveSelectNpc != 0)
            {
                _loc_3 = NpcList.getInstance().getNpcByCfgId(NpcData.getInstance().arriveSelectNpc);
                NpcData.getInstance().selectNpc = _loc_3;
            }
            if (_loc_3)
            {
                _loc_1 = Math.sqrt((_loc_2._x - _loc_3._x) * (_loc_2._x - _loc_3._x) + (_loc_2._y - _loc_3._y) * (_loc_2._y - _loc_3._y));
                if (_loc_1 <= 6 * MapUtils.GRID_BORDER)
                {
                    _loc_4 = NpcCfgObj.getInstance().getNpcByID(_loc_3.info.cfgId + "");
                    if (!_loc_4)
                    {
                        return;
                    }
                    SoundControl.getInstance().playNpcSound(_loc_3.info.cfgId, SoundFlag.NPC_SOUND);
                    if (_loc_4._function == "")
                    {
                        AutoFightController.getInstance().closeAutoFind();
                        NpcControl.getInstance().arriveHanlder();
                        return;
                    }
                    _loc_5 = false;
                    _loc_6 = NpcData.getInstance().taskMap[_loc_3.info.cfgId];
                    if (_loc_6 && _loc_6.complete)
                    {
                        _loc_5 = true;
                    }
                    _loc_7 = _loc_4._function.split(";");
                    _loc_8 = _loc_7.length;
                    NpcData.getInstance().arriveSelectNpc = 0;
                    _loc_9 = 0;
                    while (_loc_9 < _loc_8)
                    {
                        
                        _loc_10 = _loc_7[_loc_9].toString().split("|");
                        _loc_11 = int(_loc_10[0]);
                        if (_loc_11 == 1)
                        {
                            if (_loc_8 == 1 && _loc_5)
                            {
                                TaskGlobal.task = _loc_6;
                                TaskGlobal.currentTask = _loc_6;
                                TaskGlobal.manager.arrivedHandle();
                                return;
                            }
                        }
                        else if (_loc_11 == 2)
                        {
                            _loc_12 = _loc_4._shop;
                            if (_loc_12 != "" && !_loc_5)
                            {
                                NpcShopControl.getInstance().showNpcShopByCfg(_loc_4);
                                return;
                            }
                        }
                        else if (_loc_11 == 5)
                        {
                            if (!_loc_5)
                            {
                                NpcControl.getInstance().openStorage();
                                return;
                            }
                        }
                        _loc_9++;
                    }
                    NpcControl.getInstance().arriveHanlder();
                }
            }
            else if (AutoFightController.getInstance().arriveCoordVo)
            {
                _loc_13 = AutoFightController.getInstance().arriveCoordVo;
                _loc_1 = ToolKit.distance(_loc_2._x / 25, _loc_2._y / 25, _loc_13.x, _loc_13.y);
                if (_loc_1 <= 6 && _loc_13.mapId == UserObj.getInstance().playerInfo.mapId)
                {
                    if (_loc_13.id != 0)
                    {
                        _loc_14 = new Vector.<int>;
                        _loc_14.push(_loc_13.id);
                    }
                    AutoFightManager.getInstance().setMounsterType(_loc_14);
                    AutoFightController.getInstance().openAutoFight();
                    AutoFightController.getInstance().arriveCoordVo = null;
                }
            }
            else
            {
                TaskGlobal.manager.arrivedHandle();
            }
            return;
        }// end function

    }
}
