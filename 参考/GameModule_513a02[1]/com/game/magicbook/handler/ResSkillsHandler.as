package com.game.magicbook.handler
{
    import com.game.magicbook.message.*;
    import com.game.magicbook.model.*;
    import net.*;

    public class ResSkillsHandler extends Handler
    {

        public function ResSkillsHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResSkillsMessage(this.message);
            MagicBookData.getMagicBookInfo().skills_m = _loc_1.skills;
            return;
        }// end function

    }
}
