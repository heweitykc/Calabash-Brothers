package com.game.task.model
{
    import __AS3__.vec.*;
    import com.game.task.bean.*;

    public class DailyTaskMsgVO extends TaskVO
    {
        public var acceptNum:int;
        public var data:DailyTaskInfo;
        public var target:String;
        public var hard:int;
        public var rich:int;
        public var exp:Number;
        public var coin:int;
        public var zq:int;
        public var prestige:int;
        public var bindyuanbao:int;
        public var rewards:Vector.<String>;
        public var extra:Object;

        public function DailyTaskMsgVO()
        {
            return;
        }// end function

    }
}
