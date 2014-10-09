package com.game.redfortress.message
{
    import net.*;

    public class ResChangeIntegralMessage extends Message
    {
        private var _changeType:int;
        private var _playerIntegral:int;
        private var _Integral:int;
        private var _addedIntegral:int;

        public function ResChangeIntegralMessage()
        {
            return;
        }// end function

        public function set changeType(param1:int) : void
        {
            this._changeType = param1;
            return;
        }// end function

        public function get changeType() : int
        {
            return this._changeType;
        }// end function

        public function set playerIntegral(param1:int) : void
        {
            this._playerIntegral = param1;
            return;
        }// end function

        public function get playerIntegral() : int
        {
            return this._playerIntegral;
        }// end function

        public function set Integral(param1:int) : void
        {
            this._Integral = param1;
            return;
        }// end function

        public function get Integral() : int
        {
            return this._Integral;
        }// end function

        public function set addedIntegral(param1:int) : void
        {
            this._addedIntegral = param1;
            return;
        }// end function

        public function get addedIntegral() : int
        {
            return this._addedIntegral;
        }// end function

        override public function getId() : int
        {
            return 550102;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._changeType);
            writeInt(this._playerIntegral);
            writeInt(this._Integral);
            writeInt(this._addedIntegral);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._changeType = readInt();
            this._playerIntegral = readInt();
            this._Integral = readInt();
            this._addedIntegral = readInt();
            return true;
        }// end function

    }
}
