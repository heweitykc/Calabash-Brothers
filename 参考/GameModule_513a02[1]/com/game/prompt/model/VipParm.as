package com.game.prompt.model
{

    public class VipParm extends Parm
    {
        private var _vipLv:int;
        private var _idx:int;

        public function VipParm()
        {
            super(3);
            return;
        }// end function

        override public function set info(param1:Object) : void
        {
            this._idx = param1.idx;
            this._vipLv = param1.vipLv;
            return;
        }// end function

        public function get idx() : int
        {
            return this._idx;
        }// end function

        public function get vipLv() : int
        {
            return this._vipLv;
        }// end function

    }
}
