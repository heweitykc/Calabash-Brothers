package com.game.role
{
    import com.cfg.obj.*;
    import com.f1.utils.path.*;
    import com.game.fight.control.*;
    import com.game.map.control.*;
    import com.game.zones.control.*;
    import com.model.*;
    import com.model.vo.*;
    import flash.events.*;
    import flash.utils.*;
    import interfaces.role.*;

    public class AssistMM extends FollowerRole
    {
        private const DISTANCE:uint = 3000;
        private const SKILL_ID:Array;
        private var _lastTime:int;
        private var _attackTime:int = -1;
        private var _lastCheckTime:Number = 0;
        public var isFlying:Boolean;
        private var _curSkillIndex:int;
        private var isBeginAttack:Boolean = false;

        public function AssistMM()
        {
            this.SKILL_ID = [10114, 10128, 10140, 10136];
            var _loc_1:* = false;
            this.mouseChildren = false;
            this.mouseEnabled = _loc_1;
            return;
        }// end function

        public function attackToUser() : void
        {
            if (this._curSkillIndex >= this.SKILL_ID.length)
            {
                _info.currentSkill = null;
                return;
            }
            if (_info.currentSkill)
            {
                return;
            }
            this.isBeginAttack = true;
            if (this._curSkillIndex == 0)
            {
                this.moveToAttack(RoleList.getInstance().player, this.SKILL_ID[this._curSkillIndex], 1);
            }
            else
            {
                this.moveToAttack(ClientZonesSkeletonKingControl.getInstance().boss, this.SKILL_ID[this._curSkillIndex], 1);
            }
            var _loc_1:* = this;
            var _loc_2:* = this._curSkillIndex + 1;
            _loc_1._curSkillIndex = _loc_2;
            return;
        }// end function

        private function moveToAttack(param1:IRole, param2:int = 0, param3:int = -1) : void
        {
            if (_info.currentSkill)
            {
                return;
            }
            var _loc_4:* = SkillCfgObj.getInstance().getSkillInfoById(param2);
            if (SkillCfgObj.getInstance().getSkillInfoById(param2))
            {
                _loc_4.targetRole = param1;
                _info.currentSkill = _loc_4;
            }
            if (param3 != -1)
            {
                this._attackTime = param3;
            }
            return;
        }// end function

        override public function enterFrame(event:Event = null) : void
        {
            var _loc_3:* = NaN;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            if (this.isFlying)
            {
                return;
            }
            var _loc_2:* = getTimer();
            if (_loc_2 - this._lastTime >= this.DISTANCE && this.isBeginAttack)
            {
                this._lastTime = _loc_2;
                this.attackToUser();
            }
            super.enterFrame(event);
            if (_info && alive())
            {
                _loc_3 = getTimer();
                if (_info.currentSkill)
                {
                    if (_info.currentSkill.hasTargetRole())
                    {
                        if (_loc_3 - this._lastCheckTime > _info.currentSkill.q_cd)
                        {
                            _loc_6 = MapUtils.DIRECT_90;
                            _loc_7 = info.currentSkill.targetRole;
                            if (_loc_7)
                            {
                                if (!_loc_7.alive())
                                {
                                    _info.currentSkill = null;
                                    return;
                                }
                                _loc_4 = _loc_7._x;
                                _loc_5 = _loc_7._y;
                                MapUtils.countDistance([MapUtils.coo2Tile(_x), MapUtils.coo2Tile(_y)], [MapUtils.coo2Tile(_loc_4), MapUtils.coo2Tile(_loc_5)]) = (MapUtils.countDistance([MapUtils.coo2Tile(_x), MapUtils.coo2Tile(_y)], [MapUtils.coo2Tile(_loc_4), MapUtils.coo2Tile(_loc_5)]) + 1);
                                if (MapUtils.countDistance([MapUtils.coo2Tile(_x), MapUtils.coo2Tile(_y)], [MapUtils.coo2Tile(_loc_4), MapUtils.coo2Tile(_loc_5)]) > 0)
                                {
                                    if (MapUtils.countDistance([MapUtils.coo2Tile(_x), MapUtils.coo2Tile(_y)], [MapUtils.coo2Tile(_loc_4), MapUtils.coo2Tile(_loc_5)]) > _info.currentSkill.q_range_limit)
                                    {
                                        if (pathByCoo(_loc_4, _loc_5) == false)
                                        {
                                            _info.currentSkill = null;
                                        }
                                        return;
                                    }
                                }
                                _loc_6 = face2(_loc_4, _loc_5);
                                attack();
                                FightControl.getInstance().showSkillRelease(this, _info.currentSkill);
                                _loc_9 = SkillCfgObj.getInstance().getSkillInfoById(_info.currentSkill.q_skillID);
                                if (_loc_9.q_skillID == this.SKILL_ID[0])
                                {
                                    _loc_7.info.HP = _loc_7.info.HPMax;
                                    MapClientControl.getInstance().createBuffByArr(_loc_9.q_passive_buff, _loc_7);
                                }
                                else
                                {
                                    _loc_10 = SkillCfgObj.getInstance().getSkillDamageObjById(_info.currentSkill.q_skillID);
                                    if (_loc_10)
                                    {
                                        _loc_11 = int(_loc_10.q_damage) + int(_loc_10.q_scene) * (1 - Math.random() * 2);
                                    }
                                    if (_loc_7.info.HP <= _loc_11 && _loc_7.info.cfgId == ClientZonesSkeletonKingControl.getInstance().BOSS_MODEL_ID)
                                    {
                                        ClientZonesSkeletonKingControl.getInstance().lastAttack();
                                    }
                                    MapClientControl.getInstance().createAttackResult(_info.currentSkill.q_skillID, UserObj.getInstance().playerInfo.personId, _loc_7.info.personId, _loc_11, _loc_7.info.HP - _loc_11, 1);
                                }
                                if (this._attackTime > 0)
                                {
                                    var _loc_12:* = this;
                                    var _loc_13:* = this._attackTime - 1;
                                    _loc_12._attackTime = _loc_13;
                                    if (this._attackTime <= 0)
                                    {
                                        _info.currentSkill = null;
                                    }
                                }
                            }
                            this._lastCheckTime = _loc_3;
                        }
                    }
                    else
                    {
                        _info.currentSkill = null;
                    }
                }
            }
            super.enterFrame(event);
            return;
        }// end function

    }
}
