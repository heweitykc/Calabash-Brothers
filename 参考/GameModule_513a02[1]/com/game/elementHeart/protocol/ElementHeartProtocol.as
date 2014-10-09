package com.game.elementHeart.protocol
{
    import com.*;
    import com.game.masterequip.message.*;

    public class ElementHeartProtocol extends BaseProtocol
    {

        public function ElementHeartProtocol()
        {
            return;
        }// end function

        public function reqContainer(param1:int) : void
        {
            var _loc_2:* = new ReqContainerMessage();
            _loc_2.type = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqAutoSwallow(param1:int) : void
        {
            var _loc_2:* = new ReqAutoSwallowMessage();
            _loc_2.type = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqGainAll() : void
        {
            var _loc_1:* = new ReqGainAllMessage();
            send(_loc_1);
            return;
        }// end function

        public function reqGainOne(param1:int) : void
        {
            var _loc_2:* = new ReqGainOneMessage();
            _loc_2.index = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqLock(param1:int, param2:int) : void
        {
            var _loc_3:* = new ReqLockMessage();
            _loc_3.index = param2;
            _loc_3.type = param1;
            send(_loc_3);
            return;
        }// end function

        public function reqChangeIndex(param1:int, param2:int, param3:int, param4:int) : void
        {
            var _loc_5:* = new ReqChangeIndexMessage();
            _loc_5.type = param1;
            _loc_5.index = param2;
            _loc_5.targetType = param3;
            _loc_5.targetIndex = param4;
            send(_loc_5);
            return;
        }// end function

        public function reqSwallowMessage(param1:int, param2:int, param3:int, param4:int) : void
        {
            var _loc_5:* = new ReqSwallowMessage();
            _loc_5.type = param1;
            _loc_5.index = param2;
            _loc_5.targetType = param3;
            _loc_5.targetIndex = param4;
            send(_loc_5);
            return;
        }// end function

        public function reqRemveEheart(param1:int, param2:int) : void
        {
            var _loc_3:* = new ReqRemveEheartMessage();
            _loc_3.type = param1;
            _loc_3.index = param2;
            send(_loc_3);
            return;
        }// end function

    }
}
