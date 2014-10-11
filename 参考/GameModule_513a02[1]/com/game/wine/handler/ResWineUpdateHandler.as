package com.game.wine.handler
{
    import com.game.wine.message.*;
    import net.*;

    public class ResWineUpdateHandler extends Handler
    {

        public function ResWineUpdateHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResWineUpdateMessage(this.message);
            return;
        }// end function

    }
}
