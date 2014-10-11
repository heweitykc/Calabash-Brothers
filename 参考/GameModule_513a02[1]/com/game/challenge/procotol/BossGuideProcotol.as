package com.game.challenge.procotol
{
    import com.*;
    import com.game.challenge.message.*;

    public class BossGuideProcotol extends BaseProtocol
    {

        public function BossGuideProcotol()
        {
            return;
        }// end function

        public function reqSelectChallengeToGame(param1:int) : void
        {
            var _loc_2:* = new ReqSelectChallengeToGameMessage();
            _loc_2.type = param1;
            send(_loc_2);
            return;
        }// end function

    }
}
