package com.game.task.control
{
    import __AS3__.vec.*;
    import com.adobe.serialization.json.*;
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.*;
    import com.game.map.control.*;
    import com.game.map.view.topbtnspanel.*;
    import com.game.task.bean.*;
    import com.game.task.model.*;
    import com.model.vo.*;

    public class DailyTaskMsgParseController extends Object
    {

        public function DailyTaskMsgParseController()
        {
            return;
        }// end function

        public static function parse(param1:DailyTaskInfo, param2:int) : DailyTaskMsgVO
        {
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_3:* = new DailyTaskMsgVO();
            var _loc_4:* = TaskCfgObj.getInstance().getDailyTask(param1.premiseId);
            var _loc_5:* = "";
            _loc_5 = "" + killMonsterLimit(_loc_3, _loc_4.q_end_needkillmonster, param1.permiseMonster, param1.monsterIndex, param1.premiseId);
            _loc_5 = _loc_5 + goodsLimit(_loc_4.q_end_needgoods, param1.permiseGoods);
            _loc_5 = _loc_5 + achieveLimit(_loc_4.q_end_needachieve, param1.permiseAchieve);
            _loc_3.target = _loc_5;
            _loc_3.hard = int(_loc_4.q_hard);
            _loc_3.data = param1;
            _loc_3.acceptNum = param2;
            _loc_3.taskId = param1.premiseId;
            var _loc_6:* = TaskCfgObj.getInstance().getDailyReward(param1.jlId);
            if (TaskCfgObj.getInstance().getDailyReward(param1.jlId))
            {
                _loc_3.rich = _loc_6.q_rich;
                _loc_3.exp = _loc_6.q_rewards_exp;
                _loc_3.coin = _loc_6.q_rewards_coin;
                _loc_3.zq = _loc_6.q_rewards_zq;
                _loc_3.prestige = _loc_6.q_rewards_prestige;
                _loc_3.bindyuanbao = _loc_6.q_rewards_bindyuanbao;
                _loc_5 = _loc_6.q_rewards_goods ? (_loc_6.q_rewards_goods) : ("");
                _loc_7 = _loc_5.split(";");
                _loc_3.rewards = new Vector.<String>;
                _loc_8 = 0;
                while (_loc_8 < _loc_7.length)
                {
                    
                    _loc_3.rewards.push(_loc_7[_loc_8]);
                    _loc_8++;
                }
            }
            _loc_3.extra = TaskCfgObj.getInstance().getExtraReward(param1.otherjlId);
            TaskModel.getInstance().dailyAccTime = param2;
            if (_loc_3.complete)
            {
                MapControl.getInstance().showNormalEffect(TopActivateName.TOP_ICON_DAILY_TASK, true);
            }
            else
            {
                MapControl.getInstance().showNormalEffect(TopActivateName.TOP_ICON_DAILY_TASK, false);
            }
            return _loc_3;
        }// end function

        private static function killMonsterLimit(param1:DailyTaskMsgVO, param2:String, param3:Vector.<TaskAttribute>, param4:int, param5:int) : String
        {
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            if (!param2)
            {
                return "";
            }
            var _loc_6:* = "";
            var _loc_7:* = TaskCfgObj.getInstance().getDailyMonsterByIndex(param4);
            if (TaskCfgObj.getInstance().getDailyMonsterByIndex(param4))
            {
                _loc_8 = new TaskCoordVO();
                _loc_8.taskId = param5;
                _loc_8.id = int(_loc_7.q_monster);
                _loc_8.type = 2;
                _loc_8.num = int(param2);
                _loc_8.mapId = int(_loc_7.q_map);
                _loc_8.x = int(_loc_7.q_x);
                _loc_8.y = int(_loc_7.q_y);
                _loc_9 = 0;
                _loc_10 = 0;
                while (_loc_10 < param3.length)
                {
                    
                    if (param3[_loc_10].model == _loc_8.id)
                    {
                        _loc_9 = param3[_loc_10].num;
                    }
                    _loc_10++;
                }
                param1.actionMsg = _loc_8;
                if (_loc_9 >= _loc_8.num)
                {
                    param1.complete = true;
                }
                else
                {
                    param1.complete = false;
                }
                _loc_11 = MapCfgObj.getInstance().getMap(int(_loc_7.q_map));
                _loc_12 = "<u><a href=\'event:openMAP\'><font color = \'#ffff99\'>" + _loc_11.mapName + "</font></a></u>";
                _loc_6 = LanguageCfgObj.getInstance().getByIndex("11291");
                _loc_13 = MonsterCfgObj.getInstance().getMonsterCfg(_loc_8.id);
                _loc_6 = _loc_6 + ("<u><a href =\'event:" + _loc_8.toString() + "\'><font color=\'#00ff00\'>" + _loc_13.q_name + "</font></a></u><font color=\'#fff100\'>(" + _loc_9 + "/" + _loc_8.num + ")</font>");
            }
            return _loc_6;
        }// end function

        private static function goodsLimit(param1:String, param2:Vector.<TaskAttribute>) : String
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_15:* = null;
            var _loc_16:* = null;
            if (!param1)
            {
                return "";
            }
            var _loc_3:* = LanguageCfgObj.getInstance().getByIndex("11292");
            var _loc_4:* = param1.split(";");
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4.length)
            {
                
                _loc_6 = _loc_4[_loc_5];
                _loc_7 = _loc_6.split("_");
                _loc_8 = int(_loc_7[0]);
                _loc_9 = int(_loc_7[1]);
                _loc_10 = int(_loc_7[2]);
                _loc_11 = int(_loc_7[3]);
                _loc_12 = int(_loc_7[4]);
                _loc_13 = 0;
                _loc_14 = 0;
                while (_loc_14 < param2.length)
                {
                    
                    if (param2[_loc_14].model == _loc_8)
                    {
                        _loc_13 = param2[_loc_14].num;
                    }
                    _loc_14++;
                }
                _loc_15 = ItemCfgObj.getInstance().getCfgBy(_loc_8);
                _loc_16 = JSON.encode({id:_loc_8, num:_loc_9, map:_loc_10, x:_loc_11, y:_loc_12});
                _loc_3 = _loc_3 + ("<u><a href =\'event:" + _loc_16 + "\'><font color=\'#00ff00\'>" + _loc_15.q_name + "</font></a></u>(" + _loc_13 + "/" + _loc_9 + ") ");
                _loc_5++;
            }
            return _loc_3;
        }// end function

        private static function achieveLimit(param1:String, param2:Vector.<int>) : String
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            if (!param1)
            {
                return "";
            }
            var _loc_3:* = LanguageCfgObj.getInstance().getByIndex("11293");
            var _loc_4:* = param1.split(";");
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4.length)
            {
                
                _loc_6 = _loc_4[_loc_5];
                _loc_7 = _loc_6.split("_");
                _loc_8 = int(_loc_7[0]);
                _loc_9 = 0;
                _loc_10 = 0;
                while (_loc_10 < param2.length)
                {
                    
                    if (param2[_loc_10] == _loc_8)
                    {
                    }
                    _loc_10++;
                }
                _loc_11 = "acv";
                _loc_3 = _loc_3 + ("<u><a href =\'event:" + _loc_11 + "\'><font color=\'#00ff00\'>" + _loc_8 + "</font></a></u> ");
                _loc_5++;
            }
            return _loc_3;
        }// end function

    }
}
