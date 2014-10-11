package com.game.player.message
{
    import net.*;

    public class ReqWearTitleToServerMessage extends Message
    {
        private var _titleId:int;

        public function ReqWearTitleToServerMessage()
        {
            return;
        }// end function

        public function get titleId() : int
        {
            return this._titleId;
        }// end function

        public function set titleId(param1:int) : void
        {
            this._titleId = param1;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._titleId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._titleId = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 529208;
        }// end function

    }
}
