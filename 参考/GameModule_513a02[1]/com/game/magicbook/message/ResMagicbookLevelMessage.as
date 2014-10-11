package com.game.magicbook.message
{
    import com.game.utils.*;
    import net.*;

    public class ResMagicbookLevelMessage extends Message
    {
        private var _playerId:long;
        private var _star:int;
        private var _level:int;

        public function ResMagicbookLevelMessage()
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

        public function set star(param1:int) : void
        {
            this._star = param1;
            return;
        }// end function

        public function get star() : int
        {
            return this._star;
        }// end function

        public function set level(param1:int) : void
        {
            this._level = param1;
            return;
        }// end function

        public function get level() : int
        {
            return this._level;
        }// end function

        override public function getId() : int
        {
            return 600026;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._playerId);
            writeInt(this._star);
            writeInt(this._level);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playerId = readLong();
            this._star = readInt();
            this._level = readInt();
            return true;
        }// end function

    }
}
