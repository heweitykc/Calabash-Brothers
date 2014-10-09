package com.game.player.message
{
    import net.*;

    public class ResPlayerTitleInfoToClientMessage extends Message
    {
        private var _type:int;
        private var _titleid:int;

        public function ResPlayerTitleInfoToClientMessage()
        {
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function get isGetRes() : Boolean
        {
            return this._type == 1;
        }// end function

        public function get isWearRes() : Boolean
        {
            return this._type == 2;
        }// end function

        public function get titleid() : int
        {
            return this._titleid;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._type);
            writeInt(this._titleid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._type = readInt();
            this._titleid = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 529107;
        }// end function

    }
}
