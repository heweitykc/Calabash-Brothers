package com.game.autopk.protocol
{
    import com.*;
    import com.game.assistant.message.*;

    public class AutoFightProtocol extends BaseProtocol
    {
        private static var _instance:AutoFightProtocol;

        public function AutoFightProtocol()
        {
            return;
        }// end function

        public function reqGetAssistantMessage() : void
        {
            var _loc_1:* = new ReqGetAssistantMessage();
            send(_loc_1);
            return;
        }// end function

        public function reqSaveAssistantMessage(param1:String) : void
        {
            var _loc_2:* = new ReqSaveAssistantMessage();
            _loc_2.json = param1;
            send(_loc_2);
            return;
        }// end function

        public static function getInstance() : AutoFightProtocol
        {
            var _loc_1:* = _instance || new AutoFightProtocol;
            _instance = _instance || new AutoFightProtocol;
            return _loc_1;
        }// end function

    }
}
