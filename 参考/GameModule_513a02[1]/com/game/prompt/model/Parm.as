package com.game.prompt.model
{

    public class Parm extends Object
    {
        private var _type:int;

        public function Parm(param1:int)
        {
            this._type = param1;
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

        public function set info(param1:Object) : void
        {
            return;
        }// end function

    }
}
