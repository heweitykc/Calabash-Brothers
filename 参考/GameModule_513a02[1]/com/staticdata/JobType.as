package com.staticdata
{
    import com.f1.*;
    import com.util.*;

    public class JobType extends Object
    {
        public static const WARRIOR:uint = 1;
        public static const MAGICER:uint = 2;
        public static const BOWMAN:uint = 3;
        public static const KNIGHT:uint = 4;
        public static const SLAYER:uint = 5;
        public static const ARCHER:uint = 6;
        public static const GODKNIGHT:uint = 7;
        public static const GODSLAYER:uint = 8;
        public static const GODARCHER:uint = 9;
        public static const GODKNIGHT_4:uint = 10;
        public static const GODSLAYER_4:uint = 11;
        public static const GODARCHER_4_:uint = 12;
        public static const M_WARRIOR:uint = 101;
        public static const M_KNIGHT:uint = 104;
        public static const M_GODKNIGHT:uint = 107;
        public static const M_GODKNIGHT_4:uint = 111;
        public static const K_M_WARRIOR:uint = 4;
        private static const JOBNAME:Array = [LanguageCfgObj.getInstance().getByIndex("11643"), LanguageCfgObj.getInstance().getByIndex("11644"), LanguageCfgObj.getInstance().getByIndex("11645"), LanguageCfgObj.getInstance().getByIndex("11646"), LanguageCfgObj.getInstance().getByIndex("11647"), LanguageCfgObj.getInstance().getByIndex("11648"), LanguageCfgObj.getInstance().getByIndex("11649"), LanguageCfgObj.getInstance().getByIndex("11650"), LanguageCfgObj.getInstance().getByIndex("11651"), LanguageCfgObj.getInstance().getByIndex("1165_2"), LanguageCfgObj.getInstance().getByIndex("1165_3"), LanguageCfgObj.getInstance().getByIndex("1165_4")];
        private static const JOBNAME_EXTRA:Array = [LanguageCfgObj.getInstance().getByIndex("11643"), "", "", LanguageCfgObj.getInstance().getByIndex("11646"), "", "", LanguageCfgObj.getInstance().getByIndex("11649"), "", "", LanguageCfgObj.getInstance().getByIndex("11646"), "", ""];

        public function JobType()
        {
            return;
        }// end function

        public static function matchJob(param1:int, param2:Number) : Boolean
        {
            return PropUtil.canUseByJob(param2, param1);
        }// end function

        public static function getJobName(param1:int) : String
        {
            if (param1 < 0)
            {
                return null;
            }
            if (param1 < 100)
            {
                if (param1 > JOBNAME.length)
                {
                    return null;
                }
                return JOBNAME[(param1 - 1)];
            }
            else
            {
                param1 = param1 % 100;
                if (param1 > JOBNAME_EXTRA.length)
                {
                    return null;
                }
                return JOBNAME_EXTRA[(param1 - 1)];
            }
        }// end function

    }
}
