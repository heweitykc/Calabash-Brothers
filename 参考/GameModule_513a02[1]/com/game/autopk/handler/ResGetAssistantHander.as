package com.game.autopk.handler
{
    import com.game.assistant.message.*;
    import com.game.autopk.model.*;
    import net.*;

    public class ResGetAssistantHander extends Handler
    {

        public function ResGetAssistantHander()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGetAssistantMessage(this.message);
            AutoFightModel.parse(_loc_1.data);
            return;
        }// end function

    }
}
