package com.game.pet.handler
{
    import com.game.pet.message.*;
    import net.*;

    public class ResPetSkillChangeHandler extends Handler
    {

        public function ResPetSkillChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPetSkillChangeMessage(this.message);
            return;
        }// end function

    }
}
