package com.game.newactivity.gift.locale
{
    import com.f1.*;
    import com.f1.utils.*;

    public class GiftText extends Object
    {
        public static var font:String = "宋体";

        public function GiftText()
        {
            return;
        }// end function

        public static function get btnGain() : String
        {
            return v("11735");
        }// end function

        public static function get btnClickToSeeDetail() : String
        {
            return v("12388");
        }// end function

        public static function txtTime(param1:Number) : String
        {
            return ToolKit.getFormatDate(param1, v("11563") + v("11564") + v("11565") + v("11566") + v("11567"));
        }// end function

        public static function txtEndTime(param1:Number) : String
        {
            return va("12389", [txtTime(param1)]);
        }// end function

        public static function get txtTip() : String
        {
            return v("11635");
        }// end function

        public static function get txtSecond() : String
        {
            return v("10009");
        }// end function

        public static function get errActivityEnded() : String
        {
            return v("10965");
        }// end function

        public static function get err360GetGiftError0() : String
        {
            return v("12381");
        }// end function

        public static function get err360GetGiftError1() : String
        {
            return v("12382");
        }// end function

        public static function get err360GetGiftError2() : String
        {
            return v("12383");
        }// end function

        public static function get err360GetGiftError3() : String
        {
            return v("12384");
        }// end function

        public static function get err360GetGiftError4() : String
        {
            return v("12385");
        }// end function

        public static function get err360GetGiftError5() : String
        {
            return v("12386");
        }// end function

        public static function get err360GetGiftError6() : String
        {
            return v("12387");
        }// end function

        public static function get errXunleiGetGiftError1() : String
        {
            return v("12390");
        }// end function

        public static function get errXunleiGetGiftError2() : String
        {
            return v("12391");
        }// end function

        public static function get errXunleiGetGiftError3() : String
        {
            return v("12392");
        }// end function

        public static function get errXunleiVipLevelNotEnough() : String
        {
            return v("20012");
        }// end function

        public static function get btnSeeDetail() : String
        {
            return v("20001");
        }// end function

        public static function get btnOpenContinue() : String
        {
            return v("20013");
        }// end function

        public static function get btnOpenVipNow() : String
        {
            return v("20002");
        }// end function

        public static function get btnUpgradeVipNow() : String
        {
            return v("20003");
        }// end function

        public static function get err37VipLevelNotEnough() : String
        {
            return v("20004");
        }// end function

        public static function get errNotBaiduVip() : String
        {
            return v("20005");
        }// end function

        public static function get errBaiduVipLevelNotEnough() : String
        {
            return v("20006");
        }// end function

        public static function get errNotDuowanVip() : String
        {
            return v("20007");
        }// end function

        public static function get errDuowanVipLevelNotEnough() : String
        {
            return v("20008");
        }// end function

        public static function get errActivityNotStarted() : String
        {
            return v("20009");
        }// end function

        public static function get errSystemError() : String
        {
            return v("20010");
        }// end function

        public static function get clickToGainLiebaoGift() : String
        {
            return v("20011");
        }// end function

        public static function get clickToGain360HomeGift() : String
        {
            return v("20014");
        }// end function

        public static function get clickToGainNothinkGift() : String
        {
            return v("20015");
        }// end function

        private static function v(param1:String) : String
        {
            return LanguageCfgObj.getInstance().getByIndex(param1, "lang_platformGift");
        }// end function

        private static function va(param1:String, param2:Array) : String
        {
            return StringUtil.languageReplace(v(param1), param2);
        }// end function

    }
}
