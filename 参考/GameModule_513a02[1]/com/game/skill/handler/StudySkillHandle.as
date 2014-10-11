package com.game.skill.handler
{
    import com.game.skill.control.*;
    import com.game.skill.message.*;
    import net.*;

    public class StudySkillHandle extends Handler
    {

        public function StudySkillHandle()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = StudySkillMessage(this.message);
            SkillControl.getInstance().studySkillMessage(_loc_1);
            return;
        }// end function

    }
}
