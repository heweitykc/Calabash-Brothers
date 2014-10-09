package com.game.artifact.cfg
{
    import com.util.*;
    import flash.utils.*;

    public class ArtifactPropertyCfgObj extends Object
    {
        private var map:Object;
        private var minLevelCfgMapBySteplv:Dictionary;
        public var minLevel:int = 1;
        public var maxLevel:int;
        public var minSteplv:int = 1;
        public var maxSteplv:int;
        public var maxLevelExp:Number;
        private static var instance:ArtifactPropertyCfgObj;

        public function ArtifactPropertyCfgObj()
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            this.minLevelCfgMapBySteplv = new Dictionary();
            this.map = CfgUtil.getAndConvertMap("q_artifact", ArtifactPropertyCfg);
            this.maxLevel = 0;
            this.maxSteplv = 0;
            this.maxLevelExp = 0;
            for each (_loc_1 in this.map)
            {
                
                _loc_2 = _loc_1.q_step;
                _loc_3 = this.minLevelCfgMapBySteplv[_loc_2];
                if (_loc_3 == null || _loc_1.q_level < _loc_3.q_level)
                {
                    this.minLevelCfgMapBySteplv[_loc_2] = _loc_1;
                }
                if (_loc_1.q_level > this.maxLevel)
                {
                    this.maxLevel = _loc_1.q_level;
                }
                if (_loc_1.q_step > this.maxSteplv)
                {
                    this.maxSteplv = _loc_1.q_step;
                }
            }
            if (this.maxLevel != 0)
            {
                this.maxLevelExp = this.getCfg(this.maxLevel).q_exp;
            }
            return;
        }// end function

        public function getCfg(param1:int) : ArtifactPropertyCfg
        {
            return this.map[param1];
        }// end function

        public function getMinLevelCfgBySteplv(param1:int) : ArtifactPropertyCfg
        {
            return this.minLevelCfgMapBySteplv[param1];
        }// end function

        public static function getInstance() : ArtifactPropertyCfgObj
        {
            var _loc_1:* = new ArtifactPropertyCfgObj;
            instance = new ArtifactPropertyCfgObj;
            return instance || _loc_1;
        }// end function

    }
}
