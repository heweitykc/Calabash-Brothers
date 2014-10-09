package com.game.dazuo.handler
{
    import com.game.dazuo.message.*;
    import net.*;

    public class ResDazuoEruptHandler extends Handler
    {

        public function ResDazuoEruptHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResDazuoEruptMessage(this.message);
            return;
        }// end function

    }
}
