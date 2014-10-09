package com.game.casting.message
{
    import net.*;

    public class ResCastingUseItemToClientMessage extends Message
    {
        private var _type:int;
        private var _isSuccess:int;
        private var _grididx:int;
        private var _value:int;

        public function ResCastingUseItemToClientMessage()
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

        public function set grididx(param1:int) : void
        {
            this._grididx = param1;
            return;
        }// end function

        public function get grididx() : int
        {
            return this._grididx;
        }// end function

        public function set value(param1:int) : void
        {
            this._value = param1;
            return;
        }// end function

        public function get value() : int
        {
            return this._value;
        }// end function

        override public function getId() : int
        {
            return 529103;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._type);
            writeInt(this._isSuccess);
            writeInt(this._grididx);
            writeInt(this._value);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._type = readInt();
            this._isSuccess = readInt();
            this._grididx = readInt();
            this._value = readInt();
            return true;
        }// end function

    }
}
