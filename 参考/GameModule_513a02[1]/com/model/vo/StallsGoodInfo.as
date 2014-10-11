package com.model.vo
{

    public class StallsGoodInfo extends Object
    {
        private var _pos:int;
        private var _prop:PropInfo;
        private var _pricegold:int;
        private var _priceyuanbao:int;
        private var _sellid:int;
        private var _isNew:Boolean;
        private var _souldiamond:int;
        private var _show_soldiamond:int;
        private var _orgincoin:int;
        private var _orgingold:int;

        public function StallsGoodInfo()
        {
            return;
        }// end function

        public function get souldiamond() : int
        {
            return this._souldiamond;
        }// end function

        public function set souldiamond(param1:int) : void
        {
            this._souldiamond = param1;
            return;
        }// end function

        public function get show_soldiamond() : int
        {
            return this._show_soldiamond;
        }// end function

        public function set show_soldiamond(param1:int) : void
        {
            this._show_soldiamond = param1;
            return;
        }// end function

        public function get orgingold() : int
        {
            return this._orgingold;
        }// end function

        public function set orgingold(param1:int) : void
        {
            this._orgingold = param1;
            return;
        }// end function

        public function get orgincoin() : int
        {
            return this._orgincoin;
        }// end function

        public function set orgincoin(param1:int) : void
        {
            this._orgincoin = param1;
            return;
        }// end function

        public function get sellid() : int
        {
            return this._sellid;
        }// end function

        public function set sellid(param1:int) : void
        {
            this._sellid = param1;
            return;
        }// end function

        public function get isNew() : Boolean
        {
            return this._isNew;
        }// end function

        public function set isNew(param1:Boolean) : void
        {
            this._isNew = param1;
            return;
        }// end function

        public function get pos() : int
        {
            return this._pos;
        }// end function

        public function set pos(param1:int) : void
        {
            this._pos = param1;
            return;
        }// end function

        public function get priceyuanbao() : int
        {
            return this._priceyuanbao;
        }// end function

        public function set priceyuanbao(param1:int) : void
        {
            this._priceyuanbao = param1;
            return;
        }// end function

        public function get pricegold() : int
        {
            return this._pricegold;
        }// end function

        public function set pricegold(param1:int) : void
        {
            this._pricegold = param1;
            return;
        }// end function

        public function get prop() : PropInfo
        {
            return this._prop;
        }// end function

        public function set prop(param1:PropInfo) : void
        {
            this._prop = param1;
            return;
        }// end function

    }
}
