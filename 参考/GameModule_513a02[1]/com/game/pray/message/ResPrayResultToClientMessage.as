package com.game.pray.message
{
    import net.*;

    public class ResPrayResultToClientMessage extends Message
    {
        private var _type:int;
        private var _isSuccess:int;

        public function ResPrayResultToClientMessage()
        {
            return;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set isSuccess(param1:int) : void
        {
            this._isSuccess = param1;
            return;
        }// end function

        public function get isSuccess() : int
        {
            return this._isSuccess;
        }// end function

        override public function getId() : int
        {
            return 528333;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._type);
            writeByte(this._isSuccess);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._type = readByte();
            this._isSuccess = readByte();
            return true;
        }// end function

    }
}
