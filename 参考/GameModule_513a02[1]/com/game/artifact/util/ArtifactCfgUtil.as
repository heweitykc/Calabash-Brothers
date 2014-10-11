package com.game.artifact.util
{
    import com.game.artifact.model.*;
    import com.util.*;
    import flash.utils.*;

    public class ArtifactCfgUtil extends Object
    {

        public function ArtifactCfgUtil()
        {
            return;
        }// end function

        public static function parseAttributeDict(param1:String) : Dictionary
        {
            param1 = CfgUtil.removeQuotationMark(param1);
            return CfgUtil.parseDict(CfgUtil.removeWrapper(param1, "[", "]"), ",", ":", ArtifactAttrCategory.getInstancesByDesignName, CfgUtil.stringToInt, CfgUtil.putInDictWithMultiKeys);
        }// end function

        public static function parseExpAndCost(param1:Array) : Array
        {
            param1[0] = Number(param1[0]);
            param1[1] = int(param1[1]);
            return param1;
        }// end function

        public static function getExpFromExtractCfg(param1:Array) : Number
        {
            return param1 == null ? (0) : (param1[0]);
        }// end function

        public static function getCostGoldFromExtractCfg(param1:Array) : int
        {
            return param1 == null ? (0) : (param1[1]);
        }// end function

    }
}
