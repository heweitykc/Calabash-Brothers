package com.game.magicbook.protocol
{
    import com.*;
    import com.game.magicbook.message.*;
    import com.game.utils.*;

    public class MagicBookProtocol extends BaseProtocol
    {

        public function MagicBookProtocol()
        {
            return;
        }// end function

        public function reqUseOnce() : void
        {
            var _loc_1:* = new ReqUseOnceMessage();
            send(_loc_1);
            return;
        }// end function

        public function reqUse(param1:int) : void
        {
            var _loc_2:* = new ReqUseMessage();
            _loc_2.itemId = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqBreakthrough() : void
        {
            var _loc_1:* = new ReqBreakthroughMessage();
            send(_loc_1);
            return;
        }// end function

        public function reqUpExp() : void
        {
            var _loc_1:* = new ReqUpExpMessage();
            send(_loc_1);
            return;
        }// end function

        public function reqMagicbook() : void
        {
            var _loc_1:* = new ReqMagicbookMessage();
            send(_loc_1);
            return;
        }// end function

        public function reqSeeOtherMagicbook(param1:long) : void
        {
            var _loc_2:* = new ReqSeeOtherMagicbookMessage();
            _loc_2.playerId = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqGainBook() : void
        {
            var _loc_1:* = new ReqGainBookMessage();
            send(_loc_1);
            return;
        }// end function

        public function reqAdvancedUp() : void
        {
            var _loc_1:* = new ReqAdvancedUpMessage();
            send(_loc_1);
            return;
        }// end function

    }
}
