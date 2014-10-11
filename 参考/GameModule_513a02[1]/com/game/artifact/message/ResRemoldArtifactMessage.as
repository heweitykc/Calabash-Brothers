package com.game.artifact.message
{
    import __AS3__.vec.*;

    public class ResRemoldArtifactMessage extends ArtifactMessage
    {
        public var itemIds:Vector.<long>;
        public var result:int;

        public function ResRemoldArtifactMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 511016;
        }// end function

        override protected function writing() : Boolean
        {
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this.itemIds = readLongs();
            this.result = readByte();
            return true;
        }// end function

    }
}
