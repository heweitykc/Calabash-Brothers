package com.game.artifact.model
{
    import com.cfg.obj.*;
    import com.model.*;

    public class ArtifactConst extends Object
    {
        public static var mayaItemModelId:int = 600003;
        public static var tiliandanItemModelId:int = 100069;
        private static var goldExtractCostGoldList:Array;
        private static var goldExtractCostBindGoldList:Array;

        public function ArtifactConst()
        {
            return;
        }// end function

        private static function initGoldExtractCostList() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            if (goldExtractCostGoldList == null)
            {
                goldExtractCostGoldList = new Array();
                goldExtractCostBindGoldList = new Array();
                _loc_1 = GlobalCfgObj.getInstance().getArtifactGoldExtractCostGold().split(";");
                for each (_loc_2 in _loc_1)
                {
                    
                    _loc_3 = _loc_2.split("_");
                    _loc_4 = _loc_3[0];
                    _loc_5 = _loc_3[1];
                    _loc_6 = _loc_3[2];
                    _loc_7 = _loc_4 - 1;
                    goldExtractCostGoldList[_loc_7] = _loc_5;
                    goldExtractCostBindGoldList[_loc_7] = _loc_6;
                }
            }
            return;
        }// end function

        private static function getGoldExtractCost(param1:Array, param2:uint) : uint
        {
            return param2 >= param1.length ? (param1[(param1.length - 1)]) : (param1[param2]);
        }// end function

        public static function getGoldExtractCostGold(param1:uint) : uint
        {
            initGoldExtractCostList();
            return getGoldExtractCost(goldExtractCostGoldList, param1);
        }// end function

        public static function getGoldExtractCostBindGold(param1:uint) : uint
        {
            initGoldExtractCostList();
            return getGoldExtractCost(goldExtractCostBindGoldList, param1);
        }// end function

        public static function getGoldExtractMaxTimes() : int
        {
            var _loc_1:* = UserObj.getInstance().playerInfo.vipid;
            return getGoldExtractMaxTimesByVipLevel(_loc_1);
        }// end function

        public static function getGoldExtractMaxTimesByVipLevel(param1:int) : int
        {
            var _loc_2:* = VipCfgObj.getInstance().getVipInfo(param1);
            return _loc_2 == null ? (0) : (_loc_2.q_artifact_extract);
        }// end function

    }
}
