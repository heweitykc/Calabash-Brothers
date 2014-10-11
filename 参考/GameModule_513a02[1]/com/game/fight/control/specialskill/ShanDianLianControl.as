package com.game.fight.control.specialskill
{
    import com.f1.ui.scrollmc.*;
    import com.f1.utils.*;
    import com.game.fight.bean.*;
    import com.game.fight.control.*;
    import com.game.fight.message.*;
    import com.game.fight.model.*;
    import com.game.utils.*;
    import com.model.*;
    import com.util.*;
    import flash.display.*;
    import flash.utils.*;
    import interfaces.role.*;

    public class ShanDianLianControl extends Object
    {
        private var dicSkill:Dictionary;
        private var skillShowControl:SkillShowControl;

        public function ShanDianLianControl(param1:SkillShowControl)
        {
            this.dicSkill = new Dictionary();
            this.skillShowControl = param1;
            return;
        }// end function

        public function attackResult(param1:ResAttackResultMessage) : void
        {
            var _loc_2:* = param1.fightId;
            var _loc_3:* = this.dicSkill[_loc_2.toString()];
            if (!_loc_3)
            {
                _loc_3 = new ShanDianLian(this.skillShowControl);
                this.dicSkill[_loc_2.toString()] = _loc_3;
            }
            _loc_3.addedMsg(param1);
            this.ReCover();
            this.playAttactResultEffect(param1);
            return;
        }// end function

        private function playAttactResultEffect(param1:ResAttackResultMessage) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = param1.state;
            var _loc_3:* = _loc_2.fightResult;
            var _loc_5:* = -_loc_2.damage;
            var _loc_6:* = RoleList.getInstance().getRole(_loc_2.entityId);
            if (!RoleList.getInstance().getRole(_loc_2.entityId) || !_loc_6.info)
            {
                return;
            }
            if (_loc_3 == FightResultType.MISS)
            {
                if (_loc_6.isMonster())
                {
                    _loc_4 = ObjectPool.CheckOut(getDefinitionByName("fightMonsterMiss") as Class);
                }
                else
                {
                    _loc_4 = ObjectPool.CheckOut(getDefinitionByName("fightPlayerMiss") as Class);
                }
                if (_loc_6.isPlayer() && UICfg.hideOtherPlayer && !_loc_6.isUser())
                {
                }
                else if ((_loc_6.isMonster() || _loc_6.isClientMonster()) && UICfg.NORMAL_MONSTER)
                {
                }
                else
                {
                    _loc_6.showTopCue(_loc_4, 0, 0, 0, 58, ScrollMC.MISS_TYPE, 1, 100, 0.5, true, 0, 0, 1, 22, 1);
                }
            }
            return;
        }// end function

        private function ReCover() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            for (_loc_1 in this.dicSkill)
            {
                
                _loc_2 = _loc_4[_loc_1];
                if (_loc_2.state == ShanDianLian.STATE_OVER)
                {
                    _loc_4[_loc_1] = null;
                    delete _loc_4[_loc_1];
                }
            }
            return;
        }// end function

    }
}
