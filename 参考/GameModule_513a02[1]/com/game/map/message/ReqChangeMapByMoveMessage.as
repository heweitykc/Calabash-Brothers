package com.game.map.message
{
    import net.*;

    public class ReqChangeMapByMoveMessage extends Message
    {
        private var _line:int;
        private var _tranId:int;

        public function ReqChangeMapByMoveMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._line);
            writeInt(this._tranId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._line = readInt();
            this._tranId = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 101206;
        }// end function

        public function get line() : int
        {
            return this._line;
        }// end function

        public function set line(param1:int) : void
        {
            this._line = param1;
            return;
        }// end function

        public function get tranId() : int
        {
            return this._tranId;
        }// end function

        public function set tranId(param1:int) : void
        {
            this._tranId = param1;
            return;
        }// end function

    }
}
