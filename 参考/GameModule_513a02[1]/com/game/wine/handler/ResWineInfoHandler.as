package com.game.wine.handler
{
    import com.game.wine.message.*;
    import net.*;

    public class ResWineInfoHandler extends Handler
    {

        public function ResWineInfoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResWineInfoMessage(this.message);
            return;
        }// end function

    }
}
