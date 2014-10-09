package com.game.task.model
{

    public class TaskVO extends Object
    {
        public var taskId:int;
        public var label:String;
        public var actionMsg:TaskCoordVO;
        public var type:int;
        public var complete:Boolean;

        public function TaskVO()
        {
            return;
        }// end function

    }
}
