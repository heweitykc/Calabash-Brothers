package com.staticdata
{
    import com.f1.*;

    public class ChatType extends Object
    {
        public static const CHATTYPE_ALL:int = -1;
        public static const CHATTYPE_WORLD:int = 0;
        public static const CHATTYPE_SCENE:int = 1;
        public static const CHATTYPE_ROLE:int = 2;
        public static const CHATTYPE_TEAM:int = 3;
        public static const CHATTYPE_GROUP:int = 4;
        public static const CHATTYPE_HORN:int = 5;
        public static const CHATTYPE_SYSTEM:int = 6;
        public static const CHATTYPE_GM:int = 7;
        public static const CHATTYPE_TRANSACTION:int = 8;
        public static const COLOR_WORLD:uint = 16748800;
        public static const COLOR_SCENE:uint = 16777215;
        public static const COLOR_ROLE:uint = 10551551;
        public static const COLOR_TEAM:uint = 49407;
        public static const COLOR_GROUP:uint = 2031360;
        public static const COLOR_HORN:uint = 16711901;
        public static const COLOR_SYSTEM:uint = 16578048;
        public static const COLOR_TRANSACTION:uint = 16766079;
        public static var WORLD:String = LanguageCfgObj.getInstance().getByIndex("10041");
        public static var SCENE:String = LanguageCfgObj.getInstance().getByIndex("10042");
        public static var ROLE:String = LanguageCfgObj.getInstance().getByIndex("10043");
        public static var TEAM:String = LanguageCfgObj.getInstance().getByIndex("10044");
        public static var GROUP:String = LanguageCfgObj.getInstance().getByIndex("10045");
        public static var LABA:String = LanguageCfgObj.getInstance().getByIndex("10046");
        public static var SYSTEM:String = LanguageCfgObj.getInstance().getByIndex("10047");
        public static const GM:String = "GM";

        public function ChatType()
        {
            return;
        }// end function

        public static function getColor(param1:int) : uint
        {
            switch(param1)
            {
                case CHATTYPE_WORLD:
                {
                    return COLOR_WORLD;
                }
                case CHATTYPE_SCENE:
                {
                    return COLOR_SCENE;
                }
                case CHATTYPE_ROLE:
                {
                    return COLOR_ROLE;
                }
                case CHATTYPE_TEAM:
                {
                    return COLOR_TEAM;
                }
                case CHATTYPE_GROUP:
                {
                    return COLOR_GROUP;
                }
                case CHATTYPE_HORN:
                {
                    return COLOR_HORN;
                }
                case CHATTYPE_SYSTEM:
                {
                    return COLOR_SYSTEM;
                }
                default:
                {
                    break;
                }
            }
            return 0;
        }// end function

        public static function getLabel(param1:int) : String
        {
            switch(param1)
            {
                case CHATTYPE_WORLD:
                {
                    return WORLD;
                }
                case CHATTYPE_SCENE:
                {
                    return SCENE;
                }
                case CHATTYPE_ROLE:
                {
                    return ROLE;
                }
                case CHATTYPE_TEAM:
                {
                    return TEAM;
                }
                case CHATTYPE_GROUP:
                {
                    return GROUP;
                }
                case CHATTYPE_HORN:
                {
                    return LABA;
                }
                case CHATTYPE_SYSTEM:
                {
                    return SYSTEM;
                }
                case CHATTYPE_GM:
                {
                    return GM;
                }
                default:
                {
                    break;
                }
            }
            return "";
        }// end function

    }
}
