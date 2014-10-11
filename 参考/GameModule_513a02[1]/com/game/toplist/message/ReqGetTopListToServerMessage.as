package com.game.toplist.message
{
    import net.*;

    public class ReqGetTopListToServerMessage extends Message
    {
        private var _toptype:int;
        private var _start:int;
        private var _end:int;

        public function ReqGetTopListToServerMessage()
        {
            return;
        }// end function

        public function set toptype(param1:int) : void
        {
            this._toptype = param1;
            return;
        }// end function

        public function get toptype() : int
        {
            return this._toptype;
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

        override public function getId() : int
        {
            return 142201;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._toptype);
            writeInt(this._start);
            writeInt(this._end);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._toptype = readByte();
            this._start = readInt();
            this._end = readInt();
            return true;
        }// end function

    }
}
