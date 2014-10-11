package com.game.autopk.controller
{
    import com.events.*;
    import com.f1.utils.path.*;
    import com.game.autopk.*;
    import com.game.autopk.model.*;
    import com.game.backpack.model.*;
    import com.game.fight.control.*;
    import com.game.map.model.*;
    import com.game.player.control.*;
    import com.game.role.*;
    import com.model.*;
    import com.staticdata.*;
    import flash.geom.*;
    import interfaces.role.*;

    public class DieLogic extends Object
    {
        public static const RELIVE_PORP_ID:int = 200051;
        public static const DELAY_TIME:int = 5;
        public static const RANK_LIMIT:int = 60;
        public static var isContinueAuto:Boolean = false;
        private static var autoback:Boolean = false;
        public static var isComingBack:Boolean = false;

        public function DieLogic()
        {
            return;
        }// end function

        public static function die() : Boolean
        {
            isContinueAuto = false;
            var _loc_1:* = AutoFightManager.getInstance().isAutoFighting();
            if (!_loc_1 && !isComingBack)
            {
                return false;
            }
            if (AutoFightManager.FIGHT_TYPE != AutoFightManager.getInstance().type && !isComingBack)
            {
                return false;
            }
            AutoFightController.getInstance().closeAutoFight();
            if (UserObj.getInstance().playerInfo.vipid > 0)
            {
                if (AutoFightModel.autoBorn)
                {
                    isContinueAuto = true;
                    autoback = true;
                    return autoback;
                }
            }
            autoback = true;
            return autoback;
        }// end function

        private static function onTimeComplete() : void
        {
            var _loc_1:* = 0;
            if (AutoFightModel.autoBorn)
            {
                _loc_1 = BackpackObj.getInstance().getItemCount(RELIVE_PORP_ID);
                if (_loc_1 > 0)
                {
                    PlayerControl.getInstance().reqRevive(AutoReviveType.AUTO_REVIVE, RELIVE_PORP_ID);
                }
            }
            return;
        }// end function

        public static function revive() : void
        {
            var _loc_1:* = null;
            if (isContinueAuto)
            {
                _loc_1 = RoleList.getInstance().player;
                if (_loc_1 && autoback)
                {
                    autoback = false;
                    if (_loc_1 && _loc_1.fatherActType == Params.ACTION_SIMPLE_ATTACK_ID)
                    {
                        _loc_1.addEvtListener(RoleEvent.ACTION_COMPLETE, actComplete);
                        return;
                    }
                    beginBackToCoord();
                }
            }
            return;
        }// end function

        private static function actComplete(event:RoleEvent) : void
        {
            var _loc_2:* = RoleList.getInstance().player as Player;
            _loc_2.removeEvtListener(RoleEvent.ACTION_COMPLETE, actComplete);
            beginBackToCoord();
            return;
        }// end function

        private static function beginBackToCoord() : void
        {
            FightControl.getInstance().delCurrentSkill();
            UserObj.getInstance().selectRole = null;
            var _loc_1:* = AutoFightManager.getInstance().fightLogic.coord;
            var _loc_2:* = _loc_1.x;
            var _loc_3:* = _loc_1.y;
            var _loc_4:* = AutoFightManager.getInstance().fightLogic.mapId;
            AutoFightController.getInstance().openAutoFight();
            AutoFightManager.getInstance().fightLogic.coord = new Point(_loc_2, _loc_3);
            AutoFightManager.getInstance().fightLogic.mapId = _loc_4;
            return;
        }// end function

        private static function arriveHandler(event:RoleEvent = null) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            if (isContinueAuto)
            {
                _loc_2 = AutoFightManager.getInstance().fightLogic.mapId;
                _loc_3 = MapObj.getInstance().mapID;
                _loc_5 = RoleList.getInstance().player;
                if (_loc_2 == _loc_3)
                {
                    _loc_6 = AutoFightManager.getInstance().fightLogic.coord;
                    _loc_4 = Math.sqrt((_loc_5._x - _loc_6.x) * (_loc_5._x - _loc_6.x) + (_loc_5._y - _loc_6.y) * (_loc_5._y - _loc_6.y));
                    if (_loc_4 <= 8 * MapUtils.GRID_BORDER)
                    {
                        AutoFightController.getInstance().openAutoFight();
                        _loc_7 = RoleList.getInstance().player;
                        _loc_7.removeEvtListener(RoleEvent.ARRIVE, arriveHandler);
                        isComingBack = false;
                        return;
                    }
                }
            }
            return;
        }// end function

    }
}
