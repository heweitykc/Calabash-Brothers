package com.game.guide.model
{
    import __AS3__.vec.*;
    import com.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.game.guide.control.*;
    import com.game.guide.event.*;
    import com.game.task.model.*;
    import com.game.task.protocol.*;
    import com.model.*;
    import flash.utils.*;

    public class GuideConfigObj extends BaseEventDispatcher
    {
        private var _guideConfig:Vector.<int>;
        private var sender:GuideProtocol;
        public var isRolePointActiveing:Boolean = false;
        public var isInitComplete:Boolean;
        private var GUIDE_MAP:Dictionary;
        public const TASK_BTN_GUIDE_ID:String = "1001_2";
        public const FAST_TASK_BTN_GUIDE_ID:String = "1001_1";
        public const GEN_TASK_GUIDE_ID_1:String = "1002_1";
        public const GEN_TASK_GUIDE_ID_2:String = "1002_2";
        public const HORSE_UP_GUIDE_ID_1:String = "2002_1";
        public const HORSE_UP_GUIDE_ID_2:String = "2002_2";
        public const HORSE_UP_GUIDE_ID_3:String = "2002_3";
        public const PRAY_GUIDE_ID_1:String = "2005_1";
        public const PRAY_GUIDE_ID_2:String = "2005_2";
        public const PRAY_GUIDE_ID_3:String = "2005_3";
        public const ROLE_POINT_GUIDE_ID_1:String = "2004_1";
        public const ROLE_POINT_GUIDE_ID_2:String = "2004_2";
        public const ROLE_POINT_GUIDE_ID_3:String = "2004_3";
        public const ROLE_POINT_GUIDE_ID_4:String = "2004_4";
        public const SIGN_WAGE_GUIDE_ID_1:String = "2006_1";
        public const SIGN_WAGE_GUIDE_ID_2:String = "2006_2";
        public const SIGN_WAGE_GUIDE_ID_3:String = "2006_3";
        public const XSCB_ZONE_GUIDE_ID_1:String = "2007_1";
        public const XSCB_ZONE_GUIDE_ID_2:String = "2007_2";
        public const FIRST_GET_WEAPOEN_GUIDE_ID:String = "2008_1";
        public const DEKARON_ZONE_GUIDE_ID_1:String = "2009_1";
        public const DEKARON_ZONE_GUIDE_ID_2:String = "2009_2";
        public const ROLE_POINT_SY_GUIDE_ID_1:String = "3001_1";
        public const ROLE_POINT_SY_GUIDE_ID_2:String = "3001_2";
        public const TASK_ITEM_AWARD_GUIDE_ID_1:String = "3002_1";
        public const SIGN_WAGE_AWARD_SY_GUIDE_ID_1:String = "3003_1";
        public const FIRST_SKILL_GUIDE_ID_1:String = "2011_1";
        public const COMPOSE_TICKET_GUIDE_ID_1:String = "2012_1";
        public const COMPOSE_TICKET_GUIDE_ID_2:String = "2012_2";
        public const COMPOSE_TICKET_GUIDE_ID_3:String = "2012_3";
        public const COMPOSE_XS_DRESS_GUIDE_ID_2:String = "2013_1";
        public const COMPOSE_XS_DRESS_GUIDE_ID_3:String = "2013_2";
        public const ICE_WIND_TRANSFOR_GUIDE_ID_1:String = "2014_1";
        public const FIRST_OPEN_BELIA_WORLD_1:String = "3010_1";
        public const FIRST_END_BELIA_WORLD_1:String = "3011_1";
        public const FIRST_OPEN_XS_1:String = "3012_1";
        public const FIRST_END_XS_1:String = "3013_1";
        public const FIRST_BEGIN_BELIA_WORLD_1:String = "3014_1";
        public const FIRST_BEGIN_XS_1:String = "3015_1";
        public const ZHU_ZAO_ACTIVE_TEAM_1:String = "3005_1";
        public const ZHU_ZAO_ACTIVE_TEAM_2:String = "3005_2";
        public const FIRST_COMPLETE_TASK_1:String = "3017_1";
        public const FIRST_COMPLETE_TASK_2:String = "3017_2";
        public const FIRST_COMPLETE_TASK_3:String = "3017_3";
        public const ARTIFACT_ACTIVE_TEAM_1:String = "3018_1";
        public const BOSS_HOME_1:String = "3021_1";
        public const MASTER_SKILL_TEM_1:String = "1407755998_1";
        public const TASK_GUIDE_TEAM:String = "1001";
        public const GEN_TASK_GUIDE_TEAM:String = "1002";
        public const HORSE_ACTIVE_TEAM:String = "2001";
        public const HORSE_UP_ACTIVE_TEAM:String = "2002";
        public const GUILD_ACTIVE_TEAM:String = "2003";
        public const ROLE_POINT_ACTIVE_TEAM:String = "2004";
        public const PRAY_ACTIVE_TEAM:String = "2005";
        public const SIGN_WAGE_TEAM:String = "2006";
        public const XSCB_ZONE_TEAM:String = "2007";
        public const FIRST_GET_WEAPOEN_TEAM:String = "2008";
        public const DEKARON_ZONE_TEAM:String = "2009";
        public const BELIA_WORLD_ZONE_TEAM:String = "2010";
        public const FIRST_SKILL_TEAM:String = "2011";
        public const COMPOSE_TICKET_TEAM:String = "2012";
        public const COMPOSE_XS_DRESS_TEAM:String = "2013";
        public const ICE_WIND_TRANSFOR_TEAM:String = "2014";
        public const ROLE_POINT_SY_TEAM:String = "3001";
        public const TASK_ITEM_AWARD_TEAM:String = "3002";
        public const SIGN_WAGE_AWARD_SY_TEAM:String = "3003";
        public const DESKTOP_ACTIVE_TEAM:String = "3004";
        public const ZHU_ZAO_ACTIVE_TEAM:String = "3005";
        public const DAILY_TASK_ACTIVE_TEAM:String = "3006";
        public const BOSSGUILD_ACTIVE_TEAM:String = "3007";
        public const COUNTRY_ACTIVE_TEAM:String = "3008";
        public const GOLD_RAFFLE_ACTIVE_TEAM:String = "3009";
        public const FIRST_OPEN_BELIA_WORLD:String = "3010";
        public const FIRST_END_BELIA_WORLD:String = "3011";
        public const FIRST_OPEN_XS:String = "3012";
        public const FIRST_END_XS:String = "3013";
        public const FIRST_BEGIN_BELIA_WORLD:String = "3014";
        public const FIRST_BEGIN_XS:String = "3015";
        public const FIRST_DAILY_TASK:String = "3016";
        public const FIRST_COMPLETE_TASK:String = "3017";
        public const ARTIFACT_ACTIVE_TEAM:String = "3018";
        public const CHANGE_JOB_TEAM:String = "4001";
        public const TASK_TARGET_TEAM:String = "100";
        public const ACTIVE_GUIDE_ALL_CONFIG_TEAM:String = "101";
        public const SUIT_OPT_TEAM:String = "3019";
        public const BOSS_HOME:String = "3021";
        public const MASTER_SKILL_TEM:String = "1407755998";
        private static var _instance:GuideConfigObj;

        public function GuideConfigObj()
        {
            this.initGuideMap();
            this.sender = new GuideProtocol();
            ActiveGuideControl.getInstance();
            return;
        }// end function

        public function initGuideConfig(param1:Vector.<int>) : void
        {
            this._guideConfig = param1;
            this.isInitComplete = true;
            this.fixTaskConfig();
            this.fixLevelConfig();
            dispatchEvt(new GuideEvent(GuideEvent.GUIDE_ACTIVE_CONFIG_COMPLETE, null));
            return;
        }// end function

        public function get guideConfigInited() : Boolean
        {
            return this._guideConfig != null;
        }// end function

        public function fixTaskConfig() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            if (this.isInitComplete && TaskModel.getInstance().mainTaskList && TaskModel.getInstance().mainTaskList.length)
            {
                _loc_1 = 0;
                _loc_2 = TaskModel.getInstance().mainTaskList.length;
                while (_loc_1 < _loc_2)
                {
                    
                    ActiveGuideControl.getInstance().open(TaskModel.getInstance().mainTaskList[_loc_1].taskId);
                    _loc_1++;
                }
            }
            return;
        }// end function

        private function fixLevelConfig() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = UserObj.getInstance().playerInfo.level;
            var _loc_4:* = TaskCfgObj.getInstance().getActiveConfigByLevelArray(_loc_3);
            while (_loc_2 <= _loc_4.length)
            {
                
                if (_loc_4[_loc_2])
                {
                    ActiveGuideControl.getInstance().openByLv(_loc_4[_loc_2].q_level);
                }
                _loc_2++;
            }
            return;
        }// end function

        public function getGuideConfig(param1:int) : int
        {
            if (!this.GUIDE_MAP)
            {
                return 0;
            }
            var _loc_2:* = this.GUIDE_MAP[param1.toString()];
            if (_loc_2 != 0 && this._guideConfig && (this._guideConfig.length - 1) >= _loc_2 && this._guideConfig[_loc_2])
            {
                return this._guideConfig[_loc_2];
            }
            return 0;
        }// end function

        public function isOpenFunction(param1:String, param2:String = null) : Boolean
        {
            if (this.getGuideConfig(int(param1)) == 0)
            {
                Global.popManager.addedToMouseCue(param2 ? (param2) : (LanguageCfgObj.getInstance().getByIndex("10724")));
                return false;
            }
            return true;
        }// end function

        public function saveConfigByTeam(param1:int, param2:int) : void
        {
            if (!this._guideConfig)
            {
                return;
            }
            var _loc_3:* = this._guideConfig.length;
            var _loc_4:* = this.GUIDE_MAP[param1] + 1;
            while (_loc_3 < _loc_4)
            {
                
                this._guideConfig.push(0);
                _loc_3++;
            }
            this._guideConfig[this.GUIDE_MAP[param1]] = param2;
            if (param2 != 0)
            {
            }
            this.sender.saveGuideConfig(this._guideConfig);
            return;
        }// end function

        private function initGuideMap() : void
        {
            this.GUIDE_MAP = new Dictionary();
            this.GUIDE_MAP[this.TASK_GUIDE_TEAM] = 1;
            this.GUIDE_MAP[this.HORSE_ACTIVE_TEAM] = 2;
            this.GUIDE_MAP[this.HORSE_UP_ACTIVE_TEAM] = 3;
            this.GUIDE_MAP[this.GUILD_ACTIVE_TEAM] = 4;
            this.GUIDE_MAP[this.ROLE_POINT_ACTIVE_TEAM] = 5;
            this.GUIDE_MAP[this.PRAY_ACTIVE_TEAM] = 6;
            this.GUIDE_MAP[this.SIGN_WAGE_TEAM] = 7;
            this.GUIDE_MAP[this.XSCB_ZONE_TEAM] = 8;
            this.GUIDE_MAP[this.FIRST_GET_WEAPOEN_TEAM] = 9;
            this.GUIDE_MAP[this.DEKARON_ZONE_TEAM] = 10;
            this.GUIDE_MAP[this.BELIA_WORLD_ZONE_TEAM] = 11;
            this.GUIDE_MAP[this.GEN_TASK_GUIDE_TEAM] = 12;
            this.GUIDE_MAP[this.FIRST_SKILL_TEAM] = 13;
            this.GUIDE_MAP[this.DESKTOP_ACTIVE_TEAM] = 14;
            this.GUIDE_MAP[this.CHANGE_JOB_TEAM] = 15;
            this.GUIDE_MAP[this.TASK_TARGET_TEAM] = 16;
            this.GUIDE_MAP[this.ZHU_ZAO_ACTIVE_TEAM] = 17;
            this.GUIDE_MAP[this.ACTIVE_GUIDE_ALL_CONFIG_TEAM] = 18;
            this.GUIDE_MAP[this.DAILY_TASK_ACTIVE_TEAM] = 19;
            this.GUIDE_MAP[this.BOSSGUILD_ACTIVE_TEAM] = 20;
            this.GUIDE_MAP[this.COUNTRY_ACTIVE_TEAM] = 21;
            this.GUIDE_MAP[this.GOLD_RAFFLE_ACTIVE_TEAM] = 22;
            this.GUIDE_MAP[this.FIRST_OPEN_BELIA_WORLD] = 23;
            this.GUIDE_MAP[this.FIRST_END_BELIA_WORLD] = 24;
            this.GUIDE_MAP[this.FIRST_OPEN_XS] = 25;
            this.GUIDE_MAP[this.FIRST_END_XS] = 26;
            this.GUIDE_MAP[this.FIRST_BEGIN_BELIA_WORLD] = 27;
            this.GUIDE_MAP[this.FIRST_BEGIN_XS] = 28;
            this.GUIDE_MAP[this.FIRST_DAILY_TASK] = 29;
            this.GUIDE_MAP[this.FIRST_COMPLETE_TASK] = 30;
            this.GUIDE_MAP[this.ARTIFACT_ACTIVE_TEAM] = 31;
            this.GUIDE_MAP[this.SUIT_OPT_TEAM] = 32;
            this.GUIDE_MAP[this.BOSS_HOME] = 33;
            return;
        }// end function

        public static function getInstance() : GuideConfigObj
        {
            var _loc_1:* = new GuideConfigObj;
            _instance = new GuideConfigObj;
            return _instance || _loc_1;
        }// end function

    }
}
