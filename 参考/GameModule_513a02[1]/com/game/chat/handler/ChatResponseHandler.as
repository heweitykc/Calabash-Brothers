package com.game.chat.handler
{
    import com.game.chat.control.*;
    import com.game.chat.message.*;
    import com.model.vo.*;
    import com.platform.*;
    import net.*;

    public class ChatResponseHandler extends Handler
    {

        public function ChatResponseHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ChatResponseMessage(this.message);
            var _loc_2:* = new ChatInfo();
            _loc_2.chater = _loc_1.chater;
            _loc_2.chaterkinglv = _loc_1.chaterkinglv;
            _loc_2.chaterlevel = _loc_1.chaterlevel;
            _loc_2.chatername = _loc_1.chatername;
            _loc_2.chattype = _loc_1.chattype;
            _loc_2.condition = _loc_1.condition;
            _loc_2.country = _loc_1.country;
            _loc_2.data = _loc_1.other;
            _loc_2.receiver = _loc_1.receiver;
            _loc_2.receiverlevel = _loc_1.receiverlevel;
            _loc_2.receivername = _loc_1.receivername;
            _loc_2.receiverviptype = _loc_1.receiverviptype;
            _loc_2.viptype = _loc_1.viptype;
            _loc_2.vipLevel = _loc_1.viplevel;
            _loc_2.isgm = _loc_1.isgm;
            _loc_2.parse();
            Platform.instance.onChatMessageReceived(_loc_2);
            ChatController.getInstance().accept(_loc_2);
            _loc_2 = new ChatInfo();
            _loc_2.chater = _loc_1.chater;
            _loc_2.chaterkinglv = _loc_1.chaterkinglv;
            _loc_2.chaterlevel = _loc_1.chaterlevel;
            _loc_2.chatername = _loc_1.chatername;
            _loc_2.chattype = _loc_1.chattype;
            _loc_2.condition = _loc_1.condition;
            _loc_2.country = _loc_1.country;
            _loc_2.data = _loc_1.other;
            _loc_2.receiver = _loc_1.receiver;
            _loc_2.receiverlevel = _loc_1.receiverlevel;
            _loc_2.receivername = _loc_1.receivername;
            _loc_2.receiverviptype = _loc_1.receiverviptype;
            _loc_2.viptype = _loc_1.viptype;
            _loc_2.vipLevel = _loc_1.viplevel;
            _loc_2.isgm = _loc_1.isgm;
            _loc_2.parse(false);
            SpeakControl.getInstance().speakByChatInfo(_loc_2);
            return;
        }// end function

    }
}
