package com.game.skill.handler
{
    import com.game.skill.message.*;
    import net.*;

    public class SkillLingWuResultHandler extends Handler
    {

        public function SkillLingWuResultHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = SkillLingWuResultMessage(this.message);
            return;
        }// end function

    }
}
