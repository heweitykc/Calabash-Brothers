package com.game.task.view
{
    import com.events.*;
    import com.f1.interfaces.ui.list.*;
    import com.f1.ui.btn.*;
    import com.game.guide.*;
    import com.game.guide.control.*;
    import com.game.guide.model.*;
    import com.game.task.*;
    import com.game.task.model.*;
    import com.game.team.view.*;
    import com.game.vip.control.*;
    import com.model.*;
    import com.view.tipcell.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;

    public class TaskTextRender extends ListItemBase implements IItem, IGuide
    {
        private var _textField:TextField;
        private var _textField2:TextField;
        public var mc_shoe:BaseButton;
        private var _needBubbleGuide:Boolean;
        private var _data:Object;

        public function TaskTextRender()
        {
            super("FastTaskItemRender");
            return;
        }// end function

        override protected function getComp() : void
        {
            var _loc_1:* = null;
            if (!this._textField)
            {
                this._textField = _content.getChildByName("label") as TextField;
                this._textField.selectable = false;
                this._textField.mouseWheelEnabled = false;
                this._textField.textColor = 16777215;
                this._textField2 = _content.getChildByName("content") as TextField;
                this._textField2.wordWrap = true;
                this._textField2.multiline = true;
                this._textField2.selectable = false;
                this._textField2.mouseWheelEnabled = false;
                this._textField2.width = 178;
                _loc_1 = new StyleSheet();
                _loc_1.parseCSS("a:hover { color:#00fffc; }");
                this._textField2.styleSheet = _loc_1;
                this.mc_shoe = new BaseButton(_content.getChildByName("mc_shoe"));
                ShoeTipUtil.tip(this.mc_shoe);
                this.mc_shoe.addEventListener(MouseEvent.CLICK, this.onTransferHandle);
                UserObj.getInstance().playerInfo.addEvtListener(RoleEvent.UPDATE_VIP_LEVEL, this.onVIPUpdate);
                this.mc_shoe.visible = false;
            }
            return;
        }// end function

        private function onVIPUpdate(event:RoleEvent) : void
        {
            if (this._data is TaskMsgVO)
            {
                if (VIPControl.getInstance().vipinfo && VIPControl.getInstance().vipinfo.stageLevel == 1 && this.mc_shoe && this.mc_shoe.visible)
                {
                    BubbleTextControl.getInstance().showBubbleText(this.mc_shoe, this._data.taskId, this._data.complete);
                }
                else
                {
                    BubbleTextControl.getInstance().closeBubbleText();
                }
            }
            return;
        }// end function

        private function onCompleteHandle(event:MouseEvent) : void
        {
            event.stopImmediatePropagation();
            var _loc_2:* = (this._data as DailyTaskMsgVO).taskId;
            TaskGlobal.protocol.oneKeyFinishCurrentDailyTask(_loc_2, 2);
            return;
        }// end function

        private function onTransferHandle(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            event.stopImmediatePropagation();
            if (this._data is TaskMsgVO)
            {
                _loc_3 = this._data as TaskMsgVO;
                TaskGlobal.task = _loc_3;
                TaskGlobal.currentTask = _loc_3;
                if (_loc_3.complete)
                {
                    _loc_2 = _loc_3.rewardMsg;
                }
                else
                {
                    _loc_2 = _loc_3.actionMsg;
                }
            }
            else if (this._data is DailyTaskMsgVO)
            {
                _loc_4 = this._data as DailyTaskMsgVO;
                TaskGlobal.currentTask = _loc_4;
                _loc_2 = (_loc_4 as DailyTaskMsgVO).actionMsg;
            }
            TaskGlobal.manager.transferScene(_loc_2);
            TaskGlobal.manager.clickLimitHandle(this.mc_shoe);
            BubbleTextControl.getInstance().closeBubbleText();
            return;
        }// end function

        public function get key()
        {
            return null;
        }// end function

        public function get obj()
        {
            return this._data;
        }// end function

        public function set obj(param1) : void
        {
            var _loc_2:* = null;
            this._needBubbleGuide = false;
            this._data = param1;
            if (this._data is DailyTaskMsgVO)
            {
                if ((this._data as DailyTaskMsgVO).actionMsg && !(this._data as DailyTaskMsgVO).complete)
                {
                    this.mc_shoe.visible = true;
                }
                else
                {
                    this.mc_shoe.visible = false;
                }
                ItemTips.create(this._textField, this._data.data.jlId, TaskAwardTips);
            }
            if (this._data is TaskMsgVO)
            {
                _loc_2 = this._data as TaskMsgVO;
                if (int(_loc_2.conf.q_task_type) == TaskGlobal.TASK_STRONG || int(_loc_2.conf.q_task_type) == TaskGlobal.TASK_ELSE && (!_loc_2.complete || !_loc_2.conf.q_endnpc || _loc_2.conf.q_endnpc == "") || int(_loc_2.conf.q_task_type) == TaskGlobal.TASK_STRONG2 && !_loc_2.complete || int(_loc_2.conf.q_task_type) == TaskGlobal.TASK_EQUIPMENT && !_loc_2.complete || (int(_loc_2.taskId) == 50028 || int(_loc_2.taskId) == 50029 || int(_loc_2.taskId) == 50005 || int(_loc_2.taskId) == 50006) && !_loc_2.complete)
                {
                    this.mc_shoe.visible = false;
                    if (_loc_2.type == 1)
                    {
                        BubbleTextControl.getInstance().closeBubbleText();
                    }
                }
                else
                {
                    if (_loc_2.complete)
                    {
                        if (_loc_2.rewardMsg)
                        {
                            this.mc_shoe.visible = true;
                        }
                        else
                        {
                            this.mc_shoe.visible = false;
                        }
                    }
                    else if (_loc_2.actionMsg)
                    {
                        this.mc_shoe.visible = true;
                    }
                    else
                    {
                        this.mc_shoe.visible = false;
                    }
                    if (_loc_2.type == 1 && VIPControl.getInstance().vipinfo && VIPControl.getInstance().vipinfo.stageLevel == 1 && this.mc_shoe && this.mc_shoe.visible)
                    {
                        this._needBubbleGuide = true;
                        addEventListener(Event.ADDED_TO_STAGE, this.__addToStage);
                    }
                    else if (_loc_2.type == 1)
                    {
                        BubbleTextControl.getInstance().closeBubbleText();
                    }
                }
                ItemTips.create(this._textField, this._data.conf, TaskAwardTips);
            }
            if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().FIRST_DAILY_TASK)) == 0 && this._data is DailyTaskMsgVO && !this._data.complete)
            {
                addEventListener(Event.ADDED_TO_STAGE, this.__addToStage);
            }
            return;
        }// end function

        public function get label() : String
        {
            return this._textField.text;
        }// end function

        public function setText(param1:String, param2:String = "", param3:String = "") : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            this._textField.htmlText = param1;
            this._textField2.htmlText = param2;
            if (param2 != "")
            {
                _loc_4 = this._textField2.text;
                _loc_5 = this._textField2.getCharBoundaries((_loc_4.length - 1));
                if (_loc_5)
                {
                    this.mc_shoe.x = _loc_5.x + 28;
                    this.mc_shoe.y = _loc_5.y + 15;
                }
                else
                {
                    this.mc_shoe.x = this._textField2.textWidth + 18;
                }
            }
            else
            {
                this.mc_shoe.visible = false;
            }
            if (param3 != "")
            {
                if (param2 != "")
                {
                    _loc_4 = param2 + "\n" + param3;
                }
                else
                {
                    _loc_4 = param3;
                }
                this._textField2.htmlText = _loc_4;
            }
            this._textField2.height = this._textField2.textHeight + 4 + 2;
            this._h = this._textField2.y + this._textField2.height;
            this.resize();
            return;
        }// end function

        public function get textTitle() : TextField
        {
            return this._textField;
        }// end function

        public function get textContent() : TextField
        {
            return this._textField2;
        }// end function

        public function setSelected(param1:Boolean, param2:Boolean = true) : void
        {
            selected = param1;
            return;
        }// end function

        override public function clean() : void
        {
            GuideControl.getInstance().unregisterGuide(this, GuideConfigObj.getInstance().GEN_TASK_GUIDE_ID_1);
            BubbleTextControl.getInstance().closeBubbleText();
            this._needBubbleGuide = false;
            return;
        }// end function

        override public function resize() : void
        {
            super.resize();
            if (this._data.type == 1 && VIPControl.getInstance().vipinfo && VIPControl.getInstance().vipinfo.stageLevel == 1 && this.mc_shoe && this.mc_shoe.visible)
            {
                this._needBubbleGuide = true;
                addEventListener(Event.ADDED_TO_STAGE, this.__addToStage);
            }
            if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().FIRST_COMPLETE_TASK)) == 0 && this._data is DailyTaskMsgVO && this._data.complete)
            {
                addEventListener(Event.ADDED_TO_STAGE, this.__addToStage);
            }
            return;
        }// end function

        private function __addToStage(event:Event) : void
        {
            if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().FIRST_DAILY_TASK)) == 0 && this._data is DailyTaskMsgVO && !this._data.complete)
            {
                BubbleTextControl.getInstance().showBubbleText(this.mc_shoe, this._data.taskId, this._data.complete, true);
                GuideConfigObj.getInstance().saveConfigByTeam(int(GuideConfigObj.getInstance().FIRST_DAILY_TASK), 1);
            }
            else
            {
                BubbleTextControl.getInstance().showBubbleText(this.mc_shoe, this._data.taskId, this._data.complete);
            }
            removeEventListener(Event.ADDED_TO_STAGE, this.__addToStage);
            if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().FIRST_COMPLETE_TASK)) == 0 && this._data is DailyTaskMsgVO && this._data.complete)
            {
                GuideMultiControl.getInstance().registerGuide(this._textField2, this, GuideConfigObj.getInstance().FIRST_COMPLETE_TASK_1);
                GuideMultiControl.getInstance().beginGuide(int(GuideConfigObj.getInstance().FIRST_COMPLETE_TASK));
            }
            return;
        }// end function

        public function registerGuide() : void
        {
            GuideControl.getInstance().registerGuide(this, this, GuideConfigObj.getInstance().GEN_TASK_GUIDE_ID_1);
            return;
        }// end function

        public function guideAction(param1:String) : void
        {
            return;
        }// end function

        public function guidePause(param1:String) : void
        {
            return;
        }// end function

        public function guideEnd(param1:String) : void
        {
            return;
        }// end function

        public function isGuideReady() : Boolean
        {
            return true;
        }// end function

    }
}
