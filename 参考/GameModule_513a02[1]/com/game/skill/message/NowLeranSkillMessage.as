package com.game.skill.message
{
    import net.*;

    public class NowLeranSkillMessage extends Message
    {
        private var _skillModelId:int;
        private var _remainingTime:int;

        public function NowLeranSkillMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._skillModelId);
            writeInt(this._remainingTime);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._skillModelId = readInt();
            this._remainingTime = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 107106;
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

        public function get remainingTime() : int
        {
            return this._remainingTime;
        }// end function

        public function set remainingTime(param1:int) : void
        {
            this._remainingTime = param1;
            return;
        }// end function

    }
}
