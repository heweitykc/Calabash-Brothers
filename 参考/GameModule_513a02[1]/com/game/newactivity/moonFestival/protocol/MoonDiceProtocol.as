package com.game.newactivity.moonFestival.protocol
{
    import com.*;
    import com.game.bocake.message.*;

    public class MoonDiceProtocol extends BaseProtocol
    {

        public function MoonDiceProtocol()
        {
            return;
        }// end function

        public function reqOpenDice() : void
        {
            var _loc_1:* = new ReqOpenBoCakeInfoToServerMessage();
            send(_loc_1);
            return;
        }// end function

        public function reqDice(param1:int) : void
        {
            var _loc_2:* = new ReqBoCakeToServerMessage();
            _loc_2.type = param1;
            send(_loc_2);
            return;
        }// end function

    }
}
