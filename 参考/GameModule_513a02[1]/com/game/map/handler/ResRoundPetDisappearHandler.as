package com.game.map.handler
{
    import com.game.map.message.*;
    import net.*;

    public class ResRoundPetDisappearHandler extends Handler
    {

        public function ResRoundPetDisappearHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRoundPetDisappearMessage(this.message);
            return;
        }// end function

    }
}
