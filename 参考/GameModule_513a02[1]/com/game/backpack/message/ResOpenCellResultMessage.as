package com.game.backpack.message
{
    import net.*;

    public class ResOpenCellResultMessage extends Message
    {
        private var _cellId:int;
        private var _isSuccess:int;

        public function ResOpenCellResultMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._cellId);
            writeInt(this._isSuccess);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._cellId = readInt();
            this._isSuccess = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 104110;
        }// end function

        public function get cellId() : int
        {
            return this._cellId;
        }// end function

        public function set cellId(param1:int) : void
        {
            this._cellId = param1;
            return;
        }// end function

        public function get isSuccess() : int
        {
            return this._isSuccess;
        }// end function

        public function set isSuccess(param1:int) : void
        {
            this._isSuccess = param1;
            return;
        }// end function

    }
}
