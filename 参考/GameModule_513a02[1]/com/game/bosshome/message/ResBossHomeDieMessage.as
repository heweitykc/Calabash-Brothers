package com.game.bosshome.message
{
    import com.game.utils.*;
    import net.*;

    public class ResBossHomeDieMessage extends Message
    {
        private var _type:int;
        private var _playerId:long;

        public function ResBossHomeDieMessage()
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

        public function set playerId(param1:long) : void
        {
            this._playerId = param1;
            return;
        }// end function

        public function get playerId() : long
        {
            return this._playerId;
        }// end function

        override public function getId() : int
        {
            return 543004;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._type);
            writeLong(this._playerId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._type = readInt();
            this._playerId = readLong();
            return true;
        }// end function

    }
}
