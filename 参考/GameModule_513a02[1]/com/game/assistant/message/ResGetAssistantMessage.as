package com.game.assistant.message
{
    import net.*;

    public class ResGetAssistantMessage extends Message
    {
        private var json:String;

        public function ResGetAssistantMessage()
        {
            return;
        }// end function

        override protected function reading() : Boolean
        {
            this.json = readString();
            return true;
        }// end function

        override public function getId() : int
        {
            return 131209;
        }// end function

        public function get data() : String
        {
            return this.json;
        }// end function

    }
}
