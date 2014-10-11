package com.game.artifact.message
{
    import __AS3__.vec.*;

    public class ResExtractArtifactMessage extends ArtifactMessage
    {
        public var itemIds:Vector.<long>;
        public var exps:Vector.<Number>;
        public var useGold:int;
        public var result:int;

        public function ResExtractArtifactMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 511014;
        }// end function

        override protected function writing() : Boolean
        {
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this.itemIds = readLongs();
            this.exps = readLongsAsNumbers();
            this.useGold = readByte();
            this.result = readByte();
            return true;
        }// end function

    }
}
