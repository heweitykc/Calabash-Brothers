package com.game.card.protocol
{
    import com.*;
    import com.game.card.message.*;
    import com.game.utils.*;

    public class CardProtocol extends BaseProtocol
    {

        public function CardProtocol()
        {
            return;
        }// end function

        public function reqCardPhone(param1:String, param2:long, param3:String) : void
        {
            var _loc_4:* = new ReqCardPhoneToServerMessage();
            _loc_4.account = param1;
            _loc_4.playerid = param2;
            _loc_4.phone = param3;
            send(_loc_4);
            return;
        }// end function

        public function reqCard(param1:String) : void
        {
            var _loc_2:* = new ReqCardToServerMessage();
            _loc_2.card = param1;
            send(_loc_2);
            return;
        }// end function

    }
}
