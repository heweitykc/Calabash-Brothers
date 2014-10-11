package com.game.backpack.message
{
    import net.*;

    public class ResCellTimeMessage extends Message
    {
        private var _cellId:int;
        private var _timeRemaining:int;

        public function ResCellTimeMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._cellId);
            writeInt(this._timeRemaining);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._cellId = readInt();
            this._timeRemaining = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 104109;
        }// end function

        public function get cellId() : int
        {
            return this._cellId;
        }// end function

        public function set cellId(param1:int) : void
        {
            this._cellId = param1;
            return;
        }// end function

        public function get timeRemaining() : int
        {
            return this._timeRemaining;
        }// end function

        public function set timeRemaining(param1:int) : void
        {
            this._timeRemaining = param1;
            return;
        }// end function

    }
}
