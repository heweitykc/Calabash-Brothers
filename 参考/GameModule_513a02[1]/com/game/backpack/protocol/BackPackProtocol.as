package com.game.backpack.protocol
{
    import com.*;
    import com.game.backpack.message.*;
    import com.game.equip.message.*;
    import com.game.player.message.*;
    import com.game.utils.*;
    import com.model.*;

    public class BackPackProtocol extends BaseProtocol
    {

        public function BackPackProtocol()
        {
            return;
        }// end function

        public function getPkg() : void
        {
            return;
        }// end function

        public function arrange() : void
        {
            var _loc_1:* = new ReqClearUpGoodsMessage();
            send(_loc_1);
            return;
        }// end function

        public function sell() : void
        {
            return;
        }// end function

        public function spilt(param1:long, param2:int) : void
        {
            var _loc_3:* = new ReqSplitGoodsMessage();
            _loc_3.itemid = param1;
            _loc_3.count = param2;
            send(_loc_3);
            return;
        }// end function

        public function openCell(param1:int) : void
        {
            var _loc_2:* = new ReqOpenCellMessage();
            _loc_2.cellId = param1;
            send(_loc_2);
            return;
        }// end function

        public function uses(param1:long, param2:int = 1) : void
        {
            if (!UserObj.getInstance().playerInfo.alive())
            {
                return;
            }
            var _loc_3:* = new ReqUseItemMessage();
            _loc_3.itemId = param1;
            _loc_3.num = param2;
            send(_loc_3);
            return;
        }// end function

        public function getTitle(param1:long) : void
        {
            var _loc_2:* = new ReqGetTitleByUseItemToServerMessage();
            _loc_2.itemId = param1;
            send(_loc_2);
            return;
        }// end function

        public function dropItem(param1:int) : void
        {
            var _loc_2:* = new ReqDiscardMessage();
            _loc_2.cellId = param1;
            send(_loc_2);
            return;
        }// end function

        public function moveItem(param1:long, param2:int, param3:int) : void
        {
            var _loc_4:* = new ReqMoveItemMessage();
            _loc_4.itemId = param1;
            _loc_4.toGridId = param2;
            _loc_4.num = param3;
            send(_loc_4);
            return;
        }// end function

        public function takeoff(param1:long) : void
        {
            var _loc_2:* = new UnwearEquipMessage();
            _loc_2.itemId = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqCellTime(param1:int) : void
        {
            var _loc_2:* = new ReqCellTimeQueryMessage();
            _loc_2.cellId = param1;
            send(_loc_2);
            return;
        }// end function

        public function equip(param1:long, param2:int) : void
        {
            var _loc_3:* = new WearEquipMessage();
            _loc_3.itemId = param1;
            _loc_3.pos = param2;
            send(_loc_3);
            return;
        }// end function

    }
}
