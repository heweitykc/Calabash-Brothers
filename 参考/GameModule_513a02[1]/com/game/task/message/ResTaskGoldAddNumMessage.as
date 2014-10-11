package com.game.task.message
{
    import net.*;

    public class ResTaskGoldAddNumMessage extends Message
    {
        private var _tasktype:int;
        private var _nowmaxnum:int;

        public function ResTaskGoldAddNumMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._tasktype);
            writeInt(this._nowmaxnum);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._tasktype = readInt();
            this._nowmaxnum = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 120118;
        }// end function

        public function get tasktype() : int
        {
            return this._tasktype;
        }// end function

        public function set tasktype(param1:int) : void
        {
            this._tasktype = param1;
            return;
        }// end function

        public function get nowmaxnum() : int
        {
            return this._nowmaxnum;
        }// end function

        public function set nowmaxnum(param1:int) : void
        {
            this._nowmaxnum = param1;
            return;
        }// end function

    }
}
