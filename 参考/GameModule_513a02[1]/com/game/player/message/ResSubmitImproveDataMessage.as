package com.game.player.message
{
    import net.*;

    public class ResSubmitImproveDataMessage extends Message
    {
        private var _isSuccess:int;

        public function ResSubmitImproveDataMessage()
        {
            return;
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
            return 529117;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._isSuccess);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._isSuccess = readByte();
            return true;
        }// end function

    }
}
