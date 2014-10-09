package com.game.task.mediator
{
    import __AS3__.vec.*;
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.interfaces.ui.list.*;
    import com.f1.ui.image.*;
    import com.f1.utils.*;
    import com.f1.utils.path.*;
    import com.game.autopk.controller.*;
    import com.game.challenge.control.*;
    import com.game.guide.control.*;
    import com.game.guide.event.*;
    import com.game.guide.model.*;
    import com.game.map.control.*;
    import com.game.map.view.topbtnspanel.*;
    import com.game.pray.bean.*;
    import com.game.prey.control.*;
    import com.game.role.*;
    import com.game.task.*;
    import com.game.task.control.*;
    import com.game.task.events.*;
    import com.game.task.model.*;
    import com.game.task.view.*;
    import com.game.utils.*;
    import com.game.vip.control.*;
    import com.game.zones.bean.*;
    import com.game.zones.control.*;
    import com.game.zones.model.*;
    import com.greensock.*;
    import com.model.*;
    import com.staticdata.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.utils.*;

    public class FastTaskMediator extends Object
    {
        private var panel:FastTaskPanel;
        private var taskMap:Dictionary;
        private var selectRender:TaskTextRender;
        private var _rectMon:Object;
        private var _isBelialWorldOver:Boolean = true;
        private var _isScarletHoldOver:Boolean = true;
        private var _isPrayExpOver:Boolean = true;
        private var _isPrayMoneyOver:Boolean = true;

        public function FastTaskMediator(param1:FastTaskPanel)
        {
            this.taskMap = new Dictionary();
            this.panel = param1;
            TaskGlobal.myEvt.addEvtListener(TaskEvent.TASK_LIST_UPDATE, this.upadateTaskList);
            TaskGlobal.myEvt.addEvtListener(TaskEvent.DAILY_TASK_CHANGE, this.onDailyTaskChange);
            TaskGlobal.myEvt.addEvtListener(TaskEvent.TASK_ITEM_UPDATE, this.onMainTaskChange);
            TaskGlobal.myEvt.addEvtListener(TaskEvent.GET_NEW_TASK, this.addNewTask);
            this.upadateTaskList();
            UserObj.getInstance().playerInfo.addEvtListener(RoleEvent.UPDATE_LEVEL, this.onLevelUp);
            UserObj.getInstance().playerInfo.addEvtListener(RoleEvent.UPDATE_MONEY, this.onMoneyUpdate);
            UserObj.getInstance().playerInfo.addEvtListener(RoleEvent.UPDATE_VIP_LEVEL, this.onVIPUpdate);
            return;
        }// end function

        private function onVIPUpdate(event:RoleEvent) : void
        {
            if (VIPControl.getInstance().vipinfo && VIPControl.getInstance().vipinfo.stageLevel == 1 && this.panel && this.panel.mc_shoe && this.panel.parent && this.panel.mc_shoe.visible && TaskGlobal.task)
            {
                BubbleTextControl.getInstance().showBubbleText(this.panel.mc_shoe, TaskGlobal.task.taskId, TaskGlobal.task.complete);
            }
            else
            {
                BubbleTextControl.getInstance().closeBubbleText();
            }
            return;
        }// end function

        private function onLevelUp(event:RoleEvent) : void
        {
            TaskModel.getInstance().resetParse();
            return;
        }// end function

        private function onExpChange(event:RoleEvent) : void
        {
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = false;
            if (UserObj.getInstance().playerInfo.level == Params.MASTER_CHANGE_LEVEL)
            {
                _loc_2 = UserObj.getInstance().playerInfo.exp.toNumber();
                _loc_3 = LevelExpCfgObj.getInstance().getExpByLevel(UserObj.getInstance().playerInfo.job, Params.MASTER_CHANGE_LEVEL);
                _loc_4 = _loc_2 >= _loc_3;
                if (_loc_4)
                {
                    TaskModel.getInstance().resetParse();
                }
            }
            return;
        }// end function

        private function onMoneyUpdate(event:RoleEvent) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_2:* = TaskModel.getInstance().mainTaskList;
            var _loc_3:* = _loc_2.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = _loc_2[_loc_4];
                if (_loc_5.conf && _loc_5.conf.hasOwnProperty("q_consume_money"))
                {
                    _loc_6 = _loc_5.conf.q_consume_money;
                    if (_loc_6 > 0)
                    {
                        TaskModel.getInstance().resetParse();
                        break;
                    }
                }
                _loc_4++;
            }
            return;
        }// end function

        private function upadateTaskList(event:TaskEvent = null) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = TaskModel.getInstance();
            var _loc_3:* = _loc_2.dailyTaskList;
            if (this.panel.taskListContainer)
            {
                this.showTask2();
                this.panel.taskListContainer.updateThumb();
            }
            else
            {
                _loc_4 = _loc_2.mainTaskList;
                if (_loc_4.length)
                {
                    this.showTask1(_loc_4[0]);
                }
            }
            return;
        }// end function

        public function showTask1(param1:TaskMsgVO) : void
        {
            var _loc_7:* = null;
            if (param1 == null)
            {
                return;
            }
            TaskGlobal.task = param1;
            TaskGlobal.currentTask = param1;
            this.panel.txt_title.htmlText = LanguageCfgObj.getInstance().getByIndex("11319");
            if (!param1.conf)
            {
                return;
            }
            this.panel.txt_task_name.htmlText = param1.conf.q_name;
            ItemTips.create(this.panel.txt_task_name, param1.conf, TaskAwardTips);
            this.panel.mc_name.gotoAndStop((int(param1.conf.q_chapter) + 1));
            this.panel.txt_info.text = LanguageCfgObj.getInstance().getByIndex("12243") + TaskModel.getInstance().taskProcess(param1.taskId) + "%";
            var _loc_2:* = TaskCfgObj.getInstance().chapterMap();
            var _loc_3:* = _loc_2[param1.conf.q_chapter];
            var _loc_4:* = Params.OTHER_PATH + _loc_3.q_chapter_icon_big + ".png";
            var _loc_5:* = this.panel.mc_icon.image as Image;
            if ((_loc_5).url != _loc_4)
            {
                _loc_5.load(_loc_4, this.loadComplete);
            }
            this.panel.txt_task_desc.text = param1.conf.q_task_desc;
            this.panel.mc_shoe.addEventListener(MouseEvent.CLICK, this.onFastTrans);
            if (param1.complete)
            {
                this.panel.txt_label1.htmlText = param1.text2;
                this.panel.btn_task_txt.text = LanguageCfgObj.getInstance().getByIndex("11320");
                if (!param1.rewardMsg)
                {
                    this.panel.mc_shoe.visible = false;
                }
                else
                {
                    this.panel.mc_shoe.visible = true;
                }
            }
            else
            {
                this.panel.txt_label1.htmlText = param1.text1;
                this.panel.btn_task_txt.text = LanguageCfgObj.getInstance().getByIndex("11321");
                if (!param1.actionMsg)
                {
                    this.panel.mc_shoe.visible = false;
                }
                else if (param1.conf.q_task_type == "8")
                {
                    this.panel.mc_shoe.visible = false;
                }
                else
                {
                    this.panel.mc_shoe.visible = true;
                }
            }
            this.panel.txt_label1.y = this.panel.txt_task_desc.y + this.panel.txt_task_desc.textHeight + 12;
            var _loc_6:* = this.panel.txt_label1.text;
            if (_loc_6.length > 0)
            {
                _loc_7 = this.panel.txt_label1.getCharBoundaries((_loc_6.length - 1));
                if (_loc_7)
                {
                    this.panel.mc_shoe.x = this.panel.txt_label1.x + _loc_7.x + 15;
                    this.panel.mc_shoe.y = this.panel.txt_label1.y + _loc_7.y - 10;
                }
                else
                {
                    this.panel.mc_shoe.x = this.panel.txt_label1.x + this.panel.txt_label1.textWidth + 4;
                    this.panel.mc_shoe.y = this.panel.txt_label1.y - 8;
                }
            }
            else
            {
                this.panel.mc_shoe.x = this.panel.txt_label1.x + this.panel.txt_label1.textWidth + 4;
                this.panel.mc_shoe.y = this.panel.txt_label1.y - 8;
            }
            if (VIPControl.getInstance().vipinfo && VIPControl.getInstance().vipinfo.stageLevel == 1 && this.panel.mc_shoe.visible)
            {
                BubbleTextControl.getInstance().showBubbleText(this.panel.mc_shoe, param1.taskId, param1.complete);
            }
            else
            {
                BubbleTextControl.getInstance().closeBubbleText();
            }
            if (this.panel.taskListContainer)
            {
                this.panel.taskListContainer.updateThumb();
            }
            return;
        }// end function

        private function loadComplete(param1:BitmapData) : void
        {
            var _loc_2:* = this.panel.mc_icon.image as Image;
            _loc_2.setSize(54, 54);
            return;
        }// end function

        public function goOnTask() : void
        {
            var _loc_1:* = null;
            if (TaskGlobal.currentTask is TaskMsgVO)
            {
                TaskGlobal.manager.continueTask(TaskGlobal.currentTask as TaskMsgVO);
            }
            else if (TaskGlobal.currentTask is DailyTaskMsgVO)
            {
                _loc_1 = TaskGlobal.currentTask as DailyTaskMsgVO;
                TaskLinkEventManager.handle(_loc_1.actionMsg);
            }
            return;
        }// end function

        public function showTask2() : void
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            if (!this.panel.taskListContainer)
            {
                return;
            }
            if (this.panel && this.panel.btn_task)
            {
                GuideControl.getInstance().unregisterGuide(this.panel.btn_task, GuideConfigObj.getInstance().FAST_TASK_BTN_GUIDE_ID);
            }
            this.taskMap = new Dictionary();
            var _loc_1:* = this.panel.taskListContainer.contents;
            var _loc_2:* = this.panel.taskListContainer.thumbBtnPosition;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_1.length)
            {
                
                this.panel.taskListContainer.removeItem(IItem(_loc_1[_loc_3]));
                _loc_3++;
            }
            this.panel.taskListContainer.reset();
            var _loc_4:* = TaskModel.getInstance().mainTaskList;
            var _loc_5:* = _loc_4.length;
            var _loc_6:* = false;
            _loc_3 = 0;
            while (_loc_3 < _loc_5)
            {
                
                if (_loc_4[_loc_3] == null)
                {
                }
                else
                {
                    if (_loc_4[_loc_3].type != 1 && !_loc_6)
                    {
                        _loc_6 = true;
                        this.addDailyTask();
                    }
                    _loc_8 = new TaskTextRender();
                    _loc_8.obj = _loc_4[_loc_3];
                    _loc_7 = TaskGlobal.TASK_TYPE_NAME[_loc_4[_loc_3].type];
                    if (_loc_7)
                    {
                        _loc_9 = _loc_7.name;
                        _loc_10 = _loc_7.color;
                        _loc_11 = "<font color=\'" + _loc_10 + "\'>【" + _loc_9 + "】</font>";
                        if (_loc_4[_loc_3].complete)
                        {
                            _loc_8.setText("<a href =\'event:openMain_" + _loc_4[_loc_3].taskId + "\'>" + _loc_11 + _loc_4[_loc_3].label + "</a>", "<font color=\'#41E7E7\'>" + _loc_4[_loc_3].text2 + "</font>");
                        }
                        else if (_loc_4[_loc_3].text1.length > 0)
                        {
                            _loc_8.setText("<a href =\'event:openMain_" + _loc_4[_loc_3].taskId + "\'>" + _loc_11 + _loc_4[_loc_3].label + "</a>", "<font color=\'#41E7E7\'>" + _loc_4[_loc_3].text1 + "</font>", _loc_4[_loc_3].taskUnComExtraDes);
                        }
                        else
                        {
                            _loc_8.setText("<a href =\'event:openMain_" + _loc_4[_loc_3].taskId + "\'>" + _loc_11 + _loc_4[_loc_3].label + "</a>", "", _loc_4[_loc_3].taskUnComExtraDes);
                        }
                        _loc_8.textTitle.addEventListener(TextEvent.LINK, this.onTitleLinkEvent);
                        _loc_8.textContent.addEventListener(TextEvent.LINK, this.onLinkEvent);
                        this.panel.taskListContainer.add(_loc_8);
                        this.taskMap[_loc_8] = _loc_4[_loc_3];
                        if (_loc_3 == 0)
                        {
                            if (this.selectRender)
                            {
                                this.selectRender.selected = false;
                            }
                            this.selectRender = _loc_8;
                            TaskGlobal.currentTask = _loc_4[_loc_3];
                        }
                    }
                }
                _loc_3++;
            }
            if (!_loc_6)
            {
                _loc_6 = true;
                this.addDailyTask();
            }
            this.panel.taskListContainer.scrollTo(_loc_2);
            this.showGameGuide();
            return;
        }// end function

        private function addDailyTask() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            if (this.selectRender)
            {
                this.selectRender.selected = true;
            }
            var _loc_1:* = TaskModel.getInstance().dailyTaskList;
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1.length)
            {
                
                _loc_3 = new TaskTextRender();
                _loc_3.obj = _loc_1[_loc_2];
                _loc_4 = "<a href =\'event:openDaily\'><font color=\'#AA8A64\'>【" + LanguageCfgObj.getInstance().getByIndex("12244") + "】</font><font color=\'#ffffff\'>" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12245"), [_loc_1[_loc_2].acceptNum, TaskGlobal.DAILY_TASK_MAX_RANGE]) + "</font></a>";
                _loc_5 = new TaskCoordVO();
                _loc_5.id = _loc_1[_loc_2].taskId;
                _loc_5.taskId = _loc_1[_loc_2].taskId;
                _loc_5.type = 2;
                _loc_5.kind = 1;
                _loc_7 = "";
                if (_loc_1[_loc_2].complete)
                {
                    _loc_6 = LanguageCfgObj.getInstance().getByIndex("11322");
                }
                else
                {
                    _loc_6 = "<font color=\'#f6d654\'>" + _loc_1[_loc_2].target + "</font>";
                    _loc_7 = "<u><font color=\'#00c0ff\'><a href =\'event:" + _loc_5.toString() + "\'>" + LanguageCfgObj.getInstance().getByIndex("11307") + "</a></font></u>";
                }
                _loc_3.setText(_loc_4, _loc_6, _loc_7);
                _loc_3.textTitle.addEventListener(TextEvent.LINK, this.onTitleLinkEvent);
                _loc_3.textContent.addEventListener(TextEvent.LINK, this.onLinkEvent);
                this.panel.taskListContainer.add(_loc_3);
                this.taskMap[_loc_3] = _loc_1[_loc_2];
                _loc_2++;
            }
            this.panel.taskListContainer.update();
            return;
        }// end function

        private function addNewTask(event:TaskEvent) : void
        {
            this.upadateTaskList();
            return;
        }// end function

        private function onMainTaskChange(event:TaskEvent) : void
        {
            var _loc_2:* = event.data as TaskMsgVO;
            if (this.panel.taskListContainer)
            {
                if (_loc_2.complete)
                {
                    this.showTask2();
                }
                else
                {
                    this.changeTask2();
                    this.panel.taskListContainer.update();
                }
            }
            else
            {
                this.changeTask1(_loc_2);
            }
            return;
        }// end function

        public function changeTask1(param1:TaskMsgVO) : void
        {
            this.showTask1(param1);
            return;
        }// end function

        public function changeTask2() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_1:* = TaskModel.getInstance().mainTaskList;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_1.length)
            {
                
                _loc_2 = _loc_1[_loc_4];
                for (_loc_5 in this.taskMap)
                {
                    
                    if (_loc_13[_loc_5] is TaskMsgVO)
                    {
                        _loc_6 = _loc_13[_loc_5] as TaskMsgVO;
                        _loc_7 = _loc_5 as TaskTextRender;
                        if (_loc_6 && _loc_2.taskId == _loc_6.taskId)
                        {
                            _loc_7.obj = _loc_2;
                            _loc_8 = TaskCfgObj.getInstance().getTaskById(_loc_2.taskId);
                            _loc_3 = TaskGlobal.TASK_TYPE_NAME[_loc_6.type];
                            _loc_9 = _loc_3.name;
                            _loc_10 = _loc_3.color;
                            _loc_11 = "<font color=\'" + _loc_10 + "\'>【" + _loc_9 + "】</font>";
                            if (_loc_2.complete)
                            {
                                _loc_7.setText("<a href =\'event:openMain_" + _loc_2.taskId + "\'>" + _loc_11 + _loc_2.label, "<font color=\"#41E7E7\">" + _loc_2.text2 + "</font>");
                            }
                            else if (_loc_8)
                            {
                                if (_loc_2.text1.length > 0)
                                {
                                    _loc_7.setText("<a href =\'event:openMain_" + _loc_2.taskId + "\'>" + _loc_11 + _loc_2.label, "<font color=\"#41E7E7\">" + _loc_2.text1 + "</font>", MainTaskMsgParseController.getExtraDesShow(_loc_8));
                                }
                                else
                                {
                                    _loc_7.setText("<a href =\'event:openMain_" + _loc_2.taskId + "\'>" + _loc_11 + _loc_2.label, "", MainTaskMsgParseController.getExtraDesShow(_loc_8));
                                }
                            }
                            else
                            {
                                _loc_7.setText("<a href =\'event:openMain_" + _loc_2.taskId + "\'>" + _loc_11 + _loc_2.label, "<font color=\"#41E7E7\">" + _loc_2.text1 + "</font>");
                            }
                            _loc_13[_loc_7] = _loc_2;
                        }
                    }
                }
                _loc_4++;
            }
            return;
        }// end function

        private function onDailyTaskChange(event:TaskEvent) : void
        {
            this.showTask2();
            return;
        }// end function

        private function onTitleLinkEvent(event:TextEvent) : void
        {
            var _loc_2:* = null;
            if (event.text.indexOf("openMain") != -1)
            {
                _loc_2 = event.text.split("_");
                TaskControl.getInstance().open();
                if (TaskControl.getInstance().taskPanel)
                {
                    TaskControl.getInstance().taskPanel.showType(0);
                    TaskControl.getInstance().taskPanel.selectTask(int(_loc_2[1]));
                }
            }
            else
            {
                switch(event.text)
                {
                    case "openDaily":
                    {
                        TaskControl.getInstance().open();
                        if (TaskControl.getInstance().taskPanel)
                        {
                            TaskControl.getInstance().taskPanel.showType(1);
                        }
                        break;
                    }
                    default:
                    {
                        TaskLinkEventManager.linkEventHandle(event);
                        break;
                        break;
                    }
                }
            }
            return;
        }// end function

        private function onLinkEvent(event:TextEvent) : void
        {
            var _loc_2:* = event.currentTarget as TextField;
            if (!_loc_2)
            {
                return;
            }
            var _loc_3:* = _loc_2.parent.parent as TaskTextRender;
            if (!_loc_3)
            {
                return;
            }
            TaskGlobal.task = _loc_3.obj as TaskMsgVO;
            TaskGlobal.currentTask = _loc_3.obj;
            TaskLinkEventManager.linkEventHandle(event);
            return;
        }// end function

        private function onFastTrans(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (TaskGlobal.currentTask is TaskMsgVO)
            {
                _loc_2 = TaskGlobal.currentTask as TaskMsgVO;
                if (_loc_2.complete)
                {
                    _loc_3 = _loc_2.rewardMsg;
                }
                else
                {
                    _loc_3 = _loc_2.actionMsg;
                }
                TaskGlobal.manager.transferScene(_loc_3);
                BubbleTextControl.getInstance().closeBubbleText();
            }
            return;
        }// end function

        private function showGameGuide() : void
        {
            this.panel.guide1.autoSize = TextFieldAutoSize.LEFT;
            this.panel.guide2.autoSize = TextFieldAutoSize.LEFT;
            this.panel.guide3.autoSize = TextFieldAutoSize.LEFT;
            this.panel.guide4.autoSize = TextFieldAutoSize.LEFT;
            this.updateRectMonByLv();
            this.__zoneInfoUpdate();
            this._prayInfoUpdate();
            if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().BOSSGUILD_ACTIVE_TEAM)) != 0)
            {
                this.panel.guide4.htmlText = LanguageCfgObj.getInstance().getByIndex("11323");
            }
            else
            {
                this.panel.guide4.text = "";
            }
            this.panel.shoe4.visible = false;
            this.panel.shoe1.addEventListener(MouseEvent.CLICK, this.__clickGameGuideShoe);
            this.panel.shoe2.addEventListener(MouseEvent.CLICK, this.__clickGameGuideShoe);
            this.panel.shoe3.addEventListener(MouseEvent.CLICK, this.__clickGameGuideShoe);
            this.panel.shoe4.addEventListener(MouseEvent.CLICK, this.__clickGameGuideShoe);
            RoleList.getInstance().player.info.addEventListener(RoleEvent.UPDATE_DEFENSE, this.updateRectMonByLv);
            RoleList.getInstance().player.info.addEventListener(RoleEvent.UPDATE_LEVEL, this.updateRectMonByLv);
            FrameworkGlobal.addMsgListen(ZoneEvent.ZONE_INFO_UPDATE, this.__zoneInfoUpdate);
            FrameworkGlobal.addMsgListen(GameEvent.PLAYER_PRAY_INFO_UPDATE, this._prayInfoUpdate);
            FrameworkGlobal.addMsgListen(GameEvent.TOP_ACTIVATE_BTN_ADD, this.__topBtnUpdate);
            FrameworkGlobal.addMsgListen(GameEvent.TOP_ACTIVATE_BTN_REMOVE, this.__topBtnUpdate);
            this.panel.guide1.addEventListener(TextEvent.LINK, this.__onClickLink);
            this.panel.guide2.addEventListener(TextEvent.LINK, this.__onClickLink);
            this.panel.guide3.addEventListener(TextEvent.LINK, this.__onClickLink);
            this.panel.guide4.addEventListener(TextEvent.LINK, this.__onClickLink);
            GuideConfigObj.getInstance().addEventListener(GuideEvent.GUIDE_ACTIVE, this.guideActive);
            var _loc_1:* = new StyleSheet();
            _loc_1.parseCSS("a:hover { color:#00fffc; }");
            this.panel.guide1.styleSheet = _loc_1;
            this.panel.guide2.styleSheet = _loc_1;
            this.panel.guide3.styleSheet = _loc_1;
            this.panel.guide4.styleSheet = _loc_1;
            return;
        }// end function

        private function guideActive(event:GuideEvent = null) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = String(event.data);
            if (_loc_2 == GuideConfigObj.getInstance().PRAY_ACTIVE_TEAM)
            {
                _loc_3 = PrayControl.getInstance().prayInfo;
                if (_loc_3)
                {
                    if (_loc_3.prayExpTimes > 0)
                    {
                        this._isPrayExpOver = false;
                    }
                    if (_loc_3.prayGoldTimes > 0)
                    {
                        this._isPrayMoneyOver = false;
                    }
                }
                else
                {
                    this._isPrayExpOver = true;
                    this._isPrayMoneyOver = true;
                }
                this.resetList();
            }
            if (_loc_2 == GuideConfigObj.getInstance().BOSSGUILD_ACTIVE_TEAM)
            {
                if (this.panel && this.panel.guide4)
                {
                    this.panel.guide4.htmlText = LanguageCfgObj.getInstance().getByIndex("11323");
                }
            }
            return;
        }// end function

        private function updateRectMonByLv(event:RoleEvent = null) : void
        {
            var _loc_2:* = UserObj.getInstance().playerInfo.fightPower;
            var _loc_3:* = MapCfgObj.getInstance().getAllRecommandMonListByFormula();
            this._rectMon = _loc_3[Math.floor(Math.random() * _loc_3.length)];
            if (this._rectMon)
            {
                this.panel.guide1.htmlText = "<font color=\'#807059\'>【" + LanguageCfgObj.getInstance().getByIndex("12246") + "】 </font>" + "<font color=\'#13a400\'><u><a href=\'event:openGJ\'>" + this._rectMon.monName + "</a></u></font>";
                this.panel.shoe1.visible = true;
                this.panel.shoe1.x = this.panel.guide1.width + this.panel.guide1.x + 2;
            }
            else
            {
                this.panel.guide1.text = "";
                this.panel.shoe1.visible = false;
            }
            return;
        }// end function

        private function resetList() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = false;
            _loc_1 = TaskCfgObj.getInstance().gameExpGuide;
            for each (_loc_2 in _loc_1)
            {
                
                _loc_3 = false;
                if (_loc_2.q_function == GameGuideConfig.BELIAL_WORLD_FUNCTION && this._isBelialWorldOver)
                {
                    _loc_3 = true;
                }
                else if (_loc_2.q_function == GameGuideConfig.SCARLET_HOLD_FUNCTION && this._isScarletHoldOver)
                {
                    _loc_3 = true;
                }
                else if (_loc_2.q_function == GameGuideConfig.PRAY_EXP_FUNCTION && this._isPrayExpOver)
                {
                    _loc_3 = true;
                }
                else if (_loc_2.q_function == GameGuideConfig.PRAY_MONEY_FUNCTION && this._isPrayMoneyOver)
                {
                    _loc_3 = true;
                }
                if (!_loc_3)
                {
                    this.panel.guide2.htmlText = "<font color=\'#807059\'>【" + LanguageCfgObj.getInstance().getByIndex("12247") + "】 </font><font color=\'#13a400\'>" + _loc_2.q_word + "</font>";
                    if (_loc_2.q_function == GameGuideConfig.AUTO_FIGHT_FUNCTION)
                    {
                        this.panel.shoe2.visible = true;
                        this.panel.shoe2.x = this.panel.guide2.x + this.panel.guide2.width + 2;
                    }
                    else
                    {
                        this.panel.shoe2.visible = false;
                    }
                    break;
                }
            }
            _loc_1 = TaskCfgObj.getInstance().gameMoneyGuide;
            for each (_loc_2 in _loc_1)
            {
                
                _loc_3 = false;
                if (_loc_2.q_function == GameGuideConfig.BELIAL_WORLD_FUNCTION && this._isBelialWorldOver)
                {
                    _loc_3 = true;
                }
                else if (_loc_2.q_function == GameGuideConfig.SCARLET_HOLD_FUNCTION && this._isScarletHoldOver)
                {
                    _loc_3 = true;
                }
                else if (_loc_2.q_function == GameGuideConfig.PRAY_EXP_FUNCTION && this._isPrayExpOver)
                {
                    _loc_3 = true;
                }
                else if (_loc_2.q_function == GameGuideConfig.PRAY_MONEY_FUNCTION && this._isPrayMoneyOver)
                {
                    _loc_3 = true;
                }
                if (!_loc_3)
                {
                    this.panel.guide3.htmlText = "<font color=\'#807059\'>【" + LanguageCfgObj.getInstance().getByIndex("12248") + "】 </font><font color=\'#13a400\'>" + _loc_2.q_word + "</font>";
                    if (_loc_2.q_function == GameGuideConfig.AUTO_FIGHT_FUNCTION)
                    {
                        this.panel.shoe3.visible = true;
                        this.panel.shoe3.x = this.panel.guide3.x + this.panel.guide3.width + 2;
                    }
                    else
                    {
                        this.panel.shoe3.visible = false;
                    }
                    break;
                }
            }
            return;
        }// end function

        private function __topBtnUpdate(event:GameEvent) : void
        {
            if (String(event.obj) == TopActivateName.TOP_ICON_BELIAL_WORLD || String(event.obj) == TopActivateName.TOP_ICON_SCARLET_HOLD)
            {
                this.__zoneInfoUpdate();
            }
            return;
        }// end function

        private function __zoneInfoUpdate(event:ZoneEvent = null) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_2:* = ZonesModel.getInstance().zoneTeamAllInfo;
            for each (_loc_4 in _loc_2)
            {
                
                _loc_3 = ZonesCloneCfg.getInstance().getZonesInfoFromId(_loc_4.zoneid);
                _loc_5 = int(_loc_4.wait_time.toNumber() - (ToolKit.getServerTime() - _loc_4.last_time.toNumber()));
                switch(_loc_3.type)
                {
                    case ZoneType.ZONES_BELIAL_WORLD:
                    {
                        if (_loc_4.enterMaxnum > _loc_4.enternum && (_loc_5 <= 0 || _loc_4.isopen != 3) && MapControl.getInstance().hasTopBtn(TopActivateName.TOP_ICON_BELIAL_WORLD))
                        {
                            this._isBelialWorldOver = false;
                        }
                        else
                        {
                            this._isBelialWorldOver = true;
                            if (_loc_4.enterMaxnum > _loc_4.enternum && _loc_5 > 0)
                            {
                                _loc_6 = _loc_6 > _loc_5 ? (_loc_5) : (_loc_6);
                            }
                        }
                        break;
                    }
                    case ZoneType.ZONES_XS:
                    {
                        if (_loc_4.enterMaxnum > _loc_4.enternum && (_loc_5 <= 0 || _loc_4.isopen != 3) && MapControl.getInstance().hasTopBtn(TopActivateName.TOP_ICON_SCARLET_HOLD))
                        {
                            this._isScarletHoldOver = false;
                        }
                        else
                        {
                            this._isScarletHoldOver = true;
                            if (_loc_4.enterMaxnum > _loc_4.enternum && _loc_5 > 0)
                            {
                                _loc_6 = _loc_6 > _loc_5 ? (_loc_5) : (_loc_6);
                            }
                        }
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            if (_loc_5 > 0)
            {
                TweenLite.killDelayedCallsTo(this.__zoneInfoUpdate);
                TweenLite.delayedCall(Math.ceil(_loc_5 / 1000), this.__zoneInfoUpdate);
            }
            this.resetList();
            return;
        }// end function

        private function _prayInfoUpdate(event:GameEvent = null) : void
        {
            var _loc_2:* = PrayControl.getInstance().prayInfo;
            if (_loc_2 && MapControl.getInstance().bottomBar && MapControl.getInstance().bottomBar.prayBtn && MapControl.getInstance().bottomBar.prayBtn.visible)
            {
                if (_loc_2.prayExpTimes > 0)
                {
                    this._isPrayExpOver = false;
                }
                else
                {
                    this._isPrayExpOver = true;
                }
                if (_loc_2.prayGoldTimes > 0)
                {
                    this._isPrayMoneyOver = false;
                }
                else
                {
                    this._isPrayMoneyOver = true;
                }
            }
            else
            {
                this._isPrayExpOver = true;
                this._isPrayMoneyOver = true;
            }
            this.resetList();
            return;
        }// end function

        private function __clickGameGuideShoe(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            if (this._rectMon)
            {
                AutoFightController.getInstance().setArriveCoordVo(this._rectMon.monMapId, this._rectMon.monX, this._rectMon.monY, 0);
                _loc_2 = new long(0, 0);
                MapControl.getInstance().changeMapByPos(this._rectMon.monMapId, this._rectMon.monX, this._rectMon.monY, _loc_2, 0);
            }
            TaskGlobal.manager.clickLimitHandle(event.currentTarget as InteractiveObject);
            return;
        }// end function

        private function __onClickLink(event:TextEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            switch(event.text)
            {
                case "openGJ":
                {
                    if (this._rectMon)
                    {
                        _loc_2 = MapUtils.tile2Coo([this._rectMon.monX, this._rectMon.monY]);
                        AutoFightController.getInstance().setArriveCoordVo(this._rectMon.monMapId, this._rectMon.monX, this._rectMon.monY, 0);
                        _loc_3 = RoleList.getInstance().player as Player;
                        _loc_3.pathByCoo(_loc_2[0], _loc_2[1], 0, this._rectMon.monMapId, true);
                    }
                    break;
                }
                case "openEMGC":
                {
                    ZonesControl.getInstance().openZonesBeliaWorld();
                    break;
                }
                case "openXSCB":
                {
                    ZonesControl.getInstance().openZonesScarletHold();
                    break;
                }
                case "openQF":
                {
                    PrayControl.getInstance().openOrClosePrayBox();
                    break;
                }
                case "openDB":
                {
                    BossGuideControl.getInstance().openOrCloseBossGuildPanel();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

    }
}
