package com.game.masterskill.message
{
    import net.*;

    public class ResMasterSkillResetMessage extends Message
    {
        private var _masterPoint:int;

        public function ResMasterSkillResetMessage()
        {
            return;
        }// end function

        public function set masterPoint(param1:int) : void
        {
            this._masterPoint = param1;
            return;
        }// end function

        public function get masterPoint() : int
        {
            return this._masterPoint;
        }// end function

        override public function getId() : int
        {
            return 504104;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._masterPoint);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._masterPoint = readInt();
            return true;
        }// end function

    }
}
