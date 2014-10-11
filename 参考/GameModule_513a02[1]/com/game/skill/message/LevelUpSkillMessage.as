package com.game.skill.message
{
    import net.*;

    public class LevelUpSkillMessage extends Message
    {
        private var _skillModelId:int;

        public function LevelUpSkillMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._skillModelId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._skillModelId = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 107202;
        }// end function

        public function get skillModelId() : int
        {
            return this._skillModelId;
        }// end function

        public function set skillModelId(param1:int) : void
        {
            this._skillModelId = param1;
            return;
        }// end function

    }
}
