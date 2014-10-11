package com.game.map.message
{
    import com.game.structs.*;
    import com.game.utils.*;
    import net.*;

    public class ResSetSpecialPositionMessage extends Message
    {
        private var _personId:long;
        private var _position:Position;
        private var _skillID:int;

        public function ResSetSpecialPositionMessage()
        {
            return;
        }// end function

        public function get skillID() : int
        {
            return this._skillID;
        }// end function

        public function set skillID(param1:int) : void
        {
            this._skillID = param1;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._personId);
            writeBean(this._position);
            writeInt(this._skillID);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._personId = readLong();
            this._position = readBean(Position) as Position;
            this._skillID = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 501109;
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
