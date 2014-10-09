package com.game.task
{
    import __AS3__.vec.*;
    import com.*;
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.utils.*;
    import com.f1.utils.path.*;
    import com.f1.view.mapeditor.*;
    import com.game.autopk.*;
    import com.game.autopk.controller.*;
    import com.game.autopk.event.*;
    import com.game.common.*;
    import com.game.dragonking.control.*;
    import com.game.fight.control.*;
    import com.game.map.control.*;
    import com.game.map.model.*;
    import com.game.movie.*;
    import com.game.role.*;
    import com.game.role.control.*;
    import com.game.task.control.*;
    import com.game.task.events.*;
    import com.game.task.model.*;
    import com.game.task.view.*;
    import com.game.zones.control.*;
    import com.game.zones.view.bosshome.*;
    import com.greensock.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import flash.display.*;
    import flash.events.*;
    import interfaces.role.*;

    public class TaskManager extends Object
    {
        public var panel:TaskDialogPanel;
        private const delay_time:int = 5000;
        private var transferpanel:TransferPanel;
        private var _saveX:int;
        private var _saveY:int;
        private var _saveMap:int;
        private var _saveIsUserAction:Boolean;

        public function TaskManager()
        {
            return;
        }// end function

        public function arrivedHandle() : void
        {
            var _loc_2:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            Player.state = State.NONE;
            if (TaskGlobal.task_mode == false)
            {
                return;
            }
            if (this.panel && this.panel.isOpen)
            {
                return;
            }
            if (AutoFightManager.getInstance().fightLogic.fighting)
            {
                return;
            }
            var _loc_1:* = RoleList.getInstance().player;
            if (TaskGlobal.currentTask is DailyTaskMsgVO)
            {
                _loc_6 = TaskGlobal.currentTask.actionMsg;
                if (!_loc_6)
                {
                    return;
                }
                _loc_2 = ToolKit.distance(_loc_1._x / 25, _loc_1._y / 25, _loc_6.x, _loc_6.y);
                if (_loc_2 <= 6)
                {
                    _loc_7 = new Vector.<int>;
                    _loc_7.push(_loc_6.id);
                    this.autoFight(true, _loc_7);
                }
                return;
            }
            var _loc_3:* = TaskGlobal.task;
            if (!_loc_3)
            {
                return;
            }
            if (!_loc_1)
            {
                return;
            }
            var _loc_4:* = UserObj.getInstance().playerInfo.level;
            if (_loc_3.levelLimit > _loc_4)
            {
                _loc_8 = _loc_3.actionMsg;
                if (!_loc_8)
                {
                    return;
                }
                _loc_2 = ToolKit.distance(_loc_1._x / 25, _loc_1._y / 25, _loc_8.x, _loc_8.y);
                if (_loc_2 <= 6)
                {
                    AutoFightController.getInstance().openAutoFight();
                }
            }
            var _loc_5:* = MapObj.getInstance().mapID;
            if (_loc_3.complete)
            {
                _loc_9 = _loc_3.conf;
                _loc_10 = NpcCfgObj.getInstance().getNpcByID(_loc_9.q_endnpc);
                if (!_loc_10)
                {
                    return;
                }
                if (_loc_10._map != _loc_5)
                {
                    return;
                }
                _loc_2 = ToolKit.distance(_loc_1._x / 25, _loc_1._y / 25, _loc_10._x, _loc_10._y);
                if (_loc_2 <= 6)
                {
                    if (_loc_1.isPathing)
                    {
                        MapControl.getInstance().stopPath(_loc_1);
                    }
                    _loc_1.stopPath();
                    this.talkWithNpc(_loc_3);
                }
            }
            else
            {
                _loc_8 = _loc_3.actionMsg;
                if (!_loc_8)
                {
                    return;
                }
                _loc_2 = ToolKit.distance(_loc_1._x / 25, _loc_1._y / 25, _loc_8.x, _loc_8.y);
                if (_loc_2 <= 6)
                {
                    this.excuteTask(_loc_3);
                }
            }
            return;
        }// end function

        private function excuteTask(param1:TaskMsgVO) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = param1.conf.q_task_type;
            switch(_loc_2)
            {
                case TaskGlobal.TASK_KILL:
                case TaskGlobal.TASK_DROP:
                {
                    _loc_3 = new Vector.<int>;
                    _loc_3.push(param1.actionMsg.id);
                    this.autoFight(true, _loc_3);
                    break;
                }
                case TaskGlobal.TASK_SEND:
                {
                    param1.complete = true;
                    this.talkWithNpc(param1);
                    break;
                }
                case TaskGlobal.TASK_GATHER:
                {
                    _loc_3 = new Vector.<int>;
                    _loc_3.push(param1.actionMsg.id);
                    this.autoFight(true, _loc_3, true);
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            return;
        }// end function

        public function autoFight(param1:Boolean, param2:Vector.<int> = null, param3:Boolean = false) : void
        {
            Player.state = State.NONE;
            AutoFightController.getInstance().closeAutoFind();
            if (param1)
            {
                if (AutoFightManager.getInstance().type == AutoFightManager.NONE_TYPE)
                {
                    AutoFightManager.getInstance().setMounsterType(param2);
                    AutoFightManager.getInstance().taskFight(true, param3);
                }
            }
            else
            {
                AutoFightManager.getInstance().fightLogic.addEventListener(AutoFightEvent.AUTO_FIGHT_STOP, this.onAutoFightStopHandle);
                AutoFightManager.getInstance().taskFight(false);
                AutoFightManager.getInstance().setMounsterType(null);
            }
            return;
        }// end function

        private function onAutoFightStopHandle(event:AutoFightEvent) : void
        {
            var evt:* = event;
            AutoFightManager.getInstance().fightLogic.removeEventListener(AutoFightEvent.AUTO_FIGHT_STOP, this.onAutoFightStopHandle);
            var delayHandle:* = function () : void
            {
                if (TaskGlobal.task_mode)
                {
                    continueTask(TaskGlobal.task, false);
                }
                return;
            }// end function
            ;
            TweenLite.delayedCall(1, delayHandle);
            return;
        }// end function

        private function cancelAutoFightHandle(event:MouseEvent) : void
        {
            if (event.target is GameBgView)
            {
                this.autoFight(false);
            }
            return;
        }// end function

        private function talkWithNpc(param1:TaskMsgVO) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            if (param1.conf.q_chat_content != null && param1.conf.q_chat_content != "")
            {
                _loc_2 = NpcDialog.getInstance();
                _loc_2.addEvtListener(Event.COMPLETE, this.onTalkOverHandle);
                _loc_2.x = (FrameworkGlobal.stageW - 532) * 0.5;
                _loc_2.y = FrameworkGlobal.stageH - 300;
                _loc_3 = new LayoutInfo(Layout.BOTTOM_CENTER, 0, 80);
                Global.mainUIManager.addUI(_loc_2, _loc_3);
                _loc_4 = [];
                _loc_5 = param1.conf.q_chat_content;
                _loc_6 = _loc_5.length;
                _loc_5 = _loc_5.substring(2, _loc_6 - 2);
                _loc_7 = _loc_5.split("@");
                _loc_8 = NpcCfgObj.getInstance().getNpcByID(param1.conf.q_endnpc);
                _loc_9 = 0;
                while (_loc_9 < _loc_7.length)
                {
                    
                    _loc_10 = _loc_7[_loc_9].split(":", 2);
                    _loc_11 = {};
                    _loc_11.content = _loc_10[1];
                    if (_loc_10[0] == "NPC" || _loc_10[0] == "npc")
                    {
                        _loc_11.url = _loc_8._npcIcon;
                        _loc_11.name = _loc_8._npcName;
                        _loc_11.dir = 1;
                    }
                    else if (_loc_10[0] == "hero")
                    {
                        _loc_11.url = UserObj.getInstance().playerInfo.headIcon;
                        _loc_11.name = UserObj.getInstance().playerInfo.name;
                        _loc_11.dir = 0;
                    }
                    _loc_4.push(_loc_11);
                    _loc_9++;
                }
                param1.conf.q_chat_content = "";
                _loc_2.data = _loc_4;
            }
            AutoFightController.getInstance().closeAutoFind();
            this.showNpcTalkPanel(param1);
            return;
        }// end function

        public function showNpcTalkPanel(param1:TaskMsgVO) : void
        {
            if (param1.conf.q_endnpc != "")
            {
                if (param1.complete)
                {
                    this.panel = TaskDialogPanel.getInstance();
                    this.panel.update(param1);
                    this.panel.open();
                    this.panel.addEvtListener(TaskEvent.TASK_GET_REWARD, this.onGetReward);
                }
                else
                {
                    this.panel = TaskDialogPanel.getInstance();
                    this.panel.update(param1);
                    this.panel.open();
                }
            }
            return;
        }// end function

        public function onGetReward(event:TaskEvent) : void
        {
            var _loc_2:* = event.currentTarget as TaskDialogPanel;
            var _loc_3:* = (event.data as TaskMsgVO).conf.q_double_rewards;
            if (_loc_2.twice && UserObj.getInstance().playerInfo.gold < _loc_3 && UserObj.getInstance().playerInfo.bindgold < _loc_3)
            {
                MapControl.getInstance().showRechargeD();
                return;
            }
            TaskGlobal.protocol.reqMainTaskFinish((event.data as TaskMsgVO).taskId, _loc_2.twice);
            _loc_2.removeEvtListener(TaskEvent.TASK_GET_REWARD, this.onGetReward);
            _loc_2.close();
            return;
        }// end function

        private function onTalkOverHandle(event:Event) : void
        {
            var _loc_2:* = event.currentTarget as NpcDialog;
            _loc_2.removeEvtListener(TalkBoxEvent.NEXT, this.onTalkOverHandle);
            if (_loc_2)
            {
                Global.mainUIManager.removeUI(_loc_2);
                _loc_2 = null;
            }
            return;
        }// end function

        public function closeTaskDialogPanel() : void
        {
            if (this.panel)
            {
                this.panel.close();
            }
            return;
        }// end function

        public function showReward(param1:Object, param2:Vector.<RewardBox>) : int
        {
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_13:* = null;
            var _loc_14:* = 0;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = 0;
            var _loc_18:* = null;
            var _loc_19:* = 0;
            var _loc_20:* = 0;
            var _loc_21:* = null;
            var _loc_22:* = 0;
            var _loc_23:* = 0;
            var _loc_24:* = 0;
            var _loc_25:* = false;
            var _loc_26:* = null;
            var _loc_27:* = null;
            var _loc_3:* = param1.q_rewards_exp;
            var _loc_4:* = param1.q_rewards_coin;
            var _loc_5:* = param1.q_rewards_zq;
            var _loc_6:* = param1.q_rewards_exploit;
            var _loc_7:* = param1.q_rewards_prestige;
            var _loc_8:* = param1.q_rewards_bindYuanBao;
            var _loc_9:* = 0;
            if (_loc_3 > 0)
            {
                _loc_10 = param2[_loc_9++];
                _loc_10.text = _loc_3 + "";
                _loc_11 = new MoneyInfo();
                _loc_11.id = "i50001";
                _loc_11.num = _loc_3;
                _loc_11.name = Common.moneys[_loc_11.id].name;
                _loc_11.tip = Common.moneys[_loc_11.id].tip;
                _loc_10.data = _loc_11;
            }
            if (_loc_4 > 0)
            {
                _loc_10 = param2[_loc_9++];
                _loc_10.text = _loc_4 + "";
                _loc_11 = new MoneyInfo();
                _loc_11.id = "i50002";
                _loc_11.num = _loc_4;
                _loc_11.name = Common.moneys[_loc_11.id].name;
                _loc_11.tip = Common.moneys[_loc_11.id].tip;
                _loc_10.data = _loc_11;
            }
            if (_loc_5 > 0)
            {
                _loc_10 = param2[_loc_9++];
                _loc_10.text = _loc_5 + "";
                _loc_11 = new MoneyInfo();
                _loc_11.id = "i50002";
                _loc_11.num = _loc_4;
                _loc_11.name = Common.moneys[_loc_11.id].name;
                _loc_11.tip = Common.moneys[_loc_11.id].tip;
                _loc_10.data = _loc_11;
            }
            if (_loc_6 > 0)
            {
                _loc_10 = param2[_loc_9++];
                _loc_10.text = _loc_6 + "";
                _loc_11 = new MoneyInfo();
                _loc_11.id = "i50002";
                _loc_11.num = _loc_4;
                _loc_11.name = Common.moneys[_loc_11.id].name;
                _loc_11.tip = Common.moneys[_loc_11.id].tip;
                _loc_10.data = _loc_11;
            }
            if (_loc_7 > 0)
            {
                _loc_10 = param2[_loc_9++];
                _loc_10.text = _loc_7 + "";
                _loc_11 = new MoneyInfo();
                _loc_11.id = "i50002";
                _loc_11.num = _loc_4;
                _loc_11.name = Common.moneys[_loc_11.id].name;
                _loc_11.tip = Common.moneys[_loc_11.id].tip;
                _loc_10.data = _loc_11;
            }
            if (_loc_8 > 0)
            {
                _loc_10 = param2[_loc_9++];
                _loc_10.text = _loc_8 + "";
                _loc_11 = new MoneyInfo();
                _loc_11.id = "i50005";
                _loc_11.num = _loc_8;
                _loc_11.name = Common.moneys[_loc_11.id].name;
                _loc_11.tip = Common.moneys[_loc_11.id].tip;
                _loc_10.data = _loc_11;
            }
            var _loc_12:* = param1.q_rewards_goods;
            if (param1.q_rewards_goods != null && _loc_12 != "")
            {
                _loc_13 = _loc_12.split(";");
                _loc_14 = 0;
                while (_loc_14 < _loc_13.length)
                {
                    
                    _loc_15 = _loc_13[_loc_14];
                    _loc_16 = _loc_15.split("_");
                    _loc_17 = _loc_16.length;
                    _loc_18 = _loc_16[0];
                    _loc_20 = 0;
                    if (_loc_18.indexOf("!") != -1)
                    {
                        _loc_19 = int(_loc_18.substr(1, (_loc_18.length - 1)));
                        _loc_20 = 0;
                    }
                    else
                    {
                        _loc_19 = int(_loc_16[0]);
                        _loc_20 = 1;
                    }
                    _loc_21 = ItemCfgObj.getInstance().getCfgBy(_loc_19);
                    if (!_loc_21)
                    {
                    }
                    else
                    {
                        _loc_22 = _loc_16[1];
                        if (_loc_17 > 2)
                        {
                            _loc_25 = Common.jobCheck(_loc_16[2].toString(), UserObj.getInstance().playerInfo.job);
                            if (!_loc_25)
                            {
                                ;
                            }
                        }
                        if (_loc_17 > 3)
                        {
                            _loc_23 = _loc_16[3];
                        }
                        if (_loc_17 > 4)
                        {
                            _loc_24 = _loc_16[4];
                        }
                        if (!PropUtil.isEquip(_loc_21.q_type))
                        {
                            _loc_26 = new PropInfo();
                            _loc_26.convByCfg(_loc_19);
                            _loc_26.num = _loc_22;
                            _loc_26.isbind = _loc_20;
                            if (_loc_9 < param2.length)
                            {
                                _loc_10 = param2[_loc_9++];
                                _loc_10.text = _loc_22 + "";
                                _loc_10.data = _loc_26;
                            }
                        }
                        else
                        {
                            _loc_27 = new EquipmentInfo();
                            _loc_27.convEquipByCfg(_loc_19, _loc_23, _loc_24);
                            _loc_27.num = _loc_22;
                            _loc_27.isbind = _loc_20;
                            if (_loc_9 < param2.length)
                            {
                                _loc_10 = param2[_loc_9++];
                                _loc_10.text = _loc_22 + "";
                                _loc_10.data = _loc_27;
                            }
                        }
                    }
                    _loc_14++;
                }
            }
            return _loc_9;
        }// end function

        public function autoSubmitTask(param1:TaskMsgVO) : void
        {
            var _loc_2:* = param1.conf.q_task_type;
            switch(_loc_2)
            {
                case TaskGlobal.TASK_KILL:
                {
                    FightControl.getInstance().delCurrentSkill();
                    TaskGlobal.task = param1;
                    UserObj.getInstance().selectRole = null;
                    break;
                }
                case TaskGlobal.TASK_TALK:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function continueTask(param1:TaskMsgVO, param2:Boolean = true, param3:Boolean = false) : void
        {
            var _loc_4:* = null;
            this.setAutoTask(true);
            if (param1)
            {
                if (param1.complete)
                {
                    _loc_4 = param1.rewardMsg;
                    if (!_loc_4)
                    {
                        this.autoFinish();
                        return;
                    }
                }
                else
                {
                    _loc_4 = param1.actionMsg;
                }
                TaskLinkEventManager.handle(_loc_4, param2, param3);
            }
            return;
        }// end function

        public function getNewTask(param1:TaskMsgVO) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (!param1)
            {
                return;
            }
            TaskGlobal.task = param1;
            var _loc_2:* = int(param1.conf.q_task_type);
            if (_loc_2 == 6)
            {
                _loc_3 = param1.conf.q_other_msg;
                if (_loc_3)
                {
                    MoviePlayer.play(_loc_3);
                    MoviePlayer.instance.addEventListener(Event.COMPLETE, this.playerOver);
                    _loc_4 = RoleList.getInstance().player;
                    if (_loc_4)
                    {
                        _loc_4.stop();
                    }
                }
            }
            else if (_loc_2 == 1)
            {
                if (param1.transfer)
                {
                    this.openTransferPanel(param1.transMsg);
                }
                else if (param1.conf.q_taskid != "60000" && param1.conf.q_taskid != "61000")
                {
                    this.continueTask(param1, false);
                }
            }
            else
            {
                this.continueTask(param1, false);
            }
            return;
        }// end function

        private function playerOver(event:Event) : void
        {
            if (MoviePlayer.instance)
            {
                MoviePlayer.instance.removeEventListener(Event.COMPLETE, this.playerOver);
            }
            this.autoFinish();
            return;
        }// end function

        public function autoFinish() : void
        {
            return;
        }// end function

        public function openTransferPanel(param1:TaskCoordVO) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            if (MapClientControl.getInstance().isInSkeKingZone())
            {
                return;
            }
            if (param1.mapId == Params.CLIENT_ZONES_DRAGON_KING)
            {
                DragonKingController.getInstance().moveToTransfer();
                return;
            }
            if (!this.transferpanel)
            {
                this.transferpanel = new TransferPanel();
            }
            var _loc_2:* = new LayoutInfo(Layout.CENTER);
            Global.mainUIManager.addUI(this.transferpanel, _loc_2);
            var _loc_3:* = LanguageCfgObj.getInstance().getByIndex("11285");
            if (param1.num == 1)
            {
                _loc_6 = ZonesCloneCfg.getInstance().getZonesInfoFromId(param1.mapId);
                _loc_3 = _loc_6.duplicate_name;
            }
            else
            {
                _loc_7 = MapCfgObj.getInstance().getMap(param1.mapId);
                _loc_3 = _loc_7.mapName;
            }
            var _loc_4:* = "<u><font color=\'#00ff00\'>" + _loc_3 + "</font></u>";
            this.transferpanel.txt_desc.htmlText = param1.info ? (param1.info + _loc_4) : (_loc_4);
            this.transferpanel.coord = param1;
            this.transferpanel.countDown = 5;
            var _loc_5:* = RoleList.getInstance().player;
            if (RoleList.getInstance().player)
            {
                _loc_5.stopPath();
                MapControl.getInstance().stopPath(_loc_5);
            }
            return;
        }// end function

        public function transferScene(param1:TaskCoordVO, param2:int = 0, param3:Boolean = true) : void
        {
            if (!param1)
            {
                return;
            }
            if (param3)
            {
                if (this.checkOutBossHome(param1, param2))
                {
                    return;
                }
            }
            var _loc_4:* = param1.mapId;
            var _loc_5:* = param1.x;
            var _loc_6:* = param1.y;
            var _loc_7:* = param1.type;
            var _loc_8:* = RoleList.getInstance().player;
            TaskGlobal.task_mode = true;
            if (param2 == 0 && param1.taskId == 62001)
            {
                param2 = 1;
            }
            TaskGlobal.protocol.taskTransfer(_loc_4, _loc_5, _loc_6, _loc_7, param1.taskId, param2);
            NpcControl.getInstance().checkAndClosePanel();
            TaskGlobal.manager.closeTaskDialogPanel();
            return;
        }// end function

        private function checkOutBossHome(param1:TaskCoordVO, param2:int = 0) : Boolean
        {
            if (ZonesControl.getInstance().inBossHome() && param1.mapId == Params.BOSS_HOME_CITY_MAP)
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10002", BossHomeConsts.LANG_VER));
                return true;
            }
            if (param1.mapId == Params.BOSS_HOME_CITY_MAP)
            {
                ZonesControl.getInstance().openBossHome();
                return true;
            }
            if (!ZonesControl.getInstance().inBossHome())
            {
                return false;
            }
            Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("10001", "lang_bosshome"), null, [param1, param2, false], this.transferScene);
            return true;
        }// end function

        private function continueTaskDelayCall(event:RoleEvent) : void
        {
            var _loc_2:* = RoleList.getInstance().player as Player;
            _loc_2.removeEvtListener(RoleEvent.ACTION_COMPLETE, this.continueTaskDelayCall);
            this.taskFindPath(this._saveX, this._saveY, this._saveMap, this._saveIsUserAction);
            this._saveIsUserAction = true;
            return;
        }// end function

        public function taskFindPath(param1:int, param2:int, param3:int, param4:Boolean = true, param5:int = 0) : void
        {
            var x:* = param1;
            var y:* = param2;
            var mapId:* = param3;
            var isUserAction:* = param4;
            var line:* = param5;
            TaskGlobal.autoTask = true;
            var targetX:* = x * MapUtils.GRID_BORDER;
            var targetY:* = y * MapUtils.GRID_BORDER;
            var role:* = RoleList.getInstance().player;
            TaskLinkEventManager.clear();
            var player:* = RoleList.getInstance().player as Player;
            if (player && player.fatherActType == Params.ACTION_SIMPLE_ATTACK_ID)
            {
                this._saveX = x;
                this._saveY = y;
                this._saveMap = mapId;
                this._saveIsUserAction = isUserAction;
                player.addEvtListener(RoleEvent.ACTION_COMPLETE, this.continueTaskDelayCall);
                return;
            }
            var b:* = role.pathByCoo(targetX, targetY, 3, mapId, true);
            if (!b || role._x == targetX && role._y == targetY)
            {
                PlayerArriveHandler.handle();
            }
            if ((mapId != MapObj.getInstance().mapID || line != UserObj.getInstance().line && line != 0) && (isUserAction || TaskGlobal.TEST_MODEL))
            {
                MapControl.getInstance().goldMapTrans(mapId, line);
                TaskGlobal.taskFindPathCallBack = function () : void
            {
                taskFindPath(x, y, mapId, isUserAction, line);
                TaskGlobal.taskFindPathCallBack = null;
                return;
            }// end function
            ;
            }
            return;
        }// end function

        public function clickLimitHandle(param1:InteractiveObject) : void
        {
            var btn:* = param1;
            btn.mouseEnabled = false;
            var delayHandle:* = function () : void
            {
                btn.mouseEnabled = true;
                return;
            }// end function
            ;
            TweenLite.delayedCall(1, delayHandle);
            return;
        }// end function

        public function setAutoTask(param1:Boolean) : void
        {
            if (param1 && TaskGlobal.task && TaskGlobal.task.taskId < 10068)
            {
                TweenLite.killDelayedCallsTo(this.autoContinueTask);
                TweenLite.delayedCall(TaskGlobal.AUTO_FIND_PATH_CD, this.autoContinueTask);
            }
            else
            {
                TweenLite.killDelayedCallsTo(this.autoContinueTask);
            }
            return;
        }// end function

        private function autoContinueTask() : void
        {
            TweenLite.killDelayedCallsTo(this.autoContinueTask);
            TweenLite.delayedCall(TaskGlobal.AUTO_FIND_PATH_CD, this.autoContinueTask);
            var _loc_1:* = RoleList.getInstance().player;
            if (_loc_1 && TaskGlobal.task && TaskGlobal.task.taskId < 10068)
            {
                if (_loc_1.isPathing && TaskGlobal.autoTask)
                {
                }
                else
                {
                    this.continueTask(TaskGlobal.task, false, true);
                }
            }
            else
            {
                TweenLite.killDelayedCallsTo(this.autoContinueTask);
            }
            return;
        }// end function

        public function isTaskDialogOpen() : Boolean
        {
            return this.panel && this.panel.isOpen;
        }// end function

        public static function doJobTask(param1:int, param2:int = 0) : Boolean
        {
            var _loc_4:* = null;
            var _loc_3:* = TaskModel.getInstance().getTaskItemById(param1);
            TaskGlobal.task = _loc_3;
            TaskGlobal.currentTask = _loc_3;
            if (_loc_3.complete)
            {
                _loc_4 = _loc_3.rewardMsg;
            }
            else
            {
                _loc_4 = _loc_3.actionMsg;
            }
            if (param1 == 62001 || param1 == 62003 || param1 == 62005 || param1 == 63001)
            {
                _loc_4 = _loc_3.rewardMsg;
            }
            if (_loc_4)
            {
                if (param2 == 1)
                {
                    TaskLinkEventManager.handle(_loc_4);
                }
                else
                {
                    TaskGlobal.manager.transferScene(_loc_4);
                }
                return true;
            }
            return false;
        }// end function

    }
}
