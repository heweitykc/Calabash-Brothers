package com.game.magicbook.handler
{
    import com.game.magicbook.control.*;
    import com.game.magicbook.message.*;
    import net.*;

    public class ResBeAttackInfoHandler extends Handler
    {

        public function ResBeAttackInfoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResBeAttackInfoMessage(this.message);
            MagicBookSkillShowControl.getInstance().attacked(_loc_1);
            super.action();
            return;
        }// end function

    }
}
