package com.game.task.handler
{
    import com.game.guide.model.*;
    import com.game.task.message.*;
    import net.*;

    public class ResGuideInfoHandler extends Handler
    {

        public function ResGuideInfoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGetGuidesMessage(this.message);
            GuideConfigObj.getInstance().initGuideConfig(_loc_1.guides);
            return;
        }// end function

    }
}
