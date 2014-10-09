package com.staticdata
{
    import com.f1.*;
    import flash.filters.*;
    import flash.text.*;

    public class Params extends Object
    {
        public static var rechargePage:String;
        public static var officialWebSite:String;
        public static var officialRechargeWebSite:String;
        public static var getCardWebSite:String = "";
        public static var hasEnterMap:Boolean;
        public static var GUEST_REG_LEVEL:uint = 10;
        public static const TWO_PET_SKILL_ID:int = 11301;
        public static var MONSTER_RUN_ACT_DEFAULT_TIME:uint = 200;
        public static var PLAYER_RUN_ACT_DEFAULT_TIME:uint = 220;
        public static var PUBLIC_CD_MIN:uint = 300;
        public static var EXP_VIP_GUIDE_TASK:Array;
        public static const REG_OK:String = "REG_OK";
        public static const LOGIN_REG:String = "LOGIN_REG";
        public static const LOGIN_OK:String = "LOGIN_OK";
        public static const GREEN_COLOR_STR:String = "#1eff00";
        public static const RED_COLOR_STR:String = "#ff0000";
        public static const YELLOW_COLOR_STR:String = "#FFCC00";
        public static const ORANGE_COLOR_STR:String = "#ed9415";
        public static const BLUE_COLOR_STR:String = "#188ffe";
        public static const TEXT_SELECTED_COLOR_STR:String = "#00fffc";
        public static const GOLD_TXT_COLOR:uint = 16776985;
        public static const COIN_TXT_COLOR:uint = 15576374;
        public static const SOUL_DIMAOND:int = 600002;
        public static const MONEY1_NAME:String = "黄金";
        public static var MONEY2_NAME:String = LanguageCfgObj.getInstance().getByIndex("10049");
        public static const PRESTIGE_NAME:String = "名望";
        public static const SKILLPOINT_NAME:String = "修为";
        public static const SHOT_EXP_NAME:String = "射戟经验";
        public static const SKILLPOWER_NAME:String = "技力";
        public static const EP_NAME:String = "法力";
        public static const CP_NAME:String = "气势";
        public static const GUILD_NAME:String = "军团";
        public static const GUILD_CHAIRMAN_NAME:String = "主帅";
        public static const GUILD_DEPUTY_NAME:String = "副帅";
        public static const GUILD_ELDER_NAME:String = "校尉";
        public static const GOD_BLESS_BUF_NAME:String = "财神祝福";
        public static const DONATION_BUF_NAME:String = "经验加成";
        public static const EXPLOIT_JADE_NAME:String = "功勋玉牌";
        public static var GAME_NAME:String = LanguageCfgObj.getInstance().getByIndex("10050");
        public static const SCENE_ENTER_PRAC:String = "SCENE_ENTER_PRAC";
        public static const SCENE_OUT_PRAC:String = "SCENE_OUT_PRAC";
        public static const SCENE_LOGIN:String = "SCENE_LOGIN";
        public static const SCENE_LOGOUT:String = "SCENE_LOGOUT";
        public static const PAS_SKILL_ICON:String = "res/passkill/";
        public static const CHAT_CHANNEL_ALL:uint = 99;
        public static const TEXT_TYPE_NICK:String = "nick";
        public static const TEXT_TYPE_EQUIP:String = "equip";
        public static const TEXT_TYPE_ITEM:String = "item";
        public static const TEXT_TYPE_SPIRIT:String = "spirit";
        public static var loginBinURL:String = "login.bin";
        public static var registSceneSwfURL:String = "res/regist_scene.swf";
        public static const BIG_MAP_NPC:String = "big_map_npc";
        public static const BIG_MAP_TRANSFOR:String = "big_map_transfor";
        public static const BIG_MAP_RECT_MONSTER:String = "big_map_rec_monster";
        public static const BIG_MAP_BOSS:String = "big_map_boss";
        public static const BIG_MAP_TEAMMATE:String = "big_map_otherplayer";
        public static const BIG_MAP_CREAM:String = "big_map_cream";
        public static const ARENA_PAY_CD_COST:uint = 7;
        public static const BLUE_DIAMOND_ICON:String = "res/icon/blue_diamond_level.png";
        public static const YELLOW_DIAMOND_ICON:String = "res/icon/yellow_diamond_level.png";
        public static const BLUE_YEAR_ICON:String = "res/icon/blue_year.png";
        public static const YELLOW_YEAR_ICON:String = "res/icon/yellow_year.png";
        public static const STAR_ICON:String = "res/icon/star_icon.png";
        public static const CFG_BUFF_REMAIN:String = "remain";
        public static const CFG_BUFF_PERCENT:String = "percent";
        public static const RES_MANAGER:String = "RES_MANAGER";
        public static const btnYellowFilter:Array = [new GlowFilter(16776960, 1, 2, 2, 10, 3)];
        public static const FONT_TAHOMA:String = "Tahoma";
        public static const FONT1:String = "宋体";
        public static const FONT2:String = "微软雅黑";
        public static const FONT3:String = "Matura MT Script Capitals";
        public static const FONT1_FORMAT:TextFormat = new TextFormat(FONT1, 14, 16777215);
        public static const FONT2_FORMAT:TextFormat = new TextFormat(FONT2, 14, 16777215);
        public static const FONT3_FORMAT:TextFormat = new TextFormat(FONT2, 14, 14540253, null, null, null, null, null, "center");
        public static var URL_GOLD:String;
        public static const ART_PATH:String = "art/res/";
        public static const DEFAULT_ROLE_PIC:String = "default_role_pic";
        public static const ITEM_PATH:String = ART_PATH + "item/";
        public static const OTHER_PATH:String = ART_PATH + "other/";
        public static const SPIRIT_PATH:String = ART_PATH + "spirit/";
        public static const BINGZHEN_PATH:String = ART_PATH + "bingzhen/";
        public static const ROLE_PATH:String = ART_PATH + "role/";
        public static const ROLE_RES_PATH:String = ROLE_PATH + "gen/";
        public static const ROLE_ICON_PATH:String = ROLE_PATH + "icon/";
        public static const ROLE_HEAD_PATH:String = ROLE_PATH + "head/";
        public static const ROLE_HEAD_PANEL_PATH:String = ROLE_PATH + "panelhead/";
        public static const ROLE_STAND_PATH:String = ROLE_PATH + "standPic/";
        public static const ROLE_BIG_HEAD_PATH:String = ROLE_PATH + "bighead/";
        public static const ROLE_SQ_HEAD_PATH:String = ROLE_PATH + "sqhead/";
        public static const BUFF_PATH:String = ART_PATH + "buff/";
        public static const BUFF_ICON_PATH:String = BUFF_PATH + "icon/";
        public static const ZONES_LEVEL_PATH:String = ART_PATH + "zones/";
        public static const ICON_PATH:String = "res/icon/";
        public static const SKILL_PATH:String = ART_PATH + "skill/";
        public static const SKILL_ICON_PATH:String = SKILL_PATH + "icon/";
        public static const GEM_ICON_PATH:String = ICON_PATH + "gem/";
        public static const NPC_HEAD_ICON_PATH:String = "res/";
        public static const MAP_PATH:String = ART_PATH + "map/";
        public static const MAP_MAPRES_PATH:String = ART_PATH + "map/mapres/";
        public static const BOOK_PATH:String = ART_PATH + "book/";
        public static const Equipment_PATH:String = ART_PATH + "equipment/";
        public static const MOVIE_PATH:String = ART_PATH + "movie/";
        public static const ROLE_EQUIP_PATH:String = Equipment_PATH + "role/";
        public static const WEAPON_PATH:String = ART_PATH + "weapon/gen/";
        public static const WING_PATH:String = ART_PATH + "wing/";
        public static const HORSE_PATH:String = ART_PATH + "horse/gen/";
        public static const MAGICBOOK_PATH:String = ROLE_RES_PATH;
        public static const DROP_PATH:String = ART_PATH + "item/drop/";
        public static const SOUND_RES_PATH:String = "res/sound/";
        public static const DEFAULT_ROLE_RES:String = ROLE_PATH + "h000101.png";
        public static const DEFAULT_ROLE_HEAD:String = ROLE_HEAD_PATH + "h0001.png";
        public static const DEFAULT_ROLE_BIG_HEAD:String = ROLE_BIG_HEAD_PATH + "p10001.png";
        public static const DEFAULT_ROLE_ICON:String = ROLE_ICON_PATH + "p10001.png";
        public static const DEFAULT_BUFF_RES:String = BUFF_PATH + "b0002.png";
        public static const DEFAULT_SKILL_RES:String = SKILL_PATH + "j0001.png";
        public static const DEFAULT_SPIRIT_RES:String = SPIRIT_PATH + "p0004.png";
        public static const DEFENCE_PARTY:uint = 1;
        public static const ATTACK_PARTY:uint = 2;
        public static const OPERATION_MOVE:uint = 0;
        public static const OPERATION_ATK:uint = 1;
        public static const ACTION_SIMPLE_ATTACK_ID:String = "act05";
        public static const ACTION_TWO_HAND_SIMPLE_ATTACK_ID:String = "act06";
        public static const ACTION_STAND_ID:String = "act01";
        public static const ACTION_TWO_HAND_STAND_ID:String = "act02";
        public static const ACTION_RIDING_STAND_ID:String = "act12";
        public static const ACTION_SIMPLE_HURT_ID:String = "act07";
        public static const ACTION_HAND_ID:String = "act02";
        public static const ACTION_RUN:String = "act03";
        public static const ACTION_TWO_HAND_RUN:String = "act04";
        public static const ACTION_RIDING_RUN:String = "act13";
        public static const ACTION_DEAD:String = "act11";
        public static const ACTION_FLY:String = "act20";
        public static const ACTION_KICK_FLY:String = "act08";
        public static const ACTION_WING_STAND:String = "act14";
        public static const ACTION_WING_RUN:String = "act16";
        public static const ACTION_SIMPLE_RIDE_STAND:String = "act21";
        public static const ACTION_SIMPLE_RIDE_RUN:String = "act22";
        public static const ACTION_NON_ATTACK:Array = [ACTION_STAND_ID, ACTION_TWO_HAND_STAND_ID, ACTION_RIDING_STAND_ID, ACTION_SIMPLE_HURT_ID, ACTION_HAND_ID, ACTION_RUN, ACTION_TWO_HAND_RUN, ACTION_RIDING_RUN, ACTION_DEAD, ACTION_KICK_FLY, ACTION_WING_STAND, ACTION_WING_RUN];
        public static const CUTE_PET_NORMAL:uint = 1;
        public static const CUTE_PET_FOLLOW:uint = 2;
        public static const CUTE_PET_MOVE_TO_DROP:uint = 3;
        public static const CELL_NORMAL:int = 1;
        public static const CELL_OPENNING:int = 2;
        public static const CELL_OPENED:int = 3;
        public static const CELL_LOCKED:int = 4;
        public static const LEFT_WEAPON:int = 1;
        public static const RIGHT_WEAPON:int = 2;
        public static const HEAD:int = 4;
        public static const BODY:int = 3;
        public static const LEG:int = 7;
        public static const HAND:int = 6;
        public static const SHOE:int = 8;
        public static const NICKLACE:int = 5;
        public static const RING1:int = 9;
        public static const RING2:int = 10;
        public static const RIDE:int = 13;
        public static const PET:int = 11;
        public static const WING:int = 12;
        public static const SHOW:int = 13;
        public static const SHOW_2:int = 14;
        public static const VIP_BUFFID:int = 1151;
        public static const RELEASE_FRONTRES:String = "releaseFrontRes";
        public static const RELEASE_BACKRES:String = "releaseBackRes";
        public static const FLY_FRONTRES:String = "flyFrontRes";
        public static const FLY_BACKRES:String = "flyBackRes";
        public static const MAIN_HIT_FRONTRES:String = "mainHitFrontRes";
        public static const MAIN_HIT_BACKRES:String = "mainHitBackRes";
        public static const SINGLE_HIT_FRONTRES:String = "singleHitFrontRes";
        public static const SINGLE_HIT_BACKRES:String = "singleHitBackRes";
        public static const FIGHT_TYPE_PVE:uint = 1;
        public static const FIGHT_TYPE_PVP:uint = 2;
        public static const FIGHT_FROM_COPY:uint = 1;
        public static const FIGHT_FROM_ROOM:uint = 2;
        public static const FIGHT_FROM_HUNDRED:uint = 3;
        public static const COUNTRY_MAP_ID:int = 300010;
        public static const BOMP_SKILL_ID:int = 10173;
        public static const OPEN:int = 0;
        public static const LOCKED:int = 1;
        public static const UNLOCKING:int = 2;
        public static const UNOPEN:int = 3;
        public static const MAX_TRY:uint = 5000;
        public static var IP:String = "10.6.100.40";
        public static var PORT:uint = 9001;
        public static var SPORT:uint = 9002;
        public static var zoneid:uint = 9;
        public static var zoneIdStr:String;
        public static var loginTime:uint;
        public static const ITEM_PLACE_TRANSCATION:String = "item_place_transcation";
        public static const ITEM_PLACE_ROLEPANEL:String = "item_place_rolepanel";
        public static const ITEM_PLACE_BACKPACK:String = "item_place_backpack";
        public static const ITEM_PLACE_STORE:String = "item_place_store";
        public static const ITEM_ELEMENT_HEART:String = "item_element_heart";
        public static const ITEM_PLACE_SHORTCUT_AREA:String = "item_place_shortcut_area";
        public static const CAN_GET_NUM_MC_NAME:String = "CAN_GET_NUM_MC_NAME";
        public static const rqstMsgClassMap:Object = {App20:"vmsg::*", App8:"vmsg::CSClientVConndMsg", App23:"vmsg::VCli2ActSvrMsg", App11:"vmsg::VCli2PaySvrMsg"};
        public static const rspMsgClassMap:Object = {App20:"vmsg::*", App8:"vmsg::CSVConndClientMsg", App23:"vmsg::VActSvr2CliMsg", App11:"vmsg::VPaySvr2CliMsg"};
        public static const ATK_IDX:uint = 0;
        public static const DEF_IDX:uint = 1;
        public static var openid:String = "";
        public static var openkey:String = "openkey";
        public static var pf:String = "qzone";
        public static var adulturl:String = "";
        public static var isPlatform:Boolean = false;
        public static var pfMD5Key:String;
        public static const pfOpenKey:String = "4b4f3d3c35d222891a9134776d2b483e";
        public static const smsOpenKey:String = "5fce53(a0dbbT0b82c79a73&90d662f0";
        public static const activityCode:String = "475c3c3dbdeaa7c4a009b81133c26bc3";
        public static const serverOpenKey:String = "test37wankey5weufo580toUYUIksadhu";
        public static var opengm:Boolean;
        public static var needPlatReg:Boolean;
        public static var username:String = "";
        public static var isadult:String = "1";
        public static var serverid:String = "1";
        public static var serverOuterId:String = "S1";
        public static var time:String = "";
        public static var loginType:String = "1";
        public static var autoLogin:Boolean;
        public static var autoFight:Boolean;
        public static var pvType:String = "1";
        public static var pvPage:String = "";
        public static var wdType:String = "1";
        public static var wdUrl:String = "";
        public static var gameCode:String = "tszj";
        public static var corpCode:String = "37wan";
        public static const PF_37:String = "37wan";
        public static const PF_1360:String = "1360";
        public static const PF_BAIDU:String = "baidu";
        public static const PF_DUOWAN:String = "duowan";
        public static const PF_KUGOU:String = "kugou";
        public static const PF_XUNLEI:String = "xunlei";
        public static var appid:int = 100670976;
        public static var pfActSvrIp:String = "";
        public static var pfActSvrPort:int = 0;
        public static var login_bin_path:String = "res/config/login.bin";
        public static var files_XML_path:String = "files.bin";
        public static var pfkey:String = "";
        public static var task_market_source:String = "";
        public static var task_market_contract_id:String = "";
        public static var task_market_custom_id:String = "";
        public static var via:String = "";
        public static var invitorOpenID:String = "";
        public static var facebookUserId:String;
        public static var facebookUserName:String;
        public static var clickStreamOn:Boolean = true;
        public static const SEE_RECORD_HUIHE_SUDO:uint = 6;
        public static const SEE_RECORD_HUIHE_DUEL:uint = 4;
        public static const SEE_RECORD_HUIHE_DEBATE:uint = 4;
        public static const AUTO_ON_HORSE_RANGE:uint = 56;
        public static const DROP_PICK_SMALL_RANGE:uint = 125;
        public static const DROP_PICK_BIG_RANGE:uint = 800;
        public static const CUTE_PET_WALK_MAX_RANGE:uint = 900;
        public static const DROP_CUTE_PET_PICK_LIMIT:uint = 5;
        public static const PICK_LIST_WITH_BAG_FULL:Array = [700034, 700035, 700036];
        public static const CLIENT_ZONES_SKE_KING_ID:uint = 300008;
        public static const CLIENT_ZONES_DRAGON_KING:uint = 300009;
        public static const SKY_CITY_MAP:uint = 100015;
        public static const BOSS_HOME_CITY_MAP:uint = 100023;
        public static const MAINLAND_MAP_ID:uint = 100001;
        public static const ICE_WIND_MAP_ID:uint = 100002;
        public static const UNDER_CITY_1_MAP_ID:uint = 100003;
        public static const UNDER_CITY_2_MAP_ID:uint = 100004;
        public static const XS_ZONE_MAP_ID:uint = 400001;
        public static const VIP_EXP_ITEM_ID:uint = 700069;
        public static const FIRST_MAIN_TASK_ID:uint = 10000;
        public static const CHANGE_JOB_OPEN_TASK_ID:uint = 100044;
        public static const CHANGE_JOB_OPEN_LEVEL:uint = 150;
        public static const COUNTRY_OPEN_TASK_ID:uint = 100045;
        public static const COUNTRY_OPEN_LEVEL:uint = 100;
        public static const COUNTRY_NPC:uint = 310002;
        public static const MASTER_CHANGE_LEVEL:uint = 400;
        public static const ROLE_MAX_LEVEL:uint = 400;
        public static const BANK_BUY_MAX_LEVEL:uint = 250;
        public static const ISLAND_COPY_ID:uint = 9001;

        public function Params()
        {
            return;
        }// end function

        public static function pf1360() : Boolean
        {
            return pf == PF_1360;
        }// end function

        public static function pfYellow() : Boolean
        {
            return pf == "pengyou" || pf == "qzone";
        }// end function

        public static function pfTencent() : Boolean
        {
            return pf == "pengyou" || pf == "qzone" || pf == "3366" || pf == "qqgame" || pf == "tapp";
        }// end function

        public static function get isFacebookUser() : Boolean
        {
            return facebookUserId != null;
        }// end function

        public static function getNationName(param1:uint) : String
        {
            return "<font color=\'#FFFFFF\'>[群雄]</font>";
        }// end function

        public static function getGoldPrice(param1:int) : int
        {
            return param1;
        }// end function

        private static function getHzDiscountPrice(param1:int) : int
        {
            return param1;
        }// end function

        public static function getGoldBuyPrice(param1:int) : int
        {
            return param1;
        }// end function

        public static function updateConfig(param1:Object, param2:Array) : void
        {
            return;
        }// end function

    }
}
