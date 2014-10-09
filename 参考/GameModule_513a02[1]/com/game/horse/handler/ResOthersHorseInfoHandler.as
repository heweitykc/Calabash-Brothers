package com.game.horse.handler
{
    import com.game.horse.message.*;
    import com.game.primaryrole.control.*;
    import net.*;

    public class ResOthersHorseInfoHandler extends Handler
    {

        public function ResOthersHorseInfoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResOthersHorseInfoMessage(this.message);
            OtherHorseControl.getInstance().otherPlayerHorseHandler(_loc_1);
            return;
        }// end function

    }
}
