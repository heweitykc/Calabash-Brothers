package com.game.artifact.message
{

    public class ReqOpenArtifactMessage extends ArtifactMessage
    {

        public function ReqOpenArtifactMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 511218;
        }// end function

        override protected function writing() : Boolean
        {
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            return true;
        }// end function

    }
}
