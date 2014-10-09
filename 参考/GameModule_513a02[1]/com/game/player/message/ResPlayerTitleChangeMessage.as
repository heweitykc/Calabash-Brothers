package com.game.player.message
{
    import com.game.utils.*;
    import net.*;

    public class ResPlayerTitleChangeMessage extends Message
    {
        public var personId:long;
        public var titleid:int;

        public function ResPlayerTitleChangeMessage()
        {
            return;
        }// end function

        override protected function reading() : Boolean
        {
            this.personId = readLong();
            this.titleid = readInt();
            return true;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this.personId);
            writeInt(this.titleid);
            return true;
        }// end function

        override public function getId() : int
        {
            return 529110;
        }// end function

    }
}
