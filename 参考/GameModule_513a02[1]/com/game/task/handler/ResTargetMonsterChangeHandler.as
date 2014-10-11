package com.game.task.handler
{
    import com.game.task.message.*;
    import net.*;

    public class ResTargetMonsterChangeHandler extends Handler
    {

        public function ResTargetMonsterChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResTargetMonsterChangeMessage(this.message);
            return;
        }// end function

    }
}
