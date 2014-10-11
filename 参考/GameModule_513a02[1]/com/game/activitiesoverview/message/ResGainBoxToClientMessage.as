package com.game.activitiesoverview.message
{
    import net.*;

    public class ResGainBoxToClientMessage extends Message
    {
        public var boxesId:int;
        public var success:int;

        public function ResGainBoxToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this.boxesId);
            writeByte(this.success);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this.boxesId = readInt();
            this.success = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 600105;
        }// end function

    }
}
