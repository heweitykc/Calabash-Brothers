package com.game.horse.handler
{
    import com.game.horse.control.*;
    import com.game.horse.message.*;
    import net.*;

    public class ResHorseInfoHandler extends Handler
    {

        public function ResHorseInfoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResHorseInfoMessage(this.message);
            HorseControl.getInstance().resHorseInfoHandler(_loc_1);
            return;
        }// end function

    }
}
