package com.game.assistant.message
{
    import net.*;

    public class ReqSaveAssistantMessage extends Message
    {
        public var json:String;

        public function ReqSaveAssistantMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 131210;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this.json);
            return true;
        }// end function

    }
}
