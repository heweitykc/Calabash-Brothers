package com.cfg.obj
{
    import com.cfg.vo.*;
    import com.f1.manager.*;
    import com.model.*;
    import flash.utils.*;

    public class TaskCfgObj extends Object
    {
        private var _mainTaskMap:Object;
        private var _dailyTaskMap:Object;
        private var _dailyRewardMap:Object;
        private var _extraRewardMap:Object;
        private var _changejobMap:Object;
        private var _dailyMonsterMap:Object;
        private var _guideMap:Object;
        private var _guideTaskDic:Dictionary;
        private var _guideTaskItemDic:Dictionary;
        private var _activeGuideMap:Object;
        private var _chapterMap:Object;
        private var _dialogTalkMap:Object;
        private var _gameGuideMap:Object;
        private var _dialogTalkDic:Dictionary;
        private var _taskActive:Dictionary;
        private var _levelActive:Dictionary;
        private var _teamActive:Dictionary;
        public var gameExpGuide:Array;
        public var gameMoneyGuide:Array;
        private static var instance:TaskCfgObj;

        public function TaskCfgObj()
        {
            var _loc_1:* = null;
            this._mainTaskMap = CfgManager.getInstance().getMap("q_task_main");
            this._dailyTaskMap = CfgManager.getInstance().getMap("q_task_daily_cond");
            this._dailyRewardMap = CfgManager.getInstance().getMap("q_task_daily_rewards");
            this._extraRewardMap = CfgManager.getInstance().getMap("q_task_extra_rewards");
            this._changejobMap = CfgManager.getInstance().getMap("q_task_changejob");
            this._guideMap = CfgManager.getInstance().getMap("q_guide");
            this._activeGuideMap = CfgManager.getInstance().getMap("q_active");
            this._chapterMap = CfgManager.getInstance().getMap("q_chapter");
            this._dialogTalkMap = CfgManager.getInstance().getMap("q_dialog");
            this._gameGuideMap = CfgManager.getInstance().getMap("q_game_guide");
            this._dailyMonsterMap = CfgManager.getInstance().getMap("q_task_daily_monster");
            for (_loc_1 in this._changejobMap)
            {
                
                this._mainTaskMap[_loc_1] = _loc_3[_loc_1];
                this._mainTaskMap[_loc_1]["q_type"] = 6;
            }
            this.initGuideTask();
            this.initDialogTalkMap();
            this.initActiveConfig();
            this.initGameGuide();
            return;
        }// end function

        private function initGameGuide() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            this.gameExpGuide = [];
            this.gameMoneyGuide = [];
            for each (_loc_1 in this._gameGuideMap)
            {
                
                _loc_2 = int(_loc_1.q_id);
                if (_loc_2 >= 2000 && _loc_2 <= 2999)
                {
                    this.gameExpGuide.push(_loc_1);
                    continue;
                }
                if (_loc_2 >= 3000 && _loc_2 <= 3999)
                {
                    this.gameMoneyGuide.push(_loc_1);
                }
            }
            this.gameExpGuide.sortOn("q_id", Array.NUMERIC);
            this.gameExpGuide.sortOn("q_id", Array.NUMERIC);
            return;
        }// end function

        private function initGuideTask() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            this._guideTaskDic = new Dictionary();
            this._guideTaskItemDic = new Dictionary();
            for each (_loc_1 in this._guideMap)
            {
                
                if (_loc_1.q_content_id != "" && _loc_1.q_content_id != "0")
                {
                    _loc_4 = _loc_1.q_content_id.split(";");
                    for each (_loc_3 in _loc_4)
                    {
                        
                        this._guideTaskDic[_loc_3 + "_" + _loc_1.q_id] = _loc_1;
                    }
                }
            }
            return;
        }// end function

        private function initDialogTalkMap() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            this._dialogTalkDic = new Dictionary();
            for each (_loc_2 in this._dialogTalkMap)
            {
                
                _loc_1 = new QDialog();
                _loc_1.parse(_loc_2);
                if (!this._dialogTalkDic[_loc_1.team])
                {
                    this._dialogTalkDic[_loc_1.team] = [];
                }
                if (this._dialogTalkDic[_loc_1.team].length < _loc_1.index)
                {
                    this._dialogTalkDic[_loc_1.team].length = _loc_1.index - 1;
                }
                this._dialogTalkDic[_loc_1.team][(_loc_1.index - 1)] = _loc_1;
            }
            return;
        }// end function

        private function initActiveConfig() : void
        {
            var _loc_1:* = null;
            this._taskActive = new Dictionary();
            this._levelActive = new Dictionary();
            this._teamActive = new Dictionary();
            for each (_loc_1 in this._activeGuideMap)
            {
                
                this._teamActive[_loc_1.q_guide_team_id] = _loc_1;
                if (_loc_1.q_taskid != "" && _loc_1.q_taskid != "0")
                {
                    this._taskActive[_loc_1.q_taskid] = _loc_1;
                }
                if (_loc_1.q_level != "" && _loc_1.q_level != "0")
                {
                    this._levelActive[_loc_1.q_taskid] = _loc_1;
                }
            }
            return;
        }// end function

        public function getTaskById(param1:int, param2:int = 0) : Object
        {
            switch(param2)
            {
                case 0:
                {
                    return this._mainTaskMap[param1];
                }
                case 1:
                {
                    return this._dailyTaskMap[param1];
                }
                default:
                {
                    break;
                }
            }
            return null;
        }// end function

        public function get mainTask() : Object
        {
            return this._mainTaskMap;
        }// end function

        public function getDailyTask(param1:int) : Object
        {
            return this._dailyTaskMap[param1];
        }// end function

        public function getDailyReward(param1:int) : Object
        {
            return this._dailyRewardMap[param1];
        }// end function

        public function chapterMap() : Object
        {
            return this._chapterMap;
        }// end function

        public function getExtraReward(param1:int) : Object
        {
            return this._extraRewardMap[param1];
        }// end function

        public function getExtraRewardByLevel(param1:int) : Object
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            for (_loc_2 in this._extraRewardMap)
            {
                
                _loc_3 = _loc_6[_loc_2].q_mingrade;
                _loc_4 = _loc_6[_loc_2].q_maxgrade;
                if (param1 > _loc_3 && _loc_3 <= _loc_4)
                {
                    return _loc_6[_loc_2];
                }
            }
            return null;
        }// end function

        public function getGuideConfig(param1:String) : Object
        {
            return this._guideMap[param1];
        }// end function

        public function getActiveConfig(param1:int) : Object
        {
            if (this._taskActive)
            {
                return this._taskActive[param1];
            }
            return null;
        }// end function

        public function getActiveConfigByLevel(param1:int) : Object
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._levelActive)
            {
                
                if (int(_loc_2.q_level) == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function getActiveConfigByLevelArray(param1:int) : Array
        {
            var _loc_2:* = null;
            var _loc_3:* = [];
            for each (_loc_2 in this._levelActive)
            {
                
                if (int(_loc_2.q_level) <= param1)
                {
                    _loc_3.push(_loc_2);
                }
            }
            return _loc_3;
        }// end function

        public function getActiveConfigByTeam(param1:String) : Object
        {
            if (this._teamActive)
            {
                return this._teamActive[param1];
            }
            return null;
        }// end function

        public function getOpenLevelByTeam(param1:String) : int
        {
            var _loc_2:* = this.getActiveConfigByTeam(param1);
            return _loc_2 ? (_loc_2.q_level) : (0);
        }// end function

        public function getForceButtonByLevel() : Array
        {
            var _loc_2:* = null;
            var _loc_1:* = [];
            var _loc_3:* = UserObj.getInstance().playerInfo.level;
            for each (_loc_2 in this._activeGuideMap)
            {
                
                if (_loc_3 >= int(_loc_2.q_force_limit) && int(_loc_2.q_force_limit) != 999)
                {
                    _loc_1.push(_loc_2);
                }
            }
            return _loc_1;
        }// end function

        public function getGuideConfigByTaskId(param1:int, param2:int, param3:String) : Object
        {
            if (param2 == 2 || param2 == 1 && this._guideTaskDic[param1 + "_" + param2 + "_" + param3] == null)
            {
                return this._guideTaskDic[param1 + "_" + 0 + "_" + param3];
            }
            return this._guideTaskDic[param1 + "_" + param2 + "_" + param3];
        }// end function

        public function getDialogTalkByTeam(param1:int) : Array
        {
            return this._dialogTalkDic[param1];
        }// end function

        public function getDailyMonsterByIndex(param1:int) : Object
        {
            return this._dailyMonsterMap[param1];
        }// end function

        public static function getInstance() : TaskCfgObj
        {
            if (instance == null)
            {
                instance = new TaskCfgObj;
            }
            return instance;
        }// end function

    }
}
