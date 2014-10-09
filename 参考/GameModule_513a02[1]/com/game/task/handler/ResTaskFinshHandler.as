package com.game.task.handler
{
    import com.game.awardGuide.control.*;
    import com.game.clickstream.*;
    import com.game.guide.control.*;
    import com.game.task.*;
    import com.game.task.control.*;
    import com.game.task.message.*;
    import net.*;

    public class ResTaskFinshHandler extends Handler
    {

        public function ResTaskFinshHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResTaskFinshMessage(this.message);
            ClickStream.finishTask(_loc_1.modelId);
            ItemAwardGuideControl.getInstance().onDeleteCompleteTask(_loc_1.modelId);
            GuideMultiControl.getInstance().onDeleteCompleteTask(_loc_1.modelId);
            TaskControl.getInstance().resTaskFinshHandle(_loc_1);
            if (TaskGlobal.manager.panel && TaskGlobal.manager.panel.data && TaskGlobal.manager.panel.data.taskId == _loc_1.modelId)
            {
                TaskGlobal.manager.closeTaskDialogPanel();
            }
            if (TaskGlobal.task && TaskGlobal.task.taskId == _loc_1.modelId)
            {
                TaskGlobal.task = null;
            }
            return;
        }// end function

    }
}
