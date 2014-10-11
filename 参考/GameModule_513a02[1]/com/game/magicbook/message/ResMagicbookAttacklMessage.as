package com.game.magicbook.message
{
    import com.game.utils.*;
    import net.*;

    public class ResMagicbookAttacklMessage extends Message
    {
        private var _playerId:long;
        private var _targetId:long;
        private var _skillId:int;

        public function ResMagicbookAttacklMessage()
        {
            return;
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

        public function set targetId(param1:long) : void
        {
            this._targetId = param1;
            return;
        }// end function

        public function get targetId() : long
        {
            return this._targetId;
        }// end function

        public function set skillId(param1:int) : void
        {
            this._skillId = param1;
            return;
        }// end function

        public function get skillId() : int
        {
            return this._skillId;
        }// end function

        override public function getId() : int
        {
            return 600034;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._playerId);
            writeLong(this._targetId);
            writeInt(this._skillId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playerId = readLong();
            this._targetId = readLong();
            this._skillId = readInt();
            return true;
        }// end function

    }
}
