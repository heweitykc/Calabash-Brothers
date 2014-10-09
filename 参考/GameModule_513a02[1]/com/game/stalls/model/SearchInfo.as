package com.game.stalls.model
{

    public class SearchInfo extends Object
    {
        private var _goodsname:String = "";
        private var _playername:String = "";
        private var _goldyuanbao:int;
        private var _jobLimit:int;
        private var _intensify:int;
        private var _kind:int;
        private var _type:int;
        private var _useable:int;
        private var _addAttribute:int;
        private var _remark:int;
        private var _hide:String = "";

        public function SearchInfo()
        {
            return;
        }// end function

        public function get hide() : String
        {
            return this._hide;
        }// end function

        public function set hide(param1:String) : void
        {
            this._hide = param1;
            return;
        }// end function

        public function get remark() : int
        {
            return this._remark;
        }// end function

        public function set remark(param1:int) : void
        {
            this._remark = param1;
            return;
        }// end function

        public function get useable() : int
        {
            return this._useable;
        }// end function

        public function set useable(param1:int) : void
        {
            this._useable = param1;
            return;
        }// end function

        public function get addAttribute() : int
        {
            return this._addAttribute;
        }// end function

        public function set addAttribute(param1:int) : void
        {
            this._addAttribute = param1;
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

        public function get kind() : int
        {
            return this._kind;
        }// end function

        public function set kind(param1:int) : void
        {
            this._kind = param1;
            return;
        }// end function

        public function get intensify() : int
        {
            return this._intensify;
        }// end function

        public function set intensify(param1:int) : void
        {
            this._intensify = param1;
            return;
        }// end function

        public function get jobLimit() : int
        {
            return this._jobLimit;
        }// end function

        public function set jobLimit(param1:int) : void
        {
            this._jobLimit = param1;
            return;
        }// end function

        public function get goldyuanbao() : int
        {
            return this._goldyuanbao;
        }// end function

        public function set goldyuanbao(param1:int) : void
        {
            this._goldyuanbao = param1;
            return;
        }// end function

        public function get playername() : String
        {
            return this._playername;
        }// end function

        public function set playername(param1:String) : void
        {
            this._playername = param1;
            return;
        }// end function

        public function get goodsname() : String
        {
            return this._goodsname;
        }// end function

        public function set goodsname(param1:String) : void
        {
            this._goodsname = param1;
            return;
        }// end function

        public function isNull() : Boolean
        {
            return this._goodsname != "" || this._playername != "" || this.goldyuanbao != 0 || this._useable || this._addAttribute || this._remark || this._jobLimit || this._intensify || this._type || this.hide != "";
        }// end function

        public function clear() : void
        {
            this._goodsname = "";
            this._playername = "";
            this._useable = 0;
            this._addAttribute = 0;
            this._remark = 0;
            this._jobLimit = 0;
            this._intensify = 0;
            this._type = 0;
            this._hide = "";
            return;
        }// end function

    }
}
