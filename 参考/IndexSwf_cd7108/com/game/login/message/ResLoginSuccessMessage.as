package com.game.login.message
{
    import net.*;

    public class ResLoginSuccessMessage extends Message
    {
        private var _mapId:int;

        public function ResLoginSuccessMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._mapId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._mapId = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 100102;
        }// end function

        public function get mapId() : int
        {
            return this._mapId;
        }// end function

        public function set mapId(param1:int) : void
        {
            this._mapId = param1;
            return;
        }// end function

    }
}
