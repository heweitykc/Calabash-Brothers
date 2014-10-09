package com.game.facebook.locale
{
    import com.f1.*;
    import com.f1.utils.*;

    public class FacebookText extends Object
    {

        public function FacebookText()
        {
            return;
        }// end function

        public static function get shareDialogTitle() : String
        {
            return v("101");
        }// end function

        public static function get shareDialogContent() : String
        {
            return v("102");
        }// end function

        public static function get btnShareAndGain() : String
        {
            return v("103");
        }// end function

        public static function get btnGainAward() : String
        {
            return v("104");
        }// end function

        public static function get btnInviteNow() : String
        {
            return v("105");
        }// end function

        public static function get errActivityEnded() : String
        {
            return v("106");
        }// end function

        public static function invitedFriendCount(param1:int) : String
        {
            return va("107", [param1]);
        }// end function

        public static function get btnGained() : String
        {
            return v("108");
        }// end function

        public static function get btnNotGainable() : String
        {
            return v("109");
        }// end function

        private static function v(param1:String) : String
        {
            return LanguageCfgObj.getInstance().getByIndex(param1, "lang_facebook");
        }// end function

        private static function va(param1:String, param2:Array) : String
        {
            return StringUtil.languageReplace(v(param1), param2);
        }// end function

    }
}
