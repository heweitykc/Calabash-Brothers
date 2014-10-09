package com.game.task.handler
{
    import com.game.task.message.*;
    import net.*;

    public class ResTargetMonsterInfoHandler extends Handler
    {

        public function ResTargetMonsterInfoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResTargetMonsterInfoMessage(this.message);
            return;
        }// end function

    }
}
