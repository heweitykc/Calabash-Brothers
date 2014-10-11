package com.game.magicbook.handler
{
    import com.game.magicbook.message.*;
    import com.game.magicbook.model.*;
    import flash.events.*;
    import net.*;

    public class ResBookGainStateHandler extends Handler
    {

        public function ResBookGainStateHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResBookGainStateMessage(this.message);
            MagicBookData.state = _loc_1.gainState;
            MagicBookData.dispatchEvent(new Event(MagicBookData.STATE_CHANGE));
            return;
        }// end function

    }
}
