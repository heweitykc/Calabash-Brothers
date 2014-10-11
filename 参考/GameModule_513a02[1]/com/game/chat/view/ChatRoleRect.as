package com.game.chat.view
{
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.list.*;
    import com.f1.utils.*;
    import com.game.chat.events.*;
    import com.util.*;
    import flash.events.*;
    import flash.text.*;

    public class ChatRoleRect extends Component
    {
        private var _txt:TextField;
        private var _arrowBtn:BaseButton;
        private var _list:List;

        public function ChatRoleRect(param1 = null, param2:String = null)
        {
            super(param1, param2);
            this.initUI();
            addEvtListener(MouseEvent.MOUSE_DOWN, this.__mouseDown);
            this._txt.addEventListener(Event.CHANGE, this.__change);
            return;
        }// end function

        private function initUI() : void
        {
            this._txt = getDisplayChildByName("txt");
            this._txt.textColor = PropUtil.PURPLE;
            this._arrowBtn = new BaseButton(getDisplayChildByName("btn_arrow"));
            addEvtListener(MouseEvent.CLICK, this.__mouseDown);
            return;
        }// end function

        private function __mouseDown(event:MouseEvent) : void
        {
            dispatchEvent(new ChatEvent(ChatEvent.OPEN_PRIVATE_LIST));
            return;
        }// end function

        private function __change(event:Event) : void
        {
            dispatchEvent(new ChatEvent(ChatEvent.NAME_CHANGE, StringUtil.trim(this._txt.text)));
            return;
        }// end function

        public function setText(param1:String) : void
        {
            this._txt.text = param1;
            return;
        }// end function

        public function clear() : void
        {
            this._txt.text = "";
            return;
        }// end function

    }
}
