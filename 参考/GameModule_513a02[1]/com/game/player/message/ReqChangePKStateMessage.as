package com.game.player.message
{
    import net.*;

    public class ReqChangePKStateMessage extends Message
    {
        private var _pkState:int;
        private var _auto:int;

        public function ReqChangePKStateMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._pkState);
            writeInt(this._auto);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._pkState = readInt();
            this._auto = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 103204;
        }// end function

        public function get pkState() : int
        {
            return this._pkState;
        }// end function

        public function set pkState(param1:int) : void
        {
            this._pkState = param1;
            return;
        }// end function

        public function get auto() : int
        {
            return this._auto;
        }// end function

        public function set auto(param1:int) : void
        {
            this._auto = param1;
            return;
        }// end function

    }
}
