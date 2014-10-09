package com.game.movie
{
    import com.*;
    import com.events.*;
    import com.f1.ui.*;
    import com.greensock.*;
    import flash.events.*;

    public class NpcDialog extends Component
    {
        private var inited:Boolean;
        private var layout:LayoutInfo;
        private var chatList:Array;
        private var total:int;
        private var num:int;
        private var currentChat:SpeakBox2;
        private var upbox:SpeakBox2;
        private var rebox:SpeakBox2;
        private var poolLeft:Array;
        private var poolRight:Array;
        private static var _instance:NpcDialog;

        public function NpcDialog(param1 = null, param2:String = null)
        {
            this.poolLeft = [];
            this.poolRight = [];
            loadDisplay("res/dialog.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            this.inited = true;
            if (this.chatList)
            {
                this.nextChat();
            }
            return;
        }// end function

        private function onCloseChatPanel(event:MouseEvent = null) : void
        {
            this.currentChat = null;
            dispatchEvent(new Event(Event.COMPLETE));
            return;
        }// end function

        public function set data(param1:Array) : void
        {
            if (!param1)
            {
                dispatchEvent(new Event(Event.COMPLETE));
                return;
            }
            this.chatList = param1;
            if (!this.chatList || this.chatList.length < 1)
            {
                dispatchEvent(new Event(Event.COMPLETE));
            }
            var _loc_2:* = this.chatList[0];
            if (!_loc_2.url || !_loc_2.name || !_loc_2.dir || !_loc_2.content)
            {
                dispatchEvent(new Event(Event.COMPLETE));
            }
            this.num = 0;
            this.total = this.chatList.length;
            if (!this.layout)
            {
                this.layout = new LayoutInfo(Layout.BOTTOM_CENTER, -250, 300);
            }
            Global.mainUIManager.addUI(this, this.layout);
            if (this.inited)
            {
                this.nextChat();
            }
            return;
        }// end function

        private function nextChat() : void
        {
            if (this.currentChat)
            {
                this.upbox = this.currentChat;
                this.currentChat = null;
                if (this.num >= this.total)
                {
                    TweenLite.to(this.upbox, 2, {onComplete:this.onCompleteHandle, onCompleteParams:[this.upbox]});
                }
                else
                {
                    TweenLite.to(this.upbox, 0.5, {y:0, onComplete:this.onUpCompleteHandler, onCompleteParams:[this.upbox]});
                }
            }
            if (this.num >= this.total)
            {
                return;
            }
            var _loc_2:* = this;
            _loc_2.num = this.num + 1;
            var _loc_1:* = this.chatList[this.num++];
            this.currentChat = _loc_1.dir == "0" ? (this.getLeftBox()) : (this.getRightBox());
            this.currentChat.data = _loc_1;
            this.currentChat.addEvtListener(TalkBoxEvent.SPEAK_OVER, this.onSpeakComplete);
            return;
        }// end function

        private function onUpCompleteHandler(param1:SpeakBox2) : void
        {
            TweenLite.to(param1, 2, {onComplete:this.onCompleteHandle, onCompleteParams:[param1]});
            return;
        }// end function

        private function onCompleteHandle(param1:SpeakBox2) : void
        {
            var _loc_2:* = param1.direction();
            if (_loc_2 == "left")
            {
                this.poolLeft.push(param1);
            }
            else
            {
                this.poolRight.push(param1);
            }
            if (param1.parent)
            {
                param1.parent.removeChild(param1);
            }
            if (this.num >= this.total)
            {
                dispatchEvent(new Event(Event.COMPLETE));
            }
            return;
        }// end function

        private function onSpeakComplete(event:TalkBoxEvent) : void
        {
            this.nextChat();
            return;
        }// end function

        private function getLeftBox() : SpeakBox2
        {
            var _loc_1:* = null;
            if (this.poolLeft.length)
            {
                _loc_1 = this.poolLeft.pop();
            }
            else
            {
                _loc_1 = new SpeakBox2("left");
            }
            _loc_1.alpha = 1;
            _loc_1.x = 0;
            _loc_1.y = 120;
            addChild(_loc_1);
            return _loc_1;
        }// end function

        private function getRightBox() : SpeakBox2
        {
            var _loc_1:* = null;
            if (this.poolRight.length)
            {
                _loc_1 = this.poolRight.pop();
            }
            else
            {
                _loc_1 = new SpeakBox2("right");
            }
            _loc_1.alpha = 1;
            _loc_1.x = 250;
            _loc_1.y = 120;
            addChild(_loc_1);
            return _loc_1;
        }// end function

        public static function getInstance() : NpcDialog
        {
            if (!_instance)
            {
                _instance = new NpcDialog;
            }
            return _instance;
        }// end function

    }
}
