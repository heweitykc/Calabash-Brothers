package com.game.map.message
{
    import com.game.structs.*;
    import com.game.utils.*;
    import net.*;

    public class ResMonsterStopMessage extends Message
    {
        private var _monsterId:long;
        private var _position:Position;

        public function ResMonsterStopMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._monsterId);
            writeBean(this._position);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._monsterId = readLong();
            this._position = readBean(Position) as Position;
            return true;
        }// end function

        override public function getId() : int
        {
            return 101115;
        }// end function

        public function get monsterId() : long
        {
            return this._monsterId;
        }// end function

        public function set monsterId(param1:long) : void
        {
            this._monsterId = param1;
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
