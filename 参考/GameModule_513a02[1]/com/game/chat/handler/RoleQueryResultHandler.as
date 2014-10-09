package com.game.chat.handler
{
    import com.game.chat.control.*;
    import com.game.chat.message.*;
    import com.model.vo.*;
    import net.*;

    public class RoleQueryResultHandler extends Handler
    {

        public function RoleQueryResultHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_5:* = null;
            var _loc_1:* = RoleQueryResultMessage(this.message);
            var _loc_2:* = new Array();
            var _loc_3:* = _loc_1.list.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = new ChatRoleInfo(_loc_1.list[_loc_4]);
                _loc_5.index = _loc_4;
                _loc_2.push(_loc_5);
                _loc_4++;
            }
            ChatController.getInstance().acceptRole(_loc_2);
            return;
        }// end function

    }
}
