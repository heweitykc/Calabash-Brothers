package com.game.buff.handler
{
    import com.game.buff.control.*;
    import com.game.buff.message.*;
    import net.*;

    public class ResAddBuffHandler extends Handler
    {

        public function ResAddBuffHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResAddBuffMessage(this.message);
            BuffControl.getInstance().addBuffHandler(_loc_1);
            return;
        }// end function

    }
}
