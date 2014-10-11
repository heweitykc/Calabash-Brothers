package com.game.chat.model
{
    import __AS3__.vec.*;

    public class ChatSimpleVo extends Object
    {
        private var _content:String;
        private var _goods:Vector.<PropInfo>;
        private var _time:int;

        public function ChatSimpleVo()
        {
            return;
        }// end function

        public function get time() : int
        {
            return this._time;
        }// end function

        public function set time(param1:int) : void
        {
            this._time = param1;
            return;
        }// end function

        public function get goods() : Vector.<PropInfo>
        {
            return this._goods;
        }// end function

        public function set goods(param1:Vector.<PropInfo>) : void
        {
            this._goods = param1;
            return;
        }// end function

        public function get content() : String
        {
            return this._content;
        }// end function

        public function set content(param1:String) : void
        {
            this._content = param1;
            return;
        }// end function

    }
}
