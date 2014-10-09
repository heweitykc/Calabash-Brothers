package com.game.fight.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqAttackPlayerMessage extends Message
    {
        private var _fightType:int;
        private var _fightDirection:int;
        private var _fightTarget:long;

        public function ReqAttackPlayerMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._fightType);
            writeInt(this._fightDirection);
            writeLong(this._fightTarget);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._fightType = readInt();
            this._fightDirection = readInt();
            this._fightTarget = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 102202;
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
