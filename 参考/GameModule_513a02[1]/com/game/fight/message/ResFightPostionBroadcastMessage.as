package com.game.fight.message
{
    import com.game.utils.*;
    import net.*;

    public class ResFightPostionBroadcastMessage extends Message
    {
        private var _fightId:long;
        private var _personId:long;
        private var _fightDirection:int;
        private var _fightType:int;
        private var _mapModelId:int;
        private var _line:int;
        private var _x:int;
        private var _y:int;

        public function ResFightPostionBroadcastMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._fightId);
            writeLong(this._personId);
            writeInt(this._fightDirection);
            writeInt(this._fightType);
            writeInt(this._mapModelId);
            writeInt(this._line);
            writeShort(this._x);
            writeShort(this._y);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._fightId = readLong();
            this._personId = readLong();
            this._fightDirection = readInt();
            this._fightType = readInt();
            this._mapModelId = readInt();
            this._line = readInt();
            this._x = readShort();
            this._y = readShort();
            return true;
        }// end function

        override public function getId() : int
        {
            return 502101;
        }// end function

        public function get y() : int
        {
            return this._y;
        }// end function

        public function set y(param1:int) : void
        {
            this._y = param1;
            return;
        }// end function

        public function get x() : int
        {
            return this._x;
        }// end function

        public function set x(param1:int) : void
        {
            this._x = param1;
            return;
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

        public function get mapModelId() : int
        {
            return this._mapModelId;
        }// end function

        public function set mapModelId(param1:int) : void
        {
            this._mapModelId = param1;
            return;
        }// end function

        public function get fightType() : int
        {
            return this._fightType;
        }// end function

        public function set fightType(param1:int) : void
        {
            this._fightType = param1;
            return;
        }// end function

        public function get fightDirection() : int
        {
            return this._fightDirection;
        }// end function

        public function set fightDirection(param1:int) : void
        {
            this._fightDirection = param1;
            return;
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

        public function get fightId() : long
        {
            return this._fightId;
        }// end function

        public function set fightId(param1:long) : void
        {
            this._fightId = param1;
            return;
        }// end function

    }
}
