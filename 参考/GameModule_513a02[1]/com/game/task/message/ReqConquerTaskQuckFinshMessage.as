package com.game.task.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqConquerTaskQuckFinshMessage extends Message
    {
        private var _taskId:long;

        public function ReqConquerTaskQuckFinshMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._taskId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._taskId = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 120213;
        }// end function

        public function get taskId() : long
        {
            return this._taskId;
        }// end function

        public function set taskId(param1:long) : void
        {
            this._taskId = param1;
            return;
        }// end function

    }
}
