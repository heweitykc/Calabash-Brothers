package com.game.version.handler
{
    import com.game.version.message.*;
    import net.*;

    public class ResVersionResInfoHandler extends Handler
    {

        public function ResVersionResInfoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResVersionResInfoMessage(this.message);
            return;
        }// end function

    }
}
