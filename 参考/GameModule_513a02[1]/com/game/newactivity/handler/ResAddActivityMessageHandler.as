package com.game.newactivity.handler
{
    import com.game.newactivity.message.*;
    import com.game.newactivity.model.*;
    import net.*;

    public class ResAddActivityMessageHandler extends Handler
    {

        public function ResAddActivityMessageHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResAddActivityMessage(this.message);
            NewActivityModel.getInstance().addActivity(_loc_1.infoList);
            return;
        }// end function

    }
}
