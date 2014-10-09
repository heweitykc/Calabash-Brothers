package com.game.task.events
{
    import flash.events.*;

    public class TaskEvent extends Event
    {
        public var data:Object;
        public static const ACCEPT_TASK:String = "accept_task";
        public static const COMPLETE_TASK:String = "complete_task";
        public static const DOING_TASK:String = "doing_task";
        public static const TASK_LIST_UPDATE:String = "task_list_update";
        public static const TASK_ITEM_UPDATE:String = "task_item_update";
        public static const TASK_GET_REWARD:String = "task_get_reward";
        public static const GET_NEW_TASK:String = "get_new_task";
        public static const DELETE_COMPLETE_TASK:String = "delete_complete_task";
        public static const DAILY_TASK_ADD:String = "daily_task_add";
        public static const DAILY_TASK_CHANGE:String = "daily_task_change";
        public static const PANEL_UI_CHANGE:String = "panel_ui_change";

        public function TaskEvent(param1, param2:String, param3:Boolean = false, param4:Boolean = false)
        {
            this.data = param1;
            super(param2, param3, param4);
            return;
        }// end function

    }
}
