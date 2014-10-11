package com.game.artifact.message
{
    import __AS3__.vec.*;

    public class ReqRemoldArtifactMessage extends ArtifactMessage
    {
        public var itemIds:Vector.<long>;

        public function ReqRemoldArtifactMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 511215;
        }// end function

        override protected function writing() : Boolean
        {
            writeLongs(this.itemIds);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            return true;
        }// end function

    }
}
