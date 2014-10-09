package com.game.task.control
{
    import __AS3__.vec.*;
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.task.*;
    import com.game.task.bean.*;
    import com.game.task.model.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;

    public class ElseTypeTaskParse extends Object
    {

        public function ElseTypeTaskParse()
        {
            return;
        }// end function

        private static function parse26(param1:TaskMsgVO, param2:Object, param3:Array, param4:MainTaskInfo) : void
        {
            parse10(param1, param2, param3, param4);
            return;
        }// end function

        private static function parse10(param1:TaskMsgVO, param2:Object, param3:Array, param4:MainTaskInfo) : void
        {
            var _loc_7:* = null;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = 0;
            var _loc_5:* = false;
            var _loc_6:* = param2.q_transfer;
            if (param2.q_transfer && _loc_6 != "")
            {
                _loc_6 = _loc_6.replace(/{|}/g, "");
                _loc_9 = _loc_6.split("_");
                _loc_10 = uint(_loc_9[1]);
                _loc_11 = int(_loc_9[4]);
                _loc_12 = LanguageCfgObj.getInstance().getByIndex("11294");
                if (_loc_11 == 1)
                {
                    _loc_7 = ZonesCloneCfg.getInstance().getZonesInfoFromId(_loc_10);
                    _loc_12 = _loc_7.duplicate_name;
                }
                else
                {
                    _loc_14 = MapCfgObj.getInstance().getMap(_loc_10);
                    _loc_12 = _loc_14.mapName;
                }
                _loc_13 = new TaskCoordVO();
                _loc_13.autoFind = int(param2.q_bool_Pathfinding);
                _loc_13.taskId = param2.q_taskid;
                _loc_13.id = 10;
                _loc_13.x = int(_loc_9[2]);
                _loc_13.y = int(_loc_9[3]);
                _loc_13.num = int(_loc_9[4]);
                _loc_13.mapId = _loc_10;
                _loc_13.type = 0;
                _loc_13.kind = param2.q_task_type;
                _loc_13.info = String(_loc_9[0]).substr(1);
                if (int(param3[1]) == 1)
                {
                    param1.transfer = true;
                    param1.transMsg = _loc_13;
                }
                param1.text1 = "<font color=\'#ffd47f\'>" + LanguageCfgObj.getInstance().getByIndex("12221") + "</font> <u><a href =\'event:" + _loc_13.toString() + "\'><font color=\'#00ff00\'>" + _loc_12 + "</font></a></u>";
            }
            else
            {
                switch(_loc_7.type)
                {
                    case ZoneType.ZONES_XS:
                    {
                        break;
                    }
                    case ZoneType.ZONES_BELIAL_WORLD:
                    {
                        break;
                    }
                    case ZoneType.ZONES_DELARON:
                    {
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            var _loc_8:* = param4.permiseElse;
            if (param4.permiseElse && _loc_8.length)
            {
                _loc_16 = 0;
                while (_loc_16 < _loc_8.length)
                {
                    
                    _loc_5 = true;
                    _loc_16++;
                }
            }
            param1.complete = _loc_5;
            return;
        }// end function

        private static function parse11(param1:TaskMsgVO, param2:Object, param3:Array, param4:MainTaskInfo) : void
        {
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = 0;
            var _loc_5:* = false;
            var _loc_6:* = param3[1];
            var _loc_7:* = _loc_6.split("|");
            var _loc_8:* = UserObj.getInstance().playerInfo.job;
            var _loc_9:* = param3[0];
            var _loc_10:* = _loc_7[(_loc_8 - 1)];
            var _loc_11:* = ItemCfgObj.getInstance().getCfgBy(_loc_10);
            if (ItemCfgObj.getInstance().getCfgBy(_loc_10))
            {
                _loc_12 = new TaskCoordVO();
                _loc_12.autoFind = int(param2.q_bool_Pathfinding);
                _loc_12.num = _loc_10;
                _loc_13 = LanguageCfgObj.getInstance().getByIndex("11295");
                param1.text1 = param1.text1 + (_loc_13 + " <font color=\'#00ff00\'>" + _loc_11.q_name + "</font>");
                _loc_14 = param4.permiseElse;
                if (_loc_14 && _loc_14.length)
                {
                    _loc_15 = 0;
                    while (_loc_15 < _loc_14.length)
                    {
                        
                        _loc_5 = true;
                        _loc_15++;
                    }
                }
                param1.complete = _loc_5;
            }
            return;
        }// end function

        private static function parse23(param1:TaskMsgVO, param2:Object, param3:Array, param4:MainTaskInfo) : void
        {
            var _loc_10:* = 0;
            var _loc_5:* = false;
            var _loc_6:* = param3[0];
            var _loc_7:* = param3[1];
            if (param4.permiseElse && param4.permiseElse.length)
            {
                _loc_10 = 0;
                while (_loc_10 < param4.permiseElse.length)
                {
                    
                    if (param4.permiseElse[_loc_10].model == _loc_6)
                    {
                        if (param4.permiseElse[_loc_10].num >= _loc_7)
                        {
                            _loc_5 = true;
                        }
                    }
                    _loc_10++;
                }
            }
            var _loc_8:* = new TaskCoordVO();
            _loc_8.autoFind = int(param2.q_bool_Pathfinding);
            _loc_8.taskId = param2.q_taskid;
            _loc_8.num = _loc_7;
            _loc_8.type = 0;
            _loc_8.kind = param2.q_task_type;
            _loc_8.id = param3[0];
            var _loc_9:* = HorseCfgObj.getInstance().getInfoFromLevel(_loc_7);
            param1.text1 = param1.text1 + ("<font color=\'#ffd47f\'>" + LanguageCfgObj.getInstance().getByIndex("12222") + "</font><u><a href =\'event:" + _loc_8.toString() + "\'><font color=\'#00ff00\'>" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12223"), [_loc_9.horse_step, _loc_9.horse_step_level]) + "</font></a></u>");
            param1.complete = _loc_5;
            return;
        }// end function

        private static function parse24(param1:TaskMsgVO, param2:Object, param3:Array, param4:MainTaskInfo) : void
        {
            var _loc_5:* = false;
            var _loc_6:* = param3[1].split("|");
            var _loc_7:* = _loc_6[(UserObj.getInstance().playerInfo.job - 1)];
            var _loc_8:* = ItemCfgObj.getInstance().getCfgBy(_loc_7);
            var _loc_9:* = new TaskCoordVO();
            _loc_9.autoFind = int(param2.q_bool_Pathfinding);
            _loc_9.taskId = param2.q_taskid;
            _loc_9.num = _loc_7;
            _loc_9.type = 0;
            _loc_9.kind = param2.q_task_type;
            _loc_9.id = param3[0];
            param1.text1 = param1.text1 + ("<font color=\'#ffd47f\'>" + LanguageCfgObj.getInstance().getByIndex("12224") + "</font><u><a href =\'event:openHC_" + _loc_8.q_name + "\'><font color=\'#00ff00\'>" + _loc_8.q_name + "</font></a></u>");
            if (param4.permiseElse && param4.permiseElse.length)
            {
                _loc_5 = true;
            }
            param1.complete = _loc_5;
            return;
        }// end function

        private static function parse28(param1:TaskMsgVO, param2:Object, param3:Array, param4:MainTaskInfo) : void
        {
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_5:* = false;
            var _loc_6:* = param4.permiseElse;
            var _loc_7:* = int(param3[1]);
            var _loc_8:* = 0;
            var _loc_9:* = param3[0];
            if (_loc_6.length)
            {
                _loc_5 = true;
            }
            var _loc_10:* = 0;
            while (_loc_10 < _loc_6.length)
            {
                
                _loc_13 = _loc_6[_loc_10];
                if (_loc_13.model == _loc_9)
                {
                    _loc_8 = _loc_13.num;
                    if (_loc_8 < _loc_7)
                    {
                        _loc_5 = false;
                    }
                    break;
                }
                _loc_10++;
            }
            var _loc_11:* = [LanguageCfgObj.getInstance().getByIndex("12225"), LanguageCfgObj.getInstance().getByIndex("12226"), LanguageCfgObj.getInstance().getByIndex("12227")];
            for each (_loc_12 in TaskGlobal.cfg_else)
            {
                
                if (_loc_12.id == _loc_9)
                {
                    _loc_14 = _loc_12.label;
                    if (_loc_14.indexOf("{x}") != -1)
                    {
                        _loc_14 = _loc_14.replace("{x}", _loc_7) + "(" + _loc_7 + ")";
                    }
                    else
                    {
                        _loc_14 = _loc_14;
                    }
                    param1.text1 = param1.text1 + ("<font color=\'#00ff00\'>" + _loc_14 + "</font>");
                }
            }
            param1.complete = _loc_5;
            return;
        }// end function

        private static function parse31(param1:TaskMsgVO, param2:Object, param3:Array, param4:MainTaskInfo) : void
        {
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_5:* = false;
            var _loc_6:* = param3[1];
            var _loc_7:* = new TaskCoordVO();
            _loc_7.autoFind = int(param2.q_bool_Pathfinding);
            _loc_7.taskId = param2.q_taskid;
            _loc_7.type = 0;
            _loc_7.kind = param2.q_task_type;
            _loc_7.id = param3[0];
            param1.text1 = param1.text1 + ("<font color=\'#ffd47f\'>" + LanguageCfgObj.getInstance().getByIndex("12228") + "</font><font color=\'#00ff00\'></font>");
            for each (_loc_8 in TaskGlobal.cfg_else)
            {
                
                if (_loc_8.id == _loc_7.id)
                {
                    _loc_9 = _loc_8.label;
                    param1.text1 = param1.text1 + ("<font color=\'#00ff00\'>" + _loc_9 + "</font>");
                    break;
                }
            }
            if (param4.permiseElse && param4.permiseElse.length && param4.permiseElse[0].num == 1)
            {
                _loc_5 = true;
            }
            param1.complete = _loc_5;
            return;
        }// end function

        private static function parse36(param1:TaskMsgVO, param2:Object, param3:Array, param4:MainTaskInfo) : void
        {
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_5:* = false;
            var _loc_6:* = param3[1];
            var _loc_7:* = new TaskCoordVO();
            _loc_7.autoFind = int(param2.q_bool_Pathfinding);
            _loc_7.taskId = param2.q_taskid;
            _loc_7.type = 0;
            _loc_7.kind = param2.q_task_type;
            _loc_7.id = param3[0];
            param1.text1 = param1.text1 + ("<font color=\'#ffd47f\'>" + LanguageCfgObj.getInstance().getByIndex("12229") + "<u><a href=\'event:openDLQ\'><font color=\'#00ff00\'>" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12230"), [Params.GAME_NAME]) + "</font></a></u></font><font color=\'#00ff00\'></font>");
            for each (_loc_8 in TaskGlobal.cfg_else)
            {
                
                if (_loc_8.id == _loc_7.id)
                {
                    _loc_9 = _loc_8.label;
                    param1.text1 = param1.text1 + ("<font color=\'#00ff00\'>" + _loc_9 + "</font>");
                    break;
                }
            }
            if (param4.permiseElse && param4.permiseElse.length && param4.permiseElse[0].num == 1)
            {
                _loc_5 = true;
            }
            param1.complete = _loc_5;
            return;
        }// end function

        private static function parse37(param1:TaskMsgVO, param2:Object, param3:Array, param4:MainTaskInfo) : void
        {
            var _loc_5:* = false;
            var _loc_6:* = param3[1];
            var _loc_7:* = new TaskCoordVO();
            _loc_7.autoFind = int(param2.q_bool_Pathfinding);
            _loc_7.taskId = param2.q_taskid;
            _loc_7.type = 0;
            _loc_7.kind = param2.q_task_type;
            _loc_7.id = param3[0];
            if (param4.permiseElse && param4.permiseElse.length)
            {
                _loc_5 = true;
            }
            var _loc_8:* = param2.q_condition;
            var _loc_9:* = _loc_8.replace(/\[|\]/g, "");
            while (_loc_9.indexOf("\"") != -1)
            {
                
                _loc_9 = _loc_9.replace("\"", "");
            }
            param1.text1 = LanguageCfgObj.getInstance().getByIndex("11296");
            var _loc_10:* = _loc_9.split(",");
            var _loc_11:* = int(_loc_10[1]);
            param1.text1 = param1.text1 + ("<font color=\'#00ff00\'>" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12231"), [PropUtil.getEquipType((_loc_11 + 1))]) + "</font>");
            if (_loc_5)
            {
                param1.text1 = param1.text1 + "<font color=\'#00ff00\'>(1/1)</font>";
            }
            else
            {
                param1.text1 = param1.text1 + "<font color=\'#00ff00\'>(0/1)</font>";
            }
            param1.complete = _loc_5;
            return;
        }// end function

        private static function parse38(param1:TaskMsgVO, param2:Object, param3:Array, param4:MainTaskInfo) : void
        {
            var _loc_5:* = false;
            var _loc_6:* = param3[1];
            var _loc_7:* = new TaskCoordVO();
            _loc_7.autoFind = int(param2.q_bool_Pathfinding);
            _loc_7.taskId = param2.q_taskid;
            _loc_7.type = 0;
            _loc_7.kind = param2.q_task_type;
            _loc_7.id = param3[0];
            var _loc_8:* = param2.q_condition;
            var _loc_9:* = _loc_8.replace(/\[|\]/g, "");
            while (_loc_9.indexOf("\"") != -1)
            {
                
                _loc_9 = _loc_9.replace("\"", "");
            }
            param1.text1 = LanguageCfgObj.getInstance().getByIndex("11297");
            var _loc_10:* = _loc_9.split(",");
            var _loc_11:* = int(_loc_10[1]);
            var _loc_12:* = 0;
            if (param4.permiseElse && param4.permiseElse.length)
            {
                _loc_12 = param4.permiseElse[0].num;
            }
            if (_loc_12 >= _loc_11)
            {
                _loc_5 = true;
            }
            if (_loc_5)
            {
                param1.text1 = param1.text1 + ("<font color=\'#00ff00\'>(" + _loc_11 + "/" + _loc_11 + ")</font>");
            }
            else
            {
                param1.text1 = param1.text1 + ("<font color=\'#00ff00\'>(" + _loc_12 + "/" + _loc_11 + ")</font>");
            }
            param1.complete = _loc_5;
            return;
        }// end function

        private static function parse39(param1:TaskMsgVO, param2:Object, param3:Array, param4:MainTaskInfo) : void
        {
            var _loc_5:* = false;
            var _loc_6:* = param3[1];
            var _loc_7:* = new TaskCoordVO();
            _loc_7.autoFind = int(param2.q_bool_Pathfinding);
            _loc_7.taskId = param2.q_taskid;
            _loc_7.type = 0;
            _loc_7.kind = param2.q_task_type;
            _loc_7.id = param3[0];
            var _loc_8:* = param2.q_condition;
            var _loc_9:* = _loc_8.replace(/\[|\]/g, "");
            while (_loc_9.indexOf("\"") != -1)
            {
                
                _loc_9 = _loc_9.replace("\"", "");
            }
            param1.text1 = "<a href=\'event:openZZ\'>" + LanguageCfgObj.getInstance().getByIndex("12500");
            var _loc_10:* = _loc_9.split(",");
            var _loc_11:* = int(_loc_10[1]);
            var _loc_12:* = UserObj.getInstance().playerInfo.level;
            var _loc_13:* = Params.MASTER_CHANGE_LEVEL;
            var _loc_14:* = UserObj.getInstance().playerInfo.exp.toNumber();
            var _loc_15:* = LevelExpCfgObj.getInstance().getExpByLevel(UserObj.getInstance().playerInfo.job, _loc_13);
            var _loc_16:* = _loc_14 >= _loc_15;
            var _loc_17:* = 0;
            if (param4.permiseElse && param4.permiseElse.length)
            {
                _loc_17 = param4.permiseElse[0].num;
            }
            if (_loc_17 >= _loc_11 && _loc_12 >= Params.MASTER_CHANGE_LEVEL)
            {
                _loc_5 = true;
            }
            if (_loc_5)
            {
                param1.text1 = param1.text1 + ("<font color=\'#00ff00\'>(" + _loc_11 + "/" + _loc_11 + ")</font></a>\n");
                param1.text1 = param1.text1 + (LanguageCfgObj.getInstance().getByIndex("12501") + "<font color=\'#00ff00\'>(" + _loc_13 + "/" + _loc_13 + ")</font>");
            }
            else
            {
                param1.text1 = param1.text1 + ("<font color=\'#00ff00\'>(" + _loc_17 + "/" + _loc_11 + ")</font></a>\n");
                param1.text1 = param1.text1 + (LanguageCfgObj.getInstance().getByIndex("12501") + "<font color=\'#00ff00\'>(" + _loc_12 + "/" + _loc_13 + ")</font>");
            }
            param1.complete = _loc_5;
            return;
        }// end function

        private static function defaultParse(param1:TaskMsgVO, param2:Object, param3:Array, param4:MainTaskInfo) : void
        {
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_5:* = false;
            var _loc_6:* = param4.permiseElse;
            var _loc_7:* = int(param3[1]);
            var _loc_8:* = 0;
            var _loc_9:* = param3[0];
            if (_loc_6.length)
            {
                _loc_5 = true;
            }
            var _loc_10:* = 0;
            while (_loc_10 < _loc_6.length)
            {
                
                _loc_12 = _loc_6[_loc_10];
                if (_loc_12.model == _loc_9)
                {
                    _loc_8 = _loc_12.num;
                    if (_loc_8 < _loc_7)
                    {
                        _loc_5 = false;
                    }
                    break;
                }
                _loc_10++;
            }
            for each (_loc_11 in TaskGlobal.cfg_else)
            {
                
                if (_loc_11.id == _loc_9)
                {
                    _loc_13 = _loc_11.label;
                    if (_loc_13.indexOf("{x}") != -1)
                    {
                        _loc_13 = _loc_13.replace("{x}", _loc_7) + "(" + _loc_8 + "/" + _loc_7 + ")";
                    }
                    else
                    {
                        _loc_13 = _loc_13 + "(" + _loc_8 + "/" + _loc_7 + ")";
                    }
                    param1.text1 = param1.text1 + ("<font color=\'#00ff00\'>" + _loc_13 + "</font>");
                }
            }
            param1.complete = _loc_5;
            return;
        }// end function

        public static function parse(param1:MainTaskInfo, param2:Object) : TaskMsgVO
        {
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = null;
            var _loc_3:* = new TaskMsgVO();
            var _loc_4:* = false;
            var _loc_5:* = param2.q_condition.replace(/"/g, "");
            if (param2.q_condition.replace(/"/g, "") == "")
            {
                Log.error("任务ID" + param2.q_taskid + "q_condition字段为空了");
                return null;
            }
            var _loc_6:* = _loc_5.split("],");
            var _loc_7:* = param1.permiseElse;
            _loc_3.text1 = "";
            var _loc_8:* = 0;
            while (_loc_8 < _loc_6.length)
            {
                
                _loc_9 = _loc_6[_loc_8];
                _loc_9 = _loc_9.replace(/\[|\]/g, "");
                _loc_10 = _loc_9.split(",");
                _loc_11 = _loc_10[0];
                _loc_12 = new TaskCoordVO();
                _loc_12.autoFind = int(param2.q_bool_Pathfinding);
                _loc_12.type = 0;
                _loc_12.kind = 8;
                _loc_12.taskId = param2.q_taskid;
                _loc_12.id = _loc_11;
                _loc_3.actionMsg = _loc_12;
                switch(_loc_11)
                {
                    case 10:
                    case 29:
                    {
                        parse10(_loc_3, param2, _loc_10, param1);
                        break;
                    }
                    case 11:
                    {
                        parse11(_loc_3, param2, _loc_10, param1);
                        break;
                    }
                    case 23:
                    {
                        parse23(_loc_3, param2, _loc_10, param1);
                        break;
                    }
                    case 24:
                    {
                        parse24(_loc_3, param2, _loc_10, param1);
                        break;
                    }
                    case 28:
                    {
                        parse28(_loc_3, param2, _loc_10, param1);
                        break;
                    }
                    case 31:
                    {
                        parse31(_loc_3, param2, _loc_10, param1);
                        break;
                    }
                    case 36:
                    {
                        parse36(_loc_3, param2, _loc_10, param1);
                        break;
                    }
                    case 37:
                    {
                        parse37(_loc_3, param2, _loc_10, param1);
                        break;
                    }
                    case 38:
                    {
                        parse38(_loc_3, param2, _loc_10, param1);
                        break;
                    }
                    case 39:
                    {
                        parse39(_loc_3, param2, _loc_10, param1);
                        break;
                    }
                    default:
                    {
                        defaultParse(_loc_3, param2, _loc_10, param1);
                        break;
                        break;
                    }
                }
                _loc_8++;
            }
            return _loc_3;
        }// end function

    }
}
