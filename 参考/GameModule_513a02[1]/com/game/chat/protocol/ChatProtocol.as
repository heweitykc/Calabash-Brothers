package com.game.chat.protocol
{
    import __AS3__.vec.*;
    import com.*;
    import com.game.chat.bean.*;
    import com.game.chat.message.*;
    import com.game.gm.message.*;

    public class ChatProtocol extends BaseProtocol
    {

        public function ChatProtocol()
        {
            return;
        }// end function

        public function toGM(param1:String = "") : void
        {
            var _loc_2:* = new GmCommandMessage();
            _loc_2.command = param1;
            send(_loc_2);
            return;
        }// end function

        public function charRequest(param1:int, param2:String, param3:String = "", param4:Vector.<ChatGoodInfo> = null) : void
        {
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_5:* = new ChatRequestMessage();
            _loc_5.chattype = param1;
            _loc_5.condition = param2;
            var _loc_6:* = new Vector.<GoodsInfoReq>;
            if (param4 && param4.length > 0)
            {
                _loc_7 = 0;
                while (_loc_7 < param4.length)
                {
                    
                    _loc_8 = new GoodsInfoReq();
                    _loc_8.goodId = param4[_loc_7].propInfo.itemId;
                    _loc_8.index = param4[_loc_7].index;
                    _loc_6.push(_loc_8);
                    _loc_7++;
                }
            }
            else
            {
                _loc_6 = new Vector.<GoodsInfoReq>;
            }
            _loc_5.other = _loc_6;
            _loc_5.roleName = param3;
            send(_loc_5, false, null, false, true);
            return;
        }// end function

        public function query(param1:int = 1) : void
        {
            var _loc_2:* = new RoleQueryMessage();
            _loc_2.page = 1;
            _loc_2.roleLikeName = null;
            _loc_2.type = param1;
            send(_loc_2);
            return;
        }// end function

        public function queryName(param1:String, param2:int = 1) : void
        {
            var _loc_3:* = new RoleQueryMessage();
            _loc_3.page = 1;
            _loc_3.roleLikeName = param1;
            _loc_3.type = param2;
            send(_loc_3);
            return;
        }// end function

    }
}
