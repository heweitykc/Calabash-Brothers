package com.game.task.view
{
    import __AS3__.vec.*;
    import com.*;
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.f1.view.mapeditor.*;
    import com.game.backpack.model.*;
    import com.game.guide.*;
    import com.game.guide.control.*;
    import com.game.guide.model.*;
    import com.game.task.*;
    import com.game.task.control.*;
    import com.game.task.events.*;
    import com.game.task.model.*;
    import com.greensock.*;
    import com.model.*;
    import flash.events.*;
    import flash.text.*;
    import interfaces.role.*;

    public class TaskDialogPanel extends BaseBox implements IGuide
    {
        private var HIT_TWICE_REWARD:String;
        public var rewards:Vector.<RewardBox>;
        public var txt_npc_name:TextField;
        public var close_btn:BaseButton;
        public var txt_task_name:TextField;
        public var txt_talker:TextField;
        public var txt_content:TextField;
        public var btn_task:BaseButton;
        public var btn_task2:BaseButton;
        public var btn_twiceRwd:BaseButton;
        public var twice:Boolean;
        private var _data:TaskMsgVO;
        private static var _instance:TaskDialogPanel;

        public function TaskDialogPanel(param1 = null, param2:uint = 60, param3:String = "", param4:Boolean = true)
        {
            this.HIT_TWICE_REWARD = LanguageCfgObj.getInstance().getByIndex("11335");
            _peaceBox = ["*"];
            loadDisplay("res/task_chat.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("TaskChatPanel");
            super.displayReady();
            this.initUI();
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_2:* = null;
            this.btn_twiceRwd = new BaseButton(getDisplayChildByName("btn_twiceRwd"));
            this.btn_twiceRwd.addEvtListener(MouseEvent.CLICK, this.onTaskTwiceHandle);
            this.btn_twiceRwd.setText(LanguageCfgObj.getInstance().getByIndex("11336"));
            this.btn_twiceRwd.visible = false;
            this.btn_task = new BaseButton(getDisplayChildByName("btn_task"));
            this.btn_task.setText(LanguageCfgObj.getInstance().getByIndex("11337"));
            this.btn_task2 = new BaseButton(getDisplayChildByName("btn_task2"));
            this.btn_task2.addEvtListener(MouseEvent.CLICK, this.onTaskHandle);
            this.btn_task.addEvtListener(MouseEvent.CLICK, this.onTaskHandle);
            this.close_btn = new BaseButton(getDisplayChildByName("btn_close"));
            this.close_btn.addEvtListener(MouseEvent.CLICK, this.closePanel);
            this.txt_npc_name = getDisplayChildByName("txt_npc_name") as TextField;
            this.txt_npc_name.defaultTextFormat = new TextFormat(LanguageCfgObj.getInstance().getByIndex("11338"), 16, 16755200, true);
            this.txt_task_name = getDisplayChildByName("txt_task_name") as TextField;
            this.txt_talker = getDisplayChildByName("txt_talker") as TextField;
            this.txt_talker.visible = false;
            this.txt_content = getDisplayChildByName("txt_content") as TextField;
            this.rewards = new Vector.<RewardBox>(5);
            var _loc_1:* = 0;
            while (_loc_1 < 5)
            {
                
                _loc_2 = new TaskRewardBox();
                this.rewards[_loc_1] = _loc_2;
                _loc_1++;
            }
            if (this._data)
            {
                this.update(this._data);
            }
            this.registerGuide();
            return;
        }// end function

        private function onTaskTwiceHandle(event:MouseEvent) : void
        {
            this.twice = true;
            this.onTaskHandle(event);
            this.twice = false;
            return;
        }// end function

        private function onTaskHandle(event:MouseEvent) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            if (!this._data)
            {
                this.close();
                return;
            }
            var _loc_2:* = UserObj.getInstance().playerInfo.level;
            if (this._data.levelLimit > _loc_2)
            {
                this.close();
                return;
            }
            if (this._data.complete)
            {
                _loc_3 = this._data.conf;
                _loc_4 = NpcCfgObj.getInstance().getNpcByID(_loc_3.q_endnpc);
                _loc_5 = RoleList.getInstance().player;
                if (_loc_5)
                {
                    _loc_6 = ToolKit.distance(_loc_5._x / 25, _loc_5._y / 25, _loc_4._x, _loc_4._y);
                    if (_loc_6 >= 8)
                    {
                        TaskGlobal.manager.continueTask(this._data);
                        this.close();
                    }
                    else
                    {
                        dispatchEvent(new TaskEvent(this._data, TaskEvent.TASK_GET_REWARD));
                        this.close();
                    }
                }
            }
            else
            {
                TaskGlobal.manager.continueTask(this._data);
                this.close();
            }
            return;
        }// end function

        public function get data() : TaskMsgVO
        {
            return this._data;
        }// end function

        public function update(param1:TaskMsgVO) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = null;
            this._data = param1;
            if (this.txt_content)
            {
                _loc_2 = this._data.conf;
                _loc_3 = NpcCfgObj.getInstance().getNpcByID(_loc_2.q_endnpc);
                this.txt_npc_name.text = _loc_3._npcName;
                this.txt_talker.text = _loc_3._npcName + "：";
                this.txt_task_name.htmlText = _loc_2.q_name;
                _loc_4 = TaskGlobal.manager.showReward(_loc_2, this.rewards);
                _loc_5 = 152 - _loc_4 * 33;
                _loc_6 = 0;
                while (_loc_6 < this.rewards.length)
                {
                    
                    if (_loc_6 < _loc_4)
                    {
                        this.rewards[_loc_6].x = _loc_5 + 66 * _loc_6;
                        this.rewards[_loc_6].y = 270;
                        if (this.rewards[_loc_6]._lockImg)
                        {
                            this.rewards[_loc_6]._lockImg.y = 46;
                        }
                        addChild(this.rewards[_loc_6]);
                    }
                    else if (contains(this.rewards[_loc_6]))
                    {
                        removeChild(this.rewards[_loc_6]);
                    }
                    _loc_6++;
                }
                _loc_7 = UserObj.getInstance().playerInfo.level;
                if (param1.levelLimit > _loc_7)
                {
                    this.txt_content.htmlText = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12251"), [param1.levelLimit]) + "<br />" + param1.text1;
                    this.btn_task.setText(LanguageCfgObj.getInstance().getByIndex("11339"));
                }
                _loc_8 = _loc_2.q_start_chat;
                _loc_8 = _loc_8.replace(/\#[0-9]{2}/g, "");
                this.txt_content.htmlText = _loc_8;
                this.btn_twiceRwd.visible = false;
                this.btn_task2.visible = false;
                if (param1.complete)
                {
                    if (param1.conf.q_double_rewards != null && int(param1.conf.q_double_rewards) > 0)
                    {
                        _loc_9 = this.HIT_TWICE_REWARD.replace("[0]", param1.conf.q_double_rewards);
                        _loc_9 = _loc_9.replace("[0]", param1.conf.q_double_rewards);
                        StringTip.create(this.btn_twiceRwd, _loc_9);
                        this.btn_twiceRwd.visible = true;
                        this.btn_task2.visible = true;
                        this.btn_task.visible = false;
                        this.btn_task2.setText(LanguageCfgObj.getInstance().getByIndex("11340"));
                    }
                    else
                    {
                        this.btn_task.visible = true;
                        this.btn_task.setText(LanguageCfgObj.getInstance().getByIndex("11340"));
                    }
                }
                else
                {
                    this.btn_task.setText(LanguageCfgObj.getInstance().getByIndex("11337"));
                }
                if (this._data.taskId < 10068)
                {
                    TweenLite.killDelayedCallsTo(this.clickOK);
                    TweenLite.delayedCall(TaskGlobal.AUTO_CLICK_TASK_OK_CD, this.clickOK);
                    TaskGlobal.manager.setAutoTask(false);
                }
            }
            return;
        }// end function

        private function clickOK() : void
        {
            TweenLite.killDelayedCallsTo(this.clickOK);
            if (BackpackObj.getInstance().isFull())
            {
                TweenLite.delayedCall(TaskGlobal.AUTO_CLICK_TASK_OK_CD, this.clickOK);
                return;
            }
            if (this.btn_task.visible)
            {
                this.btn_task.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            }
            else if (this.btn_task2.visible)
            {
                this.btn_task2.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            }
            return;
        }// end function

        public function nextTask(param1:TaskMsgVO) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            this.btn_task.setText(LanguageCfgObj.getInstance().getByIndex("11337"));
            this._data = param1;
            if (this.txt_content)
            {
                _loc_2 = this._data.conf;
                this.txt_task_name.htmlText = _loc_2.q_name;
                _loc_3 = TaskGlobal.manager.showReward(_loc_2, this.rewards);
                _loc_4 = 152 - _loc_3 * 33;
                _loc_5 = 0;
                while (_loc_5 < this.rewards.length)
                {
                    
                    if (_loc_5 < _loc_3)
                    {
                        this.rewards[_loc_5].x = _loc_4 + 66 * _loc_5;
                        this.rewards[_loc_5].y = 270;
                        addChild(this.rewards[_loc_5]);
                    }
                    else if (contains(this.rewards[_loc_5]))
                    {
                        removeChild(this.rewards[_loc_5]);
                    }
                    _loc_5++;
                }
            }
            return;
        }// end function

        private function onLinkEvent(event:TextEvent) : void
        {
            TaskLinkEventManager.linkEventHandle(event);
            this.close();
            return;
        }// end function

        private function closePanel(event:MouseEvent) : void
        {
            this.close();
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            FrameworkGlobal.stage.addEventListener(MouseEvent.CLICK, this.onMapClick);
            Global.mainUIManager.addUI(Global.popManager.scrollSystemCue, new LayoutInfo(Layout.BOTTOM_CENTER, 0, 320));
            if (UILoaded)
            {
                this.registerGuide();
            }
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            TweenLite.killDelayedCallsTo(this.clickOK);
            TaskGlobal.manager.setAutoTask(true);
            Global.popManager.returnScrollSystemBack();
            this.guidePause(GuideConfigObj.getInstance().TASK_BTN_GUIDE_ID);
            this.guidePause(GuideConfigObj.getInstance().GEN_TASK_GUIDE_ID_2);
            return;
        }// end function

        private function onMapClick(event:MouseEvent) : void
        {
            if (event.target is GameBgView)
            {
                FrameworkGlobal.stage.removeEventListener(MouseEvent.CLICK, this.onMapClick);
                this.close();
            }
            return;
        }// end function

        public function registerGuide() : void
        {
            GuideControl.getInstance().registerGuide(this.btn_task, this, GuideConfigObj.getInstance().TASK_BTN_GUIDE_ID);
            GuideControl.getInstance().registerGuide(this.btn_task, this, GuideConfigObj.getInstance().GEN_TASK_GUIDE_ID_2);
            return;
        }// end function

        public function guideAction(param1:String) : void
        {
            return;
        }// end function

        public function guidePause(param1:String) : void
        {
            GuideControl.getInstance().backGuide(param1, 1);
            return;
        }// end function

        public function guideEnd(param1:String) : void
        {
            return;
        }// end function

        public function isGuideReady() : Boolean
        {
            return isOpen && UILoaded;
        }// end function

        public static function getInstance() : TaskDialogPanel
        {
            if (!_instance)
            {
                _instance = new TaskDialogPanel;
                Global.popManager.addPop(_instance, false, false, false, true, false, false, new LayoutInfo(1, 300, -60));
            }
            return _instance;
        }// end function

    }
}

import __AS3__.vec.*;

import com.*;

import com.cfg.info.*;

import com.cfg.obj.*;

import com.f1.*;

import com.f1.ui.*;

import com.f1.ui.box.*;

import com.f1.ui.btn.*;

import com.f1.ui.tips.*;

import com.f1.utils.*;

import com.f1.view.mapeditor.*;

import com.game.backpack.model.*;

import com.game.guide.*;

import com.game.guide.control.*;

import com.game.guide.model.*;

import com.game.task.*;

import com.game.task.control.*;

import com.game.task.events.*;

import com.game.task.model.*;

import com.greensock.*;

import com.model.*;

import flash.events.*;

import flash.text.*;

import interfaces.role.*;

class TaskRewardBox extends RewardBox
{

    function TaskRewardBox()
    {
        super("PropBox66");
        img.x = 5;
        img.y = 5;
        textField.x = 16;
        textField.y = 46;
        return;
    }// end function

    override protected function completeFunc(param1:BitmapData) : void
    {
        img.setSize(56, 56);
        return;
    }// end function

}

