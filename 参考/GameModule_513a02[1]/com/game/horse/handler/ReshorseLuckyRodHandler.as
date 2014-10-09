package com.game.horse.handler
{
    import com.game.horse.message.*;
    import net.*;

    public class ReshorseLuckyRodHandler extends Handler
    {

        public function ReshorseLuckyRodHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ReshorseLuckyRodMessage(this.message);
            return;
        }// end function

    }
}
