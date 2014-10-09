package com.game.activitiesoverview.message
{
    import net.*;

    public class ResLivenessToClientMessage extends Message
    {
        private var _liveness:int;

        public function ResLivenessToClientMessage()
        {
            return;
        }// end function

        public function get liveness() : int
        {
            return this._liveness;
        }// end function

        public function set liveness(param1:int) : void
        {
            this._liveness = param1;
            return;
        }// end function

        override public function getId() : int
        {
            return 600101;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._liveness);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            this._liveness = readShort();
            return true;
        }// end function

    }
}
