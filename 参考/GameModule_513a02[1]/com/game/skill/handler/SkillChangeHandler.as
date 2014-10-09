package com.game.skill.handler
{
    import com.game.skill.message.*;
    import net.*;

    public class SkillChangeHandler extends Handler
    {

        public function SkillChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = SkillChangeMessage(this.message);
            return;
        }// end function

    }
}
