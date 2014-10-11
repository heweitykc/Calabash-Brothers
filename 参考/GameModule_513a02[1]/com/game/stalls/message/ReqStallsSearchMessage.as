package com.game.stalls.message
{
    import net.*;

    public class ReqStallsSearchMessage extends Message
    {
        private var _goodsname:String;
        private var _playername:String;
        private var _goldyuanbao:int;
        private var _q_job_limit:int;
        private var _intensify:int;
        private var _q_kind:int;
        private var _q_type:int;
        private var _can_use:int;
        private var _addAttribut:int;
        private var _zhuoyue:int;
        private var _hidden:String;

        public function ReqStallsSearchMessage()
        {
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

        public function set playername(param1:String) : void
        {
            this._playername = param1;
            return;
        }// end function

        public function get playername() : String
        {
            return this._playername;
        }// end function

        public function set goldyuanbao(param1:int) : void
        {
            this._goldyuanbao = param1;
            return;
        }// end function

        public function get goldyuanbao() : int
        {
            return this._goldyuanbao;
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

        public function set can_use(param1:int) : void
        {
            this._can_use = param1;
            return;
        }// end function

        public function get can_use() : int
        {
            return this._can_use;
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

        public function set hidden(param1:String) : void
        {
            this._hidden = param1;
            return;
        }// end function

        public function get hidden() : String
        {
            return this._hidden;
        }// end function

        override public function getId() : int
        {
            return 123208;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this._goodsname);
            writeString(this._playername);
            writeByte(this._goldyuanbao);
            writeInt(this._q_job_limit);
            writeByte(this._intensify);
            writeInt(this._q_kind);
            writeInt(this._q_type);
            writeByte(this._can_use);
            writeByte(this._addAttribut);
            writeByte(this._zhuoyue);
            writeString(this._hidden);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._goodsname = readString();
            this._playername = readString();
            this._goldyuanbao = readByte();
            this._q_job_limit = readInt();
            this._intensify = readByte();
            this._q_kind = readInt();
            this._q_type = readInt();
            this._can_use = readByte();
            this._addAttribut = readByte();
            this._zhuoyue = readByte();
            this._hidden = readString();
            return true;
        }// end function

    }
}
