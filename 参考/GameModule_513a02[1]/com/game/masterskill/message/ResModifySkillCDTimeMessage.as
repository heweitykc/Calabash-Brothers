package com.game.masterskill.message
{
    import net.*;

    public class ResModifySkillCDTimeMessage extends Message
    {
        public var type:int;
        private var _skillId:int;
        private var _cdTime:int;

        public function ResModifySkillCDTimeMessage()
        {
            return;
        }// end function

        public function set skillId(param1:int) : void
        {
            this._skillId = param1;
            return;
        }// end function

        public function get skillId() : int
        {
            return this._skillId;
        }// end function

        public function set cdTime(param1:int) : void
        {
            this._cdTime = param1;
            return;
        }// end function

        public function get cdTime() : int
        {
            return this._cdTime;
        }// end function

        override public function getId() : int
        {
            return 504106;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._skillId);
            writeInt(this._cdTime);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._skillId = readInt();
            this._cdTime = readInt();
            this.type = readInt();
            return true;
        }// end function

    }
}
