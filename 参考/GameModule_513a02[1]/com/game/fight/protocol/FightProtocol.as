package com.game.fight.protocol
{
    import com.*;
    import com.game.fight.message.*;
    import com.game.map.model.*;
    import com.game.player.message.*;
    import com.game.utils.*;
    import com.model.*;
    import interfaces.role.*;

    public class FightProtocol extends BaseProtocol
    {

        public function FightProtocol()
        {
            return;
        }// end function

        public function attackPlayer(param1:int, param2:long, param3:int) : void
        {
            var _loc_4:* = new ReqAttackPlayerMessage();
            _loc_4.fightDirection = param3;
            _loc_4.fightType = param1;
            _loc_4.fightTarget = param2;
            send(_loc_4);
            return;
        }// end function

        public function attackFriend(param1:int, param2:long, param3:uint, param4:int) : void
        {
            var _loc_5:* = new ReqAttackFriendMessage();
            _loc_5.fightDirection = param4;
            _loc_5.fightType = param1;
            _loc_5.fightTarget = param2;
            _loc_5.targetType = param3;
            send(_loc_5);
            return;
        }// end function

        public function attackMonster(param1:int, param2:long, param3:int) : void
        {
            var _loc_4:* = new ReqAttackMonsterMessage();
            _loc_4.fightDirection = param3;
            _loc_4.fightType = param1;
            _loc_4.fightTarget = param2;
            send(_loc_4);
            return;
        }// end function

        public function attackSummonPet(param1:int, param2:long, param3:int, param4:long) : void
        {
            var _loc_5:* = new ReqAttackSummonPetMessage();
            _loc_5.fightDirection = param3;
            _loc_5.fightType = param1;
            _loc_5.fightTarget = param2;
            _loc_5.owherId = param4;
            send(_loc_5);
            return;
        }// end function

        public function attackPosition(param1:uint, param2:int, param3:int, param4:int, param5:uint, param6:uint) : void
        {
            var _loc_7:* = new ReqAttackPostionMessage();
            _loc_7.fightDirection = param4;
            _loc_7.fightType = param1;
            _loc_7.line = UserObj.getInstance().line;
            _loc_7.mapModelId = MapObj.getInstance().mapID;
            _loc_7.x = param2;
            _loc_7.y = param3;
            send(_loc_7);
            return;
        }// end function

        public function attackSpecial(param1:uint, param2:int, param3:int, param4:int, param5:uint, param6:uint, param7:Array) : void
        {
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_8:* = new ReqAttackSpecialMessage();
            _loc_8.fightDirection = param4;
            _loc_8.fightType = param1;
            _loc_8.line = UserObj.getInstance().line;
            _loc_8.mapModelId = MapObj.getInstance().mapID;
            _loc_8.x = param2;
            _loc_8.y = param3;
            for each (_loc_10 in param7)
            {
                
                _loc_9 = _loc_10.role;
                _loc_8.fightTargets.push(_loc_9.info.personId);
                _loc_8.fightTypes.push(_loc_9.info.roleType);
            }
            send(_loc_8);
            return;
        }// end function

        public function reqChangePKStateMessage(param1:int, param2:int) : void
        {
            var _loc_3:* = new ReqChangePKStateMessage();
            _loc_3.pkState = param1;
            _loc_3.auto = param2;
            send(_loc_3);
            return;
        }// end function

    }
}
