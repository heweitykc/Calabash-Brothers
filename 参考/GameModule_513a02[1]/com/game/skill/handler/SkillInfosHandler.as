package com.game.skill.handler
{
    import com.game.skill.control.*;
    import com.game.skill.message.*;
    import net.*;

    public class SkillInfosHandler extends Handler
    {

        public function SkillInfosHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = SkillInfosMessage(this.message);
            SkillControl.getInstance().skillInfosHandler(_loc_1);
            return;
        }// end function

    }
}
