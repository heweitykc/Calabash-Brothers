package com.game.lostskills.message
{
    import net.*;

    public class ReqActivateLostSkillMessage extends Message
    {
        private var _skillType:int;

        public function ReqActivateLostSkillMessage()
        {
            return;
        }// end function

        public function set skillType(param1:int) : void
        {
            this._skillType = param1;
            return;
        }// end function

        public function get skillType() : int
        {
            return this._skillType;
        }// end function

        override public function getId() : int
        {
            return 600206;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._skillType);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._skillType = readInt();
            return true;
        }// end function

    }
}
