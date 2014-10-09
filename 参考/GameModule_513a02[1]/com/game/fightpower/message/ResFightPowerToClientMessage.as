package com.game.fightpower.message
{
    import net.*;

    public class ResFightPowerToClientMessage extends Message
    {
        private var _fightPower:int;

        public function ResFightPowerToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._fightPower);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._fightPower = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 127201;
        }// end function

        public function get fightPower() : int
        {
            return this._fightPower;
        }// end function

        public function set fightPower(param1:int) : void
        {
            this._fightPower = param1;
            return;
        }// end function

    }
}
