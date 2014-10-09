package com.game.auction.message
{
    import net.*;

    public class ReqAuctionSearchMessage extends Message
    {
        private var _goodsname:String;
        private var _suit:int;
        private var _q_job_limit:int;
        private var _crit:int;
        private var _ignore:int;
        private var _intensify:int;
        private var _q_kind:int;
        private var _q_type:int;
        private var _addAttribut:int;
        private var _zhuoyue:int;
        private var _steplv:int;
        private var _start:int;
        private var _end:int;
        private var _sort:int;
        private var _mondelId:int;

        public function ReqAuctionSearchMessage()
        {
            return;
        }// end function

        public function get suit() : int
        {
            return this._suit;
        }// end function

        public function set suit(param1:int) : void
        {
            this._suit = param1;
            return;
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

        public function set goodsname(param1:String) : void
        {
            this._goodsname = param1;
            return;
        }// end function

        public function get goodsname() : String
        {
            return this._goodsname;
        }// end function

        public function set q_job_limit(param1:int) : void
        {
            this._q_job_limit = param1;
            return;
        }// end function

        public function get q_job_limit() : int
        {
            return this._q_job_limit;
        }// end function

        public function set intensify(param1:int) : void
        {
            this._intensify = param1;
            return;
        }// end function

        public function get intensify() : int
        {
            return this._intensify;
        }// end function

        public function set q_kind(param1:int) : void
        {
            this._q_kind = param1;
            return;
        }// end function

        public function get q_kind() : int
        {
            return this._q_kind;
        }// end function

        public function set q_type(param1:int) : void
        {
            this._q_type = param1;
            return;
        }// end function

        public function get q_type() : int
        {
            return this._q_type;
        }// end function

        public function set addAttribut(param1:int) : void
        {
            this._addAttribut = param1;
            return;
        }// end function

        public function get addAttribut() : int
        {
            return this._addAttribut;
        }// end function

        public function set zhuoyue(param1:int) : void
        {
            this._zhuoyue = param1;
            return;
        }// end function

        public function get zhuoyue() : int
        {
            return this._zhuoyue;
        }// end function

        public function set steplv(param1:int) : void
        {
            this._steplv = param1;
            return;
        }// end function

        public function get steplv() : int
        {
            return this._steplv;
        }// end function

        public function set start(param1:int) : void
        {
            this._start = param1;
            return;
        }// end function

        public function get start() : int
        {
            return this._start;
        }// end function

        public function set end(param1:int) : void
        {
            this._end = param1;
            return;
        }// end function

        public function get end() : int
        {
            return this._end;
        }// end function

        public function set sort(param1:int) : void
        {
            this._sort = param1;
            return;
        }// end function

        public function get sort() : int
        {
            return this._sort;
        }// end function

        public function set mondelId(param1:int) : void
        {
            this._mondelId = param1;
            return;
        }// end function

        public function get mondelId() : int
        {
            return this._mondelId;
        }// end function

        override public function getId() : int
        {
            return 512204;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this._goodsname);
            writeInt(this._q_job_limit);
            writeByte(this._intensify);
            writeInt(this._q_kind);
            writeInt(this._q_type);
            writeByte(this._addAttribut);
            writeByte(this._zhuoyue);
            writeInt(this._steplv);
            writeInt(this._start);
            writeInt(this._end);
            writeInt(this._sort);
            writeInt(this._mondelId);
            writeByte(this._crit);
            writeByte(this._ignore);
            writeByte(this._suit);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._goodsname = readString();
            this._q_job_limit = readInt();
            this._intensify = readByte();
            this._q_kind = readInt();
            this._q_type = readInt();
            this._addAttribut = readByte();
            this._zhuoyue = readByte();
            this._steplv = readInt();
            this._start = readInt();
            this._end = readInt();
            this._sort = readInt();
            this._mondelId = readInt();
            this._crit = readByte();
            this._ignore = readByte();
            this._suit = readByte();
            return true;
        }// end function

    }
}
