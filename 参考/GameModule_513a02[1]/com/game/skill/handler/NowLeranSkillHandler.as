package com.game.skill.handler
{
    import com.game.skill.control.*;
    import com.game.skill.message.*;
    import net.*;

    public class NowLeranSkillHandler extends Handler
    {

        public function NowLeranSkillHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = NowLeranSkillMessage(this.message);
            SkillControl.getInstance().nowLearnSkillHandler(_loc_1);
            return;
        }// end function

    }
}
