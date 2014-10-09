package com.game.transactions.message
{
    import __AS3__.vec.*;
    import com.game.transactions.bean.*;
    import net.*;

    public class ResTmpYuanbaoLogMessage extends Message
    {
        private var _exchange:String;
        private var _web:String;
        private var _canryuanbao:int;
        private var _tpmyuanbaolonginfo:Vector.<TmpYuanbaoLogInfo>;

        public function ResTmpYuanbaoLogMessage()
        {
            this._tpmyuanbaolonginfo = new Vector.<TmpYuanbaoLogInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeString(this._exchange);
            writeString(this._web);
            writeInt(this._canryuanbao);
            writeShort(this._tpmyuanbaolonginfo.length);
            _loc_1 = 0;
            while (_loc_1 < this._tpmyuanbaolonginfo.length)
            {
                
                writeBean(this._tpmyuanbaolonginfo[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            this._exchange = readString();
            this._web = readString();
            this._canryuanbao = readInt();
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._tpmyuanbaolonginfo[_loc_1] = readBean(TmpYuanbaoLogInfo) as TmpYuanbaoLogInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 122112;
        }// end function

        public function get exchange() : String
        {
            return this._exchange;
        }// end function

        public function set exchange(param1:String) : void
        {
            this._exchange = param1;
            return;
        }// end function

        public function get web() : String
        {
            return this._web;
        }// end function

        public function set web(param1:String) : void
        {
            this._web = param1;
            return;
        }// end function

        public function get canryuanbao() : int
        {
            return this._canryuanbao;
        }// end function

        public function set canryuanbao(param1:int) : void
        {
            this._canryuanbao = param1;
            return;
        }// end function

        public function get tpmyuanbaolonginfo() : Vector.<TmpYuanbaoLogInfo>
        {
            return this._tpmyuanbaolonginfo;
        }// end function

        public function set tpmyuanbaolonginfo(param1:Vector.<TmpYuanbaoLogInfo>) : void
        {
            this._tpmyuanbaolonginfo = param1;
            return;
        }// end function

    }
}
