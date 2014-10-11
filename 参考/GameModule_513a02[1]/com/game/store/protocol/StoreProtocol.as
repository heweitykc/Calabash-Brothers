package com.game.store.protocol
{
    import com.*;
    import com.game.store.message.*;
    import com.game.utils.*;

    public class StoreProtocol extends BaseProtocol
    {

        public function StoreProtocol()
        {
            return;
        }// end function

        public function reqBagToStore(param1:int, param2:int = 0) : void
        {
            var _loc_3:* = new ReqBagToStoreMessage();
            _loc_3.bagCellId = param1;
            send(_loc_3);
            return;
        }// end function

        public function reqStoreCellTimeQuary(param1:int, param2:int = 0) : void
        {
            var _loc_3:* = new ReqStoreCellTimeQueryMessage();
            send(_loc_3);
            return;
        }// end function

        public function reqStoreClearUp(param1:int = 0) : void
        {
            var _loc_2:* = new ReqStoreClearUpMessage();
            send(_loc_2);
            return;
        }// end function

        public function reqStoreGetItems() : void
        {
            var _loc_1:* = new ReqStoreGetItemsMessage();
            send(_loc_1);
            return;
        }// end function

        public function reqStoreMoveItem(param1:long, param2:int, param3:int, param4:int = 0) : void
        {
            var _loc_5:* = new ReqStoreMoveItemMessage();
            _loc_5.itemId = param1;
            _loc_5.toGridId = param2;
            _loc_5.num = param3;
            _loc_5.npcid = param4;
            send(_loc_5);
            return;
        }// end function

        public function reqStoreOpenCell(param1:int, param2:int = 0) : void
        {
            var _loc_3:* = new ReqStoreOpenCellMessage();
            _loc_3.cellId = param1;
            _loc_3.npcid = param2;
            send(_loc_3);
            return;
        }// end function

        public function reqStoreToBag(param1:int, param2:int = 0) : void
        {
            var _loc_3:* = new ReqStoreToBagMessage();
            _loc_3.storeCellId = param1;
            _loc_3.npcid = param2;
            send(_loc_3);
            return;
        }// end function

        public function reqOpenStore() : void
        {
            var _loc_1:* = new ReqOpenStoreMessage();
            send(_loc_1);
            return;
        }// end function

    }
}
