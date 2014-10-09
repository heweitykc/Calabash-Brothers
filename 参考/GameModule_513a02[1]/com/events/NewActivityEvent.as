package com.events
{
    import flash.events.*;

    public class NewActivityEvent extends Event
    {
        public var data:Object;
        public static const ACTIVITY_DETAIL_UPDATE:String = "activity_detail_update";
        public static const ACTIVITY_INFO_UPDATE:String = "activity_info_update";
        public static const NEW_ACT_RANK_INFO_UPDATE:String = "new_act_rank_update";
        public static const ACTIVITY_GROUP_ADD:String = "new_activity_add_group";
        public static const ACTIVITY_GROUP_REMOVE:String = "new_activity_remove_group";

        public function NewActivityEvent(param1:String, param2:Object)
        {
            this.data = param2;
            super(param1);
            return;
        }// end function

    }
}
