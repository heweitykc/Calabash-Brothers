package com.game.artifact.message
{

    public class ReqSaveArtifactSettingMessage extends ArtifactMessage
    {
        public var saveSetting:String;

        public function ReqSaveArtifactSettingMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 511217;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this.saveSetting);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            return true;
        }// end function

    }
}
