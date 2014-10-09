package com.game.role
{
    import com.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.vmc.*;
    import com.game.autopk.controller.*;
    import com.game.buff.control.*;
    import com.game.fight.control.*;
    import com.game.guide.control.*;
    import com.game.guide.model.*;
    import com.game.horse.control.*;
    import com.game.map.control.*;
    import com.game.map.event.*;
    import com.game.map.model.*;
    import com.game.map.view.topbtnspanel.*;
    import com.game.sound.control.*;
    import com.game.task.model.*;
    import com.greensock.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import flash.events.*;
    import flash.utils.*;

    public class Player extends Role
    {
        private var _checkAttackCount:uint;
        private var _lvlupMC:VMCView;
        private const ATTACK_INTERVAL:uint = 200;
        private var lastAttackTime:int;
        private var junmpers:Array;
        private var targetX:int;
        private var targetY:int;
        private var targetMap:int;
        private var targetDis:int;
        public var isStopAutoFightBack:Boolean;
        private static var _state:int;
        public static var action:int;
        public static var actState:int;

        public function Player()
        {
            mouseEnabled = false;
            mouseChildren = false;
            _alwaysShowBloodStripe = true;
            UserObj.getInstance().playerInfo.addEvtListener(RoleEvent.UPDATE_LEVEL, this.__playerUpdateLvl);
            return;
        }// end function

        public function __playerUpdateLvl(event:RoleEvent = null) : void
        {
            if (this._lvlupMC == null)
            {
                this._lvlupMC = new VMCView();
                this._lvlupMC.auto = true;
            }
            this._lvlupMC.loadRes("art/res/other/levelup.png");
            this._lvlupMC.updatePose("90", false, false, true);
            this._lvlupMC.replay();
            SoundControl.getInstance().playSound(SoundFlag.PLAYER_LEVELUP);
            getSprite().addChild(this._lvlupMC);
            if (UserObj.getInstance().playerInfo.level >= Params.CHANGE_JOB_OPEN_LEVEL && GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().CHANGE_JOB_TEAM)) == 0)
            {
                ActiveGuideControl.getInstance().open(Params.CHANGE_JOB_OPEN_TASK_ID);
            }
            if (UserObj.getInstance().playerInfo.level >= Params.COUNTRY_OPEN_LEVEL && GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().COUNTRY_ACTIVE_TEAM)) == 0)
            {
                ActiveGuideControl.getInstance().open(Params.COUNTRY_OPEN_TASK_ID);
            }
            var _loc_2:* = TaskModel.getInstance().curChangeJobTask();
            if (_loc_2 != 0)
            {
                MapControl.getInstance().addedToTopIcon(TopActivateName.TOP_ICON_CHANGE_JOB);
            }
            AutoFightController.getInstance().updateByPlayerLv(int(event.obj.pre), UserObj.getInstance().playerInfo.level);
            return;
        }// end function

        override public function pathByCoo(param1:int, param2:int, param3:int = 0, param4:int = 0, param5:Boolean = false, param6:Boolean = true, param7:Boolean = false, param8:Boolean = true) : Boolean
        {
            var _loc_9:* = false;
            var _loc_11:* = null;
            if (!alive())
            {
                return false;
            }
            if (this.isFreeze() || this.isStun())
            {
                return false;
            }
            if (BuffControl.getInstance().restrictMove)
            {
                if (BuffControl.getInstance().frozen)
                {
                    Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("FightControl_1409561973"));
                }
                return false;
            }
            if (isInSkillShunyi)
            {
                return false;
            }
            var _loc_10:* = MapObj.getInstance().mapID;
            if (param4 != 0 && param4 != _loc_10)
            {
                this.junmpers = MapSeeker.getTransfer(_loc_10, param4);
                if (this.junmpers && this.junmpers.length)
                {
                    this.targetX = param1;
                    this.targetY = param2;
                    this.targetMap = param4;
                    this.targetDis = param3;
                    FrameworkGlobal.addMsgListen(MapEvent.MAP_CHANGE_COMPLETE, this.onMapChangeComplete);
                    _loc_11 = this.junmpers.shift();
                    _loc_9 = super.pathByCoo(_loc_11.x, _loc_11.y);
                }
                if (param6 && _loc_9)
                {
                    if (_info.horseInfo && _info.horseInfo.horseStat == 0)
                    {
                        if (param5)
                        {
                            HorseControl.getInstance().changeRidingState();
                        }
                    }
                    AutoFightController.getInstance().openAutoFind();
                    Player.state = State.AUTO_ROAD;
                }
                else
                {
                    AutoFightController.getInstance().closeAutoFind();
                    Player.state = State.NONE;
                }
                return true;
            }
            if (this.junmpers && !param7)
            {
                this.junmpers = null;
                this.targetX = 0;
                this.targetY = 0;
                FrameworkGlobal.removeMsgListen(MapEvent.MAP_CHANGE_COMPLETE, this.onMapChangeComplete);
            }
            if (_info.horseInfo && _info.horseInfo.horseStat == 0)
            {
                if (param5)
                {
                    HorseControl.getInstance().changeRidingState();
                }
            }
            _loc_9 = super.pathByCoo(param1, param2, param3, param4, param5, param6, param7, param8);
            if (_loc_9)
            {
                Player.state = State.AUTO_ROAD;
            }
            if (param6 && isPathing)
            {
                AutoFightController.getInstance().openAutoFind();
            }
            else
            {
                AutoFightController.getInstance().closeAutoFind();
                Player.state = State.NONE;
            }
            return _loc_9;
        }// end function

        private function onMapChangeComplete(event:MapEvent) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = MapObj.getInstance().mapID;
            if (this.junmpers && this.junmpers.length)
            {
                _loc_3 = this.junmpers.shift();
                if (_loc_2 == _loc_3.q_tran_from_map)
                {
                    this.pathByCoo(_loc_3.x, _loc_3.y, 0, 0, false, true, true);
                }
                else
                {
                    this.stopPath();
                }
            }
            else
            {
                FrameworkGlobal.removeMsgListen(MapEvent.MAP_CHANGE_COMPLETE, this.onMapChangeComplete);
                if (this.targetMap != _loc_2 && this.targetMap != 0)
                {
                    this.pathByCoo(this.targetX, this.targetY, this.targetDis, this.targetMap);
                    return;
                }
                if (this.targetX != 0 && this.targetY != 0)
                {
                    this.pathByCoo(this.targetX, this.targetY, this.targetDis);
                    this.junmpers = null;
                    this.targetX = 0;
                    this.targetY = 0;
                }
            }
            return;
        }// end function

        override public function stopPath() : void
        {
            super.stopPath();
            this.targetMap = 0;
            if (this.junmpers)
            {
                this.junmpers = null;
                this.targetX = 0;
                this.targetY = 0;
                FrameworkGlobal.removeMsgListen(MapEvent.MAP_CHANGE_COMPLETE, this.onMapChangeComplete);
            }
            AutoFightController.getInstance().closeAutoFind();
            return;
        }// end function

        override protected function arrive() : void
        {
            super.arrive();
            this.stopAutoFightBack();
            return;
        }// end function

        public function stopPathWithoutClearJumper() : void
        {
            super.stopPath();
            AutoFightController.getInstance().closeAutoFind();
            return;
        }// end function

        override public function set info(param1:RoleInfo) : void
        {
            super.info = param1;
            this.resetCutePet();
            return;
        }// end function

        override public function enterFrame(event:Event = null) : void
        {
            super.enterFrame(event);
            var _loc_2:* = getTimer();
            if (_info && alive())
            {
                if (_info.currentSkill && !this.isFreeze())
                {
                    if (_info.currentSkill.hasTarget() || _info.isBecome)
                    {
                        if (_loc_2 - this.lastAttackTime >= this.ATTACK_INTERVAL)
                        {
                            FightControl.getInstance().checkAndAttack(this);
                            this.lastAttackTime = _loc_2;
                        }
                    }
                    else
                    {
                        FightControl.getInstance().delCurrentSkill();
                    }
                }
            }
            return;
        }// end function

        public function isFreeze() : Boolean
        {
            if (actState == State.DRAG)
            {
                return true;
            }
            return false;
        }// end function

        public function isStun() : Boolean
        {
            if (actState == State.STAKME)
            {
                return true;
            }
            return false;
        }// end function

        override public function resetCutePet() : void
        {
            var _loc_1:* = PropUtil.hasAutoPickCutePet(_info.equipPetId);
            if (CutePetList.getInstance().playerCutePet && _loc_1 != 0)
            {
                _cutePet = CutePetList.getInstance().playerCutePet.info as CutePetInfo;
            }
            if (!_cutePet && _loc_1 != 0)
            {
                _cutePet = new CutePetInfo();
                _cutePet.conByParentInfo(info);
                MapControl.getInstance().addPlayerCutePet(_cutePet);
            }
            else if (_cutePet && _loc_1 == 0)
            {
                MapControl.getInstance().removeCutePetById(_info.personId);
                _cutePet = null;
            }
            return;
        }// end function

        override public function finalize() : void
        {
            return;
        }// end function

        override public function revive() : void
        {
            super.revive();
            actState = State.NONE;
            return;
        }// end function

        public function stopAutoFightBack() : void
        {
            this.isStopAutoFightBack = true;
            TweenLite.killDelayedCallsTo(this.beginAutoFightBack);
            TweenLite.delayedCall(3, this.beginAutoFightBack);
            return;
        }// end function

        private function beginAutoFightBack() : void
        {
            this.isStopAutoFightBack = false;
            return;
        }// end function

        public static function get state() : int
        {
            return _state;
        }// end function

        public static function set state(param1:int) : void
        {
            _state = param1;
            return;
        }// end function

    }
}
