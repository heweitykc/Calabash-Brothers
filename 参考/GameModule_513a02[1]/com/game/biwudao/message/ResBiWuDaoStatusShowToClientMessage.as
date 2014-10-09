package com.game.biwudao.message
{
    import net.*;

    public class ResBiWuDaoStatusShowToClientMessage extends Message
    {
        private var _statusshow:String;

        public function ResBiWuDaoStatusShowToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this._statusshow);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._statusshow = readString();
            return true;
        }// end function

        override public function getId() : int
        {
            return 157107;
        }// end function

        public function get statusshow() : String
        {
            return this._statusshow;
        }// end function

        public function set statusshow(param1:String) : void
        {
            this._statusshow = param1;
            return;
        }// end function

    }
}
