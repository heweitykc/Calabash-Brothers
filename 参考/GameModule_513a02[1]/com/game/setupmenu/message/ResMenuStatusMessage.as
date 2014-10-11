package com.game.setupmenu.message
{
    import net.*;

    public class ResMenuStatusMessage extends Message
    {
        private var _clientset:int;
        private var _menustatus:int;

        public function ResMenuStatusMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._clientset);
            writeInt(this._menustatus);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._clientset = readInt();
            this._menustatus = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 125101;
        }// end function

        public function get clientset() : int
        {
            return this._clientset;
        }// end function

        public function set clientset(param1:int) : void
        {
            this._clientset = param1;
            return;
        }// end function

        public function get menustatus() : int
        {
            return this._menustatus;
        }// end function

        public function set menustatus(param1:int) : void
        {
            this._menustatus = param1;
            return;
        }// end function

    }
}
