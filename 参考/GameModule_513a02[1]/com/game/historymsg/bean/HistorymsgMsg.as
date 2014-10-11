package com.game.historymsg.bean
{
    import net.*;

    public class HistorymsgMsg extends Bean
    {
        public var title:String;
        public var content:String;

        public function HistorymsgMsg()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this.title);
            writeString(this.content);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this.title = readString();
            this.content = readString();
            return true;
        }// end function

    }
}
