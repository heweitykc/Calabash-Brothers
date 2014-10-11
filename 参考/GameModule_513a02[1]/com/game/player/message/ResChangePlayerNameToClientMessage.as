package com.game.player.message
{
    import com.game.utils.*;
    import net.*;

    public class ResChangePlayerNameToClientMessage extends Message
    {
        private var _playerId:long;
        private var _newname:String;
        private var _result:int;

        public function ResChangePlayerNameToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._playerId);
            writeString(this._newname);
            writeByte(this._result);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playerId = readLong();
            this._newname = readString();
            this._result = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 103127;
        }// end function

        public function get playerId() : long
        {
            return this._playerId;
        }// end function

        public function set playerId(param1:long) : void
        {
            this._playerId = param1;
            return;
        }// end function

        public function get newname() : String
        {
            return this._newname;
        }// end function

        public function set newname(param1:String) : void
        {
            this._newname = param1;
            return;
        }// end function

        public function get result() : int
        {
            return this._result;
        }// end function

        public function set result(param1:int) : void
        {
            this._result = param1;
            return;
        }// end function

    }
}
