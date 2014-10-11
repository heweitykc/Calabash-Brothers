package com.game.player.handler
{
    import com.game.elementHeart.control.*;
    import com.game.player.control.*;
    import com.game.player.message.*;
    import com.staticdata.*;
    import net.*;

    public class ResMyPlayerInfoHandler extends Handler
    {

        public function ResMyPlayerInfoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResMyPlayerInfoMessage(this.message);
            PlayerControl.getInstance().playerInfoHandler(_loc_1);
            ElementHeartControl.getInstance().reqContainer(ElementLocateType.HOUSE);
            return;
        }// end function

    }
}
