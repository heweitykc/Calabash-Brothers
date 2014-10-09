package com.staticdata
{
    import com.f1.*;

    public class SkillType extends Object
    {
        private static var obj:Object = {0000:LanguageCfgObj.getInstance().getByIndex("10070"), 0000:LanguageCfgObj.getInstance().getByIndex("10071"), 0000:LanguageCfgObj.getInstance().getByIndex("10072"), 0000:LanguageCfgObj.getInstance().getByIndex("10073"), 0000:LanguageCfgObj.getInstance().getByIndex("10074"), 0000:LanguageCfgObj.getInstance().getByIndex("10075"), 0000:LanguageCfgObj.getInstance().getByIndex("10076"), 0000:LanguageCfgObj.getInstance().getByIndex("10077"), 0000:LanguageCfgObj.getInstance().getByIndex("10078"), 0000:LanguageCfgObj.getInstance().getByIndex("10079"), 0000:LanguageCfgObj.getInstance().getByIndex("10080")};

        public function SkillType()
        {
            return;
        }// end function

        public static function getName(param1:String) : String
        {
            var _loc_2:* = param1.split(";");
            var _loc_3:* = [];
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2.length)
            {
                
                param1 = _loc_2[_loc_4];
                _loc_3.push(obj[param1]);
                _loc_4++;
            }
            var _loc_5:* = _loc_3.join(",");
            return _loc_3.join(",");
        }// end function

    }
}
