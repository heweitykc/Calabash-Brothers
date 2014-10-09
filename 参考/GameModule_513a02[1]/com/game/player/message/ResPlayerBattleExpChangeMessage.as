package com.game.player.message
{
    import net.*;

    public class ResPlayerBattleExpChangeMessage extends Message
    {
        private var _currentBattleExp:int;

        public function ResPlayerBattleExpChangeMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._currentBattleExp);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._currentBattleExp = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 103114;
        }// end function

        public function get currentBattleExp() : int
        {
            return this._currentBattleExp;
        }// end function

        public function set currentBattleExp(param1:int) : void
        {
            this._currentBattleExp = param1;
            return;
        }// end function

    }
}
