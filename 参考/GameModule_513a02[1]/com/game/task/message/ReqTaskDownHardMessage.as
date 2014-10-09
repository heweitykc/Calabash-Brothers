package com.game.task.message
{
    import net.*;

    public class ReqTaskDownHardMessage extends Message
    {
        private var _taskId:int;

        public function ReqTaskDownHardMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._taskId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._taskId = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 120204;
        }// end function

        public function get taskId() : int
        {
            return this._taskId;
        }// end function

        public function set taskId(param1:int) : void
        {
            this._taskId = param1;
            return;
        }// end function

    }
}
