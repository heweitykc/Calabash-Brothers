package com.game.task
{
    import com.f1.*;
    import com.game.role.*;
    import com.game.task.model.*;
    import com.game.task.protocol.*;
    import com.staticdata.*;

    public class TaskGlobal extends Object
    {
        public static var TASK_TYPE_NAME:Object = {1:{name:LanguageCfgObj.getInstance().getByIndex("11760"), color:"#ffde00"}, 5:{name:LanguageCfgObj.getInstance().getByIndex("11761"), color:"#b58239"}, 6:{name:LanguageCfgObj.getInstance().getByIndex("11762"), color:"#b58239"}};
        public static var TASK_TALK:int = 1;
        public static var TASK_KILL:int = 2;
        public static var TASK_DROP:int = 3;
        public static var TASK_GATHER:int = 4;
        public static var TASK_SEND:int = 5;
        public static var TASK_EFFECT:int = 6;
        public static var TASK_STRONG:int = 7;
        public static var TASK_ELSE:int = 8;
        public static var TASK_COLLECT:int = 11;
        public static var TASK_STRONG2:int = 12;
        public static var TASK_EQUIPMENT:int = 13;
        private static var _task_mode:Boolean = false;
        public static const FIRST_GET_WING:int = 10014;
        public static var CLICK_SCENE_HINT:String = LanguageCfgObj.getInstance().getByIndex("11284");
        public static const myEvt:BaseEventDispatcher = new BaseEventDispatcher();
        public static const manager:TaskManager = new TaskManager();
        public static const protocol:TaskProtocol = new TaskProtocol();
        public static var currentTask:TaskVO;
        public static var task:TaskMsgVO;
        public static var isChangeSceneContinueTask:Boolean = false;
        public static var taskFindPathCallBack:Function;
        public static const cfg_else:Array = [{id:1, label:"击杀怪物数量", desc:"击杀与玩家角色等级，相差5级范围的怪物，才能计数"}, {id:2, label:"击杀精英数量", desc:"击杀与玩家角色等级，相差10级范围的精英才能计数"}, {id:3, label:"击杀BOSS数量", desc:"击杀与玩家角色等级，相差10级范围的BOSS才能计数"}, {id:4, label:"王帮战中击杀非本帮玩家", desc:"仅在每周6才会出现任务，在战场中击杀玩家有效——若当前周6不开启攻城战，则隐藏任务"}, {id:5, label:"神树浇水", desc:"给自己、帮会神树浇水均可完成任务，浇水数量根据配置"}, {id:6, label:"每日登陆", desc:"每日登陆后直接完成任务并获得奖励，每日1次"}, {id:7, label:"完成日常任务", desc:"完成当天的" + TaskGlobal.DAILY_TASK_MAX_RANGE + "环日常任务后方可领取，直接付费完成的也算"}, {id:8, label:"消费礼金", desc:"消费礼金达到多少，即可完成任务"}, {id:9, label:"消费元宝", desc:"消费元宝达到多少，即可完成任务"}, {id:10, label:"通关经典战役", desc:"完成经典战役副本通关次数6次，即可完成任务"}, {id:11, label:"使用道具", desc:"按照任务要求，使用某种物品成功，即可完成任务，格式：[11,物品id]"}, {id:12, label:"点绛唇摇香唇", desc:"根据摇到的香唇数量来完成任务，逆天改运获得的香唇，也算"}, {id:13, label:"击杀仇人", desc:"击杀与自己等级相差5级范围的仇人，可完成任务；同一名仇人只能计1次击杀"}, {id:14, label:"完成讨伐任务", desc:"每日完成讨伐任务的数量达到多少，即可完成任务；吞噬的讨伐任务只算1个；"}, {id:15, label:"在帮旗争夺战的当天，出现该任务；", desc:"完成方式同击杀BOSS的判断：打掉20%的血或最后1刀，若帮旗死了算完成，帮旗不死就不能完成"}, {id:16, label:"获得物品\t", desc:"指定通过打怪、购买获得某种物品，并达到一定数量，即可完成任务，格式：[16,物品id，物品数量]"}, {id:17, label:"地宫寻宝任务完成", desc:"在地宫寻宝中，触发任务并完成，完成的数量根据配置"}, {id:18, label:"摘取神树果子", desc:"摘取其他玩家的神树果子，根据摘取的数量来完成任务"}, {id:19, label:"采集类", desc:"按照任务要求，在某张地图采集某种物品，即可完成任务"}, {id:20, label:"组队完成副本{x}次", desc:"在组队情况下，通关多人副本即可完成任务"}, {id:21, label:"获得真气", desc:"通过各种方式获得真气数量达到多少，即可完成"}, {id:23, label:"坐骑升级", desc:"通过各种方式获得真气数量达到多少，即可完成"}, {id:24, label:"合成道具", desc:"通过各种方式获得真气数量达到多少，即可完成"}, {id:27, label:"击杀任意BOSS", desc:"击杀任意BOSS"}, {id:28, label:"穿上指定套装", desc:"穿上指定套装"}, {id:31, label:"幸运追12极品武器+9", desc:"穿上指定套装"}];
        private static const job1:Array = [60000, 60001, 60002];
        private static const job2:Array = [60000, 60001, 60003];
        private static const job3:Array = [60000, 60001, 60004];
        private static const job4:Array = [61000, 61001, 61002];
        private static const job5:Array = [61000, 61001, 61002];
        private static const job6:Array = [61000, 61001, 61002];
        private static const job7:Array = [62000, 62001, 62002];
        private static const job8:Array = [62000, 62001, 62002];
        private static const job9:Array = [62000, 62001, 62002];
        public static const CHANGE_JOB_LEVEL1:Array = [60000, 60001, 60002, 60003, 60004];
        public static const CHANGE_JOB_LEVEL2:Array = [61000, 61001, 61002];
        public static const CHANGE_JOB_LEVEL3:Array = [62000, 62001, 62002, 62003, 62004, 62005];
        public static const CHANGE_JOB_LEVEL4:Array = [63000, 63001];
        public static const CHANGE_JOB_TASK_TOTAL:Array = [60000, 60001, 60002, 60003, 60004, 61000, 61001, 61002, 62000, 62001, 62002, 62003, 62004, 62005, 63000, 63001];
        public static const CHANGE_JOB_TASK:Array = [job1, job2, job3, job4, job5, job6, job7, job8, job9];
        public static const DAILY_TASK_MAX_RANGE:uint = 10;
        public static var AUTO_FIND_PATH_CD:Number = 20;
        public static var AUTO_CLICK_TASK_OK_CD:Number = 10;
        public static var AUTO_EQUIP_AWARD_OK:Number = 10;
        public static var AUTO_ITEM_AWARD_OK:Number = 10;
        public static var AUTO_SKILL_AWARD_OK:Number = 10;
        public static var AUTO_GUIDE_CLICK:Number = 0.1;
        public static var AUTO_VIP_GUIDE_CLICK:Number = 30;
        public static const TEST_MODEL:Boolean = false;

        public function TaskGlobal()
        {
            return;
        }// end function

        public static function get task_mode() : Boolean
        {
            return _task_mode;
        }// end function

        public static function set task_mode(param1:Boolean) : void
        {
            _task_mode = param1;
            return;
        }// end function

        public static function set autoTask(param1:Boolean) : void
        {
            Player.state = param1 ? (State.AUTO_ROAD) : (State.NONE);
            task_mode = param1;
            return;
        }// end function

        public static function get autoTask() : Boolean
        {
            return Player.state == State.AUTO_ROAD;
        }// end function

    }
}
