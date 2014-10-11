package com.game.task.mediator
{
    import __AS3__.vec.*;
    import com.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.image.*;
    import com.f1.ui.list.*;
    import com.f1.utils.*;
    import com.game.role.util.*;
    import com.game.task.*;
    import com.game.task.control.*;
    import com.game.task.events.*;
    import com.game.task.model.*;
    import com.game.task.view.*;
    import com.model.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.text.*;

    public class MainTaskMediator extends Object
    {
        private var panel:TaskPanel;
        public var btn_op:BaseButton;
        public var txt_desc:TextField;
        public var main_title:TextField;
        public var txt_label1:TextField;
        public var txt_label2:TextField;
        public var untarget_1:TextField;
        public var untarget_2:TextField;
        public var mc_shoe1:BaseButton;
        public var mc_shoe2:BaseButton;
        public var mc_icon2:MovieClip;
        public var mc_complete:MovieClip;
        public var leftBtn:BaseButton;
        public var rightBtn:BaseButton;
        public var rewards:Vector.<RewardBox>;
        public var taskListContainer:List;
        public var rewardGrid:Vector.<MovieClip>;
        private var _selectItemRender:TaskItemRender;
        public const YELLOW_SELECT_FILTER:GlowFilter;
        private const CHAPTER_POS:Array;
        private const MAX_CHAPTER:int = 6;
        private var view:MovieClip;
        private var iconsList:Vector.<MovieClip>;
        private var chapterList:Vector.<Object>;
        private var _chepterIndex:int = -1;
        private var _startChepter:int = -1;

        public function MainTaskMediator(param1:MovieClip, param2:TaskPanel)
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            this.YELLOW_SELECT_FILTER = new GlowFilter(16696576, 1, 3, 3, 3);
            this.CHAPTER_POS = [[156, 104], [236, 104], [315, 104]];
            this.panel = param2;
            this.view = param1;
            this.txt_desc = param1.getChildByName("txt_desc") as TextField;
            this.txt_desc.text = "";
            this.txt_label1 = param1.getChildByName("txt_label1") as TextField;
            this.txt_label1.autoSize = TextFieldAutoSize.LEFT;
            this.txt_label2 = param1.getChildByName("txt_label2") as TextField;
            this.txt_label2.autoSize = TextFieldAutoSize.LEFT;
            this.untarget_1 = param1.getChildByName("untarget_1") as TextField;
            this.untarget_2 = param1.getChildByName("untarget_2") as TextField;
            this.main_title = param1.getChildByName("main_title") as TextField;
            this.mc_shoe1 = new BaseButton(param1.getChildByName("mc_shoe1"));
            this.mc_shoe1.visible = false;
            this.mc_shoe1.addEventListener(MouseEvent.CLICK, this.onTransfer1);
            this.mc_shoe2 = new BaseButton(param1.getChildByName("mc_shoe2"));
            this.mc_shoe2.visible = false;
            this.mc_shoe2.addEventListener(MouseEvent.CLICK, this.onTransfer2);
            var _loc_3:* = new Image();
            _loc_3.x = 8;
            _loc_3.y = 8;
            this.taskListContainer = new List(305, 200);
            this.taskListContainer.x = 120;
            this.taskListContainer.y = 246;
            param1.addChild(this.taskListContainer);
            this.mc_complete = param1.getChildByName("mc_complete") as MovieClip;
            this.mc_complete.mouseChildren = false;
            this.mc_complete.mouseEnabled = false;
            this.mc_complete.visible = false;
            this.iconsList = new Vector.<MovieClip>;
            _loc_4 = 1;
            while (_loc_4 <= this.MAX_CHAPTER)
            {
                
                _loc_5 = param1.getChildByName("icon" + _loc_4) as MovieClip;
                _loc_6 = new Image();
                _loc_6.x = 6;
                _loc_6.y = 6;
                _loc_5.addChild(_loc_6);
                _loc_5.image = _loc_6;
                _loc_7 = new Image();
                var _loc_9:* = 72;
                _loc_7.height = 72;
                _loc_3.width = _loc_9;
                _loc_7.x = -2;
                _loc_7.y = -15;
                _loc_5.addChild(_loc_7);
                _loc_5.bigimage = _loc_7;
                _loc_5.id = _loc_4 - 1;
                this.iconsList.push(_loc_5);
                _loc_5.addEventListener(MouseEvent.CLICK, this.onIconClickHandle);
                _loc_4++;
            }
            this.setChapterIcon();
            this.rewards = new Vector.<RewardBox>(5);
            _loc_4 = 0;
            while (_loc_4 < 5)
            {
                
                _loc_8 = new RewardBox("commonRewardBox2_40");
                _loc_8.img.move(4, 4);
                _loc_8.textField.x = 1;
                _loc_8.textField.y = 30;
                this.rewards[_loc_4] = _loc_8;
                _loc_4++;
            }
            this.leftBtn = new BaseButton(param1.getChildByName("leftBtn"));
            this.rightBtn = new BaseButton(param1.getChildByName("rightBtn"));
            this.untarget_1.mouseEnabled = false;
            this.untarget_2.addEventListener(TextEvent.LINK, this.onRecommandLink);
            TaskGlobal.myEvt.addEvtListener(TaskEvent.TASK_ITEM_UPDATE, this.upadateItem);
            TaskGlobal.myEvt.addEvtListener(TaskEvent.GET_NEW_TASK, this.addNewTask);
            this.leftBtn.addEvtListener(MouseEvent.CLICK, this.onClickLeft);
            this.rightBtn.addEvtListener(MouseEvent.CLICK, this.onClickRight);
            this.txt_label1.addEventListener(TextEvent.LINK, this.onGetTaskLink1);
            this.txt_label2.addEventListener(TextEvent.LINK, this.onGetTaskLink2);
            return;
        }// end function

        public function get selectItemRender() : TaskItemRender
        {
            return this._selectItemRender;
        }// end function

        private function setChapterIcon() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            this.chapterList = new Vector.<Object>;
            var _loc_1:* = TaskCfgObj.getInstance().chapterMap();
            for each (_loc_2 in _loc_1)
            {
                
                this.chapterList.push(_loc_2);
            }
            _loc_3 = this.chapterList.length;
            _loc_4 = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_2 = this.chapterList[_loc_4];
                _loc_5 = Params.OTHER_PATH + _loc_2.q_chapter_icon_samll + ".png";
                _loc_6 = this.iconsList[_loc_4].image as Image;
                _loc_5 = Params.OTHER_PATH + _loc_2.q_chapter_icon_samll + ".png";
                _loc_6.load(_loc_5);
                _loc_6 = this.iconsList[_loc_4].bigimage as Image;
                _loc_6.smoothing = true;
                _loc_5 = Params.OTHER_PATH + _loc_2.q_chapter_icon_big + ".png";
                _loc_6.visible = false;
                _loc_6.load(_loc_5);
                _loc_4++;
            }
            this.updateIcon();
            return;
        }// end function

        private function set chepterIndex(param1:int) : void
        {
            var _loc_3:* = null;
            if (param1 < 0)
            {
                param1 = 0;
            }
            if (param1 >= this.MAX_CHAPTER)
            {
                param1 = this.MAX_CHAPTER - 1;
            }
            if (param1 > TaskModel.getInstance().chepter)
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("11325"));
                return;
            }
            var _loc_2:* = this.chapterList.length;
            if (this._chepterIndex != param1)
            {
                if (this._chepterIndex >= 0 && this._chepterIndex < this.iconsList.length)
                {
                    this.iconsList[this._chepterIndex].filters = null;
                    this.iconsList[this._chepterIndex].image.visible = true;
                    this.iconsList[this._chepterIndex].bigimage.visible = false;
                }
                this._chepterIndex = param1;
                this.iconsList[this._chepterIndex].image.visible = false;
                this.iconsList[this._chepterIndex].bigimage.visible = true;
                this.iconsList[this._chepterIndex].filters = [this.YELLOW_SELECT_FILTER];
                _loc_3 = this.chapterList[param1];
                this.main_title.text = _loc_3.q_chapter_name;
            }
            this.startChepter = this._chepterIndex - 1;
            return;
        }// end function

        private function get chepterIndex() : int
        {
            return this._chepterIndex;
        }// end function

        private function onIconClickHandle(event:MouseEvent) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_2:* = event.currentTarget as MovieClip;
            var _loc_3:* = _loc_2.id;
            if (TaskModel.getInstance().chepter < _loc_3)
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("11325"));
                return;
            }
            this.chepterIndex = _loc_2.id;
            _loc_4 = TaskModel.getInstance().getAllTaskByChapter(this._chepterIndex);
            this.taskListContainer.reset();
            if (TaskModel.getInstance().chepter == this._chepterIndex)
            {
                this.resetAndShow();
            }
            else
            {
                _loc_5 = 0;
                for each (_loc_6 in _loc_4)
                {
                    
                    _loc_7 = _loc_6 as TaskItemVO;
                    _loc_8 = MainTaskMsgParseController.parseTask(_loc_7.data);
                    _loc_9 = new TaskItemRender();
                    _loc_9.addEvtListener(MouseEvent.CLICK, this.onTaskClickHandle);
                    _loc_9.obj = _loc_8;
                    this.taskListContainer.add(_loc_9);
                    _loc_9.index = _loc_5;
                    _loc_5++;
                }
                (this.taskListContainer.contents[0] as DisplayObject).dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            }
            this.panel.tab_btns[0].setText(LanguageCfgObj.getInstance().getByIndex("11760") + "<br />" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12249"), [(this._chepterIndex + 1)]));
            return;
        }// end function

        public function selectTask(param1:int) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_2:* = TaskCfgObj.getInstance().getTaskById(param1);
            var _loc_3:* = 0;
            if (_loc_2.q_type == 1)
            {
                this.iconsList[_loc_2.q_chapter].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            }
            else
            {
                _loc_4 = TaskModel.getInstance();
                _loc_5 = _loc_4.mainTaskList.length;
                if (_loc_5 == 0)
                {
                    return;
                }
                _loc_6 = _loc_4.mainTaskList[0];
                if (!_loc_6)
                {
                    return;
                }
                this.iconsList[_loc_6.conf.q_chapter].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            }
            if (this.taskListContainer.contents)
            {
                for each (_loc_7 in this.taskListContainer.contents)
                {
                    
                    if (_loc_7 && _loc_7.obj && _loc_7.obj.taskId == param1)
                    {
                        _loc_7.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                    }
                }
            }
            return;
        }// end function

        public function set startChepter(param1:int) : void
        {
            var _loc_2:* = 0;
            if (param1 < 0)
            {
                param1 = 0;
            }
            if (param1 > this.MAX_CHAPTER - 3)
            {
                param1 = this.MAX_CHAPTER - 3;
            }
            if (this._startChepter != param1)
            {
                this._startChepter = param1;
                _loc_2 = 0;
                while (_loc_2 < this.MAX_CHAPTER)
                {
                    
                    if (_loc_2 >= this._startChepter && _loc_2 <= this._startChepter + 2)
                    {
                        this.iconsList[_loc_2].x = this.CHAPTER_POS[_loc_2 - this._startChepter][0];
                        this.iconsList[_loc_2].y = this.CHAPTER_POS[_loc_2 - this._startChepter][1];
                        this.iconsList[_loc_2].visible = true;
                    }
                    else
                    {
                        this.iconsList[_loc_2].visible = false;
                    }
                    _loc_2++;
                }
            }
            return;
        }// end function

        public function get startChepter() : int
        {
            return this._startChepter;
        }// end function

        private function onOprateHandle(event:MouseEvent) : void
        {
            var _loc_2:* = this.selectItemRender.obj as TaskMsgVO;
            TaskGlobal.manager.continueTask(_loc_2);
            this.panel.close();
            return;
        }// end function

        private function onClickLeft(event:MouseEvent) : void
        {
            (this.chepterIndex - 1);
            return;
        }// end function

        private function onClickRight(event:MouseEvent) : void
        {
            (this.chepterIndex + 1);
            return;
        }// end function

        private function onGetTaskLink1(event:TextEvent) : void
        {
            TaskLinkEventManager.linkEventHandle(event);
            this.panel.close();
            return;
        }// end function

        private function onGetTaskLink2(event:TextEvent) : void
        {
            TaskLinkEventManager.linkEventHandle(event);
            this.panel.close();
            return;
        }// end function

        private function onRecommandLink(event:TextEvent) : void
        {
            TaskLinkEventManager.linkEventHandle(event);
            return;
        }// end function

        private function addNewTask(event:TaskEvent = null) : void
        {
            var _loc_2:* = event.data as TaskMsgVO;
            if (_loc_2)
            {
                this.resetAndShow(_loc_2.taskId);
            }
            else
            {
                this.resetAndShow();
            }
            if (this._chepterIndex != _loc_2.conf.q_chapter)
            {
                this.chepterIndex = _loc_2.conf.q_chapter;
                this.updateIcon();
            }
            return;
        }// end function

        private function updateIcon() : void
        {
            var _loc_1:* = 0;
            while (_loc_1 < this.iconsList.length)
            {
                
                if (_loc_1 > TaskModel.getInstance().chepter)
                {
                    this.iconsList[_loc_1].filters = [FrameworkGlobal.colorMat];
                }
                else if (this.iconsList[_loc_1].filters)
                {
                    if (_loc_1 == this._chepterIndex)
                    {
                        this.iconsList[_loc_1].filters = [this.YELLOW_SELECT_FILTER];
                    }
                    else
                    {
                        this.iconsList[_loc_1].filters = null;
                    }
                }
                _loc_1++;
            }
            return;
        }// end function

        private function upadateItem(event:TaskEvent) : void
        {
            var _loc_2:* = event.data as TaskMsgVO;
            var _loc_3:* = this.taskListContainer.contents;
            if (this._selectItemRender && this._selectItemRender.obj.taskId == _loc_2.taskId)
            {
                this._selectItemRender.obj = _loc_2;
                this.setDetailMsg(_loc_2);
            }
            return;
        }// end function

        public function resetAndShow(param1:int = -1) : void
        {
            var _loc_8:* = null;
            this.taskListContainer.reset();
            var _loc_2:* = TaskModel.getInstance();
            var _loc_3:* = _loc_2.mainTaskList.length;
            if (_loc_3 == 0)
            {
                return;
            }
            var _loc_4:* = _loc_2.mainTaskList[0];
            if (!_loc_2.mainTaskList[0])
            {
                return;
            }
            var _loc_5:* = _loc_2.getPretaskList(_loc_4.taskId);
            _loc_3 = _loc_5.length;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            while (_loc_7 < _loc_3)
            {
                
                _loc_4 = MainTaskMsgParseController.parseTask(_loc_5[_loc_7].data);
                _loc_8 = new TaskItemRender();
                _loc_8.addEvtListener(MouseEvent.CLICK, this.onTaskClickHandle);
                _loc_8.obj = _loc_4;
                _loc_8.index = _loc_6;
                this.taskListContainer.add(_loc_8);
                _loc_6++;
                _loc_7++;
            }
            _loc_3 = _loc_2.mainTaskList.length;
            _loc_7 = 0;
            while (_loc_7 < _loc_3)
            {
                
                _loc_8 = new TaskItemRender();
                _loc_8.addEvtListener(MouseEvent.CLICK, this.onTaskClickHandle);
                _loc_8.obj = _loc_2.mainTaskList[_loc_7];
                _loc_8.index = _loc_6;
                this.taskListContainer.add(_loc_8);
                if (param1 > 0)
                {
                    if (_loc_2.mainTaskList[_loc_7].taskId == param1)
                    {
                        _loc_8.dispatchEvt(new MouseEvent(MouseEvent.CLICK));
                    }
                }
                else if (_loc_7 == 0)
                {
                    _loc_8.dispatchEvt(new MouseEvent(MouseEvent.CLICK));
                }
                _loc_6++;
                _loc_7++;
            }
            this.taskListContainer.scrollToBottom();
            return;
        }// end function

        private function onTaskClickHandle(event:MouseEvent) : void
        {
            if (this._selectItemRender)
            {
                this._selectItemRender.selected = false;
            }
            var _loc_2:* = event.currentTarget as TaskItemRender;
            var _loc_3:* = _loc_2.obj as TaskMsgVO;
            this._selectItemRender = _loc_2;
            this._selectItemRender.selected = true;
            this.setDetailMsg(_loc_3);
            return;
        }// end function

        private function setDetailMsg(param1:TaskMsgVO) : void
        {
            if (!param1)
            {
                return;
            }
            var _loc_2:* = UserObj.getInstance().playerInfo.level;
            var _loc_3:* = RoleLevelUtil.getMasterLevel(_loc_2);
            var _loc_4:* = RoleLevelUtil.getMasterLevel(param1.levelLimit);
            if (param1.levelLimit <= _loc_2)
            {
                this.txt_label1.htmlText = param1.text1 ? (param1.text1) : ("");
                this.txt_label2.htmlText = param1.text2 ? (param1.text2) : ("");
                var _loc_10:* = true;
                this.txt_label2.visible = true;
                this.txt_label1.visible = _loc_10;
                var _loc_10:* = false;
                this.untarget_2.visible = false;
                this.untarget_1.visible = _loc_10;
                this.txt_label2.y = this.txt_label1.height + this.txt_label1.y;
            }
            else
            {
                var _loc_10:* = false;
                this.txt_label2.visible = false;
                this.txt_label1.visible = _loc_10;
                var _loc_10:* = true;
                this.untarget_2.visible = true;
                this.untarget_1.visible = _loc_10;
                this.untarget_1.htmlText = LanguageCfgObj.getInstance().getByIndex("12250") + "(" + _loc_3 + "/" + _loc_4 + ")";
                this.untarget_2.htmlText = param1.text1;
            }
            if (param1.text1 && param1.text1 != "")
            {
                if (int(param1.conf.q_task_type) != 8)
                {
                }
                this.mc_shoe1.x = this.txt_label1.x + this.txt_label1.textWidth + 8;
            }
            else
            {
                this.mc_shoe1.visible = false;
            }
            if (param1.text2 && param1.text2 != "")
            {
                this.mc_shoe2.x = this.txt_label2.x + this.txt_label2.textWidth + 8;
            }
            else
            {
                this.mc_shoe2.visible = false;
            }
            var _loc_5:* = param1.conf;
            this.chepterIndex = _loc_5.q_chapter;
            var _loc_6:* = TaskGlobal.manager.showReward(_loc_5, this.rewards);
            var _loc_7:* = 472;
            var _loc_8:* = 0;
            while (_loc_8 < this.rewards.length)
            {
                
                if (_loc_8 < _loc_6)
                {
                    if (_loc_8 < 4)
                    {
                        this.rewards[_loc_8].x = _loc_7 + 53 * _loc_8;
                        this.rewards[_loc_8].y = 272;
                        this.view.addChild(this.rewards[_loc_8]);
                    }
                }
                else if (this.view.contains(this.rewards[_loc_8]))
                {
                    this.view.removeChild(this.rewards[_loc_8]);
                }
                _loc_8++;
            }
            this.mc_complete.visible = param1.rewarded;
            var _loc_9:* = _loc_5.q_task_desc;
            _loc_9 = _loc_9.replace(/{|}/g, "");
            this.txt_desc.htmlText = _loc_9;
            this.panel.tab_btns[0].setText(LanguageCfgObj.getInstance().getByIndex("11760") + "<br />" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12249"), [(this._chepterIndex + 1)]));
            return;
        }// end function

        private function onTransfer1(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            if (TaskGlobal.task)
            {
                _loc_2 = TaskGlobal.task.actionMsg;
                if (!TaskGlobal.task.complete)
                {
                    TaskGlobal.currentTask = TaskGlobal.task;
                }
                TaskGlobal.manager.transferScene(_loc_2);
                TaskGlobal.manager.clickLimitHandle(this.mc_shoe1);
            }
            return;
        }// end function

        private function onTransfer2(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            if (TaskGlobal.task)
            {
                _loc_2 = TaskGlobal.task.rewardMsg;
                TaskGlobal.manager.transferScene(_loc_2);
                TaskGlobal.manager.clickLimitHandle(this.mc_shoe2);
            }
            return;
        }// end function

        private function clear() : void
        {
            this.txt_desc.text = "";
            this.txt_label1.text = "";
            this.txt_label2.text = "";
            return;
        }// end function

    }
}
