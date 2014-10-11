package com.game.map.message
{
    import com.game.structs.*;
    import com.game.utils.*;
    import net.*;

    public class ResPetStopMessage extends Message
    {
        private var _petId:long;
        private var _position:Position;

        public function ResPetStopMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._petId);
            writeBean(this._position);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._petId = readLong();
            this._position = readBean(Position) as Position;
            return true;
        }// end function

        override public function getId() : int
        {
            return 101121;
        }// end function

        public function get petId() : long
        {
            return this._petId;
        }// end function

        public function set petId(param1:long) : void
        {
            this._petId = param1;
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
