package com.game.magicbook.handler
{
    import com.game.magicbook.message.*;
    import com.game.magicbook.model.*;
    import net.*;

    public class ResExpHandler extends Handler
    {

        public function ResExpHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResExpMessage(this.message);
            MagicBookData.getMagicBookInfo().exp_m = _loc_1.exp;
            super.action();
            return;
        }// end function

    }
}
