package com.game.artifact.cfg
{
    import com.game.artifact.util.*;
    import com.util.*;

    public class ArtifactRemoldCfgObj extends Object
    {
        public var map:Object;
        public var cfgCount:uint;
        private static var instance:ArtifactRemoldCfgObj;

        public function ArtifactRemoldCfgObj()
        {
            this.map = CfgUtil.getAndConvertMap("q_artifact_remold", ArtifactRemoldCfg);
            this.cfgCount = ArtifactUtil.getMapSize(this.map);
            return;
        }// end function

        public function getCfg(param1:int) : ArtifactRemoldCfg
        {
            return this.map[param1];
        }// end function

        public static function getInstance() : ArtifactRemoldCfgObj
        {
            var _loc_1:* = new ArtifactRemoldCfgObj;
            instance = new ArtifactRemoldCfgObj;
            return instance || _loc_1;
        }// end function

    }
}
