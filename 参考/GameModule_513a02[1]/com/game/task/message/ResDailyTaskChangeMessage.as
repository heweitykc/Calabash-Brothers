package com.game.task.message
{
    import com.game.task.bean.*;
    import net.*;

    public class ResDailyTaskChangeMessage extends Message
    {
        private var _daylyTaskacceptcount:int;
        private var _task:DailyTaskInfo;

        public function ResDailyTaskChangeMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._daylyTaskacceptcount);
            writeBean(this._task);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._daylyTaskacceptcount = readInt();
            this._task = readBean(DailyTaskInfo) as DailyTaskInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 120105;
        }// end function

        public function get daylyTaskacceptcount() : int
        {
            return this._daylyTaskacceptcount;
        }// end function

        public function set daylyTaskacceptcount(param1:int) : void
        {
            this._daylyTaskacceptcount = param1;
            return;
        }// end function

        public function get task() : DailyTaskInfo
        {
            return this._task;
        }// end function

        public function set task(param1:DailyTaskInfo) : void
        {
            this._task = param1;
            return;
        }// end function

    }
}
