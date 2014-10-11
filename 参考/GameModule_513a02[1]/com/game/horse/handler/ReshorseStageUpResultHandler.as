package com.game.horse.handler
{
    import com.game.horse.control.*;
    import com.game.horse.message.*;
    import net.*;

    public class ReshorseStageUpResultHandler extends Handler
    {

        public function ReshorseStageUpResultHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ReshorseStageUpResultMessage(this.message);
            HorseControl.getInstance().ReshorseStageUpResultHandler(_loc_1);
            return;
        }// end function

    }
}
