package com.game.map.handler
{
    import com.game.map.message.*;
    import net.*;

    public class ResRoundPetHandler extends Handler
    {

        public function ResRoundPetHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRoundPetMessage(this.message);
            return;
        }// end function

    }
}
