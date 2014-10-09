package com.game.artifact.cfg
{
    import com.game.artifact.util.*;
    import com.util.*;
    import flash.utils.*;

    public class ArtifactExtractCfg extends Object
    {
        public var q_level:int;
        public var q_gold_exp:Number;
        public var q_maya_exp:Number;
        public var q_extract_exp:Number;
        public var q_steplv:Dictionary;
        public var q_intensify:Dictionary;
        public var q_append:Dictionary;
        public var q_zhuoyue_num:Dictionary;
        public var q_zhuoyue_attribute:Dictionary;
        public var q_steplv_zhuoyue:Dictionary;
        public var q_intensify_zhuoyue:Dictionary;
        public var q_append_zhuoyue:Dictionary;

        public function ArtifactExtractCfg(param1:Object)
        {
            this.q_level = param1.level;
            this.q_gold_exp = param1.q_gold_exp;
            this.q_maya_exp = param1.q_maya_exp;
            this.q_extract_exp = param1.q_extract_exp;
            this.q_steplv = CfgUtil.parseDict(param1.q_steplv, ",", "_", CfgUtil.stringToInt, CfgUtil.stringToNumber);
            this.q_intensify = CfgUtil.parseDict(param1.q_intensify, ",", "_", CfgUtil.stringToInt, CfgUtil.stringToNumber);
            this.q_append = CfgUtil.parseDict(param1.q_append, ",", "_", CfgUtil.stringToInt, CfgUtil.stringToNumber);
            this.q_zhuoyue_num = CfgUtil.parseNestedDict(param1.q_zhuoyue_num, ",", "_", CfgUtil.stringToInt, CfgUtil.stringToInt, ArtifactCfgUtil.parseExpAndCost);
            this.q_zhuoyue_attribute = CfgUtil.parseNestedDict(param1.q_zhuoyue_attribute, ",", "_", CfgUtil.stringToInt, CfgUtil.stringToInt, CfgUtil.stringToNumber);
            this.q_steplv_zhuoyue = CfgUtil.parseDict(param1.q_steplv_zhuoyue, ",", "_", CfgUtil.stringToInt, ArtifactCfgUtil.parseExpAndCost);
            this.q_intensify_zhuoyue = CfgUtil.parseDict(param1.q_intensify_zhuoyue, ",", "_", CfgUtil.stringToInt, ArtifactCfgUtil.parseExpAndCost);
            this.q_append_zhuoyue = CfgUtil.parseDict(param1.q_append_zhuoyue, ",", "_", CfgUtil.stringToInt, ArtifactCfgUtil.parseExpAndCost);
            return;
        }// end function

    }
}
