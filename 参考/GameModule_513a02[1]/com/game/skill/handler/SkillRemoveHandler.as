package com.game.skill.handler
{
    import com.game.skill.control.*;
    import com.game.skill.message.*;
    import net.*;

    public class SkillRemoveHandler extends Handler
    {

        public function SkillRemoveHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = SkillRemoveMessage(this.message);
            SkillControl.getInstance().skillRemoveHandle(_loc_1);
            return;
        }// end function

    }
}
