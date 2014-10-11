package com.game.stalls.protocol
{
    import com.*;
    import com.game.stalls.message.*;
    import com.game.utils.*;

    public class StallsProtocol extends BaseProtocol
    {

        public function StallsProtocol()
        {
            return;
        }// end function

        public function reqIndex(param1:int, param2:int) : void
        {
            var _loc_3:* = new ReqStallsOpenUpMessage();
            _loc_3.indexLarge = param2;
            _loc_3.indexlittle = param1;
            send(_loc_3);
            return;
        }// end function

        public function reqStallsInfo(param1:long) : void
        {
            var _loc_2:* = new ReqStallsPlayerIdLookMessage();
            _loc_2.playerid = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqBuy(param1:long, param2:int, param3:int, param4:long) : void
        {
            var _loc_5:* = new ReqStallsBuyMessage();
            _loc_5.playerid = param1;
            _loc_5.pricegold = param2;
            _loc_5.priceyuanbao = param3;
            _loc_5.goodsid = param4;
            send(_loc_5);
            return;
        }// end function

        public function upload(param1:long, param2:int, param3:int, param4:int, param5:int) : void
        {
            var _loc_6:* = new ReqStallsProductWasAddedMessage();
            _loc_6.goodsid = param1;
            _loc_6.goodsnum = param5;
            _loc_6.num = param4;
            _loc_6.pricegold = param2;
            _loc_6.priceyuanbao = param3;
            send(_loc_6);
            return;
        }// end function

        public function changeItem(param1:long, param2:int, param3:int, param4:int, param5:int) : void
        {
            var _loc_6:* = new ReqStallsAdjustPricesMessage();
            _loc_6.goodsid = param1;
            _loc_6.pos = param5;
            _loc_6.num = param4;
            _loc_6.pricegold = param2;
            _loc_6.priceyuanbao = param3;
            _loc_6.currentnum = param4;
            send(_loc_6);
            return;
        }// end function

        public function download(param1:long, param2:int) : void
        {
            var _loc_3:* = new ReqStallsOffShelfMessage();
            _loc_3.goodsid = param1;
            _loc_3.num = param2;
            send(_loc_3);
            return;
        }// end function

        public function changeTitle(param1:String) : void
        {
            var _loc_2:* = new ReqChangeStallsNameMessage();
            _loc_2.name = param1;
            send(_loc_2);
            return;
        }// end function

        public function search(param1:String, param2:String, param3:int, param4:int, param5:int, param6:String, param7:int, param8:int, param9:int, param10:int, param11:int = 0, param12:int = 0) : void
        {
            var _loc_13:* = new ReqStallsSearchMessage();
            _loc_13.addAttribut = param8;
            _loc_13.can_use = param10;
            _loc_13.goldyuanbao = param11;
            _loc_13.goodsname = param1;
            _loc_13.playername = param2;
            _loc_13.q_job_limit = param4;
            _loc_13.q_kind = param5;
            _loc_13.q_type = param3;
            _loc_13.hidden = param6;
            _loc_13.intensify = param12;
            _loc_13.zhuoyue = param9;
            send(_loc_13);
            return;
        }// end function

        public function reqLog() : void
        {
            var _loc_1:* = new ReqStallsLooklogMessage();
            send(_loc_1);
            return;
        }// end function

    }
}
