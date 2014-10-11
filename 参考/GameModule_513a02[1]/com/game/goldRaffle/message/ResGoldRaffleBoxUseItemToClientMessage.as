package com.game.goldRaffle.message
{
    import net.*;

    public class ResGoldRaffleBoxUseItemToClientMessage extends Message
    {
        private var _grididx:int;
        private var _type:int;
        private var _isSuccess:int;

        public function ResGoldRaffleBoxUseItemToClientMessage()
        {
            return;
        }// end function

        public function set grididx(param1:int) : void
        {
            this._grididx = param1;
            return;
        }// end function

        public function get grididx() : int
        {
            return this._grididx;
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
            return 528105;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._grididx);
            writeInt(this._type);
            writeInt(this._isSuccess);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._grididx = readInt();
            this._type = readInt();
            this._isSuccess = readInt();
            return true;
        }// end function

    }
}
