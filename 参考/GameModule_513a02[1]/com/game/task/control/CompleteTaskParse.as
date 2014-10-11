package com.game.task.control
{
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.task.*;
    import com.game.task.model.*;
    import com.model.*;
    import com.model.vo.*;
    import com.util.*;

    public class CompleteTaskParse extends Object
    {

        public function CompleteTaskParse()
        {
            return;
        }// end function

        public static function parse(param1:TaskMsgVO, param2:Object) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = false;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = 0;
            var _loc_19:* = 0;
            var _loc_20:* = null;
            var _loc_21:* = null;
            var _loc_22:* = 0;
            var _loc_23:* = 0;
            var _loc_24:* = null;
            var _loc_25:* = null;
            var _loc_26:* = 0;
            var _loc_27:* = null;
            var _loc_28:* = 0;
            var _loc_29:* = null;
            var _loc_30:* = null;
            var _loc_31:* = null;
            var _loc_32:* = null;
            var _loc_33:* = null;
            var _loc_34:* = null;
            var _loc_35:* = 0;
            var _loc_36:* = null;
            var _loc_37:* = 0;
            var _loc_38:* = 0;
            var _loc_39:* = 0;
            var _loc_40:* = null;
            var _loc_41:* = null;
            var _loc_3:* = int(param2.q_task_type);
            switch(_loc_3)
            {
                case TaskGlobal.TASK_TALK:
                {
                    _loc_12 = NpcCfgObj.getInstance().getNpcByID(param2.q_endnpc);
                    _loc_8 = new TaskCoordVO();
                    _loc_8.autoFind = int(param2.q_bool_Pathfinding);
                    _loc_8.taskId = param2.q_taskid;
                    _loc_8.id = _loc_12._npcId;
                    _loc_8.type = 0;
                    _loc_8.kind = 1;
                    _loc_8.mapId = _loc_12._map;
                    _loc_8.x = _loc_12._x;
                    _loc_8.y = _loc_12._y;
                    _loc_5 = MapCfgObj.getInstance().getMap(_loc_12._map);
                    _loc_6 = "<u><a href=\'event:openMAP\'><font color = \'#ffff99\'>" + _loc_5.mapName + "</font></a></u>";
                    _loc_13 = _loc_8.toString();
                    param1.actionMsg = _loc_8;
                    param1.text1 = "<font color=\'#ffd47f\'>" + LanguageCfgObj.getInstance().getByIndex("12212") + "</font><u><a href =\'event:" + _loc_13 + "\'><font color=\'#00ff00\'>" + _loc_12._npcName + "</font></a></u>";
                    break;
                }
                case TaskGlobal.TASK_KILL:
                {
                    _loc_14 = param2.q_end_need_killmonster;
                    _loc_4 = _loc_14.replace(/"/g, "");
                    _loc_10 = _loc_4.split(";");
                    _loc_15 = false;
                    param1.text1 = LanguageCfgObj.getInstance().getByIndex("11286");
                    _loc_7 = 0;
                    while (_loc_7 < _loc_10.length)
                    {
                        
                        _loc_8 = new TaskCoordVO();
                        _loc_8.autoFind = int(param2.q_bool_Pathfinding);
                        _loc_8.type = 0;
                        _loc_8.kind = 2;
                        _loc_8.taskId = param2.q_taskid;
                        _loc_8.parse(_loc_10[_loc_7]);
                        _loc_5 = MapCfgObj.getInstance().getMap(_loc_8.mapId);
                        _loc_6 = "<u><a href=\'event:openMAP\'><font color = \'#ffff99\'>" + _loc_5.mapName + "</font></a></u>";
                        _loc_11 = MonsterCfgObj.getInstance().getMonsterCfg(_loc_8.id);
                        param1.actionMsg = _loc_8;
                        param1.text1 = param1.text1 + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12213"), ["<u><a href =\'event:" + _loc_8.toString() + "\'><font color=\'#00ff00\'>" + _loc_11.q_name + "</font></a></u>(" + _loc_8.num + "/" + _loc_8.num + ")"]);
                        _loc_7++;
                    }
                    param1.text1 = param1.text1 + "</font>";
                    break;
                }
                case TaskGlobal.TASK_DROP:
                {
                    _loc_4 = param2.q_end_resume_goods;
                    _loc_4 = _loc_4.replace(/"/g, "");
                    _loc_16 = _loc_4.substring(0, (_loc_4.indexOf("{") - 1));
                    _loc_17 = _loc_16.split("_");
                    _loc_4 = _loc_4.substring((_loc_4.indexOf("{") + 1), (_loc_4.length - 1));
                    _loc_10 = _loc_4.split(";");
                    _loc_18 = 10066431;
                    _loc_19 = UserObj.getInstance().playerInfo.level;
                    _loc_21 = [];
                    _loc_7 = 0;
                    while (_loc_7 < _loc_10.length)
                    {
                        
                        _loc_20 = MainTaskMsgParseController.parseStr(_loc_10[_loc_7]);
                        if (_loc_20.list.length >= 6)
                        {
                            if (_loc_20.list[4] > _loc_19 || _loc_20.list[5] < _loc_19)
                            {
                                ;
                            }
                        }
                        _loc_21.push(_loc_20);
                        _loc_7++;
                    }
                    _loc_20 = _loc_21[Math.floor(_loc_21.length * Math.random())];
                    _loc_8 = new TaskCoordVO();
                    _loc_8.autoFind = int(param2.q_bool_Pathfinding);
                    _loc_8.type = 0;
                    _loc_8.kind = 3;
                    _loc_8.taskId = param2.q_taskid;
                    _loc_8.mapId = _loc_20.list[0];
                    _loc_8.x = _loc_20.list[1];
                    _loc_8.y = _loc_20.list[2];
                    _loc_22 = _loc_20.list[3];
                    _loc_8.id = _loc_22;
                    _loc_11 = MonsterCfgObj.getInstance().getMonsterCfg(_loc_22);
                    _loc_9 = ItemCfgObj.getInstance().getCfgBy(_loc_17[0]);
                    _loc_23 = 0;
                    _loc_5 = MapCfgObj.getInstance().getMap(_loc_20.list[0]);
                    _loc_6 = "<u><a href=\'event:openMAP\'><font color = \'#ffff99\'>" + _loc_5.mapName + "</font></a></u>";
                    _loc_24 = LanguageCfgObj.getInstance().getByIndex("11287");
                    param1.actionMsg = _loc_8;
                    _loc_24 = _loc_24 + ("<u><a href =\'event:" + _loc_8.toString() + "\'><font color=\'#" + _loc_18 + "\'>" + _loc_11.q_name + "</font></a></u>");
                    _loc_25 = _loc_11.q_name.length >= 4 ? ("\n　　　") : ("");
                    if (_loc_23 < _loc_8.num)
                    {
                        _loc_24 = _loc_24 + (_loc_25 + LanguageCfgObj.getInstance().getByIndex("12214") + "<font color=\'#" + _loc_18 + "\'>" + _loc_9.q_name + "</font>(" + _loc_23 + "/" + _loc_17[1] + ");");
                    }
                    else
                    {
                        _loc_24 = _loc_24 + (_loc_25 + LanguageCfgObj.getInstance().getByIndex("12214") + "：<font color=\'#" + _loc_18 + "\'>" + _loc_9.q_name + "</font>(" + _loc_23 + "/" + _loc_17[1] + ");");
                    }
                    param1.text1 = _loc_24;
                    break;
                }
                case TaskGlobal.TASK_GATHER:
                {
                    _loc_26 = param2.q_collection_target;
                    _loc_27 = NpcCfgObj.getInstance().getNpcByID(param2.q_collection_target);
                    _loc_28 = _loc_27._acquisition_item;
                    _loc_29 = ItemCfgObj.getInstance().getCfgBy(_loc_28);
                    _loc_8 = new TaskCoordVO();
                    _loc_8.autoFind = int(param2.q_bool_Pathfinding);
                    _loc_8.type = 0;
                    _loc_8.kind = 4;
                    _loc_8.taskId = param2.q_taskid;
                    _loc_8.id = _loc_26;
                    _loc_8.mapId = 0;
                    _loc_8.x = _loc_27._x;
                    _loc_8.y = _loc_27._y;
                    _loc_5 = MapCfgObj.getInstance().getMap(_loc_27._map);
                    _loc_6 = "<u><a href=\'event:openMAP\'><font color = \'#ffff99\'>" + _loc_5.mapName + "</font></a></u>";
                    param1.actionMsg = _loc_8;
                    param1.text1 = "<font color=\'#ffd47f\'>" + LanguageCfgObj.getInstance().getByIndex("12215") + "</font><u><a href =\'event:" + _loc_8.toString() + "\'><font color=\'#00ff00\'>" + _loc_27._npcName + "</font></a></u>";
                    break;
                }
                case TaskGlobal.TASK_SEND:
                {
                    param1.text1 = LanguageCfgObj.getInstance().getByIndex("11288");
                    _loc_30 = "";
                    _loc_4 = param2.q_end_resume_goods.replace(/"/g, "");
                    _loc_4 = _loc_4.replace("!", "");
                    _loc_10 = _loc_4.split(";");
                    _loc_7 = 0;
                    while (_loc_7 < _loc_10.length)
                    {
                        
                        _loc_34 = String(_loc_10[_loc_7]).split("_", 2);
                        _loc_9 = ItemCfgObj.getInstance().getCfgBy(_loc_34[0]);
                        _loc_30 = _loc_30 + ("<font color=\'#00ff00\'>" + _loc_9.q_name + "</font>");
                        _loc_7++;
                    }
                    _loc_12 = NpcCfgObj.getInstance().getNpcByID(param2.q_endnpc);
                    _loc_31 = new TaskCoordVO();
                    _loc_31.autoFind = int(param2.q_bool_Pathfinding);
                    _loc_31.type = 0;
                    _loc_31.kind = 5;
                    _loc_31.taskId = param2.q_taskid;
                    _loc_31.id = _loc_12._npcModelId;
                    _loc_31.x = _loc_12._x;
                    _loc_31.y = _loc_12._y;
                    _loc_31.mapId = 0;
                    param1.actionMsg = _loc_31;
                    param1.text1 = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12216"), [_loc_30, "<u><a href =\'event:" + _loc_31.toString() + "\'><font color=\'#00ff00\'>" + _loc_12._npcName + "</font></a></u>"]);
                    break;
                }
                case TaskGlobal.TASK_STRONG:
                case TaskGlobal.TASK_STRONG2:
                {
                    _loc_32 = param2.q_end_need_qianghua;
                    _loc_4 = _loc_32.replace(/"/g, "");
                    _loc_33 = _loc_4.split(";");
                    param1.text1 = LanguageCfgObj.getInstance().getByIndex("11289");
                    _loc_35 = 0;
                    while (_loc_35 < _loc_33.length)
                    {
                        
                        _loc_36 = String(_loc_33[_loc_35]).split("_");
                        _loc_37 = int(_loc_36[0]);
                        _loc_38 = int(_loc_36[1]);
                        _loc_39 = int(_loc_36[2]);
                        _loc_8 = new TaskCoordVO();
                        _loc_8.autoFind = int(param2.q_bool_Pathfinding);
                        _loc_8.type = 0;
                        _loc_8.kind = 7;
                        _loc_8.taskId = param2.q_taskid;
                        _loc_8.id = _loc_38;
                        _loc_8.num = _loc_39;
                        _loc_8.x = _loc_37;
                        _loc_8.y = _loc_37;
                        param1.actionMsg = _loc_8;
                        if (_loc_35 == 2)
                        {
                            param1.text1 = param1.text1 + "\n";
                        }
                        if (_loc_38 != -1)
                        {
                            _loc_40 = _loc_38 + "_" + _loc_39;
                            _loc_41 = EquipStrengCfgObj.getInstance().getEquipStrenginfoByLev(_loc_40);
                            param1.text1 = param1.text1 + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12217"), ["<u><a href =\'event:" + _loc_8.toString() + "\'><font color=\'#00ff00\'>" + _loc_41.q_item_name + "</font></a></u>", _loc_39]);
                        }
                        else if (_loc_37 == -1)
                        {
                            param1.text1 = param1.text1 + ("<u><a href =\'event:" + _loc_8.toString() + "\'>" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12218"), [_loc_39]));
                        }
                        else
                        {
                            param1.text1 = param1.text1 + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12217"), ["<u><a href =\'event:" + _loc_8.toString() + "\'><font color=\'#ffcc00\'>" + PropUtil.getEquipType(_loc_37) + "</font></a></u>", _loc_39]);
                        }
                        _loc_35++;
                    }
                    break;
                }
                case TaskGlobal.TASK_ELSE:
                {
                    parseElseTask(param1, param2);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private static function parseElseTask(param1:TaskMsgVO, param2:Object) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = 0;
            var _loc_18:* = 0;
            var _loc_19:* = null;
            var _loc_20:* = 0;
            var _loc_21:* = null;
            var _loc_22:* = null;
            var _loc_3:* = param2.q_condition.replace(/"/g, "");
            if (_loc_3 == "")
            {
                return;
            }
            var _loc_4:* = _loc_3.split("],");
            param1.text1 = "";
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4.length)
            {
                
                _loc_6 = _loc_4[_loc_5];
                _loc_6 = _loc_6.replace(/\[|\]/g, "");
                _loc_7 = _loc_6.split(",");
                _loc_8 = _loc_7[0];
                _loc_9 = new TaskCoordVO();
                _loc_9.autoFind = int(param2.q_bool_Pathfinding);
                _loc_9.type = 0;
                _loc_9.kind = 8;
                _loc_9.taskId = param2.q_taskid;
                _loc_9.id = _loc_8;
                param1.actionMsg = _loc_9;
                switch(_loc_8)
                {
                    case 10:
                    {
                        _loc_10 = _loc_7[1];
                        _loc_11 = _loc_10.split("|");
                        _loc_12 = UserObj.getInstance().playerInfo.job;
                        _loc_13 = _loc_11[(_loc_12 - 1)];
                        _loc_14 = ItemCfgObj.getInstance().getCfgBy(_loc_13);
                        _loc_9.num = _loc_13;
                        _loc_15 = param2.q_transfer;
                        if (_loc_15 != "")
                        {
                            _loc_15 = _loc_15.replace(/{|}/g, "");
                            _loc_19 = _loc_15.split("_");
                            _loc_20 = uint(_loc_19[1]);
                            _loc_21 = MapCfgObj.getInstance().getMap(_loc_20);
                            param1.text1 = LanguageCfgObj.getInstance().getByIndex("12219") + " <u><a href =\'event:transfer\'><font color=\'#00ff00\'>" + _loc_21.mapName + "</font>";
                        }
                        break;
                    }
                    case 11:
                    {
                        _loc_10 = _loc_7[1];
                        _loc_11 = _loc_10.split("|");
                        _loc_12 = UserObj.getInstance().playerInfo.job;
                        _loc_13 = _loc_11[(_loc_12 - 1)];
                        _loc_14 = ItemCfgObj.getInstance().getCfgBy(_loc_13);
                        _loc_9.num = _loc_13;
                        _loc_16 = LanguageCfgObj.getInstance().getByIndex("11290");
                        param1.text1 = param1.text1 + (_loc_16 + " <u><a href =\'event:" + _loc_9.toString() + "\'><font color=\'#00ff00\'>" + _loc_14.q_name + "</font>");
                        break;
                    }
                    case 24:
                    {
                        _loc_13 = _loc_7[1];
                        _loc_14 = ItemCfgObj.getInstance().getCfgBy(_loc_13);
                        _loc_9 = new TaskCoordVO();
                        _loc_9.autoFind = int(param2.q_bool_Pathfinding);
                        _loc_9.taskId = param2.q_taskid;
                        _loc_9.num = _loc_13;
                        _loc_9.type = 0;
                        _loc_9.kind = param2.q_task_type;
                        _loc_9.id = _loc_7[0];
                        param1.text1 = param1.text1 + ("<font color=\'#ffd47f\'>" + LanguageCfgObj.getInstance().getByIndex("12220") + "</font><u><a href =\'event:" + _loc_9.toString() + "\'><font color=\'#00ff00\'>" + _loc_14.q_name + "</font></a></u>");
                        break;
                    }
                    default:
                    {
                        _loc_17 = _loc_7[1];
                        _loc_18 = 0;
                        for each (_loc_22 in TaskGlobal.cfg_else)
                        {
                            
                            if (_loc_22.id == _loc_8)
                            {
                                _loc_16 = _loc_22.label;
                                if (_loc_16.indexOf("{x}") != -1)
                                {
                                    _loc_16 = _loc_16.replace("{x}", _loc_17) + "(" + _loc_18 + "/" + _loc_17 + ")";
                                }
                                else
                                {
                                    _loc_16 = _loc_16 + _loc_17 + "(" + _loc_18 + "/" + _loc_17 + ")";
                                }
                                param1.text1 = param1.text1 + ("<font color=\'#00ff00\'>" + _loc_16 + "</font>");
                            }
                        }
                        break;
                        break;
                    }
                }
                _loc_5++;
            }
            return;
        }// end function

    }
}
