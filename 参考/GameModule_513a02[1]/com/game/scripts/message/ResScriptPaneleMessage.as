package com.game.scripts.message
{
    import net.*;

    public class ResScriptPaneleMessage extends Message
    {
        private var _scriptId:int;
        private var _panel:String;

        public function ResScriptPaneleMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._scriptId);
            writeString(this._panel);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._scriptId = readInt();
            this._panel = readString();
            return true;
        }// end function

        override public function getId() : int
        {
            return 148101;
        }// end function

        public function get scriptId() : int
        {
            return this._scriptId;
        }// end function

        public function set scriptId(param1:int) : void
        {
            this._scriptId = param1;
            return;
        }// end function

        public function get panel() : String
        {
            return this._panel;
        }// end function

        public function set panel(param1:String) : void
        {
            this._panel = param1;
            return;
        }// end function

    }
}
