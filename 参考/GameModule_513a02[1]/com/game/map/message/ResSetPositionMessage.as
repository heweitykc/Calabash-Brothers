package com.game.map.message
{
    import com.game.structs.*;
    import com.game.utils.*;
    import net.*;

    public class ResSetPositionMessage extends Message
    {
        private var _personId:long;
        private var _position:Position;
        private var _mapModelId:int;

        public function ResSetPositionMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._personId);
            writeBean(this._position);
            writeInt(this._mapModelId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._personId = readLong();
            this._position = readBean(Position) as Position;
            this._mapModelId = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 101109;
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

        public function get mapModelId() : int
        {
            return this._mapModelId;
        }// end function

        public function set mapModelId(param1:int) : void
        {
            this._mapModelId = param1;
            return;
        }// end function

    }
}
