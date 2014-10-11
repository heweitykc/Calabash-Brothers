package com.game.task.model
{
    import com.game.task.bean.*;

    public class TaskMsgVO extends TaskVO
    {
        public var data:Object;
        public var rewarded:Boolean;
        public var conf:Object;
        public var x:int;
        public var y:int;
        public var task_disc:String;
        public var rewardMsg:TaskCoordVO;
        public var transfer:Boolean;
        public var transMsg:TaskCoordVO;
        private var _text1:String;
        public var text2:String;
        public var taskUnComExtraDes:String;
        public var levelLimit:int;
        public var moneyLimit:int;
        public var taskInfo:MainTaskInfo;

        public function TaskMsgVO()
        {
            return;
        }// end function

        public function get text1() : String
        {
            return this._text1;
        }// end function

        public function set text1(param1:String) : void
        {
            this._text1 = param1;
            return;
        }// end function

    }
}
