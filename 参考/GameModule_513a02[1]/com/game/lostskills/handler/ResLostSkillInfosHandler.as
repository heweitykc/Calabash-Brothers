package com.game.lostskills.handler
{
    import com.game.lostskills.message.*;
    import com.game.skill.control.*;
    import net.*;

    public class ResLostSkillInfosHandler extends Handler
    {

        public function ResLostSkillInfosHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResLostSkillInfosMessage(this.message);
            SkillControl.getInstance().resLostSkillInfos(_loc_1);
            return;
        }// end function

    }
}
