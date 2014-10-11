package com.game.autopk.controller
{
    import com.events.*;
    import com.f1.*;
    import com.f1.interfaces.*;
    import com.f1.utils.path.*;
    import com.game.autopk.event.*;
    import com.game.autopk.model.*;
    import com.game.common.*;
    import com.game.fight.control.*;
    import com.game.map.control.*;
    import com.game.map.model.*;
    import com.game.map.view.*;
    import com.game.role.*;
    import com.game.zones.control.*;
    import com.greensock.*;
    import com.manager.cd.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import interfaces.role.*;

    public class AutoFightLogic extends EventDispatcher
    {
        private var pickLogic:PickLogic;
        private var skillLogic:SkillLogic;
        private var _mapId:int;
        private var rareIcon:DropIcon;
        private var _coord:Point;
        public var force:Boolean = true;
        private var _nopatrol:Boolean;
        private var _fighting:Boolean;
        private var hitTime:int = 0;
        private var timeCounter:int;
        private var startTime:int;
        private var _lockedMounster:IRole;
        private var _skillCount:int;
        private const MAX_COUNT:uint = 5;
        private var _beginHp:int;
        private var isdeadTime:int = 0;
        private var _forcePickTime:int;
        public static const CHECK_TIME_GAP:int = 250;

        public function AutoFightLogic()
        {
            this.pickLogic = new PickLogic();
            this.skillLogic = new SkillLogic();
            return;
        }// end function

        public function get nopatrol() : Boolean
        {
            return this._nopatrol;
        }// end function

        public function set nopatrol(param1:Boolean) : void
        {
            this._nopatrol = param1;
            return;
        }// end function

        public function get mapId() : int
        {
            return this._mapId;
        }// end function

        public function set mapId(param1:int) : void
        {
            this._mapId = param1;
            return;
        }// end function

        public function get coord() : Point
        {
            return this._coord;
        }// end function

        public function set coord(param1:Point) : void
        {
            this._coord = param1;
            return;
        }// end function

        private function onActionComplete(event:Event) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            if (this.lockedMounster && this.lockedMounster.alive())
            {
                this.skillLogic.autoUseSkill(this.lockedMounster, true);
                if (this._beginHp != this._lockedMounster.info.HP)
                {
                    this._skillCount = 0;
                    this._beginHp = this._lockedMounster.info.HP;
                }
                else
                {
                    var _loc_8:* = this;
                    var _loc_9:* = this._skillCount + 1;
                    _loc_8._skillCount = _loc_9;
                    if (this._skillCount >= this.MAX_COUNT)
                    {
                        if (RoleList.getInstance().nearMonstersList && RoleList.getInstance().nearMonstersList.length)
                        {
                            _loc_2 = RoleList.getInstance().nearMonstersList.indexOf(this.lockedMounster);
                            if (_loc_2 != -1)
                            {
                                RoleList.getInstance().nearMonstersList.splice(_loc_2, 1);
                            }
                            if (RoleList.getInstance().nearMonstersList.length)
                            {
                                _loc_6 = RoleList.getInstance().player;
                                for each (_loc_3 in RoleList.getInstance().nearMonstersList)
                                {
                                    
                                    _loc_4 = _loc_6.distanceSQ(_loc_3);
                                    if (_loc_4 < _loc_7 || _loc_7 == 0)
                                    {
                                        _loc_7 = _loc_4;
                                        _loc_5 = _loc_3;
                                    }
                                }
                                this.lockedMounster = _loc_5;
                            }
                            else
                            {
                                this.findAndLockMounster(this.lockedMounster);
                            }
                        }
                    }
                }
            }
            else
            {
                this.clearMonseter(false);
                this.pickCheck();
            }
            return;
        }// end function

        public function get fighting() : Boolean
        {
            return this._fighting;
        }// end function

        public function fight(param1:Boolean = true) : void
        {
            var _loc_2:* = RoleList.getInstance().player;
            this._fighting = param1;
            if (_loc_2)
            {
                if (param1)
                {
                    RoleList.getInstance().clearHate();
                    FightControl.getInstance().delCurrentSkill();
                    this._mapId = MapObj.getInstance().mapID;
                    this._coord = new Point(_loc_2._x, _loc_2._y);
                    this.skillLogic.initSkill();
                    FrameworkGlobal.stage.addEventListener(Event.ENTER_FRAME, this.onFrameHandle);
                    this.pickLogic.addEventListener(AutoFightEvent.PICK_COMPLETE, this.onPickCompleteHandle);
                    FrameworkGlobal.stageAddEvtListener(MouseEvent.CLICK, this.onStageClickHandle);
                    FrameworkGlobal.addMsgListen(GameEvent.SKILL_PUBLIC_CD_CHANGE, this.onActionComplete);
                    this.startTime = getTimer();
                    this.pickCheck();
                    dispatchEvent(new AutoFightEvent(AutoFightEvent.BEGIN_AUTO));
                    SellLogic.autoSell();
                }
                else
                {
                    RoleList.getInstance().clearHate();
                    this.lockedMounster = null;
                    FightControl.getInstance().delCurrentSkill();
                    UserObj.getInstance().selectRole = null;
                    this.skillLogic.finalize();
                    if (this.force)
                    {
                        this.pickLogic.removeEventListener(AutoFightEvent.PICK_COMPLETE, this.onPickCompleteHandle);
                        this.force = false;
                        this.pickLogic.pick(false);
                        this.dispatchEvent(new AutoFightEvent(AutoFightEvent.AUTO_FIGHT_STOP));
                    }
                    else
                    {
                        TweenLite.delayedCall(1, this.pickLogic.getDropList);
                    }
                    FrameworkGlobal.stageRemoveEvtListener(MouseEvent.CLICK, this.onStageClickHandle);
                    FrameworkGlobal.stage.removeEventListener(Event.ENTER_FRAME, this.onFrameHandle);
                    FrameworkGlobal.removeMsgListen(GameEvent.SKILL_PUBLIC_CD_CHANGE, this.onActionComplete);
                    dispatchEvent(new AutoFightEvent(AutoFightEvent.END_AUTO));
                }
            }
            return;
        }// end function

        private function onFrameHandle(event:Event) : void
        {
            var _loc_2:* = getTimer();
            if (_loc_2 - this.timeCounter < CHECK_TIME_GAP)
            {
                return;
            }
            this.timeCounter = _loc_2;
            var _loc_3:* = RoleList.getInstance().player;
            if (!_loc_3 || !_loc_3.alive())
            {
                return;
            }
            if (_loc_3.isPathing)
            {
                return;
            }
            if (_loc_3.fatherActType == Params.ACTION_RUN)
            {
                return;
            }
            if (_loc_3.fatherActType == Params.ACTION_SIMPLE_ATTACK_ID)
            {
                return;
            }
            if (CDManager.getInstance().isInSkillPublicCD())
            {
                return;
            }
            if (_loc_3.fatherActType == Params.ACTION_STAND_ID || _loc_3.fatherActType == Params.ACTION_SIMPLE_HURT_ID)
            {
                if (this.lockedMounster == null || this.lockedMounster.alive() == false || this.lockedMounster is NPC)
                {
                    Tracer.fight("猪脚站立 没有找到怪");
                    this.clearMonseter();
                    this.skillLogic.autoUseHelpSkill();
                    this.pickCheck();
                    return;
                }
                if (this.hitTime == 0)
                {
                    this.hitTime = _loc_2;
                    Tracer.fight("主角 站立 开始计时");
                    return;
                }
                if (_loc_2 - this.hitTime > 500)
                {
                    Tracer.fight("主角站立 1s 开始捡东西");
                    this.pickCheck();
                    this.hitTime = 0;
                }
            }
            return;
        }// end function

        private function onPickCompleteHandle(event:AutoFightEvent = null) : void
        {
            var _loc_2:* = false;
            Tracer.fight("拾取完毕");
            if (this._fighting)
            {
                _loc_2 = this.comeBack();
                if (!_loc_2)
                {
                    this.findAndLockMounster();
                }
                else
                {
                    Tracer.fight("回挂机点");
                }
            }
            else
            {
                Tracer.fight("取消挂机");
                this.pickLogic.removeEventListener(AutoFightEvent.PICK_COMPLETE, this.onPickCompleteHandle);
                this.dispatchEvent(new AutoFightEvent(AutoFightEvent.AUTO_FIGHT_STOP));
            }
            return;
        }// end function

        private function onMounsterDie(event:RoleEvent = null) : void
        {
            Tracer.fight("事件:怪物死亡");
            this.clearMonseter(false);
            this.pickCheck();
            return;
        }// end function

        private function set lockedMounster(param1:IRole) : void
        {
            this._lockedMounster = param1;
            this._skillCount = 0;
            if (this._lockedMounster)
            {
                if (this._lockedMounster.info)
                {
                    this._beginHp = this._lockedMounster.info.HP;
                }
                UserObj.getInstance().selectRole = this._lockedMounster;
                this.skillLogic.autoUseSkill(this._lockedMounster);
            }
            return;
        }// end function

        private function get lockedMounster() : IRole
        {
            return this._lockedMounster;
        }// end function

        private function findAndLockMounster(param1:IRole = null) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = RoleList.getInstance();
            var _loc_3:* = _loc_2.player;
            if (this._lockedMounster && this._lockedMounster.alive())
            {
                if (!UserObj.getInstance().playerInfo.currentSkill)
                {
                    this.lockedMounster = this._lockedMounster;
                }
                Tracer.fight("群攻？");
            }
            else
            {
                _loc_4 = UserObj.getInstance().playerInfo;
                if (ZonesControl.getInstance().isZonesNeedSelectMonst())
                {
                    this.lockedMounster = ZonesControl.getInstance().getMonst();
                }
                else if (AutoFightModel.mounsterType)
                {
                    this.lockedMounster = _loc_2.getNearestMounsterByType(AutoFightModel.mounsterType, null, MapObj.getInstance().tilesba);
                }
                else
                {
                    this.lockedMounster = _loc_2.getNearestMounsterByType(null, null, MapObj.getInstance().tilesba);
                }
                if (!this.lockedMounster && !this._nopatrol)
                {
                    Tracer.fight("找不到怪物则巡逻");
                    this.patrol();
                    return;
                }
                Tracer.fight("*****选择怪物");
            }
            if (!this.lockedMounster)
            {
                Tracer.fight("啥都不干");
                return;
            }
            return;
        }// end function

        private function patrol() : void
        {
            if (getTimer() - this.startTime < 10000)
            {
                return;
            }
            var _loc_1:* = RoleList.getInstance();
            var _loc_2:* = _loc_1.player;
            if (_loc_2.isPathing)
            {
                return;
            }
            _loc_2.pathByCoo(this.coord.x + (0.5 - Math.random()) * AutoFightModel.fightRange * MapUtils.GRID_BORDER, this.coord.y + (0.5 - Math.random()) * AutoFightModel.fightRange * MapUtils.GRID_BORDER, 0, 0, false, false);
            return;
        }// end function

        private function comeBack() : Boolean
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            if (!ZonesControl.getInstance().isZonesNeedSelectMonst() && AutoFightModel.fightRangeType == 1)
            {
                _loc_1 = RoleList.getInstance().player;
                if (_loc_1 && _loc_1.alive())
                {
                    _loc_2 = Math.sqrt((_loc_1._x - this.coord.x) * (_loc_1._x - this.coord.x) + (_loc_1._y - this.coord.y) * (_loc_1._y - this.coord.y));
                    if (_loc_2 > AutoFightModel.fightRange * MapUtils.GRID_BORDER)
                    {
                        _loc_1.pathByCoo(this.coord.x, this.coord.y, 0, 0, false, false);
                        return true;
                    }
                }
            }
            return false;
        }// end function

        public function reset() : void
        {
            this.skillLogic.initSkill();
            return;
        }// end function

        private function pickCheck() : void
        {
            if (AutoFightModel.autoPick || AutoFightModel.forcePick)
            {
                Tracer.fight("拾取");
                this.pickLogic.pick();
            }
            else
            {
                Tracer.fight("找怪");
                this.onPickCompleteHandle();
            }
            return;
        }// end function

        public function pick() : void
        {
            AutoFightModel.forcePick = true;
            this.pickLogic.addEventListener(AutoFightEvent.PICK_COMPLETE_ALL, this.__pickAll, false, 0, true);
            this._forcePickTime = setTimeout(this.__pickAll, 30000);
            this.pickLogic.pick();
            return;
        }// end function

        public function pickRare(param1:DropIcon) : void
        {
            if (!this.pickLogic.pickCheck(param1, 0))
            {
                return;
            }
            this.clearMonseter();
            FightControl.getInstance().delCurrentSkill();
            var _loc_2:* = RoleList.getInstance().player;
            if (_loc_2.fatherActType == Params.ACTION_SIMPLE_ATTACK_ID)
            {
                this.rareIcon = param1;
                _loc_2.addEvtListener(RoleEvent.ACTION_COMPLETE, this.completePick);
            }
            else
            {
                this.pickLogic.pick(true, param1);
            }
            return;
        }// end function

        private function completePick(event:RoleEvent) : void
        {
            var _loc_2:* = RoleList.getInstance().player;
            _loc_2.removeEvtListener(RoleEvent.ACTION_COMPLETE, this.completePick);
            this.pickLogic.pick(true, this.rareIcon);
            this.rareIcon = null;
            return;
        }// end function

        private function __pickAll(event:AutoFightEvent = null) : void
        {
            clearTimeout(this._forcePickTime);
            AutoFightModel.forcePick = false;
            this.pickLogic.removeEventListener(AutoFightEvent.PICK_COMPLETE_ALL, this.__pickAll);
            dispatchEvent(new AutoFightEvent(AutoFightEvent.PICK_COMPLETE_ALL));
            return;
        }// end function

        private function clearMonseter(param1:Boolean = false) : void
        {
            if (this.lockedMounster)
            {
                this.lockedMounster = null;
                UserObj.getInstance().selectRole = null;
                MapControl.getInstance().currentGameScene.showSelectRole(null);
                if (param1)
                {
                    this.findAndLockMounster();
                }
            }
            return;
        }// end function

        private function onStageClickHandle(event:MouseEvent) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = MapControl.getInstance().currentGameScene;
            var _loc_3:* = _loc_2 ? (_loc_2.bgView) : (null);
            if (event.target == FrameworkGlobal.stage || event.target == _loc_3 || event.target is Player)
            {
                this.lockedMounster = null;
            }
            else if (event.target is Role)
            {
                _loc_4 = event.target as Role;
                if (_loc_4.info.roleType == RoleType.ROLE_TYPE_MONSTER)
                {
                    this.clearMonseter();
                    this.lockedMounster = _loc_4;
                    return;
                }
            }
            return;
        }// end function

    }
}
