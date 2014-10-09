package com.game.skill.message
{
    import com.game.utils.*;
    import net.*;

    public class StudySkillMessage extends Message
    {
        private var _skillModelId:int;
        private var _bookId:long;

        public function StudySkillMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._skillModelId);
            writeLong(this._bookId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._skillModelId = readInt();
            this._bookId = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 107201;
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

        public function get bookId() : long
        {
            return this._bookId;
        }// end function

        public function set bookId(param1:long) : void
        {
            this._bookId = param1;
            return;
        }// end function

    }
}
