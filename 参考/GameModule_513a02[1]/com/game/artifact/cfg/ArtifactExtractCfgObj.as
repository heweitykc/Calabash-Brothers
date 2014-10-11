package com.game.artifact.cfg
{
    import com.util.*;

    public class ArtifactExtractCfgObj extends Object
    {
        private var map:Object;
        private static var instance:ArtifactExtractCfgObj;

        public function ArtifactExtractCfgObj()
        {
            this.map = CfgUtil.getAndConvertMap("q_artifact_extract", ArtifactExtractCfg);
            return;
        }// end function

        public function getCfg(param1:int) : ArtifactExtractCfg
        {
            return this.map[param1];
        }// end function

        public static function getInstance() : ArtifactExtractCfgObj
        {
            var _loc_1:* = new ArtifactExtractCfgObj;
            instance = new ArtifactExtractCfgObj;
            return instance || _loc_1;
        }// end function

    }
}
