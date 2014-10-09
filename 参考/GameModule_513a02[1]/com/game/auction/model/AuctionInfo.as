package com.game.auction.model
{

    public class AuctionInfo extends Object
    {
        private var _goodsname:String = "";
        private var _jobLimit:int;
        private var _intensify:int;
        private var _kind:int;
        private var _type:int;
        private var _useable:int;
        private var _quality:int;
        private var _stagelevel:int;
        private var _addAttribute:int;
        private var _remark:int;
        public var sort:int;
        private var _modelId:int;
        private var _luck:int;
        private var _crit:int;
        private var _ignore:int;
        private var _suit:int;

        public function AuctionInfo()
        {
            return;
        }// end function

        public function get suit() : int
        {
            return this._suit;
        }// end function

        public function get ignore() : int
        {
            return this._ignore;
        }// end function

        public function set ignore(param1:int) : void
        {
            this._ignore = param1;
            return;
        }// end function

        public function get crit() : int
        {
            return this._crit;
        }// end function

        public function set crit(param1:int) : void
        {
            this._crit = param1;
            return;
        }// end function

        public function get luck() : int
        {
            return this._luck;
        }// end function

        public function set luck(param1:int) : void
        {
            this._luck = param1;
            switch(this._luck)
            {
                case 0:
                {
                    this._crit = 0;
                    this._ignore = 0;
                    this._suit = 0;
                    break;
                }
                case 1:
                {
                    this._crit = 1;
                    this._ignore = 0;
                    this._suit = 0;
                    break;
                }
                case 2:
                {
                    this._ignore = 1;
                    this._crit = 0;
                    this._suit = 0;
                    break;
                }
                case 3:
                {
                    this._ignore = 0;
                    this._crit = 0;
                    this._suit = 1;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function get modelId() : int
        {
            return this._modelId;
        }// end function

        public function set modelId(param1:int) : void
        {
            this._modelId = param1;
            return;
        }// end function

        public function get stagelevel() : int
        {
            return this._stagelevel;
        }// end function

        public function set stagelevel(param1:int) : void
        {
            this._stagelevel = param1;
            return;
        }// end function

        public function get quality() : int
        {
            return this._quality;
        }// end function

        public function set quality(param1:int) : void
        {
            this._quality = param1;
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
            return this._goodsname != "" || this._useable || this._addAttribute || this._remark || this._jobLimit || this._intensify || this._type;
        }// end function

        public function clear() : void
        {
            this._goodsname = "";
            this._useable = 0;
            this._addAttribute = 0;
            this._remark = 0;
            this._jobLimit = 0;
            this._intensify = 0;
            this._type = 0;
            this._modelId = 0;
            this._crit = 0;
            this._ignore = 0;
            this._suit = 0;
            return;
        }// end function

    }
}
