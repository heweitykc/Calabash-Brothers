package com.game.task.view
{
    import __AS3__.vec.*;
    import com.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.events.*;
    import com.f1.utils.*;
    import com.game.task.*;
    import com.game.task.control.*;
    import com.game.task.events.*;
    import com.game.task.mediator.*;
    import com.game.task.model.*;
    import flash.display.*;
    import flash.events.*;

    public class TaskPanel extends BaseBox
    {
        public var tab_btns:Vector.<BaseButton>;
        public var panel_mcs:Vector.<DisplayObject>;
        public var btn_close:BaseButton;
        public var container:MovieClip;
        public var mainTaskUI:MovieClip;
        public var mainTaskMediator:MainTaskMediator;
        public var dailyTaskUI:MovieClip;
        public var dailyTaskMediator:DailyTaskMediator;
        private var labels:Vector.<String>;
        private var openTaskId:int;
        private var _showType:int = 0;
        private var selected_btn:BaseButton;

        public function TaskPanel(param1 = null, param2:uint = 60, param3:String = "", param4:Boolean = true)
        {
            this.labels = this.Vector.<String>([LanguageCfgObj.getInstance().getByIndex("11763"), LanguageCfgObj.getInstance().getByIndex("11764")]);
            _peaceBox = ["*"];
            setWH(805, 480);
            loadDisplay("res/task.swf");
            return;
        }// end function

        public function showType(param1:int = 0) : void
        {
            if (this.tab_btns && param1 < this.tab_btns.length)
            {
                if (this.selected_btn != this.tab_btns[param1])
                {
                    this.tab_btns[param1].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                }
            }
            else
            {
                this._showType = param1;
            }
            return;
        }// end function

        public function selectTask(param1:int) : void
        {
            this.openTaskId = param1;
            if (this.mainTaskMediator)
            {
                this.mainTaskMediator.selectTask(this.openTaskId);
                this.openTaskId = 0;
            }
            return;
        }// end function

        override protected function displayReady() : void
        {
            var _loc_3:* = null;
            initBaseBoxUI("TaskPanel");
            this.btn_close = new BaseButton(getDisplayChildByName("btn_close"));
            this.container = getDisplayChildByName("container");
            this.btn_close.addEvtListener(MouseEvent.CLICK, this.onClosePanel);
            var _loc_1:* = this.labels.length;
            this.tab_btns = new Vector.<BaseButton>(_loc_1);
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = new BaseButton(getDisplayChildByName("btn" + (_loc_2 + 1)));
                _loc_3.setText(this.labels[_loc_2], true);
                _loc_3.addEventListener(MouseEvent.CLICK, this.onTabClickHandle);
                this.tab_btns[_loc_2] = _loc_3;
                _loc_3.visible = false;
                _loc_2++;
            }
            this.tab_btns[0].visible = true;
            this.initUI();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_3:* = null;
            this.mainTaskUI = ToolKit.getNew("MainTaskComponent");
            this.container.addChild(this.mainTaskUI);
            this.mainTaskMediator = new MainTaskMediator(this.mainTaskUI, this);
            this.mainTaskUI.visible = false;
            this.dailyTaskUI = ToolKit.getNew("DailyTaskComponent");
            this.dailyTaskUI.mc_complete.visible = false;
            this.container.addChild(this.dailyTaskUI);
            this.dailyTaskUI.visible = false;
            this.dailyTaskMediator = new DailyTaskMediator(this.dailyTaskUI, this);
            this.panel_mcs = new Vector.<DisplayObject>;
            this.panel_mcs.push(this.mainTaskUI);
            this.panel_mcs.push(this.dailyTaskUI);
            addEvtListener(BoxEvent.SHOW_HIDE, this.setUpdateState);
            TaskGlobal.myEvt.addEvtListener(TaskEvent.TASK_LIST_UPDATE, this.upadateList);
            if (this._showType >= this.tab_btns.length)
            {
                this._showType = 0;
            }
            this.selected_btn = this.tab_btns[this._showType];
            var _loc_1:* = 0;
            var _loc_2:* = this.tab_btns.length;
            if (this._showType == 1)
            {
                this.mainTaskMediator.resetAndShow();
            }
            else
            {
                this.dailyTaskMediator.resetAndShow();
            }
            this.selected_btn.dispatchEvt(new MouseEvent(MouseEvent.CLICK));
            this.upadateTabButton();
            if (this._showType == 0 && this.openTaskId != 0)
            {
                this.selectTask(this.openTaskId);
            }
            return;
        }// end function

        private function setUpdateState(event:BoxEvent) : void
        {
            return;
        }// end function

        private function upadateList(event:TaskEvent = null) : void
        {
            if (event.data.toString() == "day_over")
            {
                Global.popManager.txtCue(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12253"), [TaskGlobal.DAILY_TASK_MAX_RANGE]));
                this.dailyTaskUI.mc_complete.visible = true;
            }
            else
            {
                this.upadateTabButton();
                this.showItem();
            }
            return;
        }// end function

        private function upadateTabButton() : void
        {
            var _loc_2:* = 0;
            var _loc_1:* = TaskModel.getInstance().dailyTaskList;
            if (TaskModel.getInstance().dailyAccTime > 0 || _loc_1 && _loc_1.length)
            {
                this.tab_btns[1].visible = true;
                _loc_2 = TaskModel.getInstance().dailyAccTime;
                _loc_2 = _loc_2 > 20 ? (20) : (_loc_2);
                _loc_2 = _loc_2 == 0 ? (1) : (_loc_2);
                this.tab_btns[1].setText(LanguageCfgObj.getInstance().getByIndex("12244") + "<br />" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12254"), [_loc_2]));
            }
            else
            {
                this.tab_btns[1].visible = false;
            }
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            return;
        }// end function

        private function showItem() : void
        {
            var _loc_1:* = this.tab_btns.indexOf(this.selected_btn);
            if (_loc_1 == 0)
            {
                this.mainTaskMediator.resetAndShow();
            }
            else if (_loc_1 == 1)
            {
                this.dailyTaskMediator.resetAndShow();
            }
            return;
        }// end function

        private function onTabClickHandle(event:MouseEvent) : void
        {
            this.selected_btn.selected = false;
            var _loc_2:* = this.tab_btns.indexOf(this.selected_btn);
            if (_loc_2 != -1)
            {
                this.panel_mcs[_loc_2].visible = false;
            }
            var _loc_3:* = event.currentTarget as BaseButton;
            _loc_3.selected = true;
            this.selected_btn = _loc_3;
            _loc_2 = this.tab_btns.indexOf(this.selected_btn);
            if (_loc_2 != -1)
            {
                this.panel_mcs[_loc_2].visible = true;
            }
            this.showItem();
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            return;
        }// end function

        private function clear() : void
        {
            return;
        }// end function

        private function onClosePanel(event:MouseEvent) : void
        {
            TaskControl.getInstance().openOrClose();
            return;
        }// end function

    }
}
