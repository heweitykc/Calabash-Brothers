package com.game.realm.handler
{
    import com.game.realm.message.*;
    import net.*;

    public class ResBreakthroughToClientHandler extends Handler
    {

        public function ResBreakthroughToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResBreakthroughToClientMessage(this.message);
            return;
        }// end function

    }
}
