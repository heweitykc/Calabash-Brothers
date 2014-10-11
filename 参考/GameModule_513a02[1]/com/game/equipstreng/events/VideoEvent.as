package com.game.equipstreng.events
{
    import flash.events.*;

    public class VideoEvent extends Event
    {
        public static var VIDEO_STRENG_COMPELETE:String = "Video_streng_compelete";
        public static var VIDEO_FIRE_COMPELETE:String = "Video_fire_compelete";
        public static var VIDEO_CLOSE:String = "Video_close";
        public static var VIDEO_TOTALTIME:Number = new Number();
        public static var VIDEO_ID:uint;

        public function VideoEvent(param1:String)
        {
            super(param1, false, false);
            return;
        }// end function

    }
}
