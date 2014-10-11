package com.game.task.protocol
{
    import com.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.game.task.message.*;
    import com.game.utils.*;

    public class TaskProtocol extends BaseProtocol
    {
        private var _popBox:SysCueBox;

        public function TaskProtocol()
        {
            return;
        }// end function

        public function reqMainTaskFinish(param1:int, param2:Boolean = false) : void
        {
            var _loc_3:* = new ReqTaskFinshMessage();
            _loc_3.taskId = param1;
            _loc_3.type = 0;
            _loc_3.twice = param2;
            _loc_3.conquererTaskId = new long();
            send(_loc_3);
            return;
        }// end function

        public function reqDailyTaskFinish(param1:int, param2:Boolean = false) : void
        {
            var _loc_3:* = new ReqTaskFinshMessage();
            _loc_3.taskId = param1;
            _loc_3.type = 1;
            _loc_3.twice = param2;
            _loc_3.conquererTaskId = new long();
            send(_loc_3);
            return;
        }// end function

        public function oneKeyFinishCurrentDailyTask(param1:int, param2:int = 0) : void
        {
            var _loc_3:* = "";
            if (param2 == 1)
            {
                _loc_3 = LanguageCfgObj.getInstance().getByIndex("11330");
            }
            else if (param2 == 2)
            {
                _loc_3 = LanguageCfgObj.getInstance().getByIndex("11331");
            }
            this._popBox = Global.popManager.cue(_loc_3, LanguageCfgObj.getInstance().getByIndex("11332"), [param1, param2], this.consumeToUse, null, 2, null, false, false, null) as SysCueBox;
            return;
        }// end function

        private function consumeToUse(param1:int, param2:int = 0) : void
        {
            var _loc_3:* = new ReqQuickFinshMessage();
            _loc_3.taskId = param1;
            _loc_3.type = param2;
            send(_loc_3);
            return;
        }// end function

        public function reqDailyTaskUpAchieve(param1:int) : void
        {
            var _loc_2:* = new ReqTaskUpAchieveMessage();
            _loc_2.taskId = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqTaskDownHard(param1:int) : void
        {
            var _loc_2:* = new ReqTaskDownHardMessage();
            _loc_2.taskId = param1;
            send(_loc_2);
            return;
        }// end function

        public function oneKeyFinishCurrentGongTask(param1:int) : void
        {
            var _loc_2:* = new ReqRankTaskQuckFinshMessage();
            _loc_2.modelId = param1;
            send(_loc_2);
            return;
        }// end function

        public function oneKeyFinishAllGongTask() : void
        {
            var _loc_1:* = new ReqRankTaskQuckFinshAllMessage();
            send(_loc_1);
            return;
        }// end function

        public function taskTransfer(param1:int, param2:int, param3:int, param4:int = 0, param5:int = 0, param6:int = 0) : void
        {
            var _loc_7:* = new ReqMainTaskTransMessage();
            _loc_7.mapId = param1;
            _loc_7.x = param2;
            _loc_7.y = param3;
            _loc_7.line = param6;
            _loc_7.type = param4;
            _loc_7.taskId = param5;
            send(_loc_7);
            return;
        }// end function

    }
}
