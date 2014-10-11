package com.game.fight.message
{
    import com.game.utils.*;
    import net.*;

    public class ResFightBroadcastMessage extends Message
    {
        private var _fightId:long;
        private var _personId:long;
        private var _fightDirection:int;
        private var _fightType:int;
        private var _fightTarget:long;

        public function ResFightBroadcastMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._fightId);
            writeLong(this._personId);
            writeInt(this._fightDirection);
            writeInt(this._fightType);
            writeLong(this._fightTarget);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._fightId = readLong();
            this._personId = readLong();
            this._fightDirection = readInt();
            this._fightType = readInt();
            this._fightTarget = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 102101;
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

        public function get personId() : long
        {
            return this._personId;
        }// end function

        public function set personId(param1:long) : void
        {
            this._personId = param1;
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

        public function get fightType() : int
        {
            return this._fightType;
        }// end function

        public function set fightType(param1:int) : void
        {
            this._fightType = param1;
            return;
        }// end function

        public function get fightTarget() : long
        {
            return this._fightTarget;
        }// end function

        public function set fightTarget(param1:long) : void
        {
            this._fightTarget = param1;
            return;
        }// end function

    }
}
