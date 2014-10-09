package com.game.monster.control
{
    import com.f1.utils.*;
    import com.game.map.control.*;
    import com.game.monster.message.*;
    import com.model.*;
    import interfaces.role.*;

    public class MonsterControl extends Object
    {
        private static var instance:MonsterControl;

        public function MonsterControl()
        {
            return;
        }// end function

        public function monsterMaxHpChangeHandler(param1:ResMonsterMaxHpChangeMessage) : void
        {
            var _loc_2:* = RoleList.getInstance().getRole(param1.monsterId);
            if (_loc_2)
            {
                _loc_2.info.HPMax = param1.maxHp;
                _loc_2.info.HP = param1.currentHp;
            }
            return;
        }// end function

        public function monsterMaxMpChangeHandler(param1:ResMonsterMaxMpChangeMessage) : void
        {
            var _loc_2:* = RoleList.getInstance().getRole(param1.monsterId);
            if (_loc_2)
            {
                _loc_2.info.MPMax = param1.maxMp;
                _loc_2.info.MP = param1.currentMp;
            }
            return;
        }// end function

        public function monsterHpChangeHandler(param1:ResMonsterHpChangeMessage) : void
        {
            var _loc_2:* = RoleList.getInstance().getRole(param1.monsterId);
            if (_loc_2)
            {
                if (_loc_2.info)
                {
                    _loc_2.info.HP = param1.currentHp;
                }
                else
                {
                    Log.log("怪物已经死亡了");
                }
            }
            return;
        }// end function

        public function monsterMpChangeHandler(param1:ResMonsterMpChangeMessage) : void
        {
            var _loc_2:* = RoleList.getInstance().getRole(param1.monsterId);
            if (_loc_2)
            {
                if (_loc_2.info)
                {
                    _loc_2.info.MP = param1.currentMp;
                }
                else
                {
                    Log.log("怪物已经死亡了");
                }
            }
            return;
        }// end function

        public function monsterSpeedChangeHandler(param1:ResMonsterSpeedChangeMessage) : void
        {
            var _loc_2:* = RoleList.getInstance().getRole(param1.monsterId);
            if (_loc_2)
            {
                _loc_2.info.speed = param1.speed;
            }
            return;
        }// end function

        public function monsterDie(param1:ResMonsterDieMessage) : void
        {
            return;
        }// end function

        public function monsterReviveHandler(param1:ResMonsterReviveMessage) : void
        {
            MapControl.getInstance().addMonsterByCSInfo(param1.monster);
            return;
        }// end function

        public function resMonsterSayHandler(param1:ResMonsterSayMessage) : void
        {
            var _loc_2:* = RoleList.getInstance().getRole(param1.monsterId);
            if (_loc_2)
            {
                _loc_2.richSpeak(param1.saycontent, null, false, null, 5);
            }
            return;
        }// end function

        public static function getInstance() : MonsterControl
        {
            if (instance == null)
            {
                instance = new MonsterControl;
            }
            return instance;
        }// end function

    }
}
