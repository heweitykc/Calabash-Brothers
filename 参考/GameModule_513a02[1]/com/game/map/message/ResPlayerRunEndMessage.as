package com.game.map.message
{
    import com.game.structs.*;
    import com.game.utils.*;
    import net.*;

    public class ResPlayerRunEndMessage extends Message
    {
        private var _personId:long;
        private var _position:Position;

        public function ResPlayerRunEndMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._personId);
            writeBean(this._position);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._personId = readLong();
            this._position = readBean(Position) as Position;
            return true;
        }// end function

        override public function getId() : int
        {
            return 101123;
        }// end function

        public function get personId() : long
        {
            return this._personId;
        }// end function

        public function set personId(param1:long) : void
        {
            this._personId = param1;
            return;
        }// end function

        public function get position() : Position
        {
            return this._position;
        }// end function

        public function set position(param1:Position) : void
        {
            this._position = param1;
            return;
        }// end function

    }
}
