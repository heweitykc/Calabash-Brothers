package com.game.guide.handler
{
    import com.game.gm.message.*;
    import com.game.guide.control.*;
    import net.*;

    public class ResGMOpenIconHandler extends Handler
    {

        public function ResGMOpenIconHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            ActiveGuideControl.getInstance().resGMOpenIcon(message as ResGMOpenIconMessage);
            return;
        }// end function

    }
}
