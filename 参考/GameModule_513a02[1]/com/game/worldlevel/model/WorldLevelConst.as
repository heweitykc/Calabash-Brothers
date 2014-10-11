package com.game.worldlevel.model
{
    import com.cfg.obj.*;
    import com.model.*;

    public class WorldLevelConst extends Object
    {
        public static var maxRecords:uint = 30;

        public function WorldLevelConst()
        {
            return;
        }// end function

        public static function get worldLevelEnablePlayerLevel() : int
        {
            return GlobalCfgObj.getInstance().getWorldLevelEnablePlayerLevel();
        }// end function

        public static function get worldLevelEnableMinPlayerLevelDif() : int
        {
            return GlobalCfgObj.getInstance().getWorldLevelEnableMinPlayerLevelDif();
        }// end function

        public static function getExpAddition(param1:int) : Number
        {
            return (param1 - UserObj.getInstance().playerInfo.level) * 1;
        }// end function

        public static function getExpRecoverAddition(param1:int) : Number
        {
            return (param1 - UserObj.getInstance().playerInfo.level) * 0.5;
        }// end function

    }
}
