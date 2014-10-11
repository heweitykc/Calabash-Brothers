package com.game.skill.handler
{
    import com.game.skill.control.*;
    import com.game.skill.message.*;
    import net.*;

    public class SkillStartLevelUpHandler extends Handler
    {

        public function SkillStartLevelUpHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = SkillStartLevelUpMessage(this.message);
            SkillControl.getInstance().skillStartLevelUpHandler(_loc_1);
            return;
        }// end function

    }
}
