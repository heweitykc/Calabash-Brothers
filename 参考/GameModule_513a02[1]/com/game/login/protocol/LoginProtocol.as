package com.game.login.protocol
{
    import com.*;
    import com.f1.*;
    import com.game.login.message.*;

    public class LoginProtocol extends BaseProtocol
    {

        public function LoginProtocol()
        {
            return;
        }// end function

        public function loadFinish() : void
        {
            var _loc_1:* = new ReqLoadFinishMessage();
            _loc_1.type = 0;
            _loc_1.width = FrameworkGlobal.stageW;
            _loc_1.height = FrameworkGlobal.stageH;
            send(_loc_1);
            return;
        }// end function

    }
}
