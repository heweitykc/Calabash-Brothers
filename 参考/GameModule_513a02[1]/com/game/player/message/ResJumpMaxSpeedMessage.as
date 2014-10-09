package com.game.player.message
{
    import net.*;

    public class ResJumpMaxSpeedMessage extends Message
    {
        private var _jumpmaxspeed:int;

        public function ResJumpMaxSpeedMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._jumpmaxspeed);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._jumpmaxspeed = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 103135;
        }// end function

        public function get jumpmaxspeed() : int
        {
            return this._jumpmaxspeed;
        }// end function

        public function set jumpmaxspeed(param1:int) : void
        {
            this._jumpmaxspeed = param1;
            return;
        }// end function

    }
}
