package com.game.historymsg.message
{
    import com.game.historymsg.bean.*;

    public class ResAddHistorymsgMessage extends HistorymsgMessage
    {
        public var msg:HistorymsgMsg;

        public function ResAddHistorymsgMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 0;
        }// end function

        override protected function writing() : Boolean
        {
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this.msg = readBean(HistorymsgMsg) as HistorymsgMsg;
            return true;
        }// end function

    }
}
