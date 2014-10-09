package com.game.task.handler
{
    import com.game.task.message.*;
    import net.*;

    public class ResTaskGoldAddNumHandler extends Handler
    {

        public function ResTaskGoldAddNumHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResTaskGoldAddNumMessage(this.message);
            return;
        }// end function

    }
}
