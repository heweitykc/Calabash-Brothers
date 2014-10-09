package com.game.task.mediator
{
    import __AS3__.vec.*;
    import com.cfg.obj.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.game.clickstream.*;
    import com.game.common.*;
    import com.game.guide.*;
    import com.game.guide.control.*;
    import com.game.guide.model.*;
    import com.game.task.*;
    import com.game.task.control.*;
    import com.game.task.events.*;
    import com.game.task.model.*;
    import com.game.task.view.*;
    import com.model.*;
    import com.model.vo.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;

    public class DailyTaskMediator extends Object implements IGuide
    {
        private var panel:TaskPanel;
        public var mc_shoe:BaseButton;
        public var btn_done:BaseButton;
        public var btn_op:BaseButton;
        public var btn_task:BaseButton;
        public var dif_up:BaseButton;
        public var dif_down:BaseButton;
        public var dif_mc1:MovieClip;
        public var dif_mc2:MovieClip;
        public var dif_mc3:MovieClip;
        public var dif_mc4:MovieClip;
        public var dif_mc5:MovieClip;
        public var rew_mc1:MovieClip;
        public var rew_mc2:MovieClip;
        public var rew_mc3:MovieClip;
        public var rew_mc4:MovieClip;
        public var rew_mc5:MovieClip;
        public var mc_icon:MovieClip;
        public var range:MovieClip;
        public var txt_target:TextField;
        public var txt_label1:TextField;
        public var txt_reward:TextField;
        public var txt_total:TextField;
        private var rangeMaxLen:int;
        public var rewardGrid:Vector.<RewardBox>;
        public var allGrid:Vector.<RewardBox>;
        private var diffList:Vector.<MovieClip>;
        private var rewardsList:Vector.<MovieClip>;
        private var view:MovieClip;
        private var taskId:int;
        private var task:DailyTaskMsgVO;
        private var backTime:int = 60;

        public function DailyTaskMediator(param1:MovieClip, param2:TaskPanel)
        {
            var _loc_5:* = 0;
            var _loc_6:* = null;
            this.panel = param2;
            this.view = param1;
            this.mc_shoe = new BaseButton(param1.getChildByName("mc_shoe"));
            this.mc_shoe.addEventListener(MouseEvent.CLICK, this.onMouseClickHandle);
            this.mc_shoe.visible = false;
            this.btn_done = new BaseButton(param1.getChildByName("btn_done"));
            StringTip.create(this.btn_done, LanguageCfgObj.getInstance().getByIndex("11306"));
            this.btn_done.mouseChildren = false;
            this.btn_done.setText(LanguageCfgObj.getInstance().getByIndex("11307"));
            this.btn_done.addEventListener(MouseEvent.CLICK, this.onAllComplete);
            this.btn_op = new BaseButton(param1.getChildByName("btn_op"));
            this.btn_task = new BaseButton(param1.getChildByName("btn_task"));
            this.btn_op.setText(LanguageCfgObj.getInstance().getByIndex("11308"));
            this.btn_task.setText(LanguageCfgObj.getInstance().getByIndex("11309"));
            StringTip.create(this.btn_op, LanguageCfgObj.getInstance().getByIndex("11310"));
            this.btn_op.addEventListener(MouseEvent.CLICK, this.onCurrentComplete);
            this.btn_task.addEventListener(MouseEvent.CLICK, this.onCurrentTask);
            this.dif_down = new BaseButton(param1.getChildByName("dif_down"));
            this.dif_up = new BaseButton(param1.getChildByName("dif_up"));
            this.dif_down.addEventListener(MouseEvent.CLICK, this.ondoDiffDown);
            this.dif_up.addEventListener(MouseEvent.CLICK, this.ondoRewardUp);
            var _loc_3:* = UserObj.getInstance().playerInfo.level;
            StringTip.create(this.dif_down, LanguageCfgObj.getInstance().getByIndex("11311"));
            StringTip.create(this.dif_up, LanguageCfgObj.getInstance().getByIndex("11312"));
            this.dif_mc1 = param1.getChildByName("dif_mc1") as MovieClip;
            this.dif_mc2 = param1.getChildByName("dif_mc2") as MovieClip;
            this.dif_mc3 = param1.getChildByName("dif_mc3") as MovieClip;
            this.dif_mc4 = param1.getChildByName("dif_mc4") as MovieClip;
            this.dif_mc5 = param1.getChildByName("dif_mc5") as MovieClip;
            this.diffList = new Vector.<MovieClip>;
            this.diffList.push(this.dif_mc1, this.dif_mc2, this.dif_mc3, this.dif_mc4, this.dif_mc5);
            this.rew_mc1 = param1.getChildByName("rew_mc1") as MovieClip;
            this.rew_mc2 = param1.getChildByName("rew_mc2") as MovieClip;
            this.rew_mc3 = param1.getChildByName("rew_mc3") as MovieClip;
            this.rew_mc4 = param1.getChildByName("rew_mc4") as MovieClip;
            this.rew_mc5 = param1.getChildByName("rew_mc5") as MovieClip;
            this.rewardsList = new Vector.<MovieClip>;
            this.rewardsList.push(this.rew_mc1, this.rew_mc2, this.rew_mc3, this.rew_mc4, this.rew_mc5);
            var _loc_4:* = 0;
            while (_loc_4 < 5)
            {
                
                this.diffList[_loc_4].gotoAndStop(1);
                this.rewardsList[_loc_4].gotoAndStop(1);
                _loc_4++;
            }
            this.rewardGrid = new Vector.<RewardBox>(4);
            _loc_4 = 0;
            while (_loc_4 < 5)
            {
                
                this.rewardGrid[_loc_4] = new RewardBox("commonRewardBox2_40");
                this.rewardGrid[_loc_4].img.move(4, 4);
                this.rewardGrid[_loc_4].textField.x = 1;
                this.rewardGrid[_loc_4].textField.y = 30;
                _loc_4++;
            }
            this.allGrid = new Vector.<RewardBox>(8);
            _loc_5 = 0;
            while (_loc_5 < 2)
            {
                
                _loc_4 = 0;
                while (_loc_4 < 4)
                {
                    
                    _loc_6 = new RewardBox("commonRewardBox2_40");
                    _loc_6.img.move(4, 4);
                    _loc_6.textField.x = 1;
                    _loc_6.textField.y = 30;
                    _loc_6.x = 156 + _loc_4 * 53;
                    _loc_6.y = 193 + _loc_5 * 61;
                    this.allGrid[4 * _loc_5 + _loc_4] = _loc_6;
                    _loc_4++;
                }
                _loc_5++;
            }
            this.range = param1.getChildByName("range") as MovieClip;
            this.rangeMaxLen = this.range.width;
            this.mc_icon = param1.getChildByName("mc_icon") as MovieClip;
            this.txt_target = param1.getChildByName("txt_target") as TextField;
            this.txt_target.autoSize = TextFieldAutoSize.LEFT;
            this.txt_label1 = param1.getChildByName("txt_label1") as TextField;
            this.txt_target.addEventListener(TextEvent.LINK, this.onGetTaskTarget);
            TaskGlobal.myEvt.addEvtListener(TaskEvent.DAILY_TASK_CHANGE, this.onDailyTaskChange);
            TaskGlobal.myEvt.addEvtListener(TaskEvent.TASK_LIST_UPDATE, this.dailyTaskOver);
            RoleList.getInstance().player.info.addEventListener(RoleEvent.UPDATE_LEVEL, this.__userLevelUpdateHandler);
            this.registerGuide();
            return;
        }// end function

        private function __userLevelUpdateHandler(event:RoleEvent) : void
        {
            if (!this.dif_down)
            {
                return;
            }
            var _loc_2:* = UserObj.getInstance().playerInfo.level;
            var _loc_3:* = LevelExpCfgObj.getInstance().getQ_remoney(UserObj.getInstance().playerInfo.job, _loc_2) * 180;
            StringTip.create(this.dif_down, LanguageCfgObj.getInstance().getByIndex("11311"));
            StringTip.create(this.dif_up, LanguageCfgObj.getInstance().getByIndex("11312"));
            return;
        }// end function

        private function onDailyTaskChange(event:TaskEvent = null) : void
        {
            var _loc_2:* = event.data as DailyTaskMsgVO;
            this.showItem(_loc_2);
            if (this.panel.tab_btns[1].visible == false)
            {
                this.panel.tab_btns[1].visible = true;
            }
            this.panel.tab_btns[1].setText(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12241"), [_loc_2.acceptNum]));
            return;
        }// end function

        private function onGetTaskTarget(event:TextEvent) : void
        {
            if (this.task && !this.task.complete)
            {
                TaskGlobal.currentTask = this.task;
            }
            TaskLinkEventManager.linkEventHandle(event);
            return;
        }// end function

        public function resetAndShow() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_1:* = TaskModel.getInstance();
            var _loc_2:* = _loc_1.dailyTaskList;
            if (_loc_2.length > 0)
            {
                _loc_4 = 0;
                while (_loc_4 < _loc_2.length)
                {
                    
                    _loc_3 = _loc_2[_loc_4];
                    this.showItem(_loc_3);
                    _loc_4++;
                }
            }
            else
            {
                this._dailyTaskOver();
            }
            return;
        }// end function

        private function showItem(param1:DailyTaskMsgVO) : void
        {
            var _loc_8:* = null;
            this.view.mc_complete.visible = false;
            this.dif_down.visible = true;
            this.dif_up.visible = true;
            if (param1.complete)
            {
                this.btn_task.setText(LanguageCfgObj.getInstance().getByIndex("11309"));
                ButtonFlickerControl.getInstance().addButtonFlicker(this.btn_task);
                this.btn_op.enabled = false;
                this.btn_op.filters = [ColorFilter.getGrayFilter()];
            }
            else
            {
                this.btn_task.setText(LanguageCfgObj.getInstance().getByIndex("11316"));
                ButtonFlickerControl.getInstance().removeButtonFlicker(this.btn_task);
                this.btn_op.filters = null;
                this.btn_op.enabled = true;
            }
            var _loc_9:* = null;
            this.btn_done.filters = null;
            this.btn_task.filters = _loc_9;
            var _loc_9:* = true;
            this.btn_done.enabled = true;
            this.btn_task.enabled = _loc_9;
            this.task = param1;
            this.taskId = param1.taskId;
            this.txt_target.htmlText = param1.target;
            this.txt_label1.text = LanguageCfgObj.getInstance().getByIndex("12242") + param1.acceptNum + "/" + TaskGlobal.DAILY_TASK_MAX_RANGE;
            this.range.width = this.rangeMaxLen * (param1.acceptNum / TaskGlobal.DAILY_TASK_MAX_RANGE);
            if (param1.actionMsg)
            {
                this.mc_shoe.visible = true;
                _loc_8 = this.txt_target.getCharBoundaries((this.txt_target.text.length - 1));
                if (_loc_8)
                {
                    this.mc_shoe.x = this.txt_target.x + _loc_8.x + 10;
                    this.mc_shoe.y = this.txt_target.y + _loc_8.y - 10;
                }
                else
                {
                    this.mc_shoe.x = this.txt_target.x + this.txt_target.textWidth + 2;
                }
            }
            var _loc_2:* = 0;
            while (_loc_2 < 5)
            {
                
                this.diffList[_loc_2].gotoAndStop(_loc_2 < param1.hard ? (1) : (2));
                _loc_2++;
            }
            _loc_2 = 0;
            while (_loc_2 < 5)
            {
                
                this.rewardsList[_loc_2].gotoAndStop(_loc_2 < param1.rich ? (1) : (2));
                _loc_2++;
            }
            var _loc_3:* = TaskCfgObj.getInstance().getDailyReward(param1.data.jlId);
            var _loc_9:* = this.getRewards(_loc_3, this.rewardGrid);
            var _loc_4:* = this.getRewards(_loc_3, this.rewardGrid);
            _loc_4 = _loc_9;
            var _loc_5:* = 461;
            var _loc_6:* = 0;
            while (_loc_6 < this.rewardGrid.length)
            {
                
                if (_loc_6 < _loc_4)
                {
                    this.rewardGrid[_loc_6].x = _loc_5 + _loc_6 * 53;
                    this.rewardGrid[_loc_6].y = 308;
                    this.view.addChild(this.rewardGrid[_loc_6]);
                }
                else if (this.view.contains(this.rewardGrid[_loc_6]))
                {
                    this.view.removeChild(this.rewardGrid[_loc_6]);
                }
                _loc_6++;
            }
            var _loc_7:* = TaskCfgObj.getInstance().getExtraReward(param1.data.otherjlId);
            if (!TaskCfgObj.getInstance().getExtraReward(param1.data.otherjlId))
            {
                return;
            }
            _loc_4 = this.getRewards(_loc_7, this.allGrid);
            _loc_6 = 0;
            while (_loc_6 < this.allGrid.length)
            {
                
                if (_loc_6 < _loc_4)
                {
                    this.view.addChild(this.allGrid[_loc_6]);
                }
                else if (this.view.contains(this.allGrid[_loc_6]))
                {
                    this.view.removeChild(this.allGrid[_loc_6]);
                }
                _loc_6++;
            }
            return;
        }// end function

        private function dailyTaskOver(event:TaskEvent) : void
        {
            if (event.data.toString() == "day_over")
            {
                this._dailyTaskOver();
            }
            return;
        }// end function

        private function _dailyTaskOver() : void
        {
            this.txt_label1.text = LanguageCfgObj.getInstance().getByIndex("12242") + TaskGlobal.DAILY_TASK_MAX_RANGE + "/" + TaskGlobal.DAILY_TASK_MAX_RANGE;
            this.range.width = this.rangeMaxLen;
            this.mc_shoe.visible = false;
            this.txt_target.text = "";
            var _loc_1:* = 0;
            while (_loc_1 < 5)
            {
                
                this.diffList[_loc_1].gotoAndStop(1);
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < 5)
            {
                
                this.rewardsList[_loc_1].gotoAndStop(1);
                _loc_1++;
            }
            this.btn_task.setText(LanguageCfgObj.getInstance().getByIndex("11309"));
            this.dif_down.visible = false;
            this.dif_up.visible = false;
            var _loc_2:* = [ColorFilter.getGrayFilter()];
            this.btn_done.filters = [ColorFilter.getGrayFilter()];
            this.btn_op.filters = _loc_2;
            this.btn_task.filters = _loc_2;
            ButtonFlickerControl.getInstance().removeButtonFlicker(this.btn_task);
            var _loc_2:* = false;
            this.btn_done.enabled = false;
            this.btn_op.enabled = _loc_2;
            this.btn_task.enabled = _loc_2;
            this.view.mc_complete.parent.addChild(this.view.mc_complete);
            this.view.mc_complete.visible = true;
            return;
        }// end function

        private function getRewards(param1:Object, param2:Vector.<RewardBox>) : int
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            var _loc_14:* = 0;
            var _loc_3:* = 0;
            if (Number(param1.q_rewards_exp) > 0)
            {
                _loc_4 = param2[_loc_3++];
                _loc_4.text = param1.q_rewards_exp;
                _loc_5 = new MoneyInfo();
                _loc_5.id = "i50001";
                _loc_5.num = param1.q_rewards_exp;
                _loc_5.name = Common.moneys[_loc_5.id].name;
                _loc_5.tip = Common.moneys[_loc_5.id].tip;
                _loc_4.data = _loc_5;
            }
            if (param1.q_rewards_coin > 0)
            {
                _loc_4 = param2[_loc_3++];
                _loc_4.text = param1.q_rewards_coin;
                _loc_5 = new MoneyInfo();
                _loc_5.id = "i50002";
                _loc_5.num = param1.q_rewards_coin;
                _loc_5.name = Common.moneys[_loc_5.id].name;
                _loc_5.tip = Common.moneys[_loc_5.id].tip;
                _loc_4.data = _loc_5;
            }
            if (param1.q_rewards_zq > 0)
            {
                _loc_4 = param2[_loc_3++];
                _loc_4.text = param1.q_rewards_zq;
                _loc_5 = new MoneyInfo();
                _loc_5.id = "i50002";
                _loc_5.num = param1.q_rewards_zq;
                _loc_5.name = Common.moneys[_loc_5.id].name;
                _loc_5.tip = Common.moneys[_loc_5.id].tip;
                _loc_4.data = _loc_5;
            }
            if (param1.q_rewards_prestige > 0)
            {
                _loc_4 = param2[_loc_3++];
                _loc_4.text = param1.q_rewards_prestige + "";
                _loc_5 = new MoneyInfo();
                _loc_5.id = "i50002";
                _loc_5.num = param1.q_rewards_prestige;
                _loc_5.name = Common.moneys[_loc_5.id].name;
                _loc_5.tip = Common.moneys[_loc_5.id].tip;
                _loc_4.data = _loc_5;
            }
            if (param1.q_rewards_bindyuanbao > 0)
            {
                _loc_4 = param2[_loc_3++];
                _loc_4.text = param1.q_rewards_bindyuanbao + "";
                _loc_5 = new MoneyInfo();
                _loc_5.id = "i50004";
                _loc_5.num = param1.q_rewards_bindyuanbao;
                _loc_5.name = Common.moneys[_loc_5.id].name;
                _loc_5.tip = Common.moneys[_loc_5.id].tip;
                _loc_4.data = _loc_5;
            }
            var _loc_6:* = param1.q_rewards_goods;
            if (param1.q_rewards_goods && _loc_6 != "")
            {
                _loc_7 = _loc_6.split(";");
                _loc_8 = 0;
                while (_loc_8 < _loc_7.length)
                {
                    
                    _loc_9 = _loc_7[_loc_8];
                    _loc_10 = _loc_9.split("_");
                    _loc_11 = _loc_10[0];
                    _loc_13 = new PropInfo();
                    if (_loc_11.search("!") != -1)
                    {
                        _loc_12 = int(_loc_11.replace("!", ""));
                        _loc_13.isbind = 0;
                    }
                    else
                    {
                        _loc_12 = _loc_10[0];
                        _loc_13.isbind = 1;
                    }
                    _loc_14 = _loc_10[1];
                    _loc_13.convByCfg(_loc_12);
                    _loc_13.num = _loc_14;
                    _loc_4 = param2[_loc_3++];
                    _loc_4.text = _loc_14 + "";
                    _loc_4.data = _loc_13;
                    _loc_8++;
                }
            }
            return _loc_3;
        }// end function

        public function onAllComplete(event:MouseEvent) : void
        {
            TaskGlobal.protocol.oneKeyFinishCurrentDailyTask(this.taskId, 1);
            return;
        }// end function

        private function onCurrentComplete(event:MouseEvent) : void
        {
            TaskGlobal.protocol.oneKeyFinishCurrentDailyTask(this.taskId, 2);
            return;
        }// end function

        private function onCurrentTask(event:MouseEvent) : void
        {
            if (!this.task)
            {
                return;
            }
            if (this.task.complete)
            {
                TaskGlobal.protocol.reqDailyTaskFinish(this.task.data.premiseId);
                ClickStream.add(ClickStreamId.CLICK_RiChangRenWu_LingQuJiangLi);
            }
            else
            {
                if (this.task.actionMsg)
                {
                    TaskGlobal.currentTask = this.task;
                }
                TaskLinkEventManager.handle(this.task.actionMsg);
                TaskControl.getInstance().close();
            }
            return;
        }// end function

        private function ondoDiffDown(event:MouseEvent) : void
        {
            TaskGlobal.protocol.reqTaskDownHard(this.taskId);
            return;
        }// end function

        private function ondoRewardUp(event:MouseEvent) : void
        {
            TaskGlobal.protocol.reqDailyTaskUpAchieve(this.taskId);
            return;
        }// end function

        private function onMouseClickHandle(event:MouseEvent) : void
        {
            if (this.task.actionMsg)
            {
                TaskGlobal.currentTask = this.task;
                TaskGlobal.manager.transferScene(this.task.actionMsg);
            }
            return;
        }// end function

        private function removeFromStage(event:Event) : void
        {
            this.guidePause(GuideConfigObj.getInstance().FIRST_COMPLETE_TASK_2);
            this.guidePause(GuideConfigObj.getInstance().FIRST_COMPLETE_TASK_3);
            if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().FIRST_COMPLETE_TASK)) == 0)
            {
                GuideConfigObj.getInstance().saveConfigByTeam(int(GuideConfigObj.getInstance().FIRST_COMPLETE_TASK), 1);
            }
            return;
        }// end function

        public function registerGuide() : void
        {
            GuideMultiControl.getInstance().registerGuide(this.btn_task, this, GuideConfigObj.getInstance().FIRST_COMPLETE_TASK_2);
            GuideMultiControl.getInstance().registerGuide(this.panel.btn_close, this, GuideConfigObj.getInstance().FIRST_COMPLETE_TASK_3);
            this.panel.addEventListener(Event.REMOVED_FROM_STAGE, this.removeFromStage);
            return;
        }// end function

        public function guideAction(param1:String) : void
        {
            return;
        }// end function

        public function guidePause(param1:String) : void
        {
            GuideMultiControl.getInstance().backGuide(param1, 1);
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
