package com.game.auction.protocol
{
    import com.*;
    import com.game.auction.message.*;
    import com.game.auction.model.*;
    import com.game.stalls.message.*;
    import com.game.utils.*;

    public class AuctionProtocol extends BaseProtocol
    {

        public function AuctionProtocol()
        {
            return;
        }// end function

        public function reqIndex(param1:int, param2:int, param3:AuctionInfo, param4:Boolean = false) : void
        {
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_5:* = new ReqAuctionSearchMessage();
            _loc_5.start = param1;
            _loc_5.end = param2;
            _loc_5.intensify = param3.intensify;
            if (param4)
            {
                _loc_5.q_job_limit = 0;
                _loc_5.q_type = 0;
                _loc_5.mondelId = 0;
                _loc_5.q_kind = 0;
            }
            else
            {
                _loc_5.q_job_limit = param3.jobLimit;
                _loc_5.q_kind = param3.kind;
                _loc_5.q_type = param3.type;
                _loc_5.mondelId = param3.modelId;
            }
            _loc_5.zhuoyue = param3.quality;
            _loc_5.addAttribut = param3.addAttribute;
            _loc_5.steplv = param3.stagelevel;
            _loc_5.sort = param3.sort;
            _loc_5.crit = param3.crit;
            _loc_5.ignore = param3.ignore;
            _loc_5.suit = param3.suit;
            _loc_5.goodsname = param3.goodsname;
            var _loc_6:* = param3.goodsname.split(" ");
            if (_loc_6.length == 2)
            {
                _loc_7 = AuctionObj.PARSE.length;
                _loc_8 = 0;
                while (_loc_8 < _loc_7)
                {
                    
                    if (_loc_6[0] == AuctionObj.PARSE[_loc_8].label)
                    {
                        _loc_5.goodsname = _loc_6[1];
                        _loc_5[AuctionObj.PARSE[_loc_8].key] = AuctionObj.PARSE[_loc_8].value;
                        break;
                    }
                    if (_loc_6[1] == AuctionObj.PARSE[_loc_8].label)
                    {
                        _loc_5.goodsname = _loc_6[0];
                        _loc_5[AuctionObj.PARSE[_loc_8].key] = AuctionObj.PARSE[_loc_8].value;
                        break;
                    }
                    _loc_8++;
                }
            }
            send(_loc_5);
            return;
        }// end function

        public function board(param1:long, param2:long) : void
        {
            var _loc_3:* = new ReqAuctionShowItemMessage();
            _loc_3.goodsid = param2;
            _loc_3.playerId = param1;
            send(_loc_3);
            return;
        }// end function

        public function reqStallsInfo(param1:long) : void
        {
            var _loc_2:* = new ReqQuryMyItemsMessage();
            send(_loc_2);
            return;
        }// end function

        public function reqBuy(param1:long) : void
        {
            var _loc_2:* = new ReqAuctionBuyMessage();
            _loc_2.goodsid = param1;
            send(_loc_2);
            return;
        }// end function

        public function upload(param1:long, param2:int, param3:int) : void
        {
            var _loc_4:* = new ReqAuctionAddMessage();
            _loc_4.goodsid = param1;
            _loc_4.num = param3;
            _loc_4.price = param2;
            send(_loc_4);
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

        public function download(param1:long) : void
        {
            var _loc_2:* = new ReqAuctionOffShelfMessage();
            _loc_2.goodsid = param1;
            send(_loc_2);
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
