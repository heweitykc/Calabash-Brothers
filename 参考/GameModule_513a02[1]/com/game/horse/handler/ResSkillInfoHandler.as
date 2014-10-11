package com.game.horse.handler
{
    import com.game.horse.message.*;
    import net.*;

    public class ResSkillInfoHandler extends Handler
    {

        public function ResSkillInfoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResSkillInfoMessage(this.message);
            return;
        }// end function

    }
}
