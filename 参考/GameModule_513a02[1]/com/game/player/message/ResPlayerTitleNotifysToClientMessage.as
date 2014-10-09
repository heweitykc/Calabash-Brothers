package com.game.player.message
{
    import net.*;

    public class ResPlayerTitleNotifysToClientMessage extends Message
    {
        public var type:int;
        public var titleId:int;
        public var time:int;

        public function ResPlayerTitleNotifysToClientMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 529109;
        }// end function

        override protected function reading() : Boolean
        {
            this.type = readInt();
            this.titleId = readInt();
            this.time = readInt();
            return true;
        }// end function

    }
}
