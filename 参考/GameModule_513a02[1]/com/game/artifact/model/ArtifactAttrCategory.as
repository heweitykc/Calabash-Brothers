package com.game.artifact.model
{
    import com.f1.*;
    import flash.utils.*;

    public class ArtifactAttrCategory extends Object
    {
        public var group:ArtifactAttrCategoryGroup;
        private static var instancesDictByDesignName:Dictionary = new Dictionary();
        public static var hp:ArtifactAttrCategory = new ArtifactAttrCategory(LanguageCfgObj.getInstance().getByIndex("10001", "lang_artifact"));
        public static var mp:ArtifactAttrCategory = new ArtifactAttrCategory(LanguageCfgObj.getInstance().getByIndex("10002", "lang_artifact"));
        public static var minPhysicalAttack:ArtifactAttrCategory = new ArtifactAttrCategory([LanguageCfgObj.getInstance().getByIndex("10003", "lang_artifact"), LanguageCfgObj.getInstance().getByIndex("10004", "lang_artifact")]);
        public static var maxPhysicalAttack:ArtifactAttrCategory = new ArtifactAttrCategory([LanguageCfgObj.getInstance().getByIndex("10005", "lang_artifact"), LanguageCfgObj.getInstance().getByIndex("10004", "lang_artifact")]);
        public static var minMagicAttack:ArtifactAttrCategory = new ArtifactAttrCategory([LanguageCfgObj.getInstance().getByIndex("10006", "lang_artifact"), LanguageCfgObj.getInstance().getByIndex("10004", "lang_artifact")]);
        public static var maxMagicAttack:ArtifactAttrCategory = new ArtifactAttrCategory([LanguageCfgObj.getInstance().getByIndex("10007", "lang_artifact"), LanguageCfgObj.getInstance().getByIndex("10004", "lang_artifact")]);
        public static var defense:ArtifactAttrCategory = new ArtifactAttrCategory(LanguageCfgObj.getInstance().getByIndex("10008", "lang_artifact"));
        public static var attackSuccess:ArtifactAttrCategory = new ArtifactAttrCategory(LanguageCfgObj.getInstance().getByIndex("10009", "lang_artifact"));
        public static var defenseSuccess:ArtifactAttrCategory = new ArtifactAttrCategory(LanguageCfgObj.getInstance().getByIndex("10010", "lang_artifact"));
        public static var perfectAttack:ArtifactAttrCategory = new ArtifactAttrCategory(LanguageCfgObj.getInstance().getByIndex("10011", "lang_artifact"));
        public static var ignoreAttack:ArtifactAttrCategory = new ArtifactAttrCategory(LanguageCfgObj.getInstance().getByIndex("10012", "lang_artifact"));
        public static var knowingAttack:ArtifactAttrCategory = new ArtifactAttrCategory(LanguageCfgObj.getInstance().getByIndex("10013", "lang_artifact"));

        public function ArtifactAttrCategory(param1)
        {
            var _loc_2:* = null;
            if (!(param1 is Array))
            {
                param1 = [param1];
            }
            for each (_loc_2 in param1)
            {
                
                if (instancesDictByDesignName[_loc_2] == null)
                {
                    instancesDictByDesignName[_loc_2] = [this];
                    continue;
                }
                (instancesDictByDesignName[_loc_2] as Array).push(this);
            }
            return;
        }// end function

        public static function getInstancesByDesignName(param1:String) : Array
        {
            return instancesDictByDesignName[param1];
        }// end function

    }
}
