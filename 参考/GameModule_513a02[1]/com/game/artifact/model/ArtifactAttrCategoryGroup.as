package com.game.artifact.model
{
    import com.f1.*;

    public class ArtifactAttrCategoryGroup extends Object
    {
        public var name:String;
        public var children:Array;
        public var isPercent:Boolean;
        public static var hp:ArtifactAttrCategoryGroup = new ArtifactAttrCategoryGroup(LanguageCfgObj.getInstance().getByIndex("10202"), [ArtifactAttrCategory.hp]);
        public static var mp:ArtifactAttrCategoryGroup = new ArtifactAttrCategoryGroup(LanguageCfgObj.getInstance().getByIndex("10203"), [ArtifactAttrCategory.mp]);
        public static var physicalAttack:ArtifactAttrCategoryGroup = new ArtifactAttrCategoryGroup(LanguageCfgObj.getInstance().getByIndex("10204"), [ArtifactAttrCategory.minPhysicalAttack, ArtifactAttrCategory.maxPhysicalAttack]);
        public static var magicAttack:ArtifactAttrCategoryGroup = new ArtifactAttrCategoryGroup(LanguageCfgObj.getInstance().getByIndex("10205"), [ArtifactAttrCategory.minMagicAttack, ArtifactAttrCategory.maxMagicAttack]);
        public static var defense:ArtifactAttrCategoryGroup = new ArtifactAttrCategoryGroup(LanguageCfgObj.getInstance().getByIndex("10206"), [ArtifactAttrCategory.defense]);
        public static var attackSuccess:ArtifactAttrCategoryGroup = new ArtifactAttrCategoryGroup(LanguageCfgObj.getInstance().getByIndex("10207"), [ArtifactAttrCategory.attackSuccess]);
        public static var defenseSuccess:ArtifactAttrCategoryGroup = new ArtifactAttrCategoryGroup(LanguageCfgObj.getInstance().getByIndex("10208"), [ArtifactAttrCategory.defenseSuccess]);
        public static var perfectAttack:ArtifactAttrCategoryGroup = new ArtifactAttrCategoryGroup(LanguageCfgObj.getInstance().getByIndex("10209"), [ArtifactAttrCategory.perfectAttack], true);
        public static var ignoreAttack:ArtifactAttrCategoryGroup = new ArtifactAttrCategoryGroup(LanguageCfgObj.getInstance().getByIndex("10210"), [ArtifactAttrCategory.ignoreAttack], true);
        public static var knowingAttack:ArtifactAttrCategoryGroup = new ArtifactAttrCategoryGroup(LanguageCfgObj.getInstance().getByIndex("10211"), [ArtifactAttrCategory.knowingAttack], true);
        public static var instances:Array = [hp, mp, physicalAttack, magicAttack, defense, attackSuccess, defenseSuccess, perfectAttack, ignoreAttack, knowingAttack];

        public function ArtifactAttrCategoryGroup(param1:String, param2:Array, param3:Boolean = false)
        {
            var _loc_4:* = null;
            this.name = param1;
            this.children = param2;
            this.isPercent = param3;
            for each (_loc_4 in param2)
            {
                
                _loc_4.group = this;
            }
            return;
        }// end function

        public function toPercent(param1:int) : Number
        {
            return param1 / 100;
        }// end function

        public function toPercentText(param1:int) : String
        {
            return this.toPercent(param1).toString();
        }// end function

        public static function initClass() : void
        {
            return;
        }// end function

    }
}
