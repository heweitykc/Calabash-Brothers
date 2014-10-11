package com.game.newactivity.message
{
    import net.*;

    public class ResFirstPayGroupCountMessage extends Message
    {
        private var _groupCount:String;

        public function ResFirstPayGroupCountMessage()
        {
            return;
        }// end function

        public function get groupCount() : String
        {
            return this._groupCount;
        }// end function

        public function set groupCount(param1:String) : void
        {
            this._groupCount = param1;
            return;
        }// end function

        override public function getId() : int
        {
            return 511020;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this._groupCount);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this.groupCount = readString();
            return true;
        }// end function

    }
}
