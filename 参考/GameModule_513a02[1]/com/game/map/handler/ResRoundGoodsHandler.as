package com.game.map.handler
{
    import com.game.map.control.*;
    import com.game.map.message.*;
    import net.*;

    public class ResRoundGoodsHandler extends Handler
    {

        public function ResRoundGoodsHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRoundGoodsMessage(this.message);
            MapControl.getInstance().dropRoundGoods(_loc_1);
            return;
        }// end function

    }
}
