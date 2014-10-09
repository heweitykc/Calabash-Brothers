package com.game.offline.handler
{
    import com.game.offline.control.*;
    import com.game.offline.message.*;
    import com.model.*;
    import net.*;

    public class ResRetreatInfoHandler extends Handler
    {

        public function ResRetreatInfoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRetreatInfoMessage(this.message);
            UserObj.getInstance().playerInfo.offlineExp = _loc_1.curTime;
            OfflineControl.instance.retreatInfo(_loc_1);
            return;
        }// end function

    }
}
