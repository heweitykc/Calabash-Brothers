package com.game.gm.message
{
    import net.*;

    public class ResGMOpenIconMessage extends Message
    {
        private var _iconNum:int;

        public function ResGMOpenIconMessage()
        {
            return;
        }// end function

        public function set iconNum(param1:int) : void
        {
            this._iconNum = param1;
            return;
        }// end function

        public function get iconNum() : int
        {
            return this._iconNum;
        }// end function

        override public function getId() : int
        {
            return 600025;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._iconNum);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._iconNum = readInt();
            return true;
        }// end function

    }
}
