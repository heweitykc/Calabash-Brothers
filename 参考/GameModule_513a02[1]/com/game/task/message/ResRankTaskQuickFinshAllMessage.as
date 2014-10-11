package com.game.task.message
{
    import net.*;

    public class ResRankTaskQuickFinshAllMessage extends Message
    {
        private var _allrankexp:int;

        public function ResRankTaskQuickFinshAllMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._allrankexp);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._allrankexp = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 120117;
        }// end function

        public function get allrankexp() : int
        {
            return this._allrankexp;
        }// end function

        public function set allrankexp(param1:int) : void
        {
            this._allrankexp = param1;
            return;
        }// end function

    }
}
