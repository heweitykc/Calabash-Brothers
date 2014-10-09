package com.game.newactivity.handler
{
    import com.f1.utils.*;
    import com.game.newactivity.message.*;
    import com.game.prompt.utils.*;
    import com.staticdata.*;
    import net.*;

    public class ResGetNewActivityAwardHandler extends Handler
    {

        public function ResGetNewActivityAwardHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_1:* = ResGetNewActivityAward(this.message);
            if (_loc_1.result == 0)
            {
                _loc_2 = [];
                _loc_3 = 0;
                while (_loc_3 < _loc_1.items.length)
                {
                    
                    _loc_2.push(_loc_1.items[_loc_3]);
                    _loc_3++;
                }
                ItemGetAnim.doFlyGetItemsToBack(_loc_2);
                if (_loc_1.activityId == NewActivityConfig.ACTID_GIFT_360HOME)
                {
                    JSTools.callJS("checkIsIn360Box");
                }
            }
            return;
        }// end function

    }
}
