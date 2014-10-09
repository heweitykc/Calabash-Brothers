package com.game.player.message
{
    import com.game.utils.*;
    import net.*;

    public class ResChangePKStateMessage extends Message
    {
        private var _personId:long;
        private var _pkState:int;
        private var _auto:int;

        public function ResChangePKStateMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._personId);
            writeInt(this._pkState);
            writeInt(this._auto);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._personId = readLong();
            this._pkState = readInt();
            this._auto = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 103118;
        }// end function

        public function get personId() : long
        {
            return this._personId;
        }// end function

        public function set personId(param1:long) : void
        {
            this._personId = param1;
            return;
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
