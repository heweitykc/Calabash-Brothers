package com.game.activities.message
{
    import net.*;

    public class ResCallEveryDay0ClockMessage extends Message
    {
        private var _eventType:int;

        public function ResCallEveryDay0ClockMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._eventType);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._eventType = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 138103;
        }// end function

        public function get eventType() : int
        {
            return this._eventType;
        }// end function

        public function set eventType(param1:int) : void
        {
            this._eventType = param1;
            return;
        }// end function

    }
}
