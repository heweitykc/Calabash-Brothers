package com.game.signwage.protocol
{
    import com.*;
    import com.game.signwage.message.*;

    public class SignUpProtocol extends BaseProtocol
    {
        public static const Awards_A:int = 2;
        public static const Awards_B:int = 5;
        public static const Awards_C:int = 10;
        public static const Awards_D:int = 17;
        public static const Awards_E:int = 25;

        public function SignUpProtocol()
        {
            return;
        }// end function

        public function reqClickSignToClient() : void
        {
            var _loc_1:* = new ReqClickSignToClientMessage();
            send(_loc_1);
            return;
        }// end function

        public function reqSignToClient() : void
        {
            var _loc_1:* = new ReqSignToClientMessage();
            send(_loc_1);
            return;
        }// end function

        public function reqReceiveAwardsToClient(param1:uint) : void
        {
            var _loc_2:* = new ReqReceiveAwardsToClientMessage();
            _loc_2.type = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqFillSign(param1:uint) : void
        {
            var _loc_2:* = new ReqFillSignMessage();
            _loc_2.date = param1;
            send(_loc_2);
            return;
        }// end function

    }
}
