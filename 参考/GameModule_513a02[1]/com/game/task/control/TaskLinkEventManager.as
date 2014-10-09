package com.game.task.control
{
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.*;
    import com.f1.utils.path.*;
    import com.game.autopk.controller.*;
    import com.game.casting.control.*;
    import com.game.challenge.control.*;
    import com.game.equipstreng.control.*;
    import com.game.fight.control.*;
    import com.game.goldRaffle.control.*;
    import com.game.gradegift.control.*;
    import com.game.mall.control.*;
    import com.game.mall.model.*;
    import com.game.map.control.*;
    import com.game.newactivity.firstrecharge.control.*;
    import com.game.operationpanel.control.*;
    import com.game.player.control.*;
    import com.game.primaryrole.control.*;
    import com.game.role.*;
    import com.game.role.control.*;
    import com.game.role.model.*;
    import com.game.task.*;
    import com.game.task.model.*;
    import com.game.team.control.*;
    import com.game.zones.control.*;
    import com.model.*;
    import com.staticdata.*;
    import flash.events.*;
    import interfaces.role.*;

    public class TaskLinkEventManager extends Object
    {

        public function TaskLinkEventManager()
        {
            return;
        }// end function

        public static function linkEventHandle(event:TextEvent) : void
        {
            var _loc_3:* = null;
            var _loc_6:* = null;
            var _loc_2:* = event.text;
            var _loc_4:* = RoleList.getInstance().player;
            var _loc_5:* = false;
            if (_loc_2.indexOf("openSC") != -1 && _loc_2.indexOf("openSCCZ") == -1)
            {
                _loc_3 = _loc_2.split("_");
                MallControl.getInstance().openMall(MallModel.kind[_loc_3[1]], _loc_3[2]);
            }
            else if (_loc_2.indexOf("openNPC") != -1)
            {
                _loc_3 = _loc_2.split("_");
                if (_loc_3 && _loc_3.length > 1)
                {
                    NpcControl.getInstance().npcFindPath(_loc_3[1]);
                }
            }
            else if (_loc_2.indexOf("openHC") != -1)
            {
                _loc_3 = _loc_2.split("_");
                if (_loc_3.length >= 2)
                {
                    EquipComposeControl.getInstance().openOnlyEquipComposeBox(_loc_3[1]);
                }
                else
                {
                    EquipComposeControl.getInstance().openEquipComposeBox();
                }
            }
            else
            {
                switch(_loc_2)
                {
                    case "openXSCB":
                    {
                        break;
                    }
                    case "openEMGC":
                    {
                        break;
                    }
                    case "openZZ":
                    {
                        break;
                    }
                    case "openZZGC":
                    {
                        break;
                    }
                    case "openZD":
                    {
                        break;
                    }
                    case "openDBDT":
                    {
                        break;
                    }
                    case "openRCRW":
                    {
                        break;
                    }
                    case "openJYFB":
                    {
                        break;
                    }
                    case "openSCCZ":
                    {
                        break;
                    }
                    case "openZSCJ":
                    {
                        break;
                    }
                    case "openMAP":
                    {
                        break;
                    }
                    case "openDLQ":
                    {
                        break;
                    }
                    case "openGG":
                    {
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        public static function clear() : void
        {
            AutoFightController.getInstance().closeAutoFight();
            FightControl.getInstance().delCurrentSkill();
            UserObj.getInstance().selectRole = null;
            NpcData.getInstance().selectNpc = null;
            return;
        }// end function

        public static function handle(param1:TaskCoordVO, param2:Boolean = true, param3:Boolean = false) : void
        {
            var _loc_11:* = false;
            var _loc_12:* = null;
            if (!param1)
            {
                return;
            }
            var _loc_4:* = param1.taskId;
            if (!param2 && param1.autoFind == 1 && _loc_4.toString().charAt(0) != "6")
            {
                return;
            }
            if (!param2 && _loc_4.toString().charAt(0) == "6")
            {
                ChangeJobControl.getInstance().openChangeJobBox();
                return;
            }
            var _loc_5:* = TaskCfgObj.getInstance().getTaskById(TaskGlobal.FIRST_GET_WING);
            if (!param2 && _loc_5 && _loc_4 == int(_loc_5.q_next_task) && !param3)
            {
                TaskGlobal.manager.setAutoTask(false);
                return;
            }
            var _loc_6:* = RoleList.getInstance().player as Role;
            if (RoleList.getInstance().player as Role == null)
            {
                return;
            }
            var _loc_7:* = param1.type;
            var _loc_8:* = param1.kind;
            if (_loc_7 == 2)
            {
                if (_loc_8 == 1)
                {
                    TaskGlobal.protocol.oneKeyFinishCurrentDailyTask(_loc_4, 1);
                    return;
                }
            }
            var _loc_9:* = param1.x * MapUtils.GRID_BORDER;
            var _loc_10:* = param1.y * MapUtils.GRID_BORDER;
            if (_loc_12 && _loc_12.transfer)
            {
                TaskGlobal.manager.openTransferPanel(_loc_12.transMsg);
                return;
            }
            switch(_loc_8)
            {
                case TaskGlobal.TASK_TALK:
                {
                    _loc_12 = TaskModel.getInstance().getTaskItemById(_loc_4);
                }
                case TaskGlobal.TASK_KILL:
                case TaskGlobal.TASK_DROP:
                case TaskGlobal.TASK_GATHER:
                case TaskGlobal.TASK_SEND:
                {
                    if (_loc_9 != 0 && _loc_10 != 0)
                    {
                        TaskGlobal.manager.taskFindPath(param1.x, param1.y, param1.mapId, param2);
                    }
                    break;
                }
                case TaskGlobal.TASK_EFFECT:
                {
                    break;
                }
                case TaskGlobal.TASK_STRONG:
                case TaskGlobal.TASK_STRONG2:
                {
                    if (param1.mapId == 0)
                    {
                        EquipForgeControl.getInstance().openEquipForgeBox();
                    }
                    else if (_loc_9 != 0 && _loc_10 != 0)
                    {
                        TaskGlobal.manager.taskFindPath(param1.x, param1.y, param1.mapId, param2);
                    }
                    break;
                }
                case TaskGlobal.TASK_ELSE:
                {
                    handleElseTask(_loc_9, _loc_10, param1, param2);
                    break;
                }
                default:
                {
                    if (_loc_9 != 0 && _loc_10 != 0)
                    {
                        TaskGlobal.manager.taskFindPath(param1.x, param1.y, param1.mapId, param2);
                    }
                    break;
                    break;
                }
            }
            return;
        }// end function

        private static function handleElseTask(param1:int, param2:int, param3:TaskCoordVO, param4:Boolean = true) : void
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = 0;
            var _loc_16:* = null;
            var _loc_5:* = param3.taskId;
            var _loc_6:* = TaskModel.getInstance().getTaskItemById(_loc_5);
            if (!TaskModel.getInstance().getTaskItemById(_loc_5))
            {
                return;
            }
            if (_loc_6.complete)
            {
                _loc_7 = RoleList.getInstance().player as Role;
                TaskGlobal.manager.taskFindPath(param3.x, param3.y, param3.mapId, param4);
            }
            else
            {
                _loc_8 = _loc_6.conf;
                _loc_9 = param3.id;
                _loc_10 = _loc_8.q_condition.replace(/"/g, "");
                if (_loc_10 == "")
                {
                    return;
                }
                _loc_11 = _loc_10.split("],");
                _loc_12 = 0;
                while (_loc_12 < _loc_11.length)
                {
                    
                    _loc_13 = _loc_11[_loc_12];
                    _loc_13 = _loc_13.replace(/\[|\]/g, "");
                    _loc_14 = _loc_13.split(",");
                    _loc_15 = _loc_14[0];
                    switch(_loc_9)
                    {
                        case 0:
                        {
                            TaskGlobal.manager.taskFindPath(param3.x, param3.y, param3.mapId, param4);
                            break;
                        }
                        case 10:
                        {
                            if (_loc_6.transfer)
                            {
                                TaskGlobal.manager.openTransferPanel(_loc_6.transMsg);
                            }
                            break;
                        }
                        case 11:
                        {
                            break;
                        }
                        case 23:
                        {
                            PrimaryRoleControl.getInstance().openHorse();
                            break;
                        }
                        case 24:
                        {
                            if (param3.taskId == 10132)
                            {
                                EquipComposeControl.getInstance().openOnlyEquipComposeBox(LanguageCfgObj.getInstance().getByIndex("12000"), true);
                            }
                            break;
                        }
                        case 29:
                        {
                            if (_loc_14.length > 1)
                            {
                                _loc_16 = ZonesCloneCfg.getInstance().getZonesInfoFromId(_loc_14[1]);
                                switch(_loc_16.type)
                                {
                                    case ZoneType.ZONES_XS:
                                    {
                                        ZonesControl.getInstance().openOnlyZonesScarletHold();
                                        break;
                                    }
                                    case ZoneType.ZONES_BELIAL_WORLD:
                                    {
                                        ZonesControl.getInstance().openZonesBeliaWorld();
                                        break;
                                    }
                                    default:
                                    {
                                        break;
                                    }
                                }
                            }
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    return;
                    _loc_12++;
                }
            }
            return;
        }// end function

    }
}
