package com.game.lostskills.handler
{
    import com.game.lostskills.message.*;
    import com.game.skill.control.*;
    import net.*;

    public class ResActivateLostSkillHandler extends Handler
    {

        public function ResActivateLostSkillHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResActivateLostSkillMessage(this.message);
            SkillControl.getInstance().resActivateLostSkill(_loc_1);
            return;
        }// end function

    }
}
