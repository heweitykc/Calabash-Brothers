package com.game.hotkeyguide.control
{
    import com.f1.*;
    import com.game.hotkeyguide.cfg.*;
    import com.game.hotkeyguide.view.*;
    import com.game.task.events.*;
    import com.game.task.model.*;

    public class HotkeyGuideControl extends Object
    {
        private static var instance:HotkeyGuideControl;

        public function HotkeyGuideControl()
        {
            FrameworkGlobal.addMsgListen(TaskEvent.ACCEPT_TASK, this.onTaskAccept);
            FrameworkGlobal.addMsgListen(TaskEvent.DELETE_COMPLETE_TASK, this.onTaskFinish);
            return;
        }// end function

        private function onTaskAccept(event:TaskEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.taskId;
            this.onTaskStateChange(_loc_3, HotkeyGuideTaskState.ACCEPT);
            return;
        }// end function

        private function onTaskFinish(event:TaskEvent) : void
        {
            var _loc_2:* = event.data;
            this.onTaskStateChange(_loc_2, HotkeyGuideTaskState.FINISH);
            return;
        }// end function

        private function onTaskStateChange(param1:int, param2:uint) : void
        {
            var _loc_4:* = null;
            var _loc_3:* = HotkeyGuideCfgObj.getInstance().getHotkeyGuideCfg(param1, param2);
            if (_loc_3)
            {
                _loc_4 = _loc_3.q_hotkey;
                this.showHotkeyGuide(_loc_4);
            }
            return;
        }// end function

        public function showHotkeyGuide(param1:String, param2:int = 10, param3:Boolean = false) : void
        {
            new HotkeyGuideView(param1, param2, param3);
            return;
        }// end function

        public static function getInstance() : HotkeyGuideControl
        {
            var _loc_1:* = new HotkeyGuideControl;
            instance = new HotkeyGuideControl;
            return instance || _loc_1;
        }// end function

    }
}
