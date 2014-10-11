package com.game.task.message
{
    import com.game.task.bean.*;
    import net.*;

    public class ResTreasureHuntTaskChangeMessage extends Message
    {
        private var _task:TreasureHuntTaskInfo;

        public function ResTreasureHuntTaskChangeMessage()
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
            this._task = readBean(TreasureHuntTaskInfo) as TreasureHuntTaskInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 120111;
        }// end function

        public function get task() : TreasureHuntTaskInfo
        {
            return this._task;
        }// end function

        public function set task(param1:TreasureHuntTaskInfo) : void
        {
            this._task = param1;
            return;
        }// end function

    }
}
