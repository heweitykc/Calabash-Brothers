package com.game.player.message
{
    import net.*;

    public class ResScriptCommonPlayerToClientMessage extends Message
    {
        private var _scriptid:int;
        private var _type:int;
        private var _messageData:String;

        public function ResScriptCommonPlayerToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._scriptid);
            writeInt(this._type);
            writeString(this._messageData);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._scriptid = readInt();
            this._type = readInt();
            this._messageData = readString();
            return true;
        }// end function

        override public function getId() : int
        {
            return 103130;
        }// end function

        public function get scriptid() : int
        {
            return this._scriptid;
        }// end function

        public function set scriptid(param1:int) : void
        {
            this._scriptid = param1;
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

        public function get messageData() : String
        {
            return this._messageData;
        }// end function

        public function set messageData(param1:String) : void
        {
            this._messageData = param1;
            return;
        }// end function

    }
}
