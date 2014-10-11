package com.game.login.protocol
{
    import com.*;
    import com.game.login.message.*;
    import com.game.utils.*;
    import com.staticdata.*;

    public class RegistProtocol extends BaseProtocol
    {

        public function RegistProtocol()
        {
            return;
        }// end function

        public function login() : void
        {
            var _loc_1:* = new ReqLoginMessage();
            _loc_1.name = BasicGlobal.openid;
            _loc_1.password = "b1";
            _loc_1.serverId = Params.zoneid;
            send(_loc_1);
            return;
        }// end function

        public function platformLogin(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String, param7:String = null) : void
        {
            var _loc_8:* = new ReqLoginForPlatformMessage();
            _loc_8.serverId = param1;
            _loc_8.username = param2;
            _loc_8.time = param3;
            _loc_8.isadult = param4;
            _loc_8.sign = param5;
            _loc_8.logintype = param6;
            if (param7)
            {
                _loc_8.agentPlusdata = param7;
            }
            send(_loc_8);
            return;
        }// end function

        public function createRole(param1:String, param2:int, param3:int) : void
        {
            var _loc_4:* = new ReqCreateCharacterMessage();
            _loc_4.name = param1;
            _loc_4.sex = 0;
            _loc_4.job = param3;
            send(_loc_4);
            return;
        }// end function

        public function selectRole(param1:long) : void
        {
            var _loc_2:* = new ReqSelectCharacterMessage();
            _loc_2.playerId = param1;
            send(_loc_2);
            return;
        }// end function

    }
}
