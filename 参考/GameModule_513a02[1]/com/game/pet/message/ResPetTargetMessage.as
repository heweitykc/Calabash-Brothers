package com.game.pet.message
{
    import com.game.utils.*;
    import net.*;

    public class ResPetTargetMessage extends Message
    {
        private var _targetId:long;

        public function ResPetTargetMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._targetId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._targetId = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 110114;
        }// end function

        public function get targetId() : long
        {
            return this._targetId;
        }// end function

        public function set targetId(param1:long) : void
        {
            this._targetId = param1;
            return;
        }// end function

    }
}
