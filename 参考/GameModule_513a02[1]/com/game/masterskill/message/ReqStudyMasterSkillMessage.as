package com.game.masterskill.message
{
    import net.*;

    public class ReqStudyMasterSkillMessage extends Message
    {
        private var _modelid:int;

        public function ReqStudyMasterSkillMessage()
        {
            return;
        }// end function

        public function set modelid(param1:int) : void
        {
            this._modelid = param1;
            return;
        }// end function

        public function get modelid() : int
        {
            return this._modelid;
        }// end function

        override public function getId() : int
        {
            return 504101;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._modelid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._modelid = readInt();
            return true;
        }// end function

    }
}
