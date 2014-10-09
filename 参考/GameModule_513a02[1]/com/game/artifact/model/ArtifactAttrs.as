package com.game.artifact.model
{
    import flash.utils.*;

    public class ArtifactAttrs extends Object
    {
        public var attrDict:Dictionary;

        public function ArtifactAttrs(param1:Dictionary = null)
        {
            this.attrDict = param1;
            return;
        }// end function

        public function getValue(param1:ArtifactAttrCategory) : int
        {
            return this.attrDict[param1];
        }// end function

        public function getValueText(param1:ArtifactAttrCategory) : String
        {
            return param1.group.isPercent ? (param1.group.toPercentText(this.getValue(param1)) + "%") : (this.getValue(param1).toString());
        }// end function

        public function get hp() : int
        {
            return this.attrDict[ArtifactAttrCategory.hp];
        }// end function

        public function get mp() : int
        {
            return this.attrDict[ArtifactAttrCategory.mp];
        }// end function

        public function get minPhysicalAttack() : int
        {
            return this.attrDict[ArtifactAttrCategory.minPhysicalAttack];
        }// end function

        public function get maxPhysicalAttack() : int
        {
            return this.attrDict[ArtifactAttrCategory.maxPhysicalAttack];
        }// end function

        public function get minMagicAttack() : int
        {
            return this.attrDict[ArtifactAttrCategory.minMagicAttack];
        }// end function

        public function get maxMagicAttack() : int
        {
            return this.attrDict[ArtifactAttrCategory.maxMagicAttack];
        }// end function

        public function get defense() : int
        {
            return this.attrDict[ArtifactAttrCategory.defense];
        }// end function

        public function get attackSuccess() : int
        {
            return this.attrDict[ArtifactAttrCategory.attackSuccess];
        }// end function

        public function get defenseSuccess() : int
        {
            return this.attrDict[ArtifactAttrCategory.defenseSuccess];
        }// end function

        public function get perfectAttack() : int
        {
            return this.attrDict[ArtifactAttrCategory.perfectAttack];
        }// end function

        public function get ignoreAttack() : int
        {
            return this.attrDict[ArtifactAttrCategory.ignoreAttack];
        }// end function

        public function get knowingAttack() : int
        {
            return this.attrDict[ArtifactAttrCategory.knowingAttack];
        }// end function

        public function get fightPower() : int
        {
            var _loc_1:* = this.hp + (this.minPhysicalAttack + this.maxPhysicalAttack + this.minMagicAttack + this.maxMagicAttack) * 3 + this.defense * 12 + this.mp / 10;
            _loc_1 = Math.ceil(_loc_1);
            return _loc_1;
        }// end function

    }
}
