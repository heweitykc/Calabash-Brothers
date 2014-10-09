package com.game.map.handler
{
    import com.game.map.control.*;
    import com.game.map.message.*;
    import net.*;

    public class ResRoundMonsterDisappearHandler extends Handler
    {

        public function ResRoundMonsterDisappearHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRoundMonsterDisappearMessage(this.message);
            MapControl.getInstance().roundObjectDisappearHandler(_loc_1.monstersIds);
            return;
        }// end function

    }
}
