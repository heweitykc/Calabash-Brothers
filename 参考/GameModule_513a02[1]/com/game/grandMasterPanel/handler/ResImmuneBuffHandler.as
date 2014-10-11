package com.game.grandMasterPanel.handler
{
    import com.f1.ui.scrollmc.*;
    import com.f1.utils.*;
    import com.game.fight.model.*;
    import com.game.masterskill.message.*;
    import com.model.*;
    import flash.display.*;
    import interfaces.role.*;
    import net.*;

    public class ResImmuneBuffHandler extends Handler
    {

        public function ResImmuneBuffHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_3:* = null;
            var _loc_1:* = ResImmuneBuffMessage(message);
            var _loc_2:* = _loc_1.type;
            var _loc_4:* = RoleList.getInstance().getRole(_loc_1.playerId);
            if (!RoleList.getInstance().getRole(_loc_1.playerId) || !_loc_4.info)
            {
                return;
            }
            if (_loc_2 == FightResultType.IMMU_DEC_SPEED)
            {
                _loc_3 = ToolKit.getNew("fightImmuDecSpeed");
                if (_loc_3)
                {
                    _loc_4.showTopCue(_loc_3, 0, 0, 40, -10, ScrollMC.TWO_STEP_TYPE);
                }
            }
            else if (_loc_2 == FightResultType.IMMU_POISON)
            {
                _loc_3 = ToolKit.getNew("fightImmuPoison");
                if (_loc_3)
                {
                    _loc_4.showTopCue(_loc_3, 0, 0, 40, -10, ScrollMC.TWO_STEP_TYPE);
                }
            }
            else if (_loc_2 == FightResultType.IMMU_FIX_BODY)
            {
                _loc_3 = ToolKit.getNew("fightImmuFixBody");
                if (_loc_3)
                {
                    _loc_4.showTopCue(_loc_3, 0, 0, 40, -10, ScrollMC.TWO_STEP_TYPE);
                }
            }
            else if (_loc_2 == FightResultType.IMMU_VERTIGO)
            {
                _loc_3 = ToolKit.getNew("fightImmuVertigo");
                if (_loc_3)
                {
                    _loc_4.showTopCue(_loc_3, 0, 0, 40, -10, ScrollMC.TWO_STEP_TYPE);
                }
            }
            else if (_loc_2 == FightResultType.IMMU_DAMAGE)
            {
                _loc_3 = ToolKit.getNew("fightImmuDamage");
                if (_loc_3)
                {
                    _loc_4.showTopCue(_loc_3, 0, 0, 40, -10, ScrollMC.TWO_STEP_TYPE);
                }
            }
            return;
        }// end function

    }
}
