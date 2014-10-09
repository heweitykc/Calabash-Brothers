package com.game.chat.control
{
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.manager.timer.*;
    import com.game.chat.utils.*;
    import com.game.map.event.*;
    import com.game.map.model.*;
    import com.game.task.*;
    import com.game.task.events.*;
    import com.game.task.model.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.utils.*;
    import interfaces.role.*;

    public class SpeakControl extends Object
    {
        private var petTalkList:Array;
        private var count:int;
        private var isPetRandomTalking:Boolean;
        private var countDic:Dictionary;
        private static var _instance:SpeakControl;

        public function SpeakControl()
        {
            FrameworkGlobal.addMsgListen(GameEvent.PLAYER_CUTE_PET_STATE_UPDATE, this.cutePetStateUpdateHandler);
            FrameworkGlobal.addMsgListen(GameEvent.MONSTER_TYPE_LIST_ADD, this.monsterTypeListAddHandler);
            FrameworkGlobal.addMsgListen(GameEvent.MONSTER_TYPE_LIST_REMOVE, this.monsterTypeListRemoveHandler);
            FrameworkGlobal.addMsgListen(GameEvent.MONSTER_TYPE_LIST_RESET, this.monsterTypeListResetHandler);
            this.countDic = new Dictionary();
            this.cutePetStateUpdateHandler();
            return;
        }// end function

        public function speakByChatInfo(param1:ChatInfo) : void
        {
            if (param1.chattype != ChatType.CHATTYPE_TEAM && param1.chattype != ChatType.CHATTYPE_SCENE)
            {
                return;
            }
            var _loc_2:* = RoleList.getInstance().getRole(param1.chater);
            if (_loc_2)
            {
                _loc_2.richSpeak(param1.txt, ChatUtil.makeSrc(param1), true, null, 5);
            }
            return;
        }// end function

        public function setCutePetTalkEnable(param1:Boolean) : void
        {
            if (param1)
            {
                this.addCutePetEventsLis();
                this.enterMapHandler();
            }
            else
            {
                this.removeCutePetEventLis();
                this.petStopTalk();
            }
            return;
        }// end function

        private function cutePetStateUpdateHandler(event:GameEvent = null) : void
        {
            if (CutePetList.getInstance().playerCutePet != null)
            {
                this.setCutePetTalkEnable(true);
            }
            else
            {
                this.setCutePetTalkEnable(false);
            }
            return;
        }// end function

        private function addCutePetEventsLis() : void
        {
            FrameworkGlobal.addMsgListen(MapEvent.MAP_CHANGE, this.enterMapHandler);
            TaskGlobal.myEvt.addEventListener(TaskEvent.GET_NEW_TASK, this.completeTaskHandler);
            UserObj.getInstance().playerInfo.addEventListener(RoleEvent.UPDATE_LEVEL, this.playerLevelUpdateHandler);
            return;
        }// end function

        private function removeCutePetEventLis() : void
        {
            FrameworkGlobal.removeMsgListen(MapEvent.MAP_CHANGE, this.enterMapHandler);
            TaskGlobal.myEvt.removeEventListener(TaskEvent.GET_NEW_TASK, this.completeTaskHandler);
            UserObj.getInstance().playerInfo.removeEventListener(RoleEvent.UPDATE_LEVEL, this.playerLevelUpdateHandler);
            return;
        }// end function

        private function enterMapHandler(event:MapEvent = null) : void
        {
            var _loc_2:* = SpeakCfgObj.getInstance().getSpeakArrByMap(MapObj.getInstance().mapID);
            this.resetPetTalkList(_loc_2, true);
            return;
        }// end function

        private function completeTaskHandler(event:TaskEvent) : void
        {
            var _loc_2:* = SpeakCfgObj.getInstance().getSpeakArrByTask(TaskMsgVO(event.data).taskId);
            this.resetPetTalkList(_loc_2);
            return;
        }// end function

        private function playerLevelUpdateHandler(event:RoleEvent) : void
        {
            var _loc_2:* = SpeakCfgObj.getInstance().getSpeakArrByLevel(UserObj.getInstance().playerInfo.level);
            this.resetPetTalkList(_loc_2);
            return;
        }// end function

        private function resetPetTalkList(param1:Array, param2:Boolean = false) : void
        {
            Ticker.killTimer(this.ticker);
            if (!param1 || param1.length == 0)
            {
                if (param2)
                {
                    this.petStartRandomTalk();
                    param1 = [];
                }
                else
                {
                    return;
                }
            }
            this.petTalkList = param1.concat();
            this.count = 0;
            Ticker.registerTimer(1, this.ticker);
            return;
        }// end function

        private function ticker() : void
        {
            var _loc_2:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = this;
            var _loc_10:* = this.count + 1;
            _loc_9.count = _loc_10;
            var _loc_1:* = CutePetList.getInstance().playerCutePet;
            var _loc_3:* = 0;
            var _loc_4:* = this.petTalkList.length;
            while (_loc_3 < _loc_4)
            {
                
                _loc_2 = this.petTalkList[_loc_3] as CutePetSpeakInfo;
                if (this.count >= _loc_2.time)
                {
                    _loc_1.richSpeak(_loc_2.content, null, false, null, 5);
                    this.petTalkList.splice(_loc_3, 1);
                    break;
                }
                _loc_3++;
            }
            if (this.petTalkList.length > 0)
            {
                this.isPetRandomTalking = false;
            }
            else if (!this.isPetRandomTalking)
            {
                this.petStartRandomTalk();
            }
            else
            {
                _loc_5 = SpeakCfgObj.getInstance().getFreeSpeakTimeByMapId(MapObj.getInstance().mapID);
                if (this.count >= _loc_5 && _loc_5 != -1)
                {
                    _loc_6 = SpeakCfgObj.getInstance().getFreeArrByMap(MapObj.getInstance().mapID);
                    _loc_7 = Math.random() * 10000;
                    _loc_3 = 0;
                    _loc_4 = _loc_6.length;
                    while (_loc_3 < _loc_4)
                    {
                        
                        _loc_8 = _loc_6[_loc_3] as CutePetSpeakInfo;
                        _loc_7 = _loc_7 - _loc_8.percent;
                        if (_loc_7 < 0)
                        {
                            _loc_1.richSpeak(_loc_8.content, null, false, null, 5);
                            break;
                        }
                        _loc_3++;
                    }
                    this.count = 0;
                }
            }
            return;
        }// end function

        private function petStopTalk() : void
        {
            Ticker.killTimer(this.ticker);
            this.petTalkList = null;
            this.count = 0;
            return;
        }// end function

        private function petStartRandomTalk() : void
        {
            this.count = 0;
            this.isPetRandomTalking = true;
            return;
        }// end function

        private function monsterTypeListAddHandler(event:GameEvent) : void
        {
            var _loc_2:* = event.obj;
            var _loc_3:* = MonsterCfgObj.getInstance().getMonsterCfg(_loc_2);
            if (_loc_3.q_say_condition && _loc_3.q_say_condition != "")
            {
                this.countDic[_loc_2] = 0;
                this.setMonsterSpeakEnable(true);
            }
            return;
        }// end function

        private function monsterTypeListRemoveHandler(event:GameEvent) : void
        {
            var _loc_2:* = event.obj;
            delete this.countDic[_loc_2];
            return;
        }// end function

        private function monsterTypeListResetHandler(event:GameEvent) : void
        {
            this.setMonsterSpeakEnable(false);
            return;
        }// end function

        private function setMonsterSpeakEnable(param1:Boolean) : void
        {
            Ticker.killTimer(this.monsterSpeakEnterFrame);
            if (param1)
            {
                Ticker.registerTimer(1, this.monsterSpeakEnterFrame);
            }
            return;
        }// end function

        private function monsterSpeakEnterFrame() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_1:* = 0;
            for (_loc_3 in this.countDic)
            {
                
                _loc_1++;
                var _loc_14:* = this.countDic;
                var _loc_15:* = _loc_3;
                _loc_14[_loc_15] = _loc_13[_loc_3] + 1;
                _loc_2 = _loc_13[_loc_3] + 1;
                _loc_4 = MonsterCfgObj.getInstance().getMonsterCfg(_loc_3);
                if (_loc_2 >= _loc_4.q_tosay_timeinterval)
                {
                    _loc_5 = MonsterCfgObj.getInstance().getMonsterSpeakByMonId(_loc_3);
                    if (!_loc_5)
                    {
                        break;
                    }
                    _loc_6 = Math.random() * 10000;
                    _loc_7 = 0;
                    _loc_8 = _loc_5.length;
                    while (_loc_7 < _loc_8)
                    {
                        
                        _loc_9 = _loc_5[_loc_7] as CutePetSpeakInfo;
                        _loc_6 = _loc_6 - _loc_9.percent;
                        if (_loc_6 < 0)
                        {
                            _loc_11 = RoleList.getInstance().getMonsterTypeListByModelId(_loc_3);
                            if (_loc_11 && _loc_11.length)
                            {
                                _loc_10 = Math.floor(Math.random() * _loc_11.length);
                                IRole(_loc_11[_loc_10]).richSpeak(_loc_9.content, null, false, null, 5);
                            }
                            break;
                        }
                        _loc_7++;
                    }
                    _loc_13[_loc_3] = 0;
                }
            }
            if (_loc_1 == 0)
            {
                this.setMonsterSpeakEnable(false);
            }
            return;
        }// end function

        public static function getInstance() : SpeakControl
        {
            var _loc_1:* = new SpeakControl;
            _instance = new SpeakControl;
            return _instance || _loc_1;
        }// end function

    }
}
