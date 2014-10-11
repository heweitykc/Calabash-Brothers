package com.game.task.control
{
    import com.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.vmc.*;
    import com.game.prompt.utils.*;
    import com.game.sound.control.*;
    import com.game.task.events.*;
    import com.game.task.message.*;
    import com.game.task.model.*;
    import com.game.task.view.*;
    import com.greensock.*;
    import flash.events.*;

    public class TaskControl extends Object
    {
        private var _completeEffect:VMCView;
        private var _taskPanel:TaskPanel;
        private static var instance:TaskControl;

        public function TaskControl()
        {
            FrameworkGlobal.addMsgListen(TaskEvent.ACCEPT_TASK, this.onTaskAccept);
            return;
        }// end function

        public function taskListHandler(param1:ResTaskListMessage) : void
        {
            TaskModel.getInstance().updateResTaskListMessage(param1);
            return;
        }// end function

        public function rankTaskListHandler(param1:ResRankTaskListMessage) : void
        {
            return;
        }// end function

        public function resDailyTaskChangeHandle(param1:ResDailyTaskChangeMessage) : void
        {
            TaskModel.getInstance().updateDailyTaskListMessage(param1);
            return;
        }// end function

        public function resConquerTaskChangeHandler(param1:ResConquerTaskChangeMessage) : void
        {
            return;
        }// end function

        public function resMainTaskChangeHandler(param1:ResMainTaskChangeMessage) : void
        {
            TaskModel.getInstance().updateResMainTaskMessage(param1);
            return;
        }// end function

        public function resRankTaskChangeHandler(param1:ResRankTaskChangeMessage) : void
        {
            return;
        }// end function

        public function resTreasureHuntTaskChangeHandler(param1:ResTreasureHuntTaskChangeMessage) : void
        {
            return;
        }// end function

        public function resTaskFinshHandle(param1:ResTaskFinshMessage) : void
        {
            TaskModel.getInstance().resTaskFinshMessage(param1);
            this.playEffect();
            return;
        }// end function

        private function playEffect() : void
        {
            if (this._completeEffect)
            {
                return;
            }
            this._completeEffect = new VMCView();
            this._completeEffect.auto = true;
            this._completeEffect.loadRes("res/effect/completetask.png", null, true, this.loadCompleteEffectComplete);
            return;
        }// end function

        private function loadCompleteEffectComplete() : void
        {
            SoundControl.getInstance().playSound(SoundFlag.COMPLETE_TASK);
            this._completeEffect.addEventListener(Event.COMPLETE, this.completeEffectPlayComplete);
            this._completeEffect.updatePose("90", false);
            this._completeEffect.play();
            this._completeEffect.move(FrameworkGlobal.stage.stageWidth - 280, 200);
            FrameworkGlobal.stage.addChild(this._completeEffect);
            return;
        }// end function

        private function completeEffectPlayComplete(event:Event) : void
        {
            if (!this._completeEffect)
            {
                return;
            }
            FrameworkGlobal.stage.removeChild(this._completeEffect);
            this._completeEffect.finalize();
            this._completeEffect = null;
            return;
        }// end function

        public function get taskPanel() : TaskPanel
        {
            return this._taskPanel;
        }// end function

        public function open() : void
        {
            if (this._taskPanel == null)
            {
                this._taskPanel = new TaskPanel();
                Global.popManager.addPop(this._taskPanel);
            }
            this._taskPanel.open();
            return;
        }// end function

        public function openOrClose(param1:int = 0) : void
        {
            if (this._taskPanel == null)
            {
                this._taskPanel = new TaskPanel();
                Global.popManager.addPop(this._taskPanel);
            }
            this._taskPanel.openOrClose();
            if (this._taskPanel.isOpen)
            {
                this._taskPanel.showType(param1);
            }
            return;
        }// end function

        public function close() : void
        {
            if (this._taskPanel)
            {
                this._taskPanel.close();
            }
            return;
        }// end function

        public function showGetReward(param1:ResTaskRewardInBagMessage) : void
        {
            var _loc_2:* = param1.inBagList;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2.length)
            {
                
                _loc_3 = _loc_3 + 0.2;
                TweenLite.delayedCall(_loc_3, ItemGetAnim.doFlyGetItemToBack, [_loc_2[_loc_4]]);
                _loc_4++;
            }
            return;
        }// end function

        private function onTaskAccept(event:TaskEvent) : void
        {
            var _loc_5:* = null;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.taskId;
            var _loc_4:* = TaskCfgObj.getInstance().getTaskById(_loc_3);
            if (TaskCfgObj.getInstance().getTaskById(_loc_3))
            {
                _loc_5 = _loc_4.q_word;
                if (_loc_5)
                {
                    new TaskWordView(_loc_5);
                }
            }
            return;
        }// end function

        public static function getInstance() : TaskControl
        {
            if (instance == null)
            {
                instance = new TaskControl;
            }
            return instance;
        }// end function

    }
}
