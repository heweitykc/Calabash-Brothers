package com.game.equipstreng.protocol
{
    import __AS3__.vec.*;
    import com.*;
    import com.game.equip.message.*;
    import com.game.equipstreng.message.*;
    import com.game.equipstreng.message.bean.*;
    import com.game.utils.*;

    public class EquipForgeProtocol extends BaseProtocol
    {

        public function EquipForgeProtocol()
        {
            return;
        }// end function

        public function reqEquipStreng(param1:long, param2:int, param3:int = 0) : void
        {
            var _loc_4:* = new ReqStrengItemToServerMessage();
            _loc_4.itemid = param1;
            _loc_4.type = param2;
            _loc_4.prival = param3;
            send(_loc_4);
            return;
        }// end function

        public function reqEquipProcess(param1:long, param2:int) : void
        {
            var _loc_3:* = new ReqAddAttributeItemToServerMessage();
            _loc_3.itemid = param1;
            _loc_3.type = param2;
            send(_loc_3);
            return;
        }// end function

        public function reqEquipCompose(param1:int, param2:int, param3:long) : void
        {
            var _loc_4:* = new ReqComposeEquipToServerMessage();
            _loc_4.compose_id = param1;
            _loc_4.type = param2;
            var _loc_5:* = new Vector.<long>;
            _loc_5.push(param3);
            _loc_4.equip_ids = _loc_5;
            var _loc_6:* = new Vector.<ComposeAddInfo>;
            _loc_4.materials = _loc_6;
            send(_loc_4);
            return;
        }// end function

        public function reqEquipWingCompose(param1:int, param2:int, param3:long, param4:Vector.<ComposeAddInfo>) : void
        {
            var _loc_5:* = new ReqComposeEquipToServerMessage();
            _loc_5.compose_id = param1;
            _loc_5.type = param2;
            var _loc_6:* = new Vector.<long>;
            _loc_6.push(param3);
            _loc_5.equip_ids = _loc_6;
            _loc_5.materials = param4;
            send(_loc_5);
            return;
        }// end function

        public function reqAngelCompose(param1:int, param2:int, param3:Vector.<long>) : void
        {
            var _loc_4:* = new ReqComposeEquipToServerMessage();
            _loc_4.compose_id = param1;
            _loc_4.type = param2;
            _loc_4.equip_ids = param3;
            var _loc_5:* = new Vector.<ComposeAddInfo>;
            _loc_4.materials = _loc_5;
            send(_loc_4);
            return;
        }// end function

        public function reqLuckStoneAttach(param1:long, param2:int) : void
        {
            var _loc_3:* = new ReqLuckyStoneMessage();
            _loc_3.equipId = param1;
            _loc_3.useBind = param2;
            send(_loc_3);
            return;
        }// end function

        public function reqConvertSuit(param1:long, param2:int) : void
        {
            var _loc_3:* = new ReqConvertSuitMessage();
            _loc_3.itemId = param1;
            _loc_3.type = param2;
            send(_loc_3);
            return;
        }// end function

        public function equipSuitSlit(param1:long) : void
        {
            var _loc_2:* = new ReqSplitSuitMessage();
            _loc_2.itemId = param1;
            send(_loc_2);
            return;
        }// end function

    }
}
