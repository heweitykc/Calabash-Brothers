﻿package com.game.pet.handler
{
    import com.game.pet.message.*;
    import net.*;

    public class ResPetListHandler extends Handler
    {

        public function ResPetListHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPetListMessage(this.message);
            return;
        }// end function

    }
}
