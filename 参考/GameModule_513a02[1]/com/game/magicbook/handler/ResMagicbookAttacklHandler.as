package com.game.magicbook.handler
{
    import com.game.magicbook.control.*;
    import com.game.magicbook.message.*;
    import net.*;

    public class ResMagicbookAttacklHandler extends Handler
    {

        public function ResMagicbookAttacklHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResMagicbookAttacklMessage(this.message);
            MagicBookSkillShowControl.getInstance().showSkillView(_loc_1);
            return;
        }// end function

    }
}
