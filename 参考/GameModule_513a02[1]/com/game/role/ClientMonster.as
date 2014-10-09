package com.game.role
{
    import com.cfg.obj.*;
    import com.f1.utils.*;
    import com.f1.utils.path.*;
    import com.game.dragonking.control.*;
    import com.game.fight.control.*;
    import com.game.map.control.*;
    import com.greensock.*;
    import com.model.*;
    import com.model.vo.*;
    import flash.events.*;
    import flash.utils.*;
    import interfaces.role.*;

    public class ClientMonster extends Role
    {
        private var _attackTime:int = -1;
        private var _lastCheckTime:Number = 0;
        private var _lastAlertTime:Number = 0;
        private var _lastMoveTime:Number = 0;
        private var _moveDisTime:Number = 2000;
        public var curSkillIndex:int;
        public var isAttackSpeak:Boolean = false;
        private var _attackCallBack:Function;

        public function ClientMonster()
        {
            this._lastMoveTime = getTimer();
            this._moveDisTime = 1000 + Math.random() * 3000;
            return;
        }// end function

        public function set currentSkill(param1:int) : void
        {
            this.curSkillIndex = param1;
            if (this.curSkillIndex != 0)
            {
                this.curSkillIndex = this.curSkillIndex;
            }
            var _loc_2:* = ClientMonsterInfo(_info).clientMonSkillList[this.curSkillIndex];
            var _loc_3:* = SkillCfgObj.getInstance().getSkillInfoById(_loc_2);
            if (_loc_3)
            {
                _info.currentSkill = _loc_3;
            }
            return;
        }// end function

        override public function set x(param1:Number) : void
        {
            super.x = param1;
            return;
        }// end function

        public function moveToAttack(param1:IRole, param2:int = 0, param3:int = -1, param4:Function = null) : void
        {
            this.doSpeak();
            ClientMonsterInfo(_info).isNeedAutoMove = false;
            if (_info.currentSkill)
            {
                return;
            }
            this._attackCallBack = param4;
            if (this.curSkillIndex != 0 && param2 == 0)
            {
                param2 = this.curSkillIndex;
            }
            var _loc_5:* = ClientMonsterInfo(_info).clientMonSkillList[param2];
            var _loc_6:* = SkillCfgObj.getInstance().getSkillInfoById(_loc_5);
            if (SkillCfgObj.getInstance().getSkillInfoById(_loc_5))
            {
                _loc_6.targetRole = param1;
                _info.currentSkill = _loc_6;
            }
            if (param3 != -1)
            {
                this._attackTime = param3;
            }
            return;
        }// end function

        override public function setAct(param1:String, param2:Boolean = false, param3:Boolean = true, param4:Boolean = false) : Boolean
        {
            var _loc_5:* = super.setAct(param1, param2, param3, param4);
            return super.setAct(param1, param2, param3, param4);
        }// end function

        override protected function arrive() : void
        {
            this._lastMoveTime = getTimer();
            this._moveDisTime = 1000 + Math.random() * 3000;
            super.arrive();
            return;
        }// end function

        override public function dead() : void
        {
            this._deadHandler();
            super.dead();
            return;
        }// end function

        override public function kickFly(param1:IRole, param2:uint, param3:Boolean = true) : void
        {
            if (_info.cfgId == DragonKingFightControl.getInstance().BOSS_MODEL_ID && !DragonKingFightControl.getInstance().deadComplete)
            {
                DragonKingFightControl.getInstance().dealDead();
            }
            else
            {
                this._deadHandler();
            }
            super.kickFly(param1, param2);
            return;
        }// end function

        private function _deadHandler() : void
        {
            MapClientControl.getInstance().createMonDrop(ClientMonsterInfo(info).dropList, ClientMonsterInfo(info).moneyDrop, x, y);
            (MapClientControl.getInstance().monNum - 1);
            MapClientControl.getInstance().addExp(ClientMonsterInfo(info).monExp);
            return;
        }// end function

        override protected function setToNextTarget() : void
        {
            super.setToNextTarget();
            return;
        }// end function

        override public function pathByAStarArray(param1:Array, param2:Array = null) : Boolean
        {
            return super.pathByAStarArray(param1, param2);
        }// end function

        override public function enterFrame(event:Event = null) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            var _loc_15:* = 0;
            var _loc_16:* = null;
            var _loc_17:* = 0;
            var _loc_18:* = 0;
            super.enterFrame(event);
            var _loc_2:* = getTimer();
            var _loc_3:* = RoleList.getInstance().player as Player;
            if (ClientMonsterInfo(_info).isNeedAutoMove && !isPathing && !_info.currentSkill)
            {
                if (_loc_2 - this._lastMoveTime > this._moveDisTime)
                {
                    _loc_4 = Math.random() > 0.5 ? (1) : (-1);
                    _loc_5 = Math.random() > 0.5 ? (1) : (-1);
                    _loc_6 = Math.random() * ClientMonsterInfo(_info).autoMoveRange * _loc_4;
                    _loc_7 = Math.random() * ClientMonsterInfo(_info).autoMoveRange * _loc_5;
                    _loc_8 = MapUtils.tile2Coo([_loc_6, _loc_7]);
                    _loc_9 = _info.x + _loc_8[0];
                    _loc_10 = _info.y + _loc_8[1];
                    pathByCoo(_loc_9, _loc_10);
                }
            }
            if (!_info.currentSkill && ClientMonsterInfo(_info).monAlertRange > 0)
            {
                if (_loc_2 - this._lastAlertTime > 500)
                {
                    this._lastAlertTime = _loc_2;
                    if (ToolKit.distance(_loc_3.x, _loc_3.y, x, y) <= ClientMonsterInfo(_info).monAlertRange)
                    {
                        this.moveToAttack(_loc_3);
                    }
                }
            }
            if (_info && alive())
            {
                if (isNaN(_loc_2))
                {
                    _loc_2 = getTimer();
                }
                if (_info.currentSkill)
                {
                    if (_info.currentSkill.hasTargetRole())
                    {
                        if (_loc_2 - this._lastCheckTime > _info.currentSkill.q_cd)
                        {
                            _loc_13 = MapUtils.DIRECT_90;
                            _loc_14 = info.currentSkill.targetRole;
                            if (_loc_14)
                            {
                                if (!_loc_14.alive())
                                {
                                    _info.currentSkill = null;
                                    return;
                                }
                                _loc_11 = _loc_14._x;
                                _loc_12 = _loc_14._y;
                                MapUtils.countDistance([MapUtils.coo2Tile(_x), MapUtils.coo2Tile(_y)], [MapUtils.coo2Tile(_loc_11), MapUtils.coo2Tile(_loc_12)]) = (MapUtils.countDistance([MapUtils.coo2Tile(_x), MapUtils.coo2Tile(_y)], [MapUtils.coo2Tile(_loc_11), MapUtils.coo2Tile(_loc_12)]) + 1);
                                if (MapUtils.countDistance([MapUtils.coo2Tile(_x), MapUtils.coo2Tile(_y)], [MapUtils.coo2Tile(_loc_11), MapUtils.coo2Tile(_loc_12)]) > 0)
                                {
                                    if (MapUtils.countDistance([MapUtils.coo2Tile(_x), MapUtils.coo2Tile(_y)], [MapUtils.coo2Tile(_loc_11), MapUtils.coo2Tile(_loc_12)]) > _info.currentSkill.q_range_limit)
                                    {
                                        if (pathByCoo(_loc_11, _loc_12) == false)
                                        {
                                            _info.currentSkill = null;
                                        }
                                        return;
                                    }
                                }
                                _loc_13 = face2(_loc_11, _loc_12);
                                attack();
                                FightControl.getInstance().showSkillRelease(this, _info.currentSkill);
                                _loc_16 = SkillCfgObj.getInstance().getSkillDamageObjById(_info.currentSkill.q_skillID);
                                if (_loc_16)
                                {
                                    _loc_17 = int(_loc_16.q_damage) + int(_loc_16.q_scene) * (1 - Math.random() * 2);
                                    if (_loc_14.info.HP - _loc_17 < MapClientControl.getInstance().lowestHp)
                                    {
                                        _loc_18 = _loc_14.info.HP - MapClientControl.getInstance().lowestHp > 0 ? (_loc_14.info.HP - MapClientControl.getInstance().lowestHp) : (0);
                                    }
                                    else
                                    {
                                        _loc_18 = _loc_17;
                                    }
                                }
                                else
                                {
                                    _loc_17 = _loc_14.info.HP - MapClientControl.getInstance().lowestHp;
                                    var _loc_19:* = _loc_17 > 0 ? (_loc_17) : (1);
                                    _loc_17 = _loc_17 > 0 ? (_loc_17) : (1);
                                    _loc_18 = _loc_19;
                                }
                                if (_loc_14.info.HP > MapClientControl.getInstance().lowestHp && _loc_14.info.HP > _loc_18)
                                {
                                    MapClientControl.getInstance().createAttackResult(_info.currentSkill.q_skillID, info.personId, _loc_14.info.personId, _loc_17, _loc_14.info.HP - _loc_18);
                                }
                                else
                                {
                                    MapClientControl.getInstance().createAttackResult(_info.currentSkill.q_skillID, info.personId, _loc_14.info.personId, _loc_17, _loc_14.info.HP);
                                }
                                if (this.isAttackSpeak)
                                {
                                    this.doSpeak();
                                }
                                if (this._attackTime > 0)
                                {
                                    var _loc_19:* = this;
                                    var _loc_20:* = this._attackTime - 1;
                                    _loc_19._attackTime = _loc_20;
                                    if (this._attackTime <= 0)
                                    {
                                        _info.currentSkill = null;
                                        if (this._attackCallBack != null)
                                        {
                                            this._attackCallBack();
                                            this._attackCallBack = null;
                                        }
                                    }
                                }
                            }
                            this._lastCheckTime = _loc_2;
                        }
                    }
                    else
                    {
                        _info.currentSkill = null;
                    }
                }
            }
            return;
        }// end function

        private function doSpeak() : void
        {
            var _loc_1:* = NaN;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (!isSpeaking())
            {
                _loc_1 = Math.random();
                _loc_2 = 0;
                _loc_3 = ClientMonsterInfo(info).talkPercent.length;
                while (_loc_2 < _loc_3)
                {
                    
                    if (ClientMonsterInfo(info).talkPercent[_loc_2] >= _loc_1)
                    {
                        speak(ClientMonsterInfo(info).talkContent[_loc_2]);
                        TweenLite.delayedCall(2, stopSpeak);
                        break;
                    }
                    _loc_2++;
                }
            }
            return;
        }// end function

        override public function finalize() : void
        {
            TweenLite.killDelayedCallsTo(stopSpeak);
            super.finalize();
            return;
        }// end function

    }
}
