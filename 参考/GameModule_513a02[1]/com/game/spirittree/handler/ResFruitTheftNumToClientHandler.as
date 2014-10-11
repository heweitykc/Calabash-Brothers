package com.game.spirittree.handler
{
    import com.game.spirittree.message.*;
    import net.*;

    public class ResFruitTheftNumToClientHandler extends Handler
    {

        public function ResFruitTheftNumToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResFruitTheftNumToClientMessage(this.message);
            return;
        }// end function

    }
}
