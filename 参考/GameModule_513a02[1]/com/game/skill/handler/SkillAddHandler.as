package com.game.skill.handler
{
    import com.game.skill.control.*;
    import com.game.skill.message.*;
    import net.*;

    public class SkillAddHandler extends Handler
    {

        public function SkillAddHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = SkillAddMessage(this.message);
            SkillControl.getInstance().skillAddHandler(_loc_1);
            SkillControl.getInstance().addSkillHandler(_loc_1);
            return;
        }// end function

    }
}
