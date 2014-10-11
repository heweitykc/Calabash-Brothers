package com
{
    import com.f1.*;
    import net.*;

    public class BaseProtocol extends BaseProto
    {

        public function BaseProtocol()
        {
            return;
        }// end function

        protected function send(param1:Message, param2:Boolean = false, param3:Function = null, param4:Boolean = false, param5:Boolean = false) : void
        {
            sendPkg(param1.getId(), param1, param2, param3, param4, param5);
            return;
        }// end function

    }
}
