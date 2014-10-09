package com.game.magicbook.message
{
    import net.*;

    public class ResMagicbookMessage extends Message
    {
        private var _potential:int;
        private var _star:int;
        private var _level:int;

        public function ResMagicbookMessage()
        {
            return;
        }// end function

        public function set potential(param1:int) : void
        {
            this._potential = param1;
            return;
        }// end function

        public function get potential() : int
        {
            return this._potential;
        }// end function

        public function set star(param1:int) : void
        {
            this._star = param1;
            return;
        }// end function

        public function get star() : int
        {
            return this._star;
        }// end function

        public function set level(param1:int) : void
        {
            this._level = param1;
            return;
        }// end function

        public function get level() : int
        {
            return this._level;
        }// end function

        override public function getId() : int
        {
            return 600028;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._potential);
            writeInt(this._star);
            writeInt(this._level);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._potential = readInt();
            this._star = readInt();
            this._level = readInt();
            return true;
        }// end function

    }
}
