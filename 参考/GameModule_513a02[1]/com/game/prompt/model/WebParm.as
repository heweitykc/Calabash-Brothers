package com.game.prompt.model
{

    public class WebParm extends Parm
    {
        private var _name:String;
        private var _url:String;

        public function WebParm()
        {
            super(4);
            return;
        }// end function

        override public function set info(param1:Object) : void
        {
            this._name = param1.name;
            this._url = param1.url;
            return;
        }// end function

        public function get url() : String
        {
            return this._url;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

    }
}
