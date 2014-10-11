package com.game.protect.protocol
{
    import com.*;
    import com.game.protect.message.*;
    import com.game.protectAdvanced.message.*;
    import com.game.utils.*;

    public class ProtectProtocol extends BaseProtocol
    {

        public function ProtectProtocol()
        {
            return;
        }// end function

        public function reqModifyPasswordToGame(param1:String, param2:String) : void
        {
            var _loc_3:* = new ReqModifyPasswordToGameMessage();
            _loc_3.newpassword = param1;
            _loc_3.oldpassword = param2;
            send(_loc_3);
            return;
        }// end function

        public function reqPasswordSetToGame(param1:String, param2:String, param3:String) : void
        {
            var _loc_4:* = new ReqPasswordSetToGameMessage();
            _loc_4.password = param1;
            _loc_4.mail = param2;
            _loc_4.phone = param3;
            send(_loc_4);
            return;
        }// end function

        public function reqPasswordUnlockToGame(param1:String) : void
        {
            var _loc_2:* = new ReqPasswordUnlockToGameMessage();
            _loc_2.password = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqPasswordLockToGame(param1:String) : void
        {
            var _loc_2:* = new ReqPasswordLockToGameMessage();
            _loc_2.password = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqHighUnlockToGame(param1:long) : void
        {
            var _loc_2:* = new ReqProtectMessage();
            _loc_2.type = 1;
            _loc_2.itemId = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqHighLockToGame(param1:long) : void
        {
            var _loc_2:* = new ReqProtectMessage();
            _loc_2.type = 0;
            _loc_2.itemId = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqVerification(param1:int, param2:String) : void
        {
            var _loc_3:* = new ReqVerificationMessage();
            _loc_3.sessionId = param1;
            _loc_3.passwd = param2;
            send(_loc_3);
            return;
        }// end function

    }
}
