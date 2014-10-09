package com.game.guild.events
{
    import flash.events.*;

    public class GuildEvent extends Event
    {
        public var data:Object;
        public static const GUILDLIST_CHANGE:String = "guildListChange";
        public static const MEMBERLIST_CHANGE:String = "memberListChange";
        public static const EVENTLIST_CHANGE:String = "eventListChange";
        public static const MEMBER_INFO_CHANGE:String = "memberInfoChange";
        public static const OTHER_MEMBER_INFO_CHANGE:String = "otherMemberInfoChange";
        public static const MY_MEMBER_INFO_CHANGE:String = "myMemberInfoChange";
        public static const GUILD_INFO_CHANGE:String = "guildInfoChange";

        public function GuildEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
        {
            this.data = param2;
            super(param1, param3, param4);
            return;
        }// end function

        override public function clone() : Event
        {
            return new GuildEvent(type, this.data, bubbles, cancelable);
        }// end function

    }
}
