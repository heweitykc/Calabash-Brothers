package com.game.map.message
{
    import com.game.structs.*;
    import net.*;

    public class ResSynPlayerPositionMessage extends Message
    {
        private var _position:Position;

        public function ResSynPlayerPositionMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._position);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._position = readBean(Position) as Position;
            return true;
        }// end function

        override public function getId() : int
        {
            return 101701;
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
