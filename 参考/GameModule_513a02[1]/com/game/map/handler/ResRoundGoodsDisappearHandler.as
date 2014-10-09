﻿package com.game.map.handler
{
    import com.game.map.control.*;
    import com.game.map.message.*;
    import net.*;

    public class ResRoundGoodsDisappearHandler extends Handler
    {

        public function ResRoundGoodsDisappearHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRoundGoodsDisappearMessage(this.message);
            MapControl.getInstance().dropRoundGoodsDisappear(_loc_1);
            return;
        }// end function

    }
}
