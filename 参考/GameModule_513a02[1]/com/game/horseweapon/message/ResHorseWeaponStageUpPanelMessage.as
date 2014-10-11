package com.game.horseweapon.message
{
    import net.*;

    public class ResHorseWeaponStageUpPanelMessage extends Message
    {
        private var _exp:int;

        public function ResHorseWeaponStageUpPanelMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._exp);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._exp = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 155103;
        }// end function

        public function get exp() : int
        {
            return this._exp;
        }// end function

        public function set exp(param1:int) : void
        {
            this._exp = param1;
            return;
        }// end function

    }
}
