package com.game.player.message
{
    import com.game.utils.*;
    import net.*;

    public class ResPlayerExpChangeMessage extends Message
    {
        private var _currentExp:long;

        public function ResPlayerExpChangeMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._currentExp);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._currentExp = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 103103;
        }// end function

        public function get currentExp() : long
        {
            return this._currentExp;
        }// end function

        public function set currentExp(param1:long) : void
        {
            this._currentExp = param1;
            return;
        }// end function

    }
}
