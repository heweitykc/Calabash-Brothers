package com.game.map.handler
{
    import com.game.map.control.*;
    import com.game.map.message.*;
    import net.*;

    public class ResRoundMonsterHandler extends Handler
    {

        public function ResRoundMonsterHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRoundMonsterMessage(this.message);
            MapControl.getInstance().addMonsterByCSInfo(_loc_1.monster);
            return;
        }// end function

    }
}
