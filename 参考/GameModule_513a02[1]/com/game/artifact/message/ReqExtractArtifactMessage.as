package com.game.artifact.message
{
    import __AS3__.vec.*;

    public class ReqExtractArtifactMessage extends ArtifactMessage
    {
        public var itemIds:Vector.<long>;
        public var useGold:int;
        public var isDoubleExp:int;

        public function ReqExtractArtifactMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 511213;
        }// end function

        override protected function writing() : Boolean
        {
            writeLongs(this.itemIds);
            writeByte(this.useGold);
            writeByte(this.isDoubleExp);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            return true;
        }// end function

    }
}
