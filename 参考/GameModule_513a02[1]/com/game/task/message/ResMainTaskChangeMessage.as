package com.game.task.message
{
    import com.game.task.bean.*;
    import net.*;

    public class ResMainTaskChangeMessage extends Message
    {
        private var _task:MainTaskInfo;

        public function ResMainTaskChangeMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._task);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._task = readBean(MainTaskInfo) as MainTaskInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 120104;
        }// end function

        public function get task() : MainTaskInfo
        {
            return this._task;
        }// end function

        public function set task(param1:MainTaskInfo) : void
        {
            this._task = param1;
            return;
        }// end function

    }
}
