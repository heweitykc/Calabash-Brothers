package com.game.task.message
{
    import com.game.task.bean.*;
    import net.*;

    public class ResRankTaskChangeMessage extends Message
    {
        private var _taskInfo:RankTaskInfo;

        public function ResRankTaskChangeMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._taskInfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._taskInfo = readBean(RankTaskInfo) as RankTaskInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 120115;
        }// end function

        public function get taskInfo() : RankTaskInfo
        {
            return this._taskInfo;
        }// end function

        public function set taskInfo(param1:RankTaskInfo) : void
        {
            this._taskInfo = param1;
            return;
        }// end function

    }
}
