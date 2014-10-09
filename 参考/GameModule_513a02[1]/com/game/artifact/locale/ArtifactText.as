package com.game.artifact.locale
{
    import com.f1.*;
    import com.f1.utils.*;

    public class ArtifactText extends Object
    {

        public function ArtifactText()
        {
            return;
        }// end function

        public static function useGoldOrBindGoldToExtract(param1:int, param2:int, param3:Number) : String
        {
            return va("101", [param1, param2, param3]);
        }// end function

        public static function confirmUseGoldOrBindGoldToExtract(param1:int, param2:int, param3:Number) : String
        {
            return va("102", [param1, param2, param3]);
        }// end function

        public static function get btnDoubleExtract() : String
        {
            return v("103");
        }// end function

        public static function get tipDoubleExtract() : String
        {
            return v("104");
        }// end function

        public static function get nonVip4CannotUseDoubleExtract() : String
        {
            return v("105");
        }// end function

        public static function get btnCancelDoubleExtract() : String
        {
            return v("106");
        }// end function

        public static function confirmDoubleExtract(param1:int) : String
        {
            return va("107", [param1]);
        }// end function

        public static function get errDoubleExtractEquipOnly() : String
        {
            return v("108");
        }// end function

        public static function tipDoubleExtractOneItem(param1:int, param2:Number) : String
        {
            return va("109", [param1, param2]);
        }// end function

        public static function get clickItemToDoubleExtract() : String
        {
            return v("110");
        }// end function

        private static function v(param1:String) : String
        {
            return LanguageCfgObj.getInstance().getByIndex(param1, "lang_artifact");
        }// end function

        private static function va(param1:String, param2:Array) : String
        {
            return StringUtil.languageReplace(v(param1), param2);
        }// end function

    }
}
