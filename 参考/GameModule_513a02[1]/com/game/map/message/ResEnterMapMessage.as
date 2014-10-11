package com.game.map.message
{
    import com.game.structs.*;
    import net.*;

    public class ResEnterMapMessage extends Message
    {
        private var _line:int;
        private var _pos:Position;

        public function ResEnterMapMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._line);
            writeBean(this._pos);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._line = readInt();
            this._pos = readBean(Position) as Position;
            return true;
        }// end function

        override public function getId() : int
        {
            return 101120;
        }// end function

        public function get line() : int
        {
            return this._line;
        }// end function

        public function set line(param1:int) : void
        {
            this._line = param1;
            return;
        }// end function

        public function get pos() : Position
        {
            return this._pos;
        }// end function

        public function set pos(param1:Position) : void
        {
            this._pos = param1;
            return;
        }// end function

    }
}
