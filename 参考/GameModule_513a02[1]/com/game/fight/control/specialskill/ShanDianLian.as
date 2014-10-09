package com.game.fight.control.specialskill
{
    import __AS3__.vec.*;
    import com.cfg.obj.*;
    import com.f1.utils.*;
    import com.f1.utils.path.*;
    import com.game.fight.control.*;
    import com.game.fight.message.*;
    import com.greensock.*;
    import com.model.*;
    import com.model.vo.*;
    import interfaces.role.*;

    public class ShanDianLian extends Object
    {
        private var attackLength:int = 0;
        private var vecAttactIDs:Vector.<long>;
        private var vecMsgs:Vector.<ResAttackResultMessage>;
        private var vecRoleList:Vector.<IRole>;
        private var attacked:IRole;
        private var curStep:int;
        private var skillShowControl:SkillShowControl;
        private var _state:String = "wait";
        public static const STATE_WAIT:String = "wait";
        public static const STATE_PLAY:String = "play";
        public static const STATE_OVER:String = "over";

        public function ShanDianLian(param1:SkillShowControl) : void
        {
            this.vecMsgs = new Vector.<ResAttackResultMessage>;
            this.vecRoleList = new Vector.<IRole>;
            this.skillShowControl = param1;
            Log.log("Jilifer ::: 开始技能");
            return;
        }// end function

        public function addedMsg(param1:ResAttackResultMessage) : void
        {
            if (this.state != STATE_WAIT)
            {
                return;
            }
            this.attackLength = param1.fighterIds.length;
            if (!this.vecAttactIDs)
            {
                this.vecAttactIDs = param1.fighterIds;
                this.attacked = RoleList.getInstance().getRole(param1.state.sourceId);
            }
            this.vecMsgs.push(param1);
            TweenLite.killDelayedCallsTo(this.startSkill);
            if (this.attackLength == this.vecMsgs.length)
            {
                this.startSkill();
            }
            else
            {
                TweenLite.delayedCall(2, this.startSkill);
            }
            Log.log("Jilifer ::: 加入数据：", this.vecMsgs.length.toString(), "需要数据长度：", param1.fighterIds.length.toString());
            return;
        }// end function

        private function startSkill() : void
        {
            this.preAttack();
            this.startAttack();
            this.state = STATE_OVER;
            return;
        }// end function

        private function preAttack() : void
        {
            while (this.vecAttactIDs.length > this.vecMsgs.length)
            {
                
                this.vecAttactIDs.pop();
            }
            this.attackLength = this.vecAttactIDs.length;
            var _loc_1:* = 0;
            while (_loc_1 < this.attackLength)
            {
                
                this.vecRoleList[_loc_1] = RoleList.getInstance().getRole(this.vecAttactIDs[_loc_1]);
                _loc_1++;
            }
            return;
        }// end function

        private function startAttack() : void
        {
            this.curStep = 0;
            this.roleAttack();
            return;
        }// end function

        private function roleAttack() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            Log.log("Jilifer ::: 攻击一次");
            if (this.curStep < this.attackLength)
            {
                _loc_1 = this.vecMsgs[this.curStep];
                if (this.curStep == 0)
                {
                    _loc_2 = this.attacked;
                }
                else
                {
                    _loc_2 = this.vecRoleList[(this.curStep - 1)];
                }
                _loc_3 = this.vecRoleList[this.curStep];
                _loc_4 = SkillCfgObj.getInstance().getSkillInfoById(_loc_1.state.skillId);
                _loc_4.targetRole = _loc_3;
                this.skillShowControl.showFly(_loc_2, _loc_4, this.callResultAttack);
            }
            return;
        }// end function

        private function callResultAttack() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = false;
            var _loc_6:* = 0;
            Log.log("Jilifer ::: 回调一次");
            if (this.curStep < this.attackLength)
            {
                _loc_1 = this.vecMsgs[this.curStep];
                if (this.curStep == 0)
                {
                    _loc_2 = this.attacked;
                }
                else
                {
                    _loc_2 = this.vecRoleList[(this.curStep - 1)];
                }
                _loc_3 = this.vecRoleList[this.curStep];
                if (_loc_3)
                {
                    _loc_5 = _loc_2.isUser() || _loc_3.isUser();
                    _loc_4 = SkillCfgObj.getInstance().getSkillInfoById(_loc_1.state.skillId);
                    _loc_4.targetRole = _loc_3;
                    _loc_6 = MapUtils.countDirection(_loc_2._x, _loc_2._y, _loc_3._x, _loc_3._y);
                    this.skillShowControl.showHit(_loc_2, _loc_3, _loc_4);
                    _loc_3.attacked(_loc_5, -_loc_1.state.damage, _loc_1.state.fightSpecialRes, 1, _loc_6, 100, 1);
                }
            }
            var _loc_7:* = this;
            var _loc_8:* = this.curStep + 1;
            _loc_7.curStep = _loc_8;
            if (this.curStep < this.attackLength)
            {
                this.roleAttack();
            }
            if (_loc_3 && _loc_3.info)
            {
                _loc_3.info.HP = _loc_1.state.currentHP;
            }
            if (_loc_3 && _loc_3.isMonster())
            {
                if (!_loc_3.alive())
                {
                    RoleList.getInstance().removeRole(_loc_3);
                    TweenLite.delayedCall(0.5, this.checkDie, [_loc_2, _loc_3, _loc_4]);
                }
            }
            return;
        }// end function

        private function checkDie(param1:IRole, param2:IRole, param3:SkillInfo) : void
        {
            if (!param2 || !param2.info)
            {
                return;
            }
            if (!param2.alive())
            {
                RoleList.getInstance().removeRole(param2);
                if (param3 && param3.q_whirlwind_dead > 0)
                {
                    if (param1)
                    {
                        param2.kickFly(param1, param3.q_whirlwind_dead);
                    }
                }
                else
                {
                    param2.dead();
                }
            }
            return;
        }// end function

        public function get state() : String
        {
            return this._state;
        }// end function

        public function set state(param1:String) : void
        {
            this._state = param1;
            return;
        }// end function

    }
}
