package com.game.activitiesoverview.message
{
    import net.*;

    public class ReqGainBoxToServerMessage extends Message
    {
        private var _boxId:int;

        public function ReqGainBoxToServerMessage()
        {
            return;
        }// end function

        public function get boxId() : int
        {
            return this._boxId;
        }// end function

        public function set boxId(param1:int) : void
        {
            this._boxId = param1;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._boxId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._boxId = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 600104;
        }// end function

    }
}
