package com.game.magicbook.handler
{
    import com.game.magicbook.message.*;
    import com.game.magicbook.model.*;
    import net.*;

    public class ResSeeOtherMagicbookHandler extends Handler
    {

        public function ResSeeOtherMagicbookHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResSeeOtherMagicbookMessage(this.message);
            MagicBookData.saveOtherMagicBookInfo(_loc_1);
            return;
        }// end function

    }
}
