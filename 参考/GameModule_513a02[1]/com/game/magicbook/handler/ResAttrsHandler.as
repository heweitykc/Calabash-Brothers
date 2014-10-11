package com.game.magicbook.handler
{
    import com.game.magicbook.message.*;
    import com.game.magicbook.model.*;
    import net.*;

    public class ResAttrsHandler extends Handler
    {

        public function ResAttrsHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResAttrsMessage(this.message);
            MagicBookData.getMagicBookInfo().setMagicAttrInfos(_loc_1.attrs);
            return;
        }// end function

    }
}
