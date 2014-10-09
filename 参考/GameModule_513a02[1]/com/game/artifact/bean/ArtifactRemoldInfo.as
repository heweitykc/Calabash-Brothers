package com.game.artifact.bean
{
    import net.*;

    public class ArtifactRemoldInfo extends Bean
    {
        public var itemModelId:int;
        public var count:int;

        public function ArtifactRemoldInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this.itemModelId);
            writeByte(this.count);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this.itemModelId = readInt();
            this.count = readByte();
            return true;
        }// end function

    }
}
