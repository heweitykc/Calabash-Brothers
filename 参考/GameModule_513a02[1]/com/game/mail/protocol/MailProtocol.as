package com.game.mail.protocol
{
    import __AS3__.vec.*;
    import com.*;
    import com.game.mail.message.*;
    import com.game.utils.*;

    public class MailProtocol extends BaseProtocol
    {

        public function MailProtocol()
        {
            return;
        }// end function

        public function getList() : void
        {
            var _loc_1:* = new ReqMailQueryListToServerMessage();
            send(_loc_1);
            return;
        }// end function

        public function delMail(param1:int, param2:Vector.<long>) : void
        {
            var _loc_3:* = new ReqMailDeleteMailToServerMessage();
            _loc_3.btdeleteall = param1;
            _loc_3.deleteMailIdList = param2;
            send(_loc_3);
            return;
        }// end function

        public function getItem(param1:long, param2:long) : void
        {
            var _loc_3:* = new ReqMailGetItemToServerMessage();
            _loc_3.mailid = param1;
            _loc_3.itemid = param2;
            send(_loc_3);
            return;
        }// end function

        public function getInfo(param1:long) : void
        {
            var _loc_2:* = new ReqMailQueryDetailToServerMessage();
            _loc_2.mailid = param1;
            send(_loc_2);
            return;
        }// end function

    }
}
