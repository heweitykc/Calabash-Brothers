package com.game.player.message
{
    import com.game.utils.*;
    import net.*;

    public class ResPlayerLevelUpMessage extends Message
    {
        private var _personId:long;
        private var _currentLevel:int;

        public function ResPlayerLevelUpMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._personId);
            writeInt(this._currentLevel);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._personId = readLong();
            this._currentLevel = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 103104;
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

        public function get currentLevel() : int
        {
            return this._currentLevel;
        }// end function

        public function set currentLevel(param1:int) : void
        {
            this._currentLevel = param1;
            return;
        }// end function

    }
}
