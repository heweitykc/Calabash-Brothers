package com.game.task.control
{
    import __AS3__.vec.*;
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.f1.utils.cue.*;
    import com.game.role.util.*;
    import com.game.task.*;
    import com.game.task.bean.*;
    import com.game.task.model.*;
    import com.model.*;
    import com.model.vo.*;
    import com.util.*;

    public class MainTaskMsgParseController extends Object
    {

        public function MainTaskMsgParseController()
        {
            return;
        }// end function

        private function getTaskNeed(param1:String) : Object
        {
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_2:* = param1.replace(/"/g, "");
            var _loc_3:* = _loc_2.split(";");
            var _loc_4:* = {};
            var _loc_5:* = 0;
            while (_loc_5 < _loc_3.length)
            {
                
                _loc_6 = _loc_3[_loc_5].toString().split("_");
                _loc_7 = _loc_6[0];
                _loc_8 = _loc_6[1];
                _loc_4[_loc_7] = _loc_8;
                _loc_5++;
            }
            return _loc_4;
        }// end function

        public static function replace(param1:String) : String
        {
            var _loc_2:* = UserObj.getInstance().playerInfo;
            param1 = param1.replace(/\{xxx\}/g, _loc_2.name);
            if (_loc_2.sex == 0)
            {
                param1 = param1.replace(/\{insted:1\}/g, "哥");
                param1 = param1.replace(/\{insted:2\}/g, "弟弟");
            }
            else
            {
                param1 = param1.replace(/\{insted:1\}/g, "姐");
                param1 = param1.replace(/\{insted:2\}/g, "妹妹");
            }
            return param1;
        }// end function

        public static function parseTask(param1:Object) : TaskMsgVO
        {
            var _loc_2:* = new TaskMsgVO();
            param1.q_task_desc = replace(param1.q_task_desc);
            param1.q_start_chat = replace(param1.q_start_chat);
            param1.q_task_desc2 = replace(param1.q_task_desc2);
            CompleteTaskParse.parse(_loc_2, param1);
            commonParse(_loc_2, true, null, param1);
            _loc_2.rewarded = true;
            _loc_2.complete = true;
            return _loc_2;
        }// end function

        public static function parse(param1:MainTaskInfo, param2:Object, param3:int) : TaskMsgVO
        {
            var _loc_4:* = null;
            param2.q_task_desc = replace(param2.q_task_desc);
            param2.q_start_chat = replace(param2.q_start_chat);
            param2.q_task_desc2 = replace(param2.q_task_desc2);
            switch(param3)
            {
                case TaskGlobal.TASK_TALK:
                {
                    _loc_4 = paserTaskType1(param1, param2);
                    break;
                }
                case TaskGlobal.TASK_KILL:
                {
                    _loc_4 = paserTaskType2(param1, param2);
                    break;
                }
                case TaskGlobal.TASK_DROP:
                {
                    _loc_4 = paserTaskType3(param1, param2);
                    break;
                }
                case TaskGlobal.TASK_GATHER:
                {
                    _loc_4 = paserTaskType4(param1, param2);
                    break;
                }
                case TaskGlobal.TASK_SEND:
                {
                    _loc_4 = paserTaskType5(param1, param2);
                    break;
                }
                case TaskGlobal.TASK_EFFECT:
                {
                    _loc_4 = paserTaskType6(param1, param2);
                    break;
                }
                case TaskGlobal.TASK_STRONG:
                case TaskGlobal.TASK_STRONG2:
                {
                    _loc_4 = paserTaskType7(param1, param2);
                    break;
                }
                case TaskGlobal.TASK_ELSE:
                {
                    _loc_4 = paserTaskType8(param1, param2);
                    break;
                }
                case TaskGlobal.TASK_EQUIPMENT:
                {
                    _loc_4 = paserTaskType13(param1, param2);
                    break;
                }
                case TaskGlobal.TASK_COLLECT:
                {
                    _loc_4 = paserTaskType11(param1, param2);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_4;
        }// end function

        public static function paserTaskType1(param1:MainTaskInfo, param2:Object) : TaskMsgVO
        {
            var _loc_3:* = new TaskMsgVO();
            var _loc_4:* = NpcCfgObj.getInstance().getNpcByID(param2.q_endnpc);
            if (!NpcCfgObj.getInstance().getNpcByID(param2.q_endnpc))
            {
                Log.error("任务ID：" + param1.modelId + "q_endnpc" + param2.q_endnpc + "找不到");
                return null;
            }
            var _loc_5:* = new TaskCoordVO();
            _loc_5.autoFind = int(param2.q_bool_Pathfinding);
            _loc_5.taskId = param2.q_taskid;
            _loc_5.id = _loc_4._npcId;
            _loc_5.type = 0;
            _loc_5.kind = 1;
            _loc_5.mapId = _loc_4._map;
            _loc_5.x = _loc_4._x;
            _loc_5.y = _loc_4._y;
            var _loc_6:* = _loc_5.toString();
            _loc_3.actionMsg = _loc_5;
            _loc_3.text1 = "<font color=\'#ffd47f\'>" + LanguageCfgObj.getInstance().getByIndex("12212") + "</font><u><a href =\'event:" + _loc_6 + "\'><font color=\'#00FF00\'>" + _loc_4._npcName + "</font></a></u>";
            _loc_3.taskUnComExtraDes = getExtraDesShow(param2);
            commonParse(_loc_3, true, param1, param2);
            return _loc_3;
        }// end function

        public static function paserTaskType2(param1:MainTaskInfo, param2:Object) : TaskMsgVO
        {
            var _loc_6:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = 0;
            var _loc_15:* = 0;
            var _loc_16:* = 0;
            var _loc_17:* = 0;
            var _loc_18:* = 0;
            var _loc_19:* = null;
            var _loc_20:* = 0;
            var _loc_21:* = 0;
            var _loc_22:* = null;
            var _loc_3:* = new TaskMsgVO();
            var _loc_4:* = param2.q_end_need_killmonster;
            var _loc_5:* = _loc_4.replace(/"/g, "");
            var _loc_7:* = false;
            var _loc_8:* = param1.permiseMonster;
            if (_loc_5.indexOf("|") != -1)
            {
                _loc_6 = _loc_5.split("|");
                _loc_3.text1 = LanguageCfgObj.getInstance().getByIndex("11298");
                _loc_14 = -1;
                _loc_15 = -1;
                _loc_16 = 0;
                while (_loc_16 < _loc_8.length)
                {
                    
                    if (_loc_14 < _loc_8[_loc_16].num)
                    {
                        _loc_14 = _loc_8[_loc_16].num;
                        _loc_15 = _loc_16;
                    }
                    _loc_16++;
                }
                if (_loc_15 == -1)
                {
                    if (_loc_6.length == 0)
                    {
                        throw "任务" + param2.q_taskid + "忘记配置怪物信息了！";
                    }
                    _loc_13 = new TaskCoordVO();
                    _loc_13.autoFind = int(param2.q_bool_Pathfinding);
                    _loc_13.type = 0;
                    _loc_13.kind = 2;
                    _loc_13.parse(_loc_6[0]);
                    _loc_13.taskId = param2.q_taskid;
                }
                else
                {
                    _loc_16 = 0;
                    while (_loc_16 < _loc_6.length)
                    {
                        
                        _loc_9 = new TaskCoordVO();
                        _loc_9.autoFind = int(param2.q_bool_Pathfinding);
                        _loc_9.type = 0;
                        _loc_9.kind = 2;
                        _loc_9.parse(_loc_6[_loc_16]);
                        _loc_9.taskId = param2.q_taskid;
                        if (_loc_9.id == _loc_8[_loc_15].model)
                        {
                            _loc_13 = _loc_9;
                            break;
                        }
                        _loc_16++;
                    }
                }
                if (_loc_13)
                {
                    _loc_10 = MapCfgObj.getInstance().getMap(_loc_13.mapId);
                    _loc_11 = "<u><a href=\'event:openMAP\'><font color = \'#ffff99\'>" + _loc_10.mapName + "</font></a></u>";
                    _loc_17 = _loc_14 == -1 ? (0) : (_loc_14);
                    _loc_3.actionMsg = _loc_13;
                    _loc_12 = _loc_13.toString();
                    if (_loc_17 < _loc_13.num)
                    {
                        if (param2.q_remarks && param2.q_remarks != "")
                        {
                            _loc_3.text1 = param2.q_remarks + "<font color=\'#fff100\'>(" + _loc_17 + "/" + _loc_13.num + ")</font>";
                        }
                        else
                        {
                            _loc_3.text1 = _loc_3.text1 + ("<u><a href =\'event:" + _loc_12 + "\'><font color=\'#00ff00\'>BOSS</font></a></u><font color=\'#fff100\'>(" + _loc_17 + "/" + _loc_13.num + ")</font>");
                        }
                    }
                    else if (param2.q_remarks && param2.q_remarks != "")
                    {
                        _loc_3.text1 = param2.q_remarks + "(" + _loc_17 + "/" + _loc_13.num + ")";
                    }
                    else
                    {
                        _loc_3.text1 = _loc_3.text1 + ("<font color=\'#00ff00\'><u><a href =\'event:" + _loc_12 + "\'>BOSS</a></u>(" + _loc_17 + "/" + _loc_13.num + ")</font>");
                    }
                    if (_loc_17 == _loc_13.num)
                    {
                        _loc_7 = true;
                    }
                }
                _loc_3.taskUnComExtraDes = getExtraDesShow(param2);
            }
            else
            {
                _loc_6 = _loc_5.split(";");
                _loc_3.text1 = LanguageCfgObj.getInstance().getByIndex("11298");
                _loc_18 = 0;
                while (_loc_18 < _loc_6.length)
                {
                    
                    _loc_9 = new TaskCoordVO();
                    _loc_9.autoFind = int(param2.q_bool_Pathfinding);
                    _loc_9.type = 0;
                    _loc_9.kind = 2;
                    _loc_9.taskId = param2.q_taskid;
                    _loc_9.parse(_loc_6[_loc_18]);
                    _loc_10 = MapCfgObj.getInstance().getMap(_loc_9.mapId);
                    _loc_11 = "<u><a href=\'event:openMAP\'><font color = \'#ffff99\'>" + _loc_10.mapName + "</font></a></u>";
                    if (!_loc_9.id)
                    {
                        throw "任务" + _loc_9.taskId + "忘记配置怪物了！";
                    }
                    _loc_19 = MonsterCfgObj.getInstance().getMonsterCfg(_loc_9.id);
                    _loc_20 = 0;
                    if (_loc_8.length)
                    {
                        _loc_7 = true;
                    }
                    _loc_21 = 0;
                    while (_loc_21 < _loc_8.length)
                    {
                        
                        _loc_22 = _loc_8[_loc_21];
                        if (_loc_22.model == _loc_9.id)
                        {
                            _loc_20 = _loc_22.num;
                            if (_loc_20 < _loc_9.num)
                            {
                                _loc_7 = false;
                            }
                            break;
                        }
                        _loc_21++;
                    }
                    _loc_3.actionMsg = _loc_9;
                    _loc_12 = _loc_9.toString();
                    if (_loc_20 < _loc_9.num)
                    {
                        if (param2.q_remarks && param2.q_remarks != "")
                        {
                            _loc_3.text1 = param2.q_remarks + "<font color=\'#fff100\'>(" + _loc_20 + "/" + _loc_9.num + ")</font>";
                        }
                        else
                        {
                            _loc_3.text1 = _loc_3.text1 + ("<u><a href =\'event:" + _loc_12 + "\'><font color=\'#00ff00\'>" + _loc_19.q_name + "</font></a></u><font color=\'#fff100\'>(" + _loc_20 + "/" + _loc_9.num + ")</font>");
                        }
                    }
                    else if (param2.q_remarks && param2.q_remarks != "")
                    {
                        _loc_3.text1 = param2.q_remarks + "(" + _loc_20 + "/" + _loc_9.num + ")";
                    }
                    else
                    {
                        _loc_3.text1 = _loc_3.text1 + ("<font color=\'#00ff00\'><u><a href =\'event:" + _loc_12 + "\'>" + _loc_19.q_name + "</a></u>(" + _loc_20 + "/" + _loc_9.num + ")</font>");
                    }
                    _loc_3.taskUnComExtraDes = getExtraDesShow(param2);
                    _loc_18++;
                }
                if (param2.q_remarks == "")
                {
                    _loc_3.text1 = _loc_3.text1 + "</font>";
                }
            }
            commonParse(_loc_3, _loc_7, param1, param2);
            return _loc_3;
        }// end function

        public static function paserTaskType3(param1:MainTaskInfo, param2:Object) : TaskMsgVO
        {
            var _loc_13:* = null;
            var _loc_21:* = null;
            var _loc_3:* = new TaskMsgVO();
            var _loc_4:* = false;
            var _loc_5:* = param1.permiseGoods;
            var _loc_6:* = param2.q_end_resume_goods;
            _loc_6 = _loc_6.replace(/"/g, "");
            _loc_6 = _loc_6.replace("!", "");
            var _loc_7:* = _loc_6.substring(0, (_loc_6.indexOf("{") - 1));
            var _loc_8:* = _loc_7.split("_");
            _loc_6 = _loc_6.substring((_loc_6.indexOf("{") + 1), (_loc_6.length - 1));
            var _loc_9:* = _loc_6.split(";");
            var _loc_10:* = LanguageCfgObj.getInstance().getByIndex("11300");
            var _loc_11:* = UserObj.getInstance().playerInfo.level;
            var _loc_12:* = [];
            var _loc_14:* = 0;
            while (_loc_14 < _loc_9.length)
            {
                
                _loc_13 = parseStr(_loc_9[_loc_14]);
                if (_loc_13.list.length >= 6)
                {
                    if (int(_loc_13.list[4]) > _loc_11 || int(_loc_13.list[5]) < _loc_11)
                    {
                        ;
                    }
                }
                _loc_12.push(_loc_13);
                _loc_14++;
            }
            if (_loc_12.length == 0)
            {
                Log.error("任务ID" + param1.modelId + "   q_end_resume_goods  字段没有配  " + _loc_11 + "  级的怪物");
            }
            _loc_13 = _loc_12[Math.floor(_loc_12.length * Math.random())];
            var _loc_15:* = new TaskCoordVO();
            _loc_15.autoFind = int(param2.q_bool_Pathfinding);
            _loc_15.type = 0;
            _loc_15.kind = 3;
            _loc_15.taskId = param2.q_taskid;
            _loc_15.mapId = _loc_13.list[0];
            _loc_15.x = _loc_13.list[1];
            _loc_15.y = _loc_13.list[2];
            var _loc_16:* = _loc_13.list[3];
            _loc_15.id = _loc_16;
            var _loc_17:* = MonsterCfgObj.getInstance().getMonsterCfg(_loc_16);
            if (!MonsterCfgObj.getInstance().getMonsterCfg(_loc_16))
            {
                Log.error("任务ID" + _loc_15.taskId + "找不到怪物配置ID" + _loc_16);
            }
            var _loc_18:* = ItemCfgObj.getInstance().getCfgBy(_loc_8[0]);
            var _loc_19:* = 0;
            if (_loc_5.length)
            {
                _loc_4 = true;
            }
            var _loc_20:* = 0;
            while (_loc_20 < _loc_5.length)
            {
                
                _loc_21 = _loc_5[_loc_20];
                if (_loc_21.model == _loc_8[0])
                {
                    _loc_19 = _loc_21.num;
                    if (_loc_19 < _loc_8[1])
                    {
                        _loc_4 = false;
                    }
                    break;
                }
                _loc_20++;
            }
            _loc_3.actionMsg = _loc_15;
            _loc_10 = _loc_10 + ("<u><a href =\'event:" + _loc_15.toString() + "\'><font color=\'#00ff00\'>" + _loc_17.q_name + "</font></a></u>\n");
            if (_loc_19 < _loc_15.num)
            {
                _loc_10 = _loc_10 + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12232"), ["<font color=\'#00ff00\'>" + _loc_18.q_name + "</font>(" + _loc_19 + "/" + _loc_8[1] + ")"]);
            }
            else
            {
                _loc_10 = _loc_10 + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12232"), ["<font color=\'#00ff00\'>" + _loc_18.q_name + "</font>(" + _loc_19 + "/" + _loc_8[1] + ")"]);
            }
            _loc_10 = _loc_10 + "</font>";
            _loc_3.text1 = _loc_10;
            _loc_3.taskUnComExtraDes = getExtraDesShow(param2);
            commonParse(_loc_3, _loc_4, param1, param2);
            return _loc_3;
        }// end function

        public static function paserTaskType4(param1:MainTaskInfo, param2:Object) : TaskMsgVO
        {
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = 0;
            var _loc_3:* = new TaskMsgVO();
            var _loc_4:* = false;
            var _loc_5:* = param2.q_collection_target;
            var _loc_6:* = NpcCfgObj.getInstance().getNpcByID(param2.q_collection_target);
            var _loc_7:* = _loc_6._acquisition_item;
            var _loc_8:* = ItemCfgObj.getInstance().getCfgBy(_loc_7);
            var _loc_9:* = param2.q_end_resume_goods;
            _loc_9 = _loc_9.replace(/"/g, "");
            _loc_9 = _loc_9.replace("!", "");
            var _loc_10:* = _loc_9.split(";");
            var _loc_11:* = new TaskCoordVO();
            _loc_11.autoFind = int(param2.q_bool_Pathfinding);
            _loc_11.type = 0;
            _loc_11.kind = 4;
            _loc_11.taskId = param2.q_taskid;
            _loc_11.id = _loc_5;
            _loc_11.mapId = _loc_6._map;
            _loc_11.x = _loc_6._x;
            _loc_11.y = _loc_6._y;
            _loc_3.actionMsg = _loc_11;
            _loc_3.text1 = "<font color=\'#ffd47f\'>采集：</font><u><a href =\'event:" + _loc_11.toString() + "\'><font color=\'#00ff00\'>" + _loc_6._npcName + "</font></a></u>";
            var _loc_12:* = param1.permiseGoods;
            if (_loc_12.length)
            {
                _loc_4 = true;
            }
            var _loc_13:* = 0;
            while (_loc_13 < _loc_12.length)
            {
                
                _loc_14 = parseStr(_loc_10[_loc_13]);
                _loc_15 = _loc_12[_loc_13];
                _loc_16 = ItemCfgObj.getInstance().getCfgBy(_loc_15.model);
                _loc_17 = _loc_16.q_name;
                _loc_18 = 13421823;
                if (_loc_15.num < _loc_14.num)
                {
                    _loc_4 = false;
                }
                _loc_3.text1 = _loc_3.text1 + ("(" + _loc_15.num + "/" + _loc_14.num + ")");
                _loc_13++;
            }
            _loc_3.taskUnComExtraDes = getExtraDesShow(param2);
            commonParse(_loc_3, _loc_4, param1, param2);
            return _loc_3;
        }// end function

        public static function paserTaskType5(param1:MainTaskInfo, param2:Object) : TaskMsgVO
        {
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            var _loc_15:* = 0;
            var _loc_16:* = 0;
            var _loc_17:* = null;
            var _loc_18:* = null;
            var _loc_3:* = new TaskMsgVO();
            var _loc_4:* = false;
            _loc_3.text1 = LanguageCfgObj.getInstance().getByIndex("11301");
            var _loc_5:* = param1.permiseGoods;
            var _loc_6:* = param2.q_end_resume_goods.replace(/"/g, "");
            _loc_6 = _loc_6.replace("!", "");
            var _loc_7:* = _loc_6.split(";");
            var _loc_8:* = "";
            var _loc_9:* = 0;
            while (_loc_9 < _loc_7.length)
            {
                
                _loc_11 = String(_loc_7[_loc_9]).split("_", 2);
                _loc_12 = _loc_11[0];
                _loc_13 = _loc_11[1];
                _loc_14 = ItemCfgObj.getInstance().getCfgBy(_loc_12);
                _loc_15 = 0;
                if (_loc_5.length)
                {
                    _loc_4 = true;
                }
                _loc_16 = 0;
                while (_loc_16 < _loc_5.length)
                {
                    
                    _loc_17 = _loc_5[_loc_9];
                    if (_loc_17.model == _loc_12)
                    {
                        _loc_15 = _loc_17.num;
                        if (_loc_15 < _loc_13)
                        {
                            _loc_4 = false;
                        }
                        break;
                    }
                    _loc_16++;
                }
                if (_loc_14)
                {
                    if (_loc_15 < _loc_13)
                    {
                        _loc_8 = _loc_8 + ("<font color=\'#00ff00\'>" + _loc_14.q_name + "</font>");
                    }
                    else
                    {
                        _loc_8 = _loc_8 + ("<font color=\'#00ff00\'>" + _loc_14.q_name + "</font>");
                    }
                }
                _loc_9++;
            }
            var _loc_10:* = NpcCfgObj.getInstance().getNpcByID(param2.q_endnpc);
            if (NpcCfgObj.getInstance().getNpcByID(param2.q_endnpc))
            {
                _loc_18 = new TaskCoordVO();
                _loc_18.autoFind = int(param2.q_bool_Pathfinding);
                _loc_18.type = 0;
                _loc_18.kind = 5;
                _loc_18.taskId = param1.modelId;
                _loc_18.id = _loc_10._npcModelId;
                _loc_18.x = _loc_10._x;
                _loc_18.y = _loc_10._y;
                _loc_18.mapId = _loc_10._map;
                _loc_3.text1 = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12216"), [_loc_8, "<u><a href =\'event:" + _loc_18.toString() + "\'><font color=\'#00ff00\'>" + _loc_10._npcName + "</font></a></u>"]);
                _loc_3.taskUnComExtraDes = getExtraDesShow(param2);
                _loc_3.actionMsg = _loc_18;
                commonParse(_loc_3, _loc_4, param1, param2);
            }
            return _loc_3;
        }// end function

        public static function paserTaskType11(param1:MainTaskInfo, param2:Object) : TaskMsgVO
        {
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = null;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_15:* = null;
            var _loc_3:* = new TaskMsgVO();
            var _loc_4:* = false;
            _loc_3.text1 = LanguageCfgObj.getInstance().getByIndex("11302");
            var _loc_5:* = param1.permiseGoods;
            var _loc_6:* = param2.q_end_resume_goods.replace(/"/g, "");
            _loc_6 = _loc_6.replace("!", "");
            var _loc_7:* = _loc_6.split(";");
            var _loc_8:* = 0;
            while (_loc_8 < _loc_7.length)
            {
                
                _loc_9 = String(_loc_7[_loc_8]).split("_", 2);
                _loc_10 = _loc_9[0];
                _loc_11 = _loc_9[1];
                _loc_12 = ItemCfgObj.getInstance().getCfgBy(_loc_10);
                _loc_13 = 0;
                if (_loc_5.length)
                {
                    _loc_4 = true;
                }
                _loc_14 = 0;
                while (_loc_14 < _loc_5.length)
                {
                    
                    _loc_15 = _loc_5[_loc_8];
                    if (_loc_15.model == _loc_10)
                    {
                        _loc_13 = _loc_15.num;
                        if (_loc_13 < _loc_11)
                        {
                            _loc_4 = false;
                        }
                        break;
                    }
                    _loc_14++;
                }
                if (_loc_12)
                {
                    if (param2.q_remarks && param2.q_remarks != "")
                    {
                        _loc_3.text1 = param2.q_remarks + "<font color=\'#00ff00\'>(" + _loc_13 + "/" + _loc_11 + ")</font>";
                    }
                    else
                    {
                        _loc_3.text1 = _loc_3.text1 + ("<font color=\'#00ff00\'>" + _loc_12.q_name + "(" + _loc_13 + "/" + _loc_11 + ")</font>");
                    }
                }
                _loc_8++;
            }
            _loc_3.complete = _loc_4;
            _loc_3.taskUnComExtraDes = getExtraDesShow(param2);
            commonParse(_loc_3, _loc_3.complete, param1, param2);
            return _loc_3;
        }// end function

        public static function paserTaskType6(param1:MainTaskInfo, param2:Object) : TaskMsgVO
        {
            var _loc_3:* = new TaskMsgVO();
            var _loc_4:* = true;
            _loc_3.text1 = LanguageCfgObj.getInstance().getByIndex("11303");
            _loc_3.taskUnComExtraDes = getExtraDesShow(param2);
            commonParse(_loc_3, _loc_4, param1, param2);
            return _loc_3;
        }// end function

        public static function paserTaskType7(param1:MainTaskInfo, param2:Object) : TaskMsgVO
        {
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            var _loc_15:* = false;
            var _loc_16:* = 0;
            var _loc_17:* = 0;
            var _loc_18:* = 0;
            var _loc_19:* = 0;
            var _loc_20:* = null;
            var _loc_21:* = 0;
            var _loc_22:* = 0;
            var _loc_23:* = null;
            var _loc_24:* = null;
            var _loc_25:* = null;
            var _loc_26:* = null;
            var _loc_3:* = new TaskMsgVO();
            var _loc_4:* = true;
            var _loc_5:* = param1.permiseStrong;
            var _loc_6:* = param2.q_end_need_qianghua;
            var _loc_7:* = _loc_6.replace(/"/g, "");
            var _loc_8:* = _loc_7.split(";");
            _loc_3.text1 = LanguageCfgObj.getInstance().getByIndex("11304");
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            while (_loc_10 < _loc_8.length)
            {
                
                _loc_11 = String(_loc_8[_loc_10]).split("_");
                _loc_12 = int(_loc_11[0]);
                _loc_13 = int(_loc_11[2]);
                _loc_14 = String(_loc_11[1]).split("|");
                _loc_15 = false;
                _loc_16 = -1;
                _loc_17 = -1;
                _loc_18 = -1;
                _loc_19 = 0;
                while (_loc_19 < _loc_14.length)
                {
                    
                    _loc_20 = new TaskCoordVO();
                    _loc_20.autoFind = int(param2.q_bool_Pathfinding);
                    _loc_20.type = 0;
                    _loc_20.kind = 7;
                    _loc_20.taskId = param2.q_taskid;
                    _loc_20.id = _loc_14[_loc_19];
                    _loc_20.num = _loc_13;
                    _loc_20.x = _loc_12;
                    _loc_20.y = _loc_12;
                    _loc_3.actionMsg = _loc_20;
                    _loc_21 = 0;
                    while (_loc_21 < _loc_5.length)
                    {
                        
                        _loc_22 = _loc_14[_loc_19] == -1 ? (_loc_12) : (_loc_14[_loc_19]);
                        if (_loc_5[_loc_21].model == _loc_22)
                        {
                            if (_loc_5[_loc_21].num < _loc_13)
                            {
                            }
                            else
                            {
                                _loc_15 = true;
                                break;
                            }
                        }
                        _loc_21++;
                    }
                    _loc_19++;
                }
                if (!_loc_15)
                {
                    _loc_4 = false;
                }
                else
                {
                    break;
                }
                if (param2.q_remarks != "")
                {
                    if (_loc_13 != -1)
                    {
                        _loc_3.text1 = param2.q_remarks + "<font color=\'#fff100\'>(" + _loc_5[0].num + "/" + _loc_13 + ")</font>";
                    }
                    else
                    {
                        _loc_3.text1 = param2.q_remarks;
                    }
                    break;
                }
                else if (_loc_14[0] != -1)
                {
                    if (_loc_13 != -1)
                    {
                        _loc_23 = _loc_14[0] + "_" + _loc_13;
                        _loc_24 = EquipStrengCfgObj.getInstance().getEquipStrenginfoByLev(_loc_23);
                        _loc_25 = PropUtil.createItemByCfg(_loc_24.q_item_id, 0, 0, 0, null);
                        if (!_loc_24)
                        {
                            SimpleTip.show("收到装备强化任务，没有该装备的强化配置信息" + _loc_23 + "请找策划", 6000);
                        }
                        else
                        {
                            if (_loc_9 != 0)
                            {
                                _loc_3.text1 = _loc_3.text1 + "\n";
                            }
                            _loc_26 = PropUtil.getEquipNameAndColor(_loc_25);
                            _loc_3.text1 = _loc_3.text1 + ("<u><a href =\'event:" + _loc_20.toString() + "\'><font color=\'" + _loc_26[1] + "\'>" + _loc_26[0] + "</font></a></u><font color=\'#00ff00\'>(" + _loc_5[0].num + "/" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11817"), [_loc_13]) + ")</font>");
                        }
                    }
                    else
                    {
                        _loc_25 = PropUtil.createItemByCfg(_loc_14[0], 0, 0, 0, null);
                        if (_loc_9 != 0)
                        {
                            _loc_3.text1 = _loc_3.text1 + "\n";
                        }
                        _loc_26 = PropUtil.getEquipNameAndColor(_loc_25);
                        _loc_3.text1 = _loc_3.text1 + ("<u><a href =\'event:" + _loc_20.toString() + "\'><font color=\'" + _loc_26[1] + "\'>" + _loc_26[0] + "</font></a></u><font color=\'#00ff00\'></font>");
                    }
                    _loc_9++;
                }
                else
                {
                    if (_loc_9 == 2)
                    {
                        _loc_3.text1 = _loc_3.text1 + "\n";
                    }
                    if (_loc_12 == -1)
                    {
                        if (_loc_13 != -1)
                        {
                            _loc_3.text1 = _loc_3.text1 + ("<u><a href =\'event:" + _loc_20.toString() + "\'><font color=\'#00ff00\'>" + LanguageCfgObj.getInstance().getByIndex("12233") + "</font></a></u><font color=\'#00ff00\'>(" + _loc_5[_loc_17].num + "/" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11817"), [_loc_13]) + ")</font>");
                        }
                        else
                        {
                            _loc_3.text1 = _loc_3.text1 + ("<u><a href =\'event:" + _loc_20.toString() + "\'><font color=\'#00ff00\'>" + LanguageCfgObj.getInstance().getByIndex("12233") + "</font></a></u>");
                        }
                        _loc_9++;
                    }
                    else
                    {
                        if (_loc_13 != -1)
                        {
                            _loc_3.text1 = _loc_3.text1 + ("<u><a href =\'event:" + _loc_20.toString() + "\'><font color=\'#00ff00\'>" + PropUtil.getEquipType((_loc_12 + 1)) + "</font></a></u><font color=\'#00ff00\'>+" + _loc_13 + " </font>");
                        }
                        else
                        {
                            _loc_3.text1 = _loc_3.text1 + ("<u><a href =\'event:" + _loc_20.toString() + "\'><font color=\'#00ff00\'>" + PropUtil.getEquipType((_loc_12 + 1)) + "</font></a></u>");
                        }
                        _loc_9++;
                    }
                }
                _loc_10++;
            }
            _loc_3.taskUnComExtraDes = getExtraDesShow(param2);
            commonParse(_loc_3, _loc_4, param1, param2);
            return _loc_3;
        }// end function

        public static function paserTaskType13(param1:MainTaskInfo, param2:Object) : TaskMsgVO
        {
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_3:* = new TaskMsgVO();
            var _loc_4:* = true;
            var _loc_5:* = param1.permiseWear;
            _loc_3.text1 = LanguageCfgObj.getInstance().getByIndex("11304");
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            while (_loc_7 < _loc_5.length)
            {
                
                _loc_8 = new TaskCoordVO();
                _loc_8.autoFind = int(param2.q_bool_Pathfinding);
                _loc_8.type = 0;
                _loc_8.kind = 7;
                _loc_8.taskId = param2.q_taskid;
                _loc_8.id = _loc_5[_loc_7].model;
                _loc_8.num = 1;
                _loc_8.x = 0;
                _loc_8.y = 0;
                _loc_3.actionMsg = _loc_8;
                if (_loc_5[_loc_7].num == 0)
                {
                    _loc_4 = false;
                    _loc_9 = _loc_5[_loc_7].model;
                    _loc_10 = PropUtil.createItemByCfg(_loc_9);
                    _loc_11 = PropUtil.getEquipNameAndColor(_loc_10);
                    _loc_3.text1 = _loc_3.text1 + ("<font color=\'" + _loc_11[1] + "\'>" + _loc_11[0] + "</font><font color=\'#00ff00\'>(" + _loc_5[_loc_7].num + "/" + 1 + ")</font>");
                    if (_loc_7 != (_loc_5.length - 1))
                    {
                        _loc_3.text1 = _loc_3.text1 + "\n";
                    }
                }
                _loc_7++;
            }
            _loc_3.taskUnComExtraDes = getExtraDesShow(param2);
            commonParse(_loc_3, _loc_4, param1, param2);
            return _loc_3;
        }// end function

        public static function paserTaskType8(param1:MainTaskInfo, param2:Object) : TaskMsgVO
        {
            var _loc_3:* = ElseTypeTaskParse.parse(param1, param2);
            _loc_3.taskUnComExtraDes = getExtraDesShow(param2);
            commonParse(_loc_3, _loc_3.complete, param1, param2);
            return _loc_3;
        }// end function

        private static function commonParse(param1:TaskMsgVO, param2:Boolean, param3:MainTaskInfo, param4:Object) : void
        {
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = 0;
            param1.complete = param2;
            param1.data = param3;
            param1.conf = param4;
            param1.taskId = param4.q_taskid;
            param1.label = "<font color=\'#ffffff\'>" + param4.q_name + "</font>";
            param1.levelLimit = param4.q_accept_needmingrade;
            param1.taskInfo = param3;
            param1.type = int(param4.q_type);
            var _loc_5:* = NpcCfgObj.getInstance().getNpcByID(param4.q_endnpc);
            if (NpcCfgObj.getInstance().getNpcByID(param4.q_endnpc))
            {
                _loc_8 = new TaskCoordVO();
                _loc_8.autoFind = int(param4.q_bool_Pathfinding);
                _loc_8.taskId = param4.q_taskid;
                _loc_8.id = _loc_5._npcId;
                _loc_8.x = _loc_5._x;
                _loc_8.y = _loc_5._y;
                _loc_8.mapId = _loc_5._map;
                _loc_8.type = 0;
                _loc_8.kind = param4.q_task_type;
                _loc_9 = MapCfgObj.getInstance().getMap(_loc_5._map);
                _loc_10 = "<u><a href=\'event:openMAP\'><font color = \'#ffff99\'>" + _loc_9.mapName + "</font></a></u>";
                param1.rewardMsg = _loc_8;
                if (param2)
                {
                    param1.label = param1.label + ("<font color=\'#00ff00\'>" + LanguageCfgObj.getInstance().getByIndex("12234") + "</font>");
                    param1.text2 = "<font color=\'#ffd47f\'>" + LanguageCfgObj.getInstance().getByIndex("12236") + "</font><u><a href =\'event:" + _loc_8.toString() + "\'><font color=\'#00ff00\'>" + _loc_5._npcName + "</font></a></u>";
                }
                else
                {
                    param1.label = param1.label + ("<font color=\'#ff0000\'>" + LanguageCfgObj.getInstance().getByIndex("12235") + "</font>");
                    param1.text2 = "<font color=\'#ffd47f\'>" + LanguageCfgObj.getInstance().getByIndex("12237") + "</font><u><a href =\'event:" + _loc_8.toString() + "\'><font color=\'#00ff00\'>" + _loc_5._npcName + "</font></a></u>";
                }
            }
            else
            {
                if (param2)
                {
                    param1.label = param1.label + ("<font color=\'#00ff00\'>" + LanguageCfgObj.getInstance().getByIndex("12234") + "</font>");
                }
                else
                {
                    param1.label = param1.label + ("<font color=\'#ff0000\'>" + LanguageCfgObj.getInstance().getByIndex("12235") + "</font>");
                }
                param1.text2 = "";
            }
            param1.task_disc = param4.q_task_desc;
            var _loc_6:* = param4.q_transfer;
            if (param4.q_transfer != null && _loc_6 != "")
            {
                _loc_6 = _loc_6.replace(/{|}/g, "");
                _loc_11 = _loc_6.split("_");
                param1.transfer = true;
                param1.transMsg = new TaskCoordVO();
                param1.transMsg.autoFind = int(param4.q_bool_Pathfinding);
                param1.transMsg.type = 0;
                param1.transMsg.taskId = param4.q_taskid;
                param1.transMsg.id = param4.q_taskid;
                param1.transMsg.mapId = int(_loc_11[1]);
                param1.transMsg.x = int(_loc_11[2]);
                param1.transMsg.y = int(_loc_11[3]);
                param1.transMsg.num = int(_loc_11[4]);
                param1.transMsg.info = String(_loc_11[0]).substr(1);
            }
            var _loc_7:* = UserObj.getInstance().playerInfo.level;
            if (param1.levelLimit > _loc_7)
            {
                param1.complete = false;
                param1.label = param4.q_name + "<font color=\'#ff0000\'>(" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12238"), [RoleLevelUtil.getMasterLevel(param1.levelLimit)]) + ")</font>";
                param1.text1 = "";
                param1.text2 = "";
                param1.actionMsg = null;
                param1.rewardMsg = null;
                param1.taskUnComExtraDes = "";
                if (param4.q_other_msg)
                {
                    _loc_6 = param4.q_other_msg;
                    _loc_11 = _loc_6.split(";");
                    _loc_12 = Math.random() * _loc_11.length;
                    _loc_6 = _loc_11[_loc_12];
                    _loc_11 = _loc_6.split("_");
                    _loc_13 = new TaskCoordVO();
                    _loc_13.autoFind = int(param4.q_bool_Pathfinding);
                    _loc_13.type = 0;
                    _loc_13.taskId = param4.q_taskid;
                    _loc_13.id = int(_loc_11[0]);
                    _loc_13.mapId = int(_loc_11[1]);
                    _loc_13.x = int(_loc_11[2]);
                    _loc_13.y = int(_loc_11[3]);
                    _loc_13.num = _loc_13.id;
                    _loc_13.info = _loc_6;
                    param1.actionMsg = _loc_13;
                    param1.rewardMsg = _loc_13;
                    _loc_14 = MapCfgObj.getInstance().getMap(_loc_13.mapId);
                    param1.text1 = "<font color=\'#ffd47f\'>" + LanguageCfgObj.getInstance().getByIndex("12239") + "</font><u><a href =\'event:" + _loc_13.toString() + "\'><font color=\'#00ff00\'>" + _loc_14.mapName + "</font></a></u>";
                    param1.taskUnComExtraDes = getExtraDesShow(param4);
                }
            }
            if (param4.hasOwnProperty("q_consume_money"))
            {
                _loc_15 = param4.q_consume_money;
                if (UserObj.getInstance().playerInfo.money < _loc_15)
                {
                    param1.complete = false;
                    param1.text1 = "<font color=\'#00ff00\'>" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12240"), ["<font color=\'#ff0000\'>" + _loc_15 + "</font>"]) + "</font>";
                    param1.text1 = param1.text1 + ("\n" + getExtraDesShow(param4));
                    param1.actionMsg = null;
                    param1.rewardMsg = null;
                }
            }
            return;
        }// end function

        public static function parseStr(param1:String) : Object
        {
            var _loc_7:* = null;
            var _loc_2:* = param1.split("_");
            var _loc_3:* = _loc_2[0];
            var _loc_4:* = _loc_2[1];
            var _loc_5:* = param1.indexOf("{") + 1;
            var _loc_6:* = param1.indexOf("}");
            param1 = param1.substring(_loc_5, _loc_6);
            if (_loc_5 == -1 || _loc_6 == -1)
            {
                _loc_7 = _loc_2;
            }
            else
            {
                _loc_7 = param1.split("_");
            }
            return {id:_loc_3, num:_loc_4, list:_loc_7};
        }// end function

        public static function getExtraDesShow(param1:Object) : String
        {
            if (param1.q_help && param1.q_help != "")
            {
                return param1.q_help;
            }
            return "";
        }// end function

    }
}
