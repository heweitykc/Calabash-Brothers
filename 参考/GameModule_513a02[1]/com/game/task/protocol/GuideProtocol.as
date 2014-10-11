package com.game.task.protocol
{
    import __AS3__.vec.*;
    import com.*;
    import com.game.task.message.*;

    public class GuideProtocol extends BaseProtocol
    {

        public function GuideProtocol()
        {
            return;
        }// end function

        public function saveGuideConfig(param1:Vector.<int>) : void
        {
            var _loc_2:* = new ReqSaveGuidesMessage();
            _loc_2.guides = param1;
            send(_loc_2);
            return;
        }// end function

    }
}
