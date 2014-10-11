package com.game.gm.message
{
    import net.*;

    public class GmLevelMessage extends Message
    {
        private var _level:int;

        public function GmLevelMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._level);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._level = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 200101;
        }// end function

        public function get level() : int
        {
            return this._level;
        }// end function

        public function set level(param1:int) : void
        {
            this._level = param1;
            return;
        }// end function

    }
}
