package com.game.task.handler
{
    import com.game.task.message.*;
    import net.*;

    public class ResTargetMonsterHandler extends Handler
    {

        public function ResTargetMonsterHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResTargetMonsterMessage(this.message);
            return;
        }// end function

    }
}
