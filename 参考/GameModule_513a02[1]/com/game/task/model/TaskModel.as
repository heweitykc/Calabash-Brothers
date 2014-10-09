package com.game.task.model
{
    import __AS3__.vec.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.guide.control.*;
    import com.game.guide.model.*;
    import com.game.guide.view.*;
    import com.game.map.control.*;
    import com.game.map.model.*;
    import com.game.map.view.topbtnspanel.*;
    import com.game.role.control.*;
    import com.game.role.model.*;
    import com.game.task.*;
    import com.game.task.bean.*;
    import com.game.task.control.*;
    import com.game.task.events.*;
    import com.game.task.message.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.utils.*;

    public class TaskModel extends Object
    {
        private var cheptersMap:Dictionary;
        private var cheptersTaskNum:Vector.<int>;
        private var allTaskMap:Object;
        public var mutishow:Boolean;
        private var _chepter:int;
        private var has_show_daily_icon:Boolean;
        private var _mainItemDatas:Vector.<TaskMsgVO>;
        private var _dailyItemDatas:Vector.<DailyTaskMsgVO>;
        private var _dailyAccTime:int;
        private const TASK_TYPE_SORT:Array;
        private static var _instance:TaskModel;

        public function TaskModel()
        {
            this._mainItemDatas = new Vector.<TaskMsgVO>;
            this._dailyItemDatas = new Vector.<DailyTaskMsgVO>;
            this.TASK_TYPE_SORT = [1, 2, 6, 5];
            return;
        }// end function

        public function taskNumByChepter(param1:int) : int
        {
            if (!this.cheptersTaskNum)
            {
                this.getAllTaskCfg();
            }
            return this.cheptersTaskNum[param1];
        }// end function

        public function taskProcess(param1:int) : int
        {
            var _loc_7:* = null;
            var _loc_2:* = TaskCfgObj.getInstance().getTaskById(param1);
            var _loc_3:* = this.getAllTaskByChapter(_loc_2.q_chapter);
            var _loc_4:* = _loc_3[param1] as TaskItemVO;
            var _loc_5:* = 0;
            while (_loc_4.preTaskId != 0)
            {
                
                _loc_7 = _loc_3[_loc_4.preTaskId] as TaskItemVO;
                if (!_loc_7)
                {
                    break;
                }
                _loc_4 = _loc_7;
                _loc_5++;
            }
            var _loc_6:* = _loc_5 / this.taskNumByChepter(_loc_2.q_chapter);
            return _loc_5 / this.taskNumByChepter(_loc_2.q_chapter) * 100;
        }// end function

        public function getAllTaskByChapter(param1:int) : Object
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (this.cheptersMap && this.cheptersMap[param1])
            {
                return this.cheptersMap[param1];
            }
            var _loc_2:* = this.getAllTaskCfg();
            var _loc_3:* = {};
            for (_loc_4 in _loc_2)
            {
                
                _loc_5 = this.allTaskMap[_loc_4] as TaskItemVO;
                if (int(_loc_5.data.q_chapter) == param1 && _loc_5.data.q_taskid.charAt(0) == "1")
                {
                    _loc_3[_loc_4] = _loc_5;
                }
            }
            if (!this.cheptersMap)
            {
                this.cheptersMap = new Dictionary();
            }
            this.cheptersMap[param1] = _loc_3;
            return _loc_3;
        }// end function

        public function getAllTaskCfg() : Object
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            if (this.allTaskMap)
            {
                return this.allTaskMap;
            }
            this.allTaskMap = {};
            var _loc_1:* = TaskCfgObj.getInstance().mainTask;
            this.cheptersTaskNum = new Vector.<int>(10);
            for (_loc_2 in _loc_1)
            {
                
                _loc_3 = _loc_1[_loc_2];
                _loc_4 = new TaskItemVO();
                _loc_4.data = _loc_3;
                _loc_4.taskId = int(_loc_2);
                _loc_5 = _loc_4.data.q_next_task;
                if (!_loc_5)
                {
                    continue;
                }
                _loc_6 = _loc_5.split(";");
                _loc_4.nextTaskIdList = this.Vector.<int>(_loc_6);
                this.allTaskMap[_loc_2] = _loc_4;
                _loc_7 = _loc_3.q_chapter;
                (this.cheptersTaskNum[_loc_7] + 1);
            }
            for (_loc_2 in this.allTaskMap)
            {
                
                _loc_4 = _loc_12[_loc_2] as TaskItemVO;
                if (_loc_4.nextTaskIdList.length != 0)
                {
                    _loc_8 = 0;
                    while (_loc_8 < _loc_4.nextTaskIdList.length)
                    {
                        
                        _loc_9 = _loc_4.nextTaskIdList[_loc_8];
                        _loc_10 = _loc_12[_loc_9] as TaskItemVO;
                        if (_loc_10)
                        {
                            _loc_10.preTaskId = _loc_4.taskId;
                        }
                        _loc_8++;
                    }
                }
            }
            return this.allTaskMap;
        }// end function

        public function getPretaskList(param1:int) : Vector.<TaskItemVO>
        {
            var _loc_6:* = null;
            var _loc_2:* = TaskCfgObj.getInstance().getTaskById(param1);
            var _loc_3:* = this.getAllTaskByChapter(_loc_2.q_chapter);
            var _loc_4:* = new Vector.<TaskItemVO>;
            var _loc_5:* = _loc_3[param1] as TaskItemVO;
            if (_loc_3[param1] as TaskItemVO)
            {
                while (_loc_5.preTaskId != 0)
                {
                    
                    _loc_6 = _loc_3[_loc_5.preTaskId] as TaskItemVO;
                    if (!_loc_6)
                    {
                        break;
                    }
                    _loc_5 = _loc_6;
                    _loc_4.push(_loc_5);
                }
            }
            _loc_4 = _loc_4.reverse();
            return _loc_4;
        }// end function

        public function getPreTaskId(param1:int) : int
        {
            var _loc_2:* = TaskCfgObj.getInstance().getTaskById(param1);
            var _loc_3:* = this.getAllTaskCfg();
            var _loc_4:* = _loc_3[param1] as TaskItemVO;
            return (_loc_4).preTaskId;
        }// end function

        public function updateResTaskListMessage(param1:ResTaskListMessage) : void
        {
            if (TaskGlobal.TEST_MODEL)
            {
                var _loc_2:* = 0.1;
                TaskGlobal.AUTO_VIP_GUIDE_CLICK = 0.1;
                TaskGlobal.AUTO_SKILL_AWARD_OK = _loc_2;
                TaskGlobal.AUTO_ITEM_AWARD_OK = _loc_2;
                TaskGlobal.AUTO_EQUIP_AWARD_OK = _loc_2;
                TaskGlobal.AUTO_CLICK_TASK_OK_CD = _loc_2;
                TaskGlobal.AUTO_FIND_PATH_CD = _loc_2;
            }
            NpcControl.getInstance().init();
            if (param1.DailyTask.length > 0)
            {
                this.mutishow = true;
            }
            if (param1.mainTask.length > 1)
            {
                this.mutishow = true;
            }
            if (param1.mainTask.length > 0 && param1.mainTask[0].modelId == Params.FIRST_MAIN_TASK_ID)
            {
                WelcomePageControl.getInstance().showWelcome();
            }
            this._mainItemDatas = new Vector.<TaskMsgVO>;
            this._dailyItemDatas = new Vector.<DailyTaskMsgVO>;
            this.parseMainTask(param1.mainTask);
            TaskModel.getInstance().dailyAccTime = param1.daylyTaskacceptcount;
            this.parseDailyTask(param1.DailyTask, param1.daylyTaskacceptcount);
            this.parseTreasureHuntTask(param1.treasureHuntTask);
            this.parseConquerTask(param1.conqueryTask, param1.conquerTaskAcceptCount, param1.conquerTaskAcceptMaxCount);
            GuideControl.getInstance().taskStopPath();
            this._mainItemDatas.sort(this.sortOfTask);
            if (this._mainItemDatas && this._mainItemDatas.length)
            {
                this._chepter = this._mainItemDatas[0].conf.q_chapter;
            }
            this.updateNpcTaskMap();
            if (this._dailyItemDatas.length)
            {
                this.showDailyIcon(true);
            }
            if (this._mainItemDatas.length > 0)
            {
                TaskGlobal.task = this._mainItemDatas[0];
            }
            GuideConfigObj.getInstance().fixTaskConfig();
            TaskGlobal.myEvt.dispatchEvt(new TaskEvent("add", TaskEvent.TASK_LIST_UPDATE));
            FrameworkGlobal.sendMsg(new TaskEvent("add", TaskEvent.TASK_LIST_UPDATE));
            if (param1.mainTask.length && param1.mainTask[0].modelId != Params.FIRST_MAIN_TASK_ID)
            {
                TaskGlobal.manager.setAutoTask(true);
            }
            return;
        }// end function

        private function parseMainTask(param1:Vector.<MainTaskInfo>) : void
        {
            var _loc_4:* = null;
            if (!param1 || param1.length == 0)
            {
                return;
            }
            var _loc_2:* = param1.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = this.parseMainTaskItem(param1[_loc_3]);
                this._mainItemDatas.push(_loc_4);
                _loc_3++;
            }
            return;
        }// end function

        public function updateNpcTaskMap() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            for (_loc_1 in NpcData.getInstance().taskMap)
            {
                
                delete _loc_8[_loc_1];
            }
            _loc_2 = this._mainItemDatas.length;
            _loc_3 = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = this._mainItemDatas[_loc_3];
                _loc_5 = TaskCfgObj.getInstance().getTaskById(_loc_4.taskId);
                if (_loc_5 && _loc_4.complete)
                {
                    _loc_6 = String(_loc_5.q_endnpc);
                    if (_loc_6 && _loc_6 != "")
                    {
                        _loc_8[_loc_6] = _loc_4;
                    }
                }
                _loc_3++;
            }
            return;
        }// end function

        protected function parseMainTaskItem(param1:MainTaskInfo) : TaskMsgVO
        {
            var _loc_2:* = TaskCfgObj.getInstance().getTaskById(param1.modelId);
            if (!_loc_2)
            {
                Log.error("任务" + param1.modelId + "没有在q_task_main.xsl里面配置");
                return null;
            }
            var _loc_3:* = _loc_2.q_task_type;
            var _loc_4:* = MainTaskMsgParseController.parse(param1, _loc_2, _loc_3);
            if (!MainTaskMsgParseController.parse(param1, _loc_2, _loc_3))
            {
                return null;
            }
            if (_loc_4.complete)
            {
                FrameworkGlobal.sendMsg(new TaskEvent(_loc_4, TaskEvent.COMPLETE_TASK));
                TaskGlobal.manager.autoSubmitTask(_loc_4);
            }
            TaskGlobal.task = _loc_4;
            return _loc_4;
        }// end function

        public function get chepter() : int
        {
            return this._chepter;
        }// end function

        private function parseDailyTask(param1:Vector.<DailyTaskInfo>, param2:int) : void
        {
            var _loc_5:* = null;
            if (!param1 || param1.length == 0)
            {
                return;
            }
            var _loc_3:* = param1.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = DailyTaskMsgParseController.parse(param1[_loc_4], param2);
                this._dailyItemDatas.push(_loc_5);
                _loc_4++;
            }
            return;
        }// end function

        private function parseConquerTask(param1:Vector.<ConquerTaskInfo>, param2:int, param3:int) : void
        {
            return;
        }// end function

        private function parseTreasureHuntTask(param1:Vector.<TreasureHuntTaskInfo>) : void
        {
            return;
        }// end function

        public function updateDailyTaskListMessage(param1:ResDailyTaskChangeMessage) : void
        {
            var _loc_2:* = DailyTaskMsgParseController.parse(param1.task, param1.daylyTaskacceptcount);
            var _loc_3:* = this._dailyItemDatas.length;
            this._dailyItemDatas[0] = _loc_2;
            TaskGlobal.myEvt.dispatchEvt(new TaskEvent(_loc_2, TaskEvent.DAILY_TASK_CHANGE));
            this.mutishow = true;
            TaskGlobal.myEvt.dispatchEvt(new TaskEvent(this._mainItemDatas, TaskEvent.PANEL_UI_CHANGE));
            if (this._dailyItemDatas.length)
            {
                this.showDailyIcon(true);
            }
            return;
        }// end function

        private function showDailyIcon(param1:Boolean) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (param1)
            {
                if (!this.has_show_daily_icon)
                {
                    if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().DAILY_TASK_ACTIVE_TEAM)) != 0)
                    {
                        MapControl.getInstance().addedToTopIcon(TopActivateName.TOP_ICON_DAILY_TASK);
                        this.has_show_daily_icon = true;
                        _loc_3 = LanguageCfgObj.getInstance().getByIndex("11329");
                        MapControl.getInstance().topActivateBtnTips(TopActivateName.TOP_ICON_DAILY_TASK, _loc_3);
                    }
                }
                _loc_2 = TaskGlobal.DAILY_TASK_MAX_RANGE - this._dailyItemDatas[0].acceptNum + 1;
                MapControl.getInstance().topActivateSetCountText(TopActivateName.TOP_ICON_DAILY_TASK, _loc_2.toString());
            }
            else
            {
                MapControl.getInstance().removeFromTopIcon(TopActivateName.TOP_ICON_DAILY_TASK);
                this.has_show_daily_icon = false;
            }
            return;
        }// end function

        public function resTaskFinshMessage(param1:ResTaskFinshMessage) : void
        {
            var _loc_4:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_2:* = param1.type;
            var _loc_3:* = param1.modelId;
            if (_loc_2 == 2)
            {
                if (this._dailyItemDatas.length)
                {
                    if (this._dailyItemDatas[0].data.premiseId == _loc_3)
                    {
                        if (this._dailyItemDatas[0].acceptNum == TaskGlobal.DAILY_TASK_MAX_RANGE)
                        {
                            this._dailyItemDatas.length = 0;
                            this.showDailyIcon(false);
                            TaskGlobal.myEvt.dispatchEvt(new TaskEvent("day_over", TaskEvent.TASK_LIST_UPDATE));
                            return;
                        }
                    }
                }
                this._dailyItemDatas.length = 0;
                TaskGlobal.myEvt.dispatchEvt(new TaskEvent("day_change", TaskEvent.TASK_LIST_UPDATE));
            }
            else
            {
                _loc_7 = this._mainItemDatas.length;
                _loc_8 = 0;
                while (_loc_8 < _loc_7)
                {
                    
                    _loc_9 = this._mainItemDatas[_loc_8];
                    if (_loc_9 && _loc_9.taskId == _loc_3)
                    {
                        _loc_4 = _loc_9;
                        this._mainItemDatas.splice(_loc_8, 1);
                        FrameworkGlobal.sendMsg(new TaskEvent(_loc_3, TaskEvent.DELETE_COMPLETE_TASK));
                        break;
                    }
                    _loc_8++;
                }
            }
            if (param1.modelId == TaskGlobal.FIRST_GET_WING)
            {
                GuideGetFirstWing.getInstance().open();
            }
            var _loc_5:* = MapObj.getInstance().mapID;
            var _loc_6:* = MapCfgObj.getInstance().getMap(_loc_5);
            if (_loc_6.zones_type != 0 && _loc_4 && int(_loc_4.conf.q_task_type) == TaskGlobal.TASK_ELSE && _loc_4.actionMsg && (_loc_4.actionMsg.id == 10 || _loc_4.actionMsg.id == 29))
            {
                TaskGlobal.isChangeSceneContinueTask = true;
            }
            this.updateNpcTaskMap();
            FrameworkGlobal.sendMsg(new TaskEvent("over", TaskEvent.TASK_LIST_UPDATE));
            TaskGlobal.myEvt.dispatchEvt(new TaskEvent(_loc_3, TaskEvent.TASK_LIST_UPDATE));
            return;
        }// end function

        public function updateResMainTaskMessage(param1:ResMainTaskChangeMessage) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = this._mainItemDatas.length;
            var _loc_3:* = false;
            var _loc_5:* = this.parseMainTaskItem(param1.task);
            if (!this.parseMainTaskItem(param1.task))
            {
                return;
            }
            TaskGlobal.task = _loc_5;
            var _loc_6:* = 0;
            while (_loc_6 < _loc_2)
            {
                
                _loc_4 = this._mainItemDatas[_loc_6];
                if (_loc_4 && _loc_4.taskId == param1.task.modelId)
                {
                    _loc_3 = true;
                    this._mainItemDatas[_loc_6] = _loc_5;
                    break;
                }
                _loc_6++;
            }
            var _loc_7:* = null;
            if (_loc_5.complete)
            {
                if (_loc_5.conf.q_task_type == "4")
                {
                    TaskGlobal.manager.autoFight(false);
                }
                if ((_loc_5.conf.q_task_type == "2" || _loc_5.conf.q_task_type == "3") && String(_loc_5.conf.q_taskid).charAt(0) != "6")
                {
                    if (int(_loc_5.conf.q_bool_Pathfinding) == 0)
                    {
                        TaskGlobal.manager.continueTask(TaskGlobal.task, false);
                    }
                }
                else if (_loc_5.conf.q_taskid != "60000" && _loc_5.conf.q_taskid != "61000")
                {
                    TaskGlobal.manager.continueTask(TaskGlobal.task, false);
                }
                TaskGlobal.manager.autoFinish();
                _loc_7 = "compete";
            }
            if (_loc_5.conf.q_task_type == "1")
            {
                this._chepter = _loc_5.conf.q_chapter;
            }
            if (_loc_3)
            {
                _loc_6 = 0;
                while (_loc_6 < this._mainItemDatas.length)
                {
                    
                    if (_loc_4.taskId == _loc_5.taskId)
                    {
                        this._mainItemDatas[_loc_6] = _loc_5;
                        if (_loc_5.complete)
                        {
                            this._mainItemDatas.sort(this.sortOfTask);
                        }
                        TaskGlobal.myEvt.dispatchEvt(new TaskEvent(_loc_5, TaskEvent.TASK_ITEM_UPDATE));
                        break;
                    }
                    _loc_6++;
                }
            }
            else
            {
                this._mainItemDatas.push(_loc_5);
                this._mainItemDatas.sort(this.sortOfTask);
                TaskGlobal.myEvt.dispatchEvt(new TaskEvent(_loc_5, TaskEvent.GET_NEW_TASK));
                FrameworkGlobal.sendMsg(new TaskEvent(_loc_5, TaskEvent.ACCEPT_TASK));
                TaskGlobal.manager.getNewTask(_loc_5);
                _loc_7 = "add";
            }
            _loc_2 = this._mainItemDatas.length;
            if (_loc_2 > 1)
            {
                this.mutishow = true;
                TaskGlobal.myEvt.dispatchEvt(new TaskEvent(this._mainItemDatas, TaskEvent.PANEL_UI_CHANGE));
            }
            this.updateNpcTaskMap();
            if (_loc_7)
            {
                FrameworkGlobal.sendMsg(new TaskEvent(_loc_7, TaskEvent.TASK_LIST_UPDATE));
            }
            return;
        }// end function

        public function get dailyTaskList() : Vector.<DailyTaskMsgVO>
        {
            return this._dailyItemDatas;
        }// end function

        public function get dailyAccTime() : int
        {
            return this._dailyAccTime;
        }// end function

        public function set dailyAccTime(param1:int) : void
        {
            this._dailyAccTime = param1;
            return;
        }// end function

        public function get mainTaskList() : Vector.<TaskMsgVO>
        {
            return this._mainItemDatas;
        }// end function

        public function curChangeJobTask() : int
        {
            var _loc_1:* = 0;
            var _loc_2:* = TaskGlobal.CHANGE_JOB_TASK_TOTAL;
            if (_loc_2 == null)
            {
                return 0;
            }
            var _loc_3:* = 0;
            while (_loc_3 < this._mainItemDatas.length)
            {
                
                if (_loc_2.indexOf(this._mainItemDatas[_loc_3].taskId) != -1)
                {
                    _loc_1 = this._mainItemDatas[_loc_3].taskId;
                }
                _loc_3++;
            }
            return _loc_1;
        }// end function

        public function curChangeJobLevel() : int
        {
            var _loc_1:* = TaskGlobal.CHANGE_JOB_LEVEL1;
            var _loc_2:* = 0;
            while (_loc_1 && _loc_2 < this._mainItemDatas.length)
            {
                
                if (_loc_1.indexOf(this._mainItemDatas[_loc_2].taskId) != -1)
                {
                    return 1;
                }
                _loc_2++;
            }
            var _loc_3:* = TaskGlobal.CHANGE_JOB_LEVEL2;
            _loc_2 = 0;
            while (_loc_3 && _loc_2 < this._mainItemDatas.length)
            {
                
                if (_loc_3.indexOf(this._mainItemDatas[_loc_2].taskId) != -1)
                {
                    return 2;
                }
                _loc_2++;
            }
            var _loc_4:* = TaskGlobal.CHANGE_JOB_LEVEL3;
            _loc_2 = 0;
            while (_loc_4 && _loc_2 < this._mainItemDatas.length)
            {
                
                if (_loc_4.indexOf(this._mainItemDatas[_loc_2].taskId) != -1)
                {
                    return 3;
                }
                _loc_2++;
            }
            var _loc_5:* = TaskGlobal.CHANGE_JOB_LEVEL4;
            _loc_2 = 0;
            while (_loc_5 && _loc_2 < this._mainItemDatas.length)
            {
                
                if (_loc_5.indexOf(this._mainItemDatas[_loc_2].taskId) != -1)
                {
                    return 4;
                }
                _loc_2++;
            }
            return 0;
        }// end function

        public function curChangeJobTaskLevel() : int
        {
            var _loc_1:* = 0;
            var _loc_2:* = this.curChangeJobTask();
            if (_loc_2)
            {
                _loc_1 = UserObj.getInstance().playerInfo.jobkind;
            }
            return _loc_1;
        }// end function

        public function getTaskItemById(param1:int) : TaskMsgVO
        {
            var _loc_2:* = 0;
            while (_loc_2 < this._mainItemDatas.length)
            {
                
                if (this._mainItemDatas[_loc_2] && this._mainItemDatas[_loc_2].taskId == param1)
                {
                    return this._mainItemDatas[_loc_2];
                }
                _loc_2++;
            }
            return null;
        }// end function

        private function sortOfTask(param1:TaskVO, param2:TaskVO) : Number
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            if (param1 && param2)
            {
                _loc_3 = this.TASK_TYPE_SORT.indexOf(param1.type);
                _loc_4 = this.TASK_TYPE_SORT.indexOf(param2.type);
                if (_loc_3 != _loc_4)
                {
                    return _loc_3 - _loc_4;
                }
                if (param1.complete != param2.complete)
                {
                    if (param1.complete)
                    {
                        return -1;
                    }
                    return 1;
                }
                return param2.taskId - param1.taskId;
            }
            return 0;
        }// end function

        public function resetParse() : void
        {
            var _loc_3:* = null;
            var _loc_1:* = this._mainItemDatas.length;
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = this._mainItemDatas[_loc_2];
                this._mainItemDatas[_loc_2] = MainTaskMsgParseController.parse(_loc_3.taskInfo, _loc_3.conf, _loc_3.conf.q_task_type);
                _loc_2++;
            }
            this.updateNpcTaskMap();
            TaskGlobal.myEvt.dispatchEvt(new TaskEvent(this._mainItemDatas, TaskEvent.TASK_LIST_UPDATE));
            FrameworkGlobal.sendMsg(new TaskEvent("all", TaskEvent.TASK_LIST_UPDATE));
            return;
        }// end function

        public static function getInstance() : TaskModel
        {
            var _loc_1:* = new TaskModel;
            _instance = new TaskModel;
            return _instance || _loc_1;
        }// end function

    }
}
