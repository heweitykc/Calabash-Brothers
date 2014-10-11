package com.game.artifact.event
{
    import flash.events.*;

    public class ArtifactEvent extends Event
    {
        public var data:Object;
        public static const ARTIFACT_DATA_CHANGE:String = "ARTIFACT_DATA_CHANGE";
        public static const EXTRACTABLE_ITEMS_CHANGE:String = "EXTRACTABLE_ITEMS_CHANGE";
        public static const EXTRACTABLE_ITEMS_HAS_NEW:String = "EXTRACTABLE_ITEMS_HAS_NEW";
        public static const FILTERED_EXTRACTABLE_ITEMS_CHANGE:String = "FILTERED_EXTRACTABLE_ITEMS_CHANGE";
        public static const FILTERED_EXTRACTABLE_ITEMS_HAS_NEW:String = "FILTERED_EXTRACTABLE_ITEMS_HAS_NEW";
        public static const AUTO_EXTRACTABLE_ITEMS_CHANGE:String = "AUTO_EXTRACTABLE_ITEMS_CHANGE";
        public static const AUTO_EXTRACTABLE_ITEMS_HAS_NEW:String = "AUTO_EXTRACTABLE_ITEMS_HAS_NEW";
        public static const ITEM_BE_EXTRACT:String = "ITEM_BE_EXTRACT";
        public static const ITEM_BE_EXTRACT_OK:String = "ITEM_BE_EXTRACT_OK";
        public static const AUTO_EXTRACT_MSG_CHANGE:String = "AUTO_EXTRACT_MSG_CHANGE";

        public function ArtifactEvent(param1:String, param2 = null)
        {
            super(param1);
            this.data = param2;
            return;
        }// end function

    }
}
