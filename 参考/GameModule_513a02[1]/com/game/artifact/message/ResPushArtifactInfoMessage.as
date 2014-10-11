package com.game.artifact.message
{
    import __AS3__.vec.*;
    import com.game.artifact.bean.*;

    public class ResPushArtifactInfoMessage extends ArtifactMessage
    {
        public var level:int;
        public var exp:Number;
        public var extract:int;
        public var remold:Vector.<ArtifactRemoldInfo>;
        public var saveSetting:String;

        public function ResPushArtifactInfoMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 511012;
        }// end function

        override protected function writing() : Boolean
        {
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this.level = readShort();
            this.exp = readLongAsNumber();
            this.extract = readByte();
            this.remold = readBeans(new Vector.<ArtifactRemoldInfo>, ArtifactRemoldInfo);
            this.saveSetting = readString();
            return true;
        }// end function

    }
}
